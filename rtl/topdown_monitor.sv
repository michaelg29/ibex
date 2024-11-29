

module topdown_monitor #(
  parameter IDX_ICACHE = 1,
  parameter IDX_BPRED = 2,
  parameter IDX_DCACHE = 3,
  parameter IDX_EXECUTE = 4
) (
  // Clock and Reset
  input  logic         clk_i,
  input  logic         rst_ni,

  // Performance Counters
  input  logic         instr_ret_i,                 // instr retired in ID/EX stage
  input  logic         instr_ret_compressed_i,      // compressed instr retired
  input  logic         instr_ret_spec_i,            // speculative instr_ret_i
  input  logic         instr_ret_compressed_spec_i, // speculative instr_ret_compressed_i
  input  logic         iside_wait_i,                // core waiting for the iside
  input  logic         jump_i,                      // jump instr seen (j, jr, jal, jalr)
  input  logic         branch_i,                    // branch instr seen (bf, bnf)
  input  logic         branch_taken_i,              // branch was taken
  input  logic         mem_load_i,                  // load from memory in this cycle
  input  logic         mem_store_i,                 // store to memory in this cycle
  input  logic         dside_wait_i,                // core waiting for the dside
  input  logic         mul_wait_i,                  // core waiting for multiply
  input  logic         div_wait_i,                  // core waiting for divide

  // Top-down analysis signals
  input  logic         mispredict_i,                // branch prediction error
  input  logic         alu_req_i,                   // ALU issue request
  input  logic         mul_req_i,                   // multiplication issue request
  input  logic         div_req_i,                   // division issue request
  input  logic         lsu_req_i,                    // load-store issue request

  // Counter increment control
  output logic         base_comp_incr_o,
  output logic         icache_comp_incr_o,
  output logic         bpred_comp_incr_o,
  output logic         dcache_comp_incr_o,
  output logic         ex_comp_incr_o,
  output logic         dependency_comp_incr_o
);

  // constant indices
  localparam IDX_BASE = 0;
  localparam IDX_DEPENDENCY = 5;

  // local wires
  logic [6-1:0] events; // pulses for specific events
  logic mul_wait_prev;
  logic div_wait_prev;

  // only see first cycle of mul/div wait
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      mul_wait_prev <= 1'b0;
      div_wait_prev <= 1'b0;
    end else begin
      mul_wait_prev <= mul_wait_i;
      div_wait_prev <= div_wait_i;
    end
  end

  always @(*) begin
    events[IDX_BASE] = alu_req_i |
                 (mul_req_i & ~mul_wait_prev) | // only consider first cycle of request
                 (div_req_i & ~div_wait_prev) | // only consider first cycle of request
                 lsu_req_i;

    // component takes responsibility if
    //   stall
    //   there is a possible event in the component
    //   higher priority event did not happen

    // instruction cache miss
    events[IDX_ICACHE] = iside_wait_i & ~events[IDX_ICACHE-1];

    // branch misprediction
    events[IDX_BPRED] = mispredict_i & ~events[IDX_BPRED-1];

    // data cache miss
    events[IDX_DCACHE] = dside_wait_i & ~events[IDX_DCACHE-1];

    // execution unit busy
    events[IDX_EXECUTE] = (mul_wait_i | div_wait_i) & ~events[IDX_EXECUTE-1];

    // dependency
    events[IDX_DEPENDENCY] = ~events[IDX_DEPENDENCY-1];

    // lower level events
    //events[IDX_ICACHE_L3] = events[IDX_ICACHE] & iside_l3_wait_i;
  end

  assign base_comp_incr_o = events[IDX_BASE];
  assign icache_comp_incr_o = events[IDX_ICACHE];
  assign bpred_comp_incr_o = events[IDX_BPRED];
  assign dcache_comp_incr_o = events[IDX_DCACHE];
  assign ex_comp_incr_o = events[IDX_EXECUTE];
  assign dependency_comp_incr_o = events[IDX_DEPENDENCY];

endmodule
