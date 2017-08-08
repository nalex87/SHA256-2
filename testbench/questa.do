file delete -force work
## Create a work library
vlib work
## compile the verilog files
vlog -reportprogress -sv -f tb_pkg.f +acc

## run simulator
## +acc adds the full debug
## -L altera_mef_ver adds the altera library for megafunctions, etc
## it invokes a library search, and compiles those files into work
## top is the top level
## lvds_adc_top is the top level DUT

##Start Simulator
#vsim -L altera_mf_ver -L altera_lnsim_ver -L altera_ver -L lpm_ver -L sgate_ver -L cyclonev_ver -voptargs="+acc" top
vsim -voptargs="+acc" top

## Creates a wave log file
log -r /*

## open the Wave window
view wave

## This opens the script which adds signals
do wave.do
## Run the sim till stop
run -all
