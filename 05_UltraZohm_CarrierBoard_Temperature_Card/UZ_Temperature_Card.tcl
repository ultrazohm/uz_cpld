
########## Tcl recorder starts at 05/20/21 11:02:00 ##########

set version "2.1"
set proj_dir "E:/01_Repos/Ultrazohm/CPLD_Lattice_local/01_UltraZohm_CarrierBoard_Temperature_Card"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" uz_tempcard_cpld_schematic.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:02:00 ###########


########## Tcl recorder starts at 05/20/21 11:27:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" uz_tempcard_cpld_schematic.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:27:36 ###########


########## Tcl recorder starts at 05/20/21 11:28:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" uz_tempcard_cpld_schematic.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:28:27 ###########


########## Tcl recorder starts at 05/20/21 11:35:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" uz_tempcard_cpld_schematic.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:35:20 ###########


########## Tcl recorder starts at 05/20/21 11:36:03 ##########

# Commands to make the Process: 
# Navigate Hierarchy
# - none -
# Application to view the Process: 
# Navigate Hierarchy
if [runCmd "\"$cpld_bin/hiernav\" uz_tempcard_cpld_schematic.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:36:03 ###########


########## Tcl recorder starts at 05/20/21 11:36:16 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup uz_tempcard_cpld_schematic.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"uz_tempcard_cpld_schematic.bls\" -o \"uz_tempcard_cpld_schematic.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i uz_tempcard_cpld_schematic.bl0 -o uz_tempcard_cpld_schematic.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"uz_tempcard_cpld_schematic.bl1\" -o \"uz_temperature_card.bl2\" -omod \"uz_temperature_card\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_temperature_card -lci uz_temperature_card.lct -log uz_temperature_card.imp -err automake.err -tti uz_temperature_card.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_temperature_card.lct -blifopt uz_temperature_card.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_temperature_card.bl2 -sweep -mergefb -err automake.err -o uz_temperature_card.bl3 @uz_temperature_card.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_temperature_card.lct -dev lc4k -diofft uz_temperature_card.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_temperature_card.bl3 -family AMDMACH -idev van -o uz_temperature_card.bl4 -oxrf uz_temperature_card.xrf -err automake.err @uz_temperature_card.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_temperature_card.lct -dev lc4k -prefit uz_temperature_card.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_temperature_card.bl4 -out uz_temperature_card.bl5 -err automake.err -log uz_temperature_card.log -mod uz_tempcard_cpld_schematic @uz_temperature_card.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_temperature_card.bl5 -o uz_temperature_card.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_temperature_card.bl5 -type BLIF -presrc uz_temperature_card.bl3 -crf uz_temperature_card.crf -sif uz_temperature_card.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_temperature_card.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:36:16 ###########


########## Tcl recorder starts at 05/20/21 11:38:00 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" uz_tempcard_cpld_schematic.bl0 -o uz_tempcard_cpld_schematic.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:00 ###########


########## Tcl recorder starts at 05/20/21 11:38:02 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/blif2eqn\" uz_tempcard_cpld_schematic.bl0 -o uz_tempcard_cpld_schematic.abt -testfix -template \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -prj uz_temperature_card -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:02 ###########


########## Tcl recorder starts at 05/20/21 11:38:04 ##########

# Commands to make the Process: 
# Verilog Test Fixture Declarations
if [runCmd "\"$cpld_bin/sch2tf\" -prj uz_temperature_card uz_tempcard_cpld_schematic.sch  -template \"$install_dir/ispcpld/generic/verilog/tfi.tft\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:04 ###########


########## Tcl recorder starts at 05/20/21 11:38:06 ##########

# Commands to make the Process: 
# Verilog Test Fixture Template
if [runCmd "\"$cpld_bin/sch2tf\" -template \"$install_dir/ispcpld/generic/verilog/tft.tft\" -prj uz_temperature_card -ext .tft uz_tempcard_cpld_schematic.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:06 ###########


########## Tcl recorder starts at 05/20/21 11:38:07 ##########

# Commands to make the Process: 
# VHDL Test Bench Template
if [runCmd "\"$cpld_bin/vhdl\" -tuz_tempcard_cpld_schematic.vht -s uz_tempcard_cpld_schematic.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:07 ###########


########## Tcl recorder starts at 05/20/21 11:38:08 ##########

# Commands to make the Process: 
# Bus Signal Cross Reference
if [runCmd "\"$cpld_bin/vhdl\" -s -lib=lat_vhd uz_tempcard_cpld_schematic.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/exfgen\" -vhd uz_tempcard_cpld_schematic.vhd -out uz_tempcard_cpld_schematic.exf"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:08 ###########


########## Tcl recorder starts at 05/20/21 11:38:14 ##########

# Commands to make the Process: 
# Navigate Hierarchy
# - none -
# Application to view the Process: 
# Navigate Hierarchy
if [runCmd "\"$cpld_bin/hiernav\" uz_tempcard_cpld_schematic.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 11:38:14 ###########


########## Tcl recorder starts at 05/20/21 12:01:20 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci uz_temperature_card.lct -touch uz_temperature_card.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 12:01:20 ###########


########## Tcl recorder starts at 05/20/21 12:01:25 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_temperature_card.bl5 -type BLIF -presrc uz_temperature_card.bl3 -crf uz_temperature_card.crf -sif uz_temperature_card.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_temperature_card.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 12:01:25 ###########


########## Tcl recorder starts at 05/20/21 12:04:04 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i uz_temperature_card.bl5 -o uz_temperature_card.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_temperature_card.bl5 -type BLIF -presrc uz_temperature_card.bl3 -crf uz_temperature_card.crf -sif uz_temperature_card.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_temperature_card.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 12:04:04 ###########


########## Tcl recorder starts at 05/20/21 12:14:34 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_temperature_card.bl5 -type BLIF -presrc uz_temperature_card.bl3 -crf uz_temperature_card.crf -sif uz_temperature_card.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_temperature_card.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 12:14:34 ###########


########## Tcl recorder starts at 05/20/21 13:25:03 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i uz_temperature_card.bl5 -o uz_temperature_card.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_temperature_card.bl5 -type BLIF -presrc uz_temperature_card.bl3 -crf uz_temperature_card.crf -sif uz_temperature_card.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_temperature_card.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 13:25:03 ###########


########## Tcl recorder starts at 05/20/21 13:25:08 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" uz_temperature_card.bl5 -o uz_temperature_card.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 13:25:08 ###########


########## Tcl recorder starts at 05/20/21 13:25:10 ##########

# Commands to make the Process: 
# Fitter Report (Text)
if [catch {open uz_temperature_card.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_temperature_card.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_temperature_card.bl5 -lci uz_temperature_card.lct -d m4s_128_64 -lco uz_temperature_card.lco -html_rpt -fti uz_temperature_card.fti -fmt PLA -tto uz_temperature_card.tt4 -nojed -eqn uz_temperature_card.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_temperature_card.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_temperature_card.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_temperature_card.bl5 -lci uz_temperature_card.lct -d m4s_128_64 -lco uz_temperature_card.lco -html_rpt -fti uz_temperature_card.fti -fmt PLA -tto uz_temperature_card.tt4 -eqn uz_temperature_card.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_temperature_card.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_temperature_card.rs1
file delete uz_temperature_card.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_temperature_card.bl5 -o uz_temperature_card.tda -lci uz_temperature_card.lct -dev m4s_128_64 -family lc4k -mod uz_tempcard_cpld_schematic -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_temperature_card -if uz_temperature_card.jed -j2s -log uz_temperature_card.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/21 13:25:10 ###########


########## Tcl recorder starts at 05/21/21 11:05:06 ##########

set version "2.1"
set proj_dir "E:/01_Repos/Ultrazohm/CPLD_Lattice_local/05_UltraZohm_CarrierBoard_Temperature_Card"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_temperature_card.bl5 -type BLIF -presrc uz_temperature_card.bl3 -crf uz_temperature_card.crf -sif uz_temperature_card.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_temperature_card.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/21/21 11:05:06 ###########


########## Tcl recorder starts at 05/21/21 11:45:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_temperature_card.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_temperature_card.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_temperature_card.bl5 -lci uz_temperature_card.lct -d m4s_128_64 -lco uz_temperature_card.lco -html_rpt -fti uz_temperature_card.fti -fmt PLA -tto uz_temperature_card.tt4 -nojed -eqn uz_temperature_card.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_temperature_card.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_temperature_card.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_temperature_card.bl5 -lci uz_temperature_card.lct -d m4s_128_64 -lco uz_temperature_card.lco -html_rpt -fti uz_temperature_card.fti -fmt PLA -tto uz_temperature_card.tt4 -eqn uz_temperature_card.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_temperature_card.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_temperature_card.rs1
file delete uz_temperature_card.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_temperature_card.bl5 -o uz_temperature_card.tda -lci uz_temperature_card.lct -dev m4s_128_64 -family lc4k -mod uz_tempcard_cpld_schematic -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_temperature_card -if uz_temperature_card.jed -j2s -log uz_temperature_card.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/21/21 11:45:24 ###########


########## Tcl recorder starts at 05/21/21 11:45:32 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup uz_tempcard_cpld_schematic.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"uz_tempcard_cpld_schematic.bls\" -o \"uz_tempcard_cpld_schematic.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i uz_tempcard_cpld_schematic.bl0 -o uz_tempcard_cpld_schematic.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"uz_tempcard_cpld_schematic.bl1\" -o \"uz_temperature_card.bl2\" -omod \"uz_temperature_card\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_temperature_card -lci uz_temperature_card.lct -log uz_temperature_card.imp -err automake.err -tti uz_temperature_card.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_temperature_card.lct -blifopt uz_temperature_card.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_temperature_card.bl2 -sweep -mergefb -err automake.err -o uz_temperature_card.bl3 @uz_temperature_card.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_temperature_card.lct -dev lc4k -diofft uz_temperature_card.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_temperature_card.bl3 -family AMDMACH -idev van -o uz_temperature_card.bl4 -oxrf uz_temperature_card.xrf -err automake.err @uz_temperature_card.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_temperature_card.lct -dev lc4k -prefit uz_temperature_card.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_temperature_card.bl4 -out uz_temperature_card.bl5 -err automake.err -log uz_temperature_card.log -mod uz_tempcard_cpld_schematic @uz_temperature_card.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_temperature_card.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_temperature_card.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_temperature_card.bl5 -lci uz_temperature_card.lct -d m4s_128_64 -lco uz_temperature_card.lco -html_rpt -fti uz_temperature_card.fti -fmt PLA -tto uz_temperature_card.tt4 -nojed -eqn uz_temperature_card.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_temperature_card.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_temperature_card.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_temperature_card.bl5 -lci uz_temperature_card.lct -d m4s_128_64 -lco uz_temperature_card.lco -html_rpt -fti uz_temperature_card.fti -fmt PLA -tto uz_temperature_card.tt4 -eqn uz_temperature_card.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_temperature_card.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_temperature_card.rs1
file delete uz_temperature_card.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_temperature_card.bl5 -o uz_temperature_card.tda -lci uz_temperature_card.lct -dev m4s_128_64 -family lc4k -mod uz_tempcard_cpld_schematic -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_temperature_card -if uz_temperature_card.jed -j2s -log uz_temperature_card.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/21/21 11:45:32 ###########


########## Tcl recorder starts at 05/21/21 11:45:43 ##########

# Commands to make the Process: 
# Timing Analysis
# - none -
# Application to view the Process: 
# Timing Analysis
if [runCmd "\"$cpld_bin/timing\" -prj \"uz_temperature_card\" -tti \"uz_temperature_card.tt4\" -gui -dir \"$proj_dir\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/21/21 11:45:43 ###########

