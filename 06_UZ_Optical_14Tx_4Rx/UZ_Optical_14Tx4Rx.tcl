
########## Tcl recorder starts at 03/05/21 20:26:06 ##########

set version "2.0"
set proj_dir "C:/Users/ga92wum/git/UltraZohm/Software/CPLD/06_UZ_Optical_14Tx_4Rx"
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

########## Tcl recorder end at 03/05/21 20:26:06 ###########


########## Tcl recorder starts at 03/05/21 20:26:13 ##########

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

########## Tcl recorder end at 03/05/21 20:26:13 ###########


########## Tcl recorder starts at 03/05/21 20:26:28 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" top_level.bl0 -o top_level.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 20:26:28 ###########


########## Tcl recorder starts at 03/05/21 20:26:44 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_optical_14tx4rx.bl2\" -omod \"uz_optical_14tx4rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_optical_14tx4rx -lci uz_optical_14tx4rx.lct -log uz_optical_14tx4rx.imp -err automake.err -tti uz_optical_14tx4rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -blifopt uz_optical_14tx4rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_optical_14tx4rx.bl2 -sweep -mergefb -err automake.err -o uz_optical_14tx4rx.bl3 @uz_optical_14tx4rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -diofft uz_optical_14tx4rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_optical_14tx4rx.bl3 -family AMDMACH -idev van -o uz_optical_14tx4rx.bl4 -oxrf uz_optical_14tx4rx.xrf -err automake.err @uz_optical_14tx4rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -prefit uz_optical_14tx4rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_optical_14tx4rx.bl4 -out uz_optical_14tx4rx.bl5 -err automake.err -log uz_optical_14tx4rx.log -mod top_level @uz_optical_14tx4rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.sif"] {
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
	puts $rspFile "-nodal -src uz_optical_14tx4rx.bl5 -type BLIF -presrc uz_optical_14tx4rx.bl3 -crf uz_optical_14tx4rx.crf -sif uz_optical_14tx4rx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_optical_14tx4rx.lct
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

########## Tcl recorder end at 03/05/21 20:26:44 ###########


########## Tcl recorder starts at 03/05/21 20:42:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_optical_14tx4rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -nojed -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_optical_14tx4rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_optical_14tx4rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_optical_14tx4rx.rs1
file delete uz_optical_14tx4rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.tda -lci uz_optical_14tx4rx.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 20:42:31 ###########


########## Tcl recorder starts at 03/05/21 20:45:31 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_optical_14tx4rx.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_optical_14tx4rx.lco
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

########## Tcl recorder end at 03/05/21 20:45:31 ###########


########## Tcl recorder starts at 03/05/21 20:47:47 ##########

# Commands to make the Process: 
# Post-Fit Re-Compile
# - none -
# Application to view the Process: 
# Post-Fit Re-Compile
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_optical_14tx4rx.bl5 -type BLIF -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_optical_14tx4rx.lct -prc uz_optical_14tx4rx.lco -log uz_optical_14tx4rx.log -touch uz_optical_14tx4rx.fti
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

########## Tcl recorder end at 03/05/21 20:47:47 ###########


########## Tcl recorder starts at 03/05/21 20:53:06 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.sif"] {
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
	puts $rspFile "-nodal -src uz_optical_14tx4rx.bl5 -type BLIF -presrc uz_optical_14tx4rx.bl3 -crf uz_optical_14tx4rx.crf -sif uz_optical_14tx4rx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_optical_14tx4rx.lct
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

########## Tcl recorder end at 03/05/21 20:53:06 ###########


########## Tcl recorder starts at 03/05/21 20:55:04 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_optical_14tx4rx.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_optical_14tx4rx.lco
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

########## Tcl recorder end at 03/05/21 20:55:04 ###########


########## Tcl recorder starts at 03/05/21 20:55:50 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_optical_14tx4rx.bl2\" -omod \"uz_optical_14tx4rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_optical_14tx4rx -lci uz_optical_14tx4rx.lct -log uz_optical_14tx4rx.imp -err automake.err -tti uz_optical_14tx4rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -blifopt uz_optical_14tx4rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_optical_14tx4rx.bl2 -sweep -mergefb -err automake.err -o uz_optical_14tx4rx.bl3 @uz_optical_14tx4rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -diofft uz_optical_14tx4rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_optical_14tx4rx.bl3 -family AMDMACH -idev van -o uz_optical_14tx4rx.bl4 -oxrf uz_optical_14tx4rx.xrf -err automake.err @uz_optical_14tx4rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -prefit uz_optical_14tx4rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_optical_14tx4rx.bl4 -out uz_optical_14tx4rx.bl5 -err automake.err -log uz_optical_14tx4rx.log -mod top_level @uz_optical_14tx4rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_optical_14tx4rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -nojed -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_optical_14tx4rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_optical_14tx4rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_optical_14tx4rx.rs1
file delete uz_optical_14tx4rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.tda -lci uz_optical_14tx4rx.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_optical_14tx4rx.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_optical_14tx4rx.lco
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

########## Tcl recorder end at 03/05/21 20:55:50 ###########


########## Tcl recorder starts at 03/05/21 20:56:03 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 20:56:03 ###########


########## Tcl recorder starts at 03/05/21 20:56:11 ##########

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

########## Tcl recorder end at 03/05/21 20:56:11 ###########


########## Tcl recorder starts at 03/05/21 20:56:17 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 20:56:17 ###########


########## Tcl recorder starts at 03/05/21 20:56:22 ##########

# Commands to make the Process: 
# Fitter Report (Text)
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_optical_14tx4rx.bl2\" -omod \"uz_optical_14tx4rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_optical_14tx4rx -lci uz_optical_14tx4rx.lct -log uz_optical_14tx4rx.imp -err automake.err -tti uz_optical_14tx4rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -blifopt uz_optical_14tx4rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_optical_14tx4rx.bl2 -sweep -mergefb -err automake.err -o uz_optical_14tx4rx.bl3 @uz_optical_14tx4rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -diofft uz_optical_14tx4rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_optical_14tx4rx.bl3 -family AMDMACH -idev van -o uz_optical_14tx4rx.bl4 -oxrf uz_optical_14tx4rx.xrf -err automake.err @uz_optical_14tx4rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -prefit uz_optical_14tx4rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_optical_14tx4rx.bl4 -out uz_optical_14tx4rx.bl5 -err automake.err -log uz_optical_14tx4rx.log -mod top_level @uz_optical_14tx4rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_optical_14tx4rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -nojed -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_optical_14tx4rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_optical_14tx4rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_optical_14tx4rx.rs1
file delete uz_optical_14tx4rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.tda -lci uz_optical_14tx4rx.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 20:56:22 ###########


########## Tcl recorder starts at 03/05/21 21:00:38 ##########

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

########## Tcl recorder end at 03/05/21 21:00:38 ###########


########## Tcl recorder starts at 03/05/21 21:00:43 ##########

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

########## Tcl recorder end at 03/05/21 21:00:43 ###########


########## Tcl recorder starts at 03/05/21 21:00:47 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_optical_14tx4rx.bl2\" -omod \"uz_optical_14tx4rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_optical_14tx4rx -lci uz_optical_14tx4rx.lct -log uz_optical_14tx4rx.imp -err automake.err -tti uz_optical_14tx4rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -blifopt uz_optical_14tx4rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_optical_14tx4rx.bl2 -sweep -mergefb -err automake.err -o uz_optical_14tx4rx.bl3 @uz_optical_14tx4rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -diofft uz_optical_14tx4rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_optical_14tx4rx.bl3 -family AMDMACH -idev van -o uz_optical_14tx4rx.bl4 -oxrf uz_optical_14tx4rx.xrf -err automake.err @uz_optical_14tx4rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -prefit uz_optical_14tx4rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_optical_14tx4rx.bl4 -out uz_optical_14tx4rx.bl5 -err automake.err -log uz_optical_14tx4rx.log -mod top_level @uz_optical_14tx4rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.sif"] {
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
	puts $rspFile "-nodal -src uz_optical_14tx4rx.bl5 -type BLIF -presrc uz_optical_14tx4rx.bl3 -crf uz_optical_14tx4rx.crf -sif uz_optical_14tx4rx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_optical_14tx4rx.lct
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

########## Tcl recorder end at 03/05/21 21:00:47 ###########


########## Tcl recorder starts at 03/05/21 21:01:16 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_optical_14tx4rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -nojed -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_optical_14tx4rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_optical_14tx4rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_optical_14tx4rx.rs1
file delete uz_optical_14tx4rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.tda -lci uz_optical_14tx4rx.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 21:01:16 ###########


########## Tcl recorder starts at 03/05/21 21:01:59 ##########

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

########## Tcl recorder end at 03/05/21 21:01:59 ###########


########## Tcl recorder starts at 03/05/21 21:02:06 ##########

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

########## Tcl recorder end at 03/05/21 21:02:06 ###########


########## Tcl recorder starts at 03/05/21 21:02:10 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_optical_14tx4rx.bl2\" -omod \"uz_optical_14tx4rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_optical_14tx4rx -lci uz_optical_14tx4rx.lct -log uz_optical_14tx4rx.imp -err automake.err -tti uz_optical_14tx4rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -blifopt uz_optical_14tx4rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_optical_14tx4rx.bl2 -sweep -mergefb -err automake.err -o uz_optical_14tx4rx.bl3 @uz_optical_14tx4rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -diofft uz_optical_14tx4rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_optical_14tx4rx.bl3 -family AMDMACH -idev van -o uz_optical_14tx4rx.bl4 -oxrf uz_optical_14tx4rx.xrf -err automake.err @uz_optical_14tx4rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_optical_14tx4rx.lct -dev lc4k -prefit uz_optical_14tx4rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_optical_14tx4rx.bl4 -out uz_optical_14tx4rx.bl5 -err automake.err -log uz_optical_14tx4rx.log -mod top_level @uz_optical_14tx4rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_optical_14tx4rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -nojed -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_optical_14tx4rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_optical_14tx4rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_optical_14tx4rx.bl5 -lci uz_optical_14tx4rx.lct -d m4s_128_64 -lco uz_optical_14tx4rx.lco -html_rpt -fti uz_optical_14tx4rx.fti -fmt PLA -tto uz_optical_14tx4rx.tt4 -eqn uz_optical_14tx4rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_optical_14tx4rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_optical_14tx4rx.rs1
file delete uz_optical_14tx4rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_optical_14tx4rx.bl5 -o uz_optical_14tx4rx.tda -lci uz_optical_14tx4rx.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_optical_14tx4rx -if uz_optical_14tx4rx.jed -j2s -log uz_optical_14tx4rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/21 21:02:10 ###########

