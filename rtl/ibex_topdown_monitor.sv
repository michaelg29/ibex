// Generated by CIRCT firtool-1.62.1
module ibex_topdown_monitor(
  input  clk_i,
         rst_ni,
         io_inhibit_i,
         io_iside_wait_i,
         io_dside_wait_i,
         io_mul_wait_i,
         io_div_wait_i,
         io_mispredict_i,
         io_alu_req_i_0,
         io_mul_req_i_0,
         io_div_req_i_0,
         io_lsu_req_i_0,
  output io_base_comp_incr_o_0,
         io_icache_comp_incr_o_0,
         io_bpred_comp_incr_o_0,
         io_dcache_comp_incr_o_0,
         io_ex_comp_incr_o_0,
         io_dependency_comp_incr_o_0
);

  reg  mul_wait_prev;
  reg  div_wait_prev;
  wire _GEN =
    io_alu_req_i_0 | io_mul_req_i_0 & ~mul_wait_prev | io_div_req_i_0 & ~div_wait_prev
    | io_lsu_req_i_0;
  wire _GEN_0 = ~io_inhibit_i & ~_GEN;
  wire _GEN_1 = io_mul_wait_i | io_div_wait_i;
  wire _GEN_2 = io_iside_wait_i | io_mispredict_i | io_dside_wait_i;
  always @(posedge clk_i) begin
    mul_wait_prev <= io_mul_wait_i;
    div_wait_prev <= io_div_wait_i;
  end // always @(posedge)
  assign io_base_comp_incr_o_0 = ~io_inhibit_i & _GEN;
  assign io_icache_comp_incr_o_0 = _GEN_0 & io_iside_wait_i;
  assign io_bpred_comp_incr_o_0 = _GEN_0 & ~io_iside_wait_i & io_mispredict_i;
  assign io_dcache_comp_incr_o_0 =
    _GEN_0 & ~(io_iside_wait_i | io_mispredict_i) & io_dside_wait_i;
  assign io_ex_comp_incr_o_0 = _GEN_0 & ~_GEN_2 & _GEN_1;
  assign io_dependency_comp_incr_o_0 = _GEN_0 & ~_GEN_2 & ~_GEN_1;
endmodule


