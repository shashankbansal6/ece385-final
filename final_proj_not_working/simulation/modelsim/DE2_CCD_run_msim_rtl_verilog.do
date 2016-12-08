transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/ece385-final-master/ece385-final-master/DE2_CCD-test {C:/Users/User/Desktop/ece385-final-master/ece385-final-master/DE2_CCD-test/comparator.v}
vlog -sv -work work +incdir+C:/Users/User/Desktop/ece385-final-master/ece385-final-master/DE2_CCD-test {C:/Users/User/Desktop/ece385-final-master/ece385-final-master/DE2_CCD-test/max_digit.sv}

vlog -sv -work work +incdir+C:/Users/User/Desktop/ece385-final-master/ece385-final-master/DE2_CCD-test {C:/Users/User/Desktop/ece385-final-master/ece385-final-master/DE2_CCD-test/testbench_comparator.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_comparator

add wave *
view structure
view signals
run 1000 ns
