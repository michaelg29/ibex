
# namespace for Genus (Synthesis).
namespace eval gn {}
# namespace for Innovus (Place&Route). Some variables from gn namespace may be used by Innovus, if shared.
namespace eval iv {}

#####################################################################
# Project Information, Synthesis
#####################################################################
# Design name, typically matches top-level RTL file
set TOPCELL		ibex_top_syn

# List of HDL files
set gn::VERILOG_LIST [list prim_secded_pkg.sv prim_ram_1p_pkg.sv prim_generic_ram_1p.sv prim_generic_buf.sv prim_assert.sv prim_clock_gating.v prim_flop_macros.sv ibex_pkg.sv ibex_alu.sv ibex_compressed_decoder.sv ibex_controller.sv ibex_cs_registers.sv ibex_counter.sv ibex_decoder.sv ibex_ex_block.sv ibex_id_stage.sv ibex_if_stage.sv ibex_wb_stage.sv ibex_load_store_unit.sv ibex_multdiv_slow.sv ibex_multdiv_fast.sv ibex_prefetch_buffer.sv ibex_fetch_fifo.sv ibex_pmp.sv ibex_core.sv ibex_register_file_latch.sv ibex_branch_predict.sv ibex_icache.sv ibex_csr.sv ibex_top.sv ibex_top_syn.sv ]
set gn::SDC_LIST	   [list "${TOPCELL}.nangate.sdc"]
#set iv::extra_netlist_files [list ../../input/syn/rtl/prim_clock_gating.v ]
# Design specific timing vars, referenced in .sdc file
set clk_period       2000
set clk_name         "clk_i"

# set SYNTHESIS macro
set gn::HDL_DEFS { \
  "SYNTHESIS" \
  "SYNTHESIS_MEMORY_BLACK_BOXING" \
}

# set HDL language: {v2001 | v1995 | sv | vhdl }
set gn::HDL_LANG "sv"

source ../../tech/tech_setup.tcl
set gn::RTLDir { ../../input/rtl/ ../../input/vendor/lowrisc_ip/ip/prim_generic/rtl/ ../../input/vendor/lowrisc_ip/ip/prim/rtl/ ../../input/vendor/lowrisc_ip/dv/sv/dv_utils/ ../../input/syn/rtl/ }
#set gn::SDCDir ../../input/syn/

#####################################################################
# Project Information, Place&Route
#####################################################################
# Use Tempus engine?  More accurate for long wires
set iv::TEMPUS_ENGINE 1
# Incremental optimization?
set iv::INCR_OPT	  1
# Power and ground net names as they should be implemented in your design
set iv::PWR_name	  DVDD
set iv::GND_name	  DVSS
# Power and ground pin names as they are in the digital std cell lib
set iv::PWR_libname	  VDD
set iv::GND_libname	  VSS

# Floorplan "from scratch" vars, use when no boundary/pin input data is available, e.g., input DEF
set vars(fp,density)      0.30
set vars(fp,aspect_ratio) 1.0

# Routing variables
set iv::data_bottom_routing_layer  2
set iv::data_top_routing_layer	   7
set iv::ceiling_layer	           $iv::data_top_routing_layer
set iv::data_bottom_pin_layername  "M2"
set iv::data_top_pin_layername	   "M7"

set iv::clk_bottom_routing_layer   $iv::data_bottom_routing_layer
set iv::clk_top_routing_layer      $iv::data_top_routing_layer
set iv::clk_maxfanout			   32
set iv::clk_maxcap			       10

# Target setup and hold slack, in nS
set iv::setup_target_slack         0
set iv::hold_target_slack          0

#####################################################################
# Tool Variables
#####################################################################
set gn::GEN_EFFORT	medium
set gn::MAP_EFFORT	high
set gn::OPT_EFFORT	high
set gn::SYN_INCR 	false

# IF any Genus messages annoy you, add it here
set gn::SUPPRESS_MSG	{LBR-30 LBR-31 VLOGPT-35}
