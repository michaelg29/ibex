/* verilator lint_off DECLFILENAME */
// Generated by CIRCT firtool-1.62.1
module TopdownMonitor(
  input  io_inhibit_i,
         io_icache_wait_i_0,
         io_dcache_wait_i_0,
         io_ex_wait_i_0,
         io_mispredict_i_0,
         io_lane_request_i_0,
  output io_base_comp_incr_o_0,
         io_icache_comp_incr_o_0,
         io_bpred_comp_incr_o_0,
         io_dcache_comp_incr_o_0,
         io_ex_comp_incr_o_0,
         io_dependency_comp_incr_o_0
);

  wire _GEN = ~io_inhibit_i & ~io_lane_request_i_0;
  wire _GEN_0 = io_icache_wait_i_0 | io_mispredict_i_0 | io_dcache_wait_i_0;
  assign io_base_comp_incr_o_0 = ~io_inhibit_i & io_lane_request_i_0;
  assign io_icache_comp_incr_o_0 = _GEN & io_icache_wait_i_0;
  assign io_bpred_comp_incr_o_0 = _GEN & ~io_icache_wait_i_0 & io_mispredict_i_0;
  assign io_dcache_comp_incr_o_0 =
    _GEN & ~(io_icache_wait_i_0 | io_mispredict_i_0) & io_dcache_wait_i_0;
  assign io_ex_comp_incr_o_0 = _GEN & ~_GEN_0 & io_ex_wait_i_0;
  assign io_dependency_comp_incr_o_0 = _GEN & ~_GEN_0 & ~io_ex_wait_i_0;
endmodule

module ibex_topdown_monitor(
  input  clk_i,
         rst_ni,
         io_inhibit_i,
         io_iside_wait_i,
         io_dside_wait_i,
         io_mul_wait_i,
         io_div_wait_i,
         io_mispredict_i,
         io_alu_req_i,
         io_mul_req_i,
         io_div_req_i,
         io_lsu_req_i,
  output io_base_comp_incr_o,
         io_icache_comp_incr_o,
         io_bpred_comp_incr_o,
         io_dcache_comp_incr_o,
         io_ex_comp_incr_o,
         io_dependency_comp_incr_o
);

  reg mul_wait_prev;
  reg div_wait_prev;
  always @(posedge clk_i) begin
    mul_wait_prev <= io_mul_wait_i;
    div_wait_prev <= io_div_wait_i;
  end // always @(posedge)
  TopdownMonitor topdown_monitor (
    .io_inhibit_i                (io_inhibit_i),
    .io_icache_wait_i_0          (io_iside_wait_i),
    .io_dcache_wait_i_0          (io_dside_wait_i),
    .io_ex_wait_i_0              (io_mul_wait_i | io_div_wait_i),
    .io_mispredict_i_0           (io_mispredict_i),
    .io_lane_request_i_0
      (io_alu_req_i | io_mul_req_i & ~mul_wait_prev | io_div_req_i & ~div_wait_prev
       | io_lsu_req_i),
    .io_base_comp_incr_o_0       (io_base_comp_incr_o),
    .io_icache_comp_incr_o_0     (io_icache_comp_incr_o),
    .io_bpred_comp_incr_o_0      (io_bpred_comp_incr_o),
    .io_dcache_comp_incr_o_0     (io_dcache_comp_incr_o),
    .io_ex_comp_incr_o_0         (io_ex_comp_incr_o),
    .io_dependency_comp_incr_o_0 (io_dependency_comp_incr_o)
  );
endmodule


/* verilator lint_on DECLFILENAME */