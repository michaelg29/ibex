
module ibex_cpi_tracer (
  // Clock and reset
  input  logic        clk_i,
  input  logic        rst_ni,

  // enable control
  input  logic        inhibit,

  // Frontend event signals
  input  logic mispredict_i,
  input  logic iside_wait_i,
  input  logic alu_req_i,
  input  logic mul_req_i,
  input  logic div_req_i,
  input  logic lsu_req_i,

  // Backend event signals
  input  logic instr_ret_i,
  input  logic dside_wait_i,
  input  logic mul_wait_i,
  input  logic div_wait_i
);

  localparam int unsigned N_LANES = 1;

  // ==========================================
  // ===== INTERNAL SIGNALS AND VARIABLES =====
  // ==========================================

  // imports
  import ibex_tracer_pkg::*;

`ifdef VERILATOR
  // logging variables
  int          file_handle;
  string       file_name;
  logic trace_log_enable;
`endif

  // signals
  logic mul_wait_prev;
  logic div_wait_prev;

  // counters
  int unsigned cycle [N_LANES-1:0];
  int unsigned base_cycles [N_LANES-1:0];
  int unsigned icache_cycles [N_LANES-1:0];
  int unsigned bpred_cycles [N_LANES-1:0];
  int unsigned dcache_cycles [N_LANES-1:0];
  int unsigned ex_cycles [N_LANES-1:0];
  int unsigned dependency_cycles [N_LANES-1:0];

  // analysis events
  logic [N_LANES-1:0] base_comp;
  logic [N_LANES-1:0] icache_comp;
  logic [N_LANES-1:0] bpred_comp;
  logic [N_LANES-1:0] dcache_comp;
  logic [N_LANES-1:0] ex_comp;
  logic [N_LANES-1:0] dependency_comp;

`ifdef VERILATOR
  // initial values
  initial begin
    file_handle = 0;

    if ($value$plusargs("ibex_tracer_enable=%b", trace_log_enable)) begin
      if (trace_log_enable == 1'b0) begin
        $display("%m: Instruction trace disabled.");
      end
    end else begin
      trace_log_enable = 1'b1;
    end
  end
`endif

  // =============================
  // ===== UTILITY FUNCTIONS =====
  // =============================

`ifdef VERILATOR
  // print information at a rising edge
  function automatic void printbuffer_dumpline(int fh);
    // TODO: write trace for a cycle
    $fwrite(fh, "\n");
  endfunction
`endif

`ifdef VERILATOR
  // close output file for writing
  final begin
    if (file_handle != 32'h0) begin
      int fh = file_handle;
      $fclose(fh);
    end
  end
`endif

  // =========================
  // ===== TRACING LOGIC =====
  // =========================

  // counters
  genvar i_cnt;
  for (i_cnt = 0; i_cnt < N_LANES; ++i_cnt) begin: datapath_cnt
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        cycle[i_cnt] <= 0;
        base_cycles[i_cnt] <= 0;
        icache_cycles[i_cnt] <= 0;
        bpred_cycles[i_cnt] <= 0;
        dcache_cycles[i_cnt] <= 0;
        ex_cycles[i_cnt] <= 0;
        dependency_cycles[i_cnt] <= 0;
      end else begin
        cycle[i_cnt] <= cycle[i_cnt] + 1;

        if (base_comp[i_cnt]) begin
          base_cycles[i_cnt] <= base_cycles[i_cnt] + 1;
        end

        if (icache_comp[i_cnt]) begin
          icache_cycles[i_cnt] <= icache_cycles[i_cnt] + 1;
        end

        if (bpred_comp[i_cnt]) begin
          bpred_cycles[i_cnt] <= bpred_cycles[i_cnt] + 1;
        end

        if (dcache_comp[i_cnt]) begin
          dcache_cycles[i_cnt] <= dcache_cycles[i_cnt] + 1;
        end

        if (ex_comp[i_cnt]) begin
          ex_cycles[i_cnt] <= ex_cycles[i_cnt] + 1;
        end

        if (dependency_comp[i_cnt]) begin
          dependency_cycles[i_cnt] <= dependency_cycles[i_cnt] + 1;
        end
      end
    end
  endgenerate

`ifdef VERILATOR
  // log execution
  always @(posedge clk_i) begin
    if (trace_log_enable) begin

      int fh = file_handle;

      // open file
      if (fh == 32'h0) begin
        string file_name_base = "trace_core";
        void'($value$plusargs("ibex_tracer_file_base=%s", file_name_base));
        $sformat(file_name, "%s.log", file_name_base);

        $display("%m: Writing execution trace to %s", file_name);
        fh = $fopen(file_name, "w");
        file_handle <= fh;

        // TODO: write file header
      end

      printbuffer_dumpline(fh);
    end
  end
`endif

  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      mul_wait_prev <= 1'b0;
      div_wait_prev <= 1'b0;
    end else begin
      mul_wait_prev <= mul_wait_i;
      div_wait_prev <= div_wait_i;
    end
  end

  // always executing logic for each instruction lane of the datapath
  genvar i_lane;
  for (i_lane = 0; i_lane < N_LANES; ++i_lane) begin: datapath_comp
    always_comb begin
      // default values
      base_comp[i_lane] = 1'b0;
      icache_comp[i_lane] = 1'b0;
      bpred_comp[i_lane] = 1'b0;
      dcache_comp[i_lane] = 1'b0;
      ex_comp[i_lane] = 1'b0;
      dependency_comp[i_lane] = 1'b0;

      if (~inhibit) begin
        // determine if underutilization at frontend-backend transfer
        if (~(alu_req_i |
              (mul_req_i & ~mul_wait_prev) | // only consider first cycle of request
              (div_req_i & ~div_wait_prev) | // only consider first cycle of request
              lsu_req_i)) begin

          // Possible frontend causes
          // ========================
          if (iside_wait_i) begin // I-cache miss
            icache_comp[i_lane] = 1'b1;
          end else if (mispredict_i) begin // misprediction
            bpred_comp[i_lane] = 1'b1;
          end

          // Possible backend causes
          // =======================
          else if (dside_wait_i) begin // data cache miss
            dcache_comp[i_lane] = 1'b1;
          end else if (mul_wait_i | div_wait_i) begin // execution block (ALU, mult, div) latency
            ex_comp[i_lane] = 1'b1;
          end else begin // dependency violation
            dependency_comp[i_lane] = 1'b0;
          end
        end else begin
          base_comp[i_lane] = 1'b1;
        end

        /*
          n = # ports/lanes used
          W = # total ports/lanes available

          f = n/W
          base_comp_cpi += f
          if (f < 1) { // underutilization at stage
            if (FE stall) {
              if (icache miss) {
                icache_comp_cpi += 1-f
              }
              else if (bpred miss) {
                bpred_comp_cpi += 1-f
              }
            }
            else if (BE stall) {
              waiting_instr = ROB head or producer of first non-ready instr
              if (waiting_instr has dcache miss) {
                dcache_comp_cpi += 1-f
              }
              else if (latency(waiting_instr) > 1CC) {
                alu_latency_comp_cpi += 1-f
              }
              else {
                dependency_comp_cpi += 1-f
              }
            }
          }
         */
      end
    end
  end

endmodule
