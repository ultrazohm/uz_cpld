
########## Tcl recorder starts at 03/31/21 19:45:11 ##########

set version "2.1"
set proj_dir "C:/ZynqUltra/60_Software/cpld_lattice/05_UZ_D_GaN_Inverter"
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
if [runCmd "\"$cpld_bin/sch2jhd\" top_level.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:45:11 ###########


########## Tcl recorder starts at 03/31/21 19:53:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top_level.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:53:11 ###########


########## Tcl recorder starts at 03/31/21 19:55:03 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top_level.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:55:03 ###########


########## Tcl recorder starts at 03/31/21 19:55:49 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_d_gan_inverter.bl2\" -omod \"uz_d_gan_inverter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_d_gan_inverter -lci uz_d_gan_inverter.lct -log uz_d_gan_inverter.imp -err automake.err -tti uz_d_gan_inverter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -blifopt uz_d_gan_inverter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_d_gan_inverter.bl2 -sweep -mergefb -err automake.err -o uz_d_gan_inverter.bl3 @uz_d_gan_inverter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -diofft uz_d_gan_inverter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_d_gan_inverter.bl3 -family AMDMACH -idev van -o uz_d_gan_inverter.bl4 -oxrf uz_d_gan_inverter.xrf -err automake.err @uz_d_gan_inverter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -prefit uz_d_gan_inverter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_d_gan_inverter.bl4 -out uz_d_gan_inverter.bl5 -err automake.err -log uz_d_gan_inverter.log -mod top_level @uz_d_gan_inverter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_d_gan_inverter.bl5 -o uz_d_gan_inverter.sif"] {
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
	puts $rspFile "-nodal -src uz_d_gan_inverter.bl5 -type BLIF -presrc uz_d_gan_inverter.bl3 -crf uz_d_gan_inverter.crf -sif uz_d_gan_inverter.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_d_gan_inverter.lct
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

########## Tcl recorder end at 03/31/21 19:55:49 ###########


########## Tcl recorder starts at 03/31/21 19:55:55 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_d_gan_inverter.bl2\" -omod \"uz_d_gan_inverter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_d_gan_inverter -lci uz_d_gan_inverter.lct -log uz_d_gan_inverter.imp -err automake.err -tti uz_d_gan_inverter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -blifopt uz_d_gan_inverter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_d_gan_inverter.bl2 -sweep -mergefb -err automake.err -o uz_d_gan_inverter.bl3 @uz_d_gan_inverter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -diofft uz_d_gan_inverter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_d_gan_inverter.bl3 -family AMDMACH -idev van -o uz_d_gan_inverter.bl4 -oxrf uz_d_gan_inverter.xrf -err automake.err @uz_d_gan_inverter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -prefit uz_d_gan_inverter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_d_gan_inverter.bl4 -out uz_d_gan_inverter.bl5 -err automake.err -log uz_d_gan_inverter.log -mod top_level @uz_d_gan_inverter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_d_gan_inverter.bl5 -o uz_d_gan_inverter.sif"] {
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
	puts $rspFile "-nodal -src uz_d_gan_inverter.bl5 -type BLIF -presrc uz_d_gan_inverter.bl3 -crf uz_d_gan_inverter.crf -sif uz_d_gan_inverter.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_d_gan_inverter.lct
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

########## Tcl recorder end at 03/31/21 19:55:55 ###########


########## Tcl recorder starts at 03/31/21 19:57:23 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" top_level.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:57:23 ###########


########## Tcl recorder starts at 03/31/21 19:57:29 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_d_gan_inverter.bl2\" -omod \"uz_d_gan_inverter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_d_gan_inverter -lci uz_d_gan_inverter.lct -log uz_d_gan_inverter.imp -err automake.err -tti uz_d_gan_inverter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci uz_d_gan_inverter.lct -touch uz_d_gan_inverter.imp
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

########## Tcl recorder end at 03/31/21 19:57:29 ###########


########## Tcl recorder starts at 03/31/21 19:57:44 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" top_level.bl0 -o top_level.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:57:44 ###########


########## Tcl recorder starts at 03/31/21 19:57:48 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:57:48 ###########


########## Tcl recorder starts at 03/31/21 19:57:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top_level.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:57:53 ###########


########## Tcl recorder starts at 03/31/21 19:57:56 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top_level.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 19:57:56 ###########


########## Tcl recorder starts at 03/31/21 19:58:02 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_d_gan_inverter.bl2\" -omod \"uz_d_gan_inverter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_d_gan_inverter -lci uz_d_gan_inverter.lct -log uz_d_gan_inverter.imp -err automake.err -tti uz_d_gan_inverter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -blifopt uz_d_gan_inverter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_d_gan_inverter.bl2 -sweep -mergefb -err automake.err -o uz_d_gan_inverter.bl3 @uz_d_gan_inverter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -diofft uz_d_gan_inverter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_d_gan_inverter.bl3 -family AMDMACH -idev van -o uz_d_gan_inverter.bl4 -oxrf uz_d_gan_inverter.xrf -err automake.err @uz_d_gan_inverter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -prefit uz_d_gan_inverter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_d_gan_inverter.bl4 -out uz_d_gan_inverter.bl5 -err automake.err -log uz_d_gan_inverter.log -mod top_level @uz_d_gan_inverter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_d_gan_inverter.bl5 -o uz_d_gan_inverter.sif"] {
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
	puts $rspFile "-nodal -src uz_d_gan_inverter.bl5 -type BLIF -presrc uz_d_gan_inverter.bl3 -crf uz_d_gan_inverter.crf -sif uz_d_gan_inverter.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_d_gan_inverter.lct
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

########## Tcl recorder end at 03/31/21 19:58:02 ###########


########## Tcl recorder starts at 03/31/21 20:07:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_d_gan_inverter.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_d_gan_inverter.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_d_gan_inverter.bl5 -lci uz_d_gan_inverter.lct -d m4s_128_64 -lco uz_d_gan_inverter.lco -html_rpt -fti uz_d_gan_inverter.fti -fmt PLA -tto uz_d_gan_inverter.tt4 -nojed -eqn uz_d_gan_inverter.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_d_gan_inverter.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_d_gan_inverter.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_d_gan_inverter.bl5 -lci uz_d_gan_inverter.lct -d m4s_128_64 -lco uz_d_gan_inverter.lco -html_rpt -fti uz_d_gan_inverter.fti -fmt PLA -tto uz_d_gan_inverter.tt4 -eqn uz_d_gan_inverter.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_d_gan_inverter.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_d_gan_inverter.rs1
file delete uz_d_gan_inverter.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_d_gan_inverter.bl5 -o uz_d_gan_inverter.tda -lci uz_d_gan_inverter.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_d_gan_inverter -if uz_d_gan_inverter.jed -j2s -log uz_d_gan_inverter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 20:07:30 ###########


########## Tcl recorder starts at 03/31/21 20:07:53 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_d_gan_inverter.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_d_gan_inverter.lco
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

########## Tcl recorder end at 03/31/21 20:07:53 ###########


########## Tcl recorder starts at 03/31/21 20:11:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top_level.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 20:11:44 ###########


########## Tcl recorder starts at 03/31/21 20:11:51 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top_level.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bls\" -o \"top_level.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_d_gan_inverter.bl2\" -omod \"uz_d_gan_inverter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_d_gan_inverter -lci uz_d_gan_inverter.lct -log uz_d_gan_inverter.imp -err automake.err -tti uz_d_gan_inverter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -blifopt uz_d_gan_inverter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_d_gan_inverter.bl2 -sweep -mergefb -err automake.err -o uz_d_gan_inverter.bl3 @uz_d_gan_inverter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -diofft uz_d_gan_inverter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_d_gan_inverter.bl3 -family AMDMACH -idev van -o uz_d_gan_inverter.bl4 -oxrf uz_d_gan_inverter.xrf -err automake.err @uz_d_gan_inverter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_d_gan_inverter.lct -dev lc4k -prefit uz_d_gan_inverter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_d_gan_inverter.bl4 -out uz_d_gan_inverter.bl5 -err automake.err -log uz_d_gan_inverter.log -mod top_level @uz_d_gan_inverter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_d_gan_inverter.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_d_gan_inverter.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_d_gan_inverter.bl5 -lci uz_d_gan_inverter.lct -d m4s_128_64 -lco uz_d_gan_inverter.lco -html_rpt -fti uz_d_gan_inverter.fti -fmt PLA -tto uz_d_gan_inverter.tt4 -nojed -eqn uz_d_gan_inverter.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_d_gan_inverter.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_d_gan_inverter.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_d_gan_inverter.bl5 -lci uz_d_gan_inverter.lct -d m4s_128_64 -lco uz_d_gan_inverter.lco -html_rpt -fti uz_d_gan_inverter.fti -fmt PLA -tto uz_d_gan_inverter.tt4 -eqn uz_d_gan_inverter.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_d_gan_inverter.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_d_gan_inverter.rs1
file delete uz_d_gan_inverter.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_d_gan_inverter.bl5 -o uz_d_gan_inverter.tda -lci uz_d_gan_inverter.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_d_gan_inverter -if uz_d_gan_inverter.jed -j2s -log uz_d_gan_inverter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/21 20:11:51 ###########


########## Tcl recorder starts at 03/31/21 20:13:55 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_d_gan_inverter.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_d_gan_inverter.lco
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

########## Tcl recorder end at 03/31/21 20:13:55 ###########

