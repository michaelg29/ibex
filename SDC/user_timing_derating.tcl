
# Optional.
# Allows user to specify custom timing derating scale factors.

#####################################################################
# User-specified de-rating
#####################################################################
# adds pessimism to the hold analysis by making the latching clock path 10 percent slower.
set_timing_derate -delay_corner dc_min -late 1.1
# adds pessimism to the setup analysis by making the latching clock path 10 percent faster.
set_timing_derate -delay_corner dc_max -early 0.9
report_timing_derate
