#####################################################################
# SDC file may be customized per design
#####################################################################

set sdc_version 1.6
set_asap7_units

current_design $TOPCELL

create_clock -name $clk_name -add -period $clk_period [get_ports $clk_name]

# Transition/Slew settings
set_max_transition [expr 0.3*$clk_period] [current_design]
set_max_transition [expr 0.1*$clk_period] [get_clocks $clk_name] -clock_path
set_clock_transition [expr 0.1*$clk_period] [get_clocks $clk_name]

# % of cycle given to parent for input/output paths, e.g., 0.3 gives 30% of the cycle to the parent
set_input_delay -max -clock [get_clocks $clk_name] [expr 0.3 * $clk_period] [remove_from_collection [all_inputs] [get_ports $clk_name]]
set_input_delay -min -clock [get_clocks $clk_name] [expr 0.0 * $clk_period] [remove_from_collection [all_inputs] [get_ports $clk_name]]
set_output_delay -max -clock [get_clocks $clk_name] [expr 0.3 * $clk_period] [all_outputs]
set_output_delay -min -clock [get_clocks $clk_name] [expr 0.0 * $clk_period] [all_outputs]

# Uncertainty to give to clocks
set_clock_uncertainty 5 [all_clocks]

set_load 10.0 [all_outputs]
