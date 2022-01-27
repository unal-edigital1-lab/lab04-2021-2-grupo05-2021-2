transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/Users/Administrador/Documents/UNAL\ Docs/2021\ -\ II/Electronica\ Digital\ I/Lab/lab04-2021-2-grupo05-2021-2/src {G:/Users/Administrador/Documents/UNAL Docs/2021 - II/Electronica Digital I/Lab/lab04-2021-2-grupo05-2021-2/src/display.v}
vlog -vlog01compat -work work +incdir+G:/Users/Administrador/Documents/UNAL\ Docs/2021\ -\ II/Electronica\ Digital\ I/Lab/lab04-2021-2-grupo05-2021-2/src {G:/Users/Administrador/Documents/UNAL Docs/2021 - II/Electronica Digital I/Lab/lab04-2021-2-grupo05-2021-2/src/BCDtoSSeg.v}

vlog -vlog01compat -work work +incdir+G:/Users/Administrador/Documents/UNAL\ Docs/2021\ -\ II/Electronica\ Digital\ I/Lab/lab04-2021-2-grupo05-2021-2/src {G:/Users/Administrador/Documents/UNAL Docs/2021 - II/Electronica Digital I/Lab/lab04-2021-2-grupo05-2021-2/src/TB_display.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  display

add wave *
view structure
view signals
run -all
