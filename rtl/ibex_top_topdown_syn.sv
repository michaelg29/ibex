// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

/**
 * Top level module of the ibex RISC-V core for synthesis
 */

// overridable defines
`ifndef DM_HALT_ADDR
  `define DM_HALT_ADDR 32'h1A110800
`endif
`ifndef DM_EXCEPTION_ADDR
  `define DM_EXCEPTION_ADDR 32'h1A110808
`endif

// register file type
`ifdef VERILATOR
  `define IBEX_RF_TYPE ibex_pkg::RegFileFF
`else
  `define IBEX_RF_TYPE ibex_pkg::RegFileLatch
`endif

module ibex_top_topdown_syn (
  // Clock and Reset
  input  logic                         clk_i,
  input  logic                         rst_ni,

  input  logic                         test_en_i,     // enable all clock gates for testing
  input  logic                         scan_rst_ni,
  input  prim_ram_1p_pkg::ram_1p_cfg_t ram_cfg_i,


  input  logic [31:0]                  hart_id_i,
  input  logic [31:0]                  boot_addr_i,

  // Instruction memory interface
  output logic                         instr_req_o,
  input  logic                         instr_gnt_i,
  input  logic                         instr_rvalid_i,
  output logic [31:0]                  instr_addr_o,
  input  logic [31:0]                  instr_rdata_i,
  input  logic [6:0]                   instr_rdata_intg_i,
  input  logic                         instr_err_i,

  // Data memory interface
  output logic                         data_req_o,
  input  logic                         data_gnt_i,
  input  logic                         data_rvalid_i,
  output logic                         data_we_o,
  output logic [3:0]                   data_be_o,
  output logic [31:0]                  data_addr_o,
  output logic [31:0]                  data_wdata_o,
  output logic [6:0]                   data_wdata_intg_o,
  input  logic [31:0]                  data_rdata_i,
  input  logic [6:0]                   data_rdata_intg_i,
  input  logic                         data_err_i,

  // Interrupt inputs
  input  logic                         irq_software_i,
  input  logic                         irq_timer_i,
  input  logic                         irq_external_i,
  input  logic [14:0]                  irq_fast_i,
  input  logic                         irq_nm_i,       // non-maskeable interrupt

  // Debug Interface
  input  logic                         debug_req_i,
  output ibex_pkg::crash_dump_t        crash_dump_o,
  output logic                         double_fault_seen_o,

  // CPU Control Signals
  input  ibex_pkg::ibex_mubi_t         fetch_enable_i,
  output logic                         alert_minor_o,
  output logic                         alert_major_internal_o,
  output logic                         alert_major_bus_o,
  output logic                         core_sleep_o

);

  ibex_top #(
    .PMPEnable        ( 1'b0                             ),
    .PMPGranularity   ( 0                                ),
    .PMPNumRegions    ( 4                                ),
    .MHPMCounterNum   ( 0                                ),
    .MHPMCounterWidth ( 40                               ),
    .TopDownEnable    ( 1'b1                             ),
    .RV32E            ( 1'b0                             ),
    .RV32M            ( ibex_pkg::RV32MSlow              ),
    .RV32B            ( ibex_pkg::RV32BNone              ),
    .RegFile          ( `IBEX_RF_TYPE                    ),
    .BranchTargetALU  ( 1'b0                             ),
    .ICache           ( 1'b1                             ),
    .ICacheECC        ( 1'b0                             ),
    .BranchPredictor  ( 1'b1                             ),
    .DbgTriggerEn     ( 1'b0                             ),
    .DbgHwBreakNum    ( 1                                ),
    .WritebackStage   ( 1'b1                             ),
    .SecureIbex       ( 1'b0                             ),
    .ICacheScramble   ( 1'b0                             ),
    .RndCnstLfsrSeed  ( ibex_pkg::RndCnstLfsrSeedDefault ),
    .RndCnstLfsrPerm  ( ibex_pkg::RndCnstLfsrPermDefault ),
    .DmHaltAddr       ( `DM_HALT_ADDR                    ),
    .DmExceptionAddr  ( `DM_EXCEPTION_ADDR               )
  ) u_ibex_top (
    .clk_i,
    .rst_ni,

    .test_en_i,
    .scan_rst_ni,
    .ram_cfg_i,

    .hart_id_i,
    .boot_addr_i,

    .instr_req_o,
    .instr_gnt_i,
    .instr_rvalid_i,
    .instr_addr_o,
    .instr_rdata_i,
    .instr_rdata_intg_i,
    .instr_err_i,

    .data_req_o,
    .data_gnt_i,
    .data_rvalid_i,
    .data_we_o,
    .data_be_o,
    .data_addr_o,
    .data_wdata_o,
    .data_wdata_intg_o,
    .data_rdata_i,
    .data_rdata_intg_i,
    .data_err_i,

    .irq_software_i,
    .irq_timer_i,
    .irq_external_i,
    .irq_fast_i,
    .irq_nm_i,

    .scramble_key_valid_i(1'b0),
    //.scramble_key_i({ibex_pkg::SCRAMBLE_KEY_W'{1'b0}}),
    .scramble_key_i('0),
    //.scramble_nonce_i({ibex_pkg::SCRAMBLE_NONCE_W'{1'b0}}),
    .scramble_nonce_i('0),
    .scramble_req_o(),

    .debug_req_i,
    .crash_dump_o,
    .double_fault_seen_o,

  // RISC-V Formal Interface
  `ifdef RVFI
    .rvfi_valid(),
    .rvfi_order(),
    .rvfi_insn(),
    .rvfi_trap(),
    .rvfi_halt(),
    .rvfi_intr(),
    .rvfi_mode(),
    .rvfi_ixl(),
    .rvfi_rs1_addr(),
    .rvfi_rs2_addr(),
    .rvfi_rs3_addr(),
    .rvfi_rs1_rdata(),
    .rvfi_rs2_rdata(),
    .rvfi_rs3_rdata(),
    .rvfi_rd_addr(),
    .rvfi_rd_wdata(),
    .rvfi_pc_rdata(),
    .rvfi_pc_wdata(),
    .rvfi_mem_addr(),
    .rvfi_mem_rmask(),
    .rvfi_mem_wmask(),
    .rvfi_mem_rdata(),
    .rvfi_mem_wdata(),
    .rvfi_ext_pre_mip(),
    .rvfi_ext_post_mip(),
    .rvfi_ext_nmi(),
    .rvfi_ext_nmi_int(),
    .rvfi_ext_debug_req(),
    .rvfi_ext_debug_mode(),
    .rvfi_ext_rf_wr_suppress(),
    .rvfi_ext_mcycle(),
    .rvfi_ext_mhpmcounters(),
    .rvfi_ext_mhpmcountersh(),
    .rvfi_ext_ic_scr_key_valid(),
    .rvfi_ext_irq_valid(),
  `endif

    .fetch_enable_i,
    .alert_minor_o,
    .alert_major_internal_o,
    .alert_major_bus_o,
    .core_sleep_o
  );

endmodule
