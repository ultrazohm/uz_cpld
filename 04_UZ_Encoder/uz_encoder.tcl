
########## Tcl recorder starts at 01/22/21 10:20:56 ##########

set version "2.0"
set proj_dir "C:/Users/ga92wum/git/UltraZohm/Software/CPLD/04_UZ_Encoder"
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

########## Tcl recorder end at 01/22/21 10:20:56 ###########


########## Tcl recorder starts at 01/22/21 10:21:10 ##########

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

########## Tcl recorder end at 01/22/21 10:21:10 ###########


########## Tcl recorder starts at 01/22/21 10:21:54 ##########

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

########## Tcl recorder end at 01/22/21 10:21:54 ###########


########## Tcl recorder starts at 01/22/21 10:27:00 ##########

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

########## Tcl recorder end at 01/22/21 10:27:00 ###########


########## Tcl recorder starts at 01/22/21 10:39:09 ##########

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

########## Tcl recorder end at 01/22/21 10:39:09 ###########


########## Tcl recorder starts at 01/22/21 10:39:21 ##########

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

########## Tcl recorder end at 01/22/21 10:39:21 ###########


########## Tcl recorder starts at 01/22/21 10:39:26 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod top_level @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 10:39:26 ###########


########## Tcl recorder starts at 01/22/21 10:40:16 ##########

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

########## Tcl recorder end at 01/22/21 10:40:16 ###########


########## Tcl recorder starts at 01/22/21 10:40:46 ##########

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

########## Tcl recorder end at 01/22/21 10:40:47 ###########


########## Tcl recorder starts at 01/22/21 10:40:50 ##########

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

########## Tcl recorder end at 01/22/21 10:40:50 ###########


########## Tcl recorder starts at 01/22/21 10:40:53 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod top_level @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 10:40:53 ###########


########## Tcl recorder starts at 01/22/21 10:42:22 ##########

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

########## Tcl recorder end at 01/22/21 10:42:22 ###########


########## Tcl recorder starts at 01/22/21 10:42:30 ##########

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

########## Tcl recorder end at 01/22/21 10:42:30 ###########


########## Tcl recorder starts at 01/22/21 10:42:33 ##########

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

########## Tcl recorder end at 01/22/21 10:42:33 ###########


########## Tcl recorder starts at 01/22/21 10:42:37 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod top_level @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 10:42:37 ###########


########## Tcl recorder starts at 01/22/21 11:22:22 ##########

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

########## Tcl recorder end at 01/22/21 11:22:22 ###########


########## Tcl recorder starts at 01/22/21 11:24:59 ##########

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

########## Tcl recorder end at 01/22/21 11:24:59 ###########


########## Tcl recorder starts at 01/22/21 11:25:02 ##########

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

########## Tcl recorder end at 01/22/21 11:25:02 ###########


########## Tcl recorder starts at 01/22/21 11:25:43 ##########

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

########## Tcl recorder end at 01/22/21 11:25:43 ###########


########## Tcl recorder starts at 01/22/21 11:26:52 ##########

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

########## Tcl recorder end at 01/22/21 11:26:52 ###########


########## Tcl recorder starts at 01/22/21 11:27:08 ##########

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

########## Tcl recorder end at 01/22/21 11:27:08 ###########


########## Tcl recorder starts at 01/22/21 11:40:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" aa.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 11:40:59 ###########


########## Tcl recorder starts at 01/22/21 11:44:00 ##########

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

########## Tcl recorder end at 01/22/21 11:44:00 ###########


########## Tcl recorder starts at 01/22/21 11:44:00 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
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
if [runCmd "\"$cpld_bin/blif2eqn\" top_level.bl0 -o top_level.abt -testfix -template \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -prj uz_encoder -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 11:44:00 ###########


########## Tcl recorder starts at 01/22/21 11:52:13 ##########

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

########## Tcl recorder end at 01/22/21 11:52:13 ###########


########## Tcl recorder starts at 01/22/21 11:53:50 ##########

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

########## Tcl recorder end at 01/22/21 11:53:50 ###########


########## Tcl recorder starts at 01/22/21 11:53:51 ##########

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

########## Tcl recorder end at 01/22/21 11:53:51 ###########


########## Tcl recorder starts at 01/22/21 11:55:05 ##########

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

########## Tcl recorder end at 01/22/21 11:55:05 ###########


########## Tcl recorder starts at 01/22/21 11:55:54 ##########

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

########## Tcl recorder end at 01/22/21 11:55:54 ###########


########## Tcl recorder starts at 01/22/21 11:56:11 ##########

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

########## Tcl recorder end at 01/22/21 11:56:11 ###########


########## Tcl recorder starts at 01/22/21 11:56:14 ##########

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

########## Tcl recorder end at 01/22/21 11:56:14 ###########


########## Tcl recorder starts at 01/22/21 11:56:18 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/blif2eqn\" top_level.bl0 -o top_level.abt -testfix -template \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -prj uz_encoder -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 11:56:18 ###########


########## Tcl recorder starts at 01/22/21 11:56:40 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod top_level @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 11:56:40 ###########


########## Tcl recorder starts at 01/22/21 11:57:49 ##########

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

########## Tcl recorder end at 01/22/21 11:57:49 ###########


########## Tcl recorder starts at 01/22/21 11:59:07 ##########

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

########## Tcl recorder end at 01/22/21 11:59:07 ###########


########## Tcl recorder starts at 01/22/21 11:59:53 ##########

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

########## Tcl recorder end at 01/22/21 11:59:53 ###########


########## Tcl recorder starts at 01/22/21 12:00:23 ##########

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

########## Tcl recorder end at 01/22/21 12:00:23 ###########


########## Tcl recorder starts at 01/22/21 12:00:28 ##########

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

########## Tcl recorder end at 01/22/21 12:00:28 ###########


########## Tcl recorder starts at 01/22/21 12:00:30 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod top_level @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 12:00:30 ###########


########## Tcl recorder starts at 01/22/21 12:01:19 ##########

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

########## Tcl recorder end at 01/22/21 12:01:19 ###########


########## Tcl recorder starts at 01/22/21 12:01:23 ##########

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

########## Tcl recorder end at 01/22/21 12:01:23 ###########


########## Tcl recorder starts at 01/22/21 12:01:25 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" top_level"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 12:01:25 ###########


########## Tcl recorder starts at 01/22/21 12:01:31 ##########

# Commands to make the Process: 
# Navigate Hierarchy
# - none -
# Application to view the Process: 
# Navigate Hierarchy
if [runCmd "\"$cpld_bin/hiernav\" top_level.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 12:01:31 ###########


########## Tcl recorder starts at 01/22/21 12:01:37 ##########

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

########## Tcl recorder end at 01/22/21 12:01:37 ###########


########## Tcl recorder starts at 01/22/21 12:01:38 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" -i top_level.bl0 -o top_level.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 12:01:38 ###########


########## Tcl recorder starts at 01/22/21 12:01:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod top_level @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 12:01:45 ###########


########## Tcl recorder starts at 01/22/21 12:05:34 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 12:05:34 ###########


########## Tcl recorder starts at 01/22/21 14:50:24 ##########

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

########## Tcl recorder end at 01/22/21 14:50:24 ###########


########## Tcl recorder starts at 01/22/21 14:52:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 14:52:40 ###########


########## Tcl recorder starts at 01/22/21 15:05:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:05:07 ###########


########## Tcl recorder starts at 01/22/21 15:07:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:07:47 ###########


########## Tcl recorder starts at 01/22/21 15:17:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:17:52 ###########


########## Tcl recorder starts at 01/22/21 15:18:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:18:14 ###########


########## Tcl recorder starts at 01/22/21 15:18:14 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:18:14 ###########


########## Tcl recorder starts at 01/22/21 15:20:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:20:03 ###########


########## Tcl recorder starts at 01/22/21 15:20:09 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:20:09 ###########


########## Tcl recorder starts at 01/22/21 15:20:16 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" uz_encoder.jid  CPLD_Encoder"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:20:16 ###########


########## Tcl recorder starts at 01/22/21 15:21:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:21:04 ###########


########## Tcl recorder starts at 01/22/21 15:21:07 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:21:07 ###########


########## Tcl recorder starts at 01/22/21 15:21:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:21:36 ###########


########## Tcl recorder starts at 01/22/21 15:21:39 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:21:39 ###########


########## Tcl recorder starts at 01/22/21 15:21:42 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:21:42 ###########


########## Tcl recorder starts at 01/22/21 15:21:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CPLD_Encoder"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:21:45 ###########


########## Tcl recorder starts at 01/22/21 15:21:50 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 15:21:50 ###########


########## Tcl recorder starts at 01/22/21 15:22:02 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod CPLD_Encoder @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 15:22:02 ###########


########## Tcl recorder starts at 01/22/21 15:44:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:44:38 ###########


########## Tcl recorder starts at 01/22/21 15:44:47 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:44:47 ###########


########## Tcl recorder starts at 01/22/21 15:45:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:45:37 ###########


########## Tcl recorder starts at 01/22/21 15:45:44 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:45:44 ###########


########## Tcl recorder starts at 01/22/21 15:46:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:46:05 ###########


########## Tcl recorder starts at 01/22/21 15:46:09 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:46:09 ###########


########## Tcl recorder starts at 01/22/21 15:46:12 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:46:12 ###########


########## Tcl recorder starts at 01/22/21 15:46:13 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn -list  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:46:13 ###########


########## Tcl recorder starts at 01/22/21 15:46:15 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" CPLD_Encoder.bl0 -o CPLD_Encoder.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:46:15 ###########


########## Tcl recorder starts at 01/22/21 15:46:18 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CPLD_Encoder"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:46:18 ###########


########## Tcl recorder starts at 01/22/21 15:46:30 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 15:46:30 ###########


########## Tcl recorder starts at 01/22/21 15:46:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod CPLD_Encoder @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 15:46:45 ###########


########## Tcl recorder starts at 01/22/21 15:48:08 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 15:48:08 ###########


########## Tcl recorder starts at 01/22/21 15:48:13 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 15:48:13 ###########


########## Tcl recorder starts at 01/22/21 15:51:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:51:15 ###########


########## Tcl recorder starts at 01/22/21 15:51:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:51:38 ###########


########## Tcl recorder starts at 01/22/21 15:51:41 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:51:41 ###########


########## Tcl recorder starts at 01/22/21 15:52:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:52:13 ###########


########## Tcl recorder starts at 01/22/21 15:52:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:52:47 ###########


########## Tcl recorder starts at 01/22/21 15:52:51 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:52:51 ###########


########## Tcl recorder starts at 01/22/21 15:52:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:52:59 ###########


########## Tcl recorder starts at 01/22/21 15:53:01 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:53:01 ###########


########## Tcl recorder starts at 01/22/21 15:53:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:53:09 ###########


########## Tcl recorder starts at 01/22/21 15:53:11 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:53:11 ###########


########## Tcl recorder starts at 01/22/21 15:53:23 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 15:53:23 ###########


########## Tcl recorder starts at 01/22/21 15:53:31 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod CPLD_Encoder @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 15:53:31 ###########


########## Tcl recorder starts at 01/22/21 15:57:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 15:57:40 ###########


########## Tcl recorder starts at 01/22/21 16:05:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:05:33 ###########


########## Tcl recorder starts at 01/22/21 16:06:01 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:06:01 ###########


########## Tcl recorder starts at 01/22/21 16:06:02 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" uz_encoder.jid  CPLD_Encoder"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:06:02 ###########


########## Tcl recorder starts at 01/22/21 16:06:07 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:06:07 ###########


########## Tcl recorder starts at 01/22/21 16:06:08 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn -list  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:06:08 ###########


########## Tcl recorder starts at 01/22/21 16:06:12 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" CPLD_Encoder.bl0 -o CPLD_Encoder.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:06:12 ###########


########## Tcl recorder starts at 01/22/21 16:06:31 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 16:06:31 ###########


########## Tcl recorder starts at 01/22/21 16:06:38 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod CPLD_Encoder @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 16:06:38 ###########


########## Tcl recorder starts at 01/22/21 16:07:11 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CPLD_Encoder"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:07:11 ###########


########## Tcl recorder starts at 01/22/21 16:07:22 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -vec -ovec top_level_encoder.tmv -sim uz_encoder -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:07:22 ###########


########## Tcl recorder starts at 01/22/21 16:07:35 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 16:07:35 ###########


########## Tcl recorder starts at 01/22/21 16:07:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_encoder.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.bl5 -lci uz_encoder.lct -d m4s_128_64 -lco uz_encoder.lco -html_rpt -fti uz_encoder.fti -fmt PLA -tto uz_encoder.tt4 -nojed -eqn uz_encoder.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_encoder.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.bl5 -lci uz_encoder.lct -d m4s_128_64 -lco uz_encoder.lco -html_rpt -fti uz_encoder.fti -fmt PLA -tto uz_encoder.tt4 -eqn uz_encoder.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_encoder.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_encoder.rs1
file delete uz_encoder.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_encoder.bl5 -o uz_encoder.tda -lci uz_encoder.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec top_level_encoder.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_encoder -if uz_encoder.jed -j2s -log uz_encoder.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:07:58 ###########


########## Tcl recorder starts at 01/22/21 16:08:02 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_encoder.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_encoder.lco
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

########## Tcl recorder end at 01/22/21 16:08:02 ###########


########## Tcl recorder starts at 01/22/21 16:08:44 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 16:08:44 ###########


########## Tcl recorder starts at 01/22/21 16:09:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_encoder.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.bl5 -lci uz_encoder.lct -d m4s_128_64 -lco uz_encoder.lco -html_rpt -fti uz_encoder.fti -fmt PLA -tto uz_encoder.tt4 -nojed -eqn uz_encoder.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_encoder.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.bl5 -lci uz_encoder.lct -d m4s_128_64 -lco uz_encoder.lco -html_rpt -fti uz_encoder.fti -fmt PLA -tto uz_encoder.tt4 -eqn uz_encoder.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_encoder.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_encoder.rs1
file delete uz_encoder.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_encoder.bl5 -o uz_encoder.tda -lci uz_encoder.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec top_level_encoder.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_encoder -if uz_encoder.jed -j2s -log uz_encoder.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 16:09:52 ###########


########## Tcl recorder starts at 01/22/21 16:09:59 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src uz_encoder.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -postfit -lci uz_encoder.lco
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

########## Tcl recorder end at 01/22/21 16:09:59 ###########


########## Tcl recorder starts at 01/22/21 16:10:29 ##########

# Commands to make the Process: 
# Report File
if [catch {open uz_encoder.rsp w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rsp: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.tt4 -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -pla uz_encoder.tt4 -lci uz_encoder.lct -prj uz_encoder -dir \"$proj_dir\" -err automake.err -log uz_encoder.nrp -exf CPLD_Encoder.exf 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" @uz_encoder.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_encoder.rsp

########## Tcl recorder end at 01/22/21 16:10:29 ###########


########## Tcl recorder starts at 01/22/21 16:19:32 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 16:19:32 ###########


########## Tcl recorder starts at 01/22/21 17:41:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:41:58 ###########


########## Tcl recorder starts at 01/22/21 17:42:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:42:52 ###########


########## Tcl recorder starts at 01/22/21 17:42:56 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:42:56 ###########


########## Tcl recorder starts at 01/22/21 17:42:59 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:42:59 ###########


########## Tcl recorder starts at 01/22/21 17:43:00 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -syn -list  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:43:00 ###########


########## Tcl recorder starts at 01/22/21 17:43:02 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" CPLD_Encoder.bl0 -o CPLD_Encoder.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:43:02 ###########


########## Tcl recorder starts at 01/22/21 17:43:07 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_encoder.bl2\" -omod \"uz_encoder\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder -lci uz_encoder.lct -log uz_encoder.imp -err automake.err -tti uz_encoder.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_encoder.lct -touch uz_encoder.imp
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

########## Tcl recorder end at 01/22/21 17:43:07 ###########


########## Tcl recorder starts at 01/22/21 17:43:13 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -blifopt uz_encoder.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder.bl2 -sweep -mergefb -err automake.err -o uz_encoder.bl3 @uz_encoder.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -diofft uz_encoder.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder.bl3 -family AMDMACH -idev van -o uz_encoder.bl4 -oxrf uz_encoder.xrf -err automake.err @uz_encoder.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder.lct -dev lc4k -prefit uz_encoder.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder.bl4 -out uz_encoder.bl5 -err automake.err -log uz_encoder.log -mod CPLD_Encoder @uz_encoder.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_encoder.bl5 -o uz_encoder.sif"] {
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
	puts $rspFile "-nodal -src uz_encoder.bl5 -type BLIF -presrc uz_encoder.bl3 -crf uz_encoder.crf -sif uz_encoder.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_encoder.lct
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

########## Tcl recorder end at 01/22/21 17:43:13 ###########


########## Tcl recorder starts at 01/22/21 17:44:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_encoder.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.bl5 -lci uz_encoder.lct -d m4s_128_64 -lco uz_encoder.lco -html_rpt -fti uz_encoder.fti -fmt PLA -tto uz_encoder.tt4 -nojed -eqn uz_encoder.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_encoder.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.bl5 -lci uz_encoder.lct -d m4s_128_64 -lco uz_encoder.lco -html_rpt -fti uz_encoder.fti -fmt PLA -tto uz_encoder.tt4 -eqn uz_encoder.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_encoder.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_encoder.rs1
file delete uz_encoder.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_encoder.bl5 -o uz_encoder.tda -lci uz_encoder.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec top_level_encoder.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_encoder -if uz_encoder.jed -j2s -log uz_encoder.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:44:46 ###########


########## Tcl recorder starts at 01/22/21 17:44:53 ##########

# Commands to make the Process: 
# Report File
if [catch {open uz_encoder.rsp w} rspFile] {
	puts stderr "Cannot create response file uz_encoder.rsp: $rspFile"
} else {
	puts $rspFile "-i uz_encoder.tt4 -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -pla uz_encoder.tt4 -lci uz_encoder.lct -prj uz_encoder -dir \"$proj_dir\" -err automake.err -log uz_encoder.nrp -exf CPLD_Encoder.exf 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" @uz_encoder.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_encoder.rsp

########## Tcl recorder end at 01/22/21 17:44:53 ###########


########## Tcl recorder starts at 01/22/21 17:46:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:46:13 ###########


########## Tcl recorder starts at 01/22/21 17:46:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:46:16 ###########


########## Tcl recorder starts at 01/22/21 17:46:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:46:46 ###########

