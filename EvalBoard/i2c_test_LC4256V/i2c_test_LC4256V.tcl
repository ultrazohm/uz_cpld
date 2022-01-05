
########## Tcl recorder starts at 01/05/22 15:29:29 ##########

set version "2.1"
set proj_dir "C:/GIT/UltraZohm/Software/cpld_lattice/EvalBoard/i2c_test_LC4256V"
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
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_lc4256v.bl2\" -omod \"i2c_test_lc4256v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_lc4256v -lci i2c_test_lc4256v.lct -log i2c_test_lc4256v.imp -err automake.err -tti i2c_test_lc4256v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -blifopt i2c_test_lc4256v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_lc4256v.bl2 -sweep -mergefb -err automake.err -o i2c_test_lc4256v.bl3 @i2c_test_lc4256v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -diofft i2c_test_lc4256v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_lc4256v.bl3 -family AMDMACH -idev van -o i2c_test_lc4256v.bl4 -oxrf i2c_test_lc4256v.xrf -err automake.err @i2c_test_lc4256v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -prefit i2c_test_lc4256v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_lc4256v.bl4 -out i2c_test_lc4256v.bl5 -err automake.err -log i2c_test_lc4256v.log -mod io_pins @i2c_test_lc4256v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_lc4256v.bl5 -o i2c_test_lc4256v.sif"] {
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
	puts $rspFile "-nodal -src i2c_test_lc4256v.bl5 -type BLIF -presrc i2c_test_lc4256v.bl3 -crf i2c_test_lc4256v.crf -sif i2c_test_lc4256v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci i2c_test_lc4256v.lct
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

########## Tcl recorder end at 01/05/22 15:29:29 ###########


########## Tcl recorder starts at 01/05/22 15:33:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:33:37 ###########


########## Tcl recorder starts at 01/05/22 15:45:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:45:51 ###########


########## Tcl recorder starts at 01/05/22 15:49:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:49:23 ###########


########## Tcl recorder starts at 01/05/22 15:53:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:53:47 ###########


########## Tcl recorder starts at 01/05/22 15:55:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:55:49 ###########


########## Tcl recorder starts at 01/05/22 15:56:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:56:36 ###########


########## Tcl recorder starts at 01/05/22 15:57:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:57:53 ###########


########## Tcl recorder starts at 01/05/22 15:58:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:58:05 ###########


########## Tcl recorder starts at 01/05/22 15:59:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 15:59:41 ###########


########## Tcl recorder starts at 01/05/22 16:00:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:00:05 ###########


########## Tcl recorder starts at 01/05/22 16:01:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:01:30 ###########


########## Tcl recorder starts at 01/05/22 16:03:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:03:17 ###########


########## Tcl recorder starts at 01/05/22 16:04:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:04:37 ###########


########## Tcl recorder starts at 01/05/22 16:05:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:05:55 ###########


########## Tcl recorder starts at 01/05/22 16:06:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:06:29 ###########


########## Tcl recorder starts at 01/05/22 16:10:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:10:58 ###########


########## Tcl recorder starts at 01/05/22 16:14:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:14:46 ###########


########## Tcl recorder starts at 01/05/22 16:34:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:34:49 ###########


########## Tcl recorder starts at 01/05/22 16:35:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:35:21 ###########


########## Tcl recorder starts at 01/05/22 16:36:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:36:09 ###########


########## Tcl recorder starts at 01/05/22 16:44:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:44:38 ###########


########## Tcl recorder starts at 01/05/22 16:45:16 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:45:16 ###########


########## Tcl recorder starts at 01/05/22 16:51:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:51:41 ###########


########## Tcl recorder starts at 01/05/22 16:51:43 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:51:43 ###########


########## Tcl recorder starts at 01/05/22 16:55:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:55:35 ###########


########## Tcl recorder starts at 01/05/22 16:55:41 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:55:41 ###########


########## Tcl recorder starts at 01/05/22 16:57:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:57:42 ###########


########## Tcl recorder starts at 01/05/22 16:59:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 16:59:16 ###########


########## Tcl recorder starts at 01/05/22 17:00:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:00:22 ###########


########## Tcl recorder starts at 01/05/22 17:00:24 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:00:24 ###########


########## Tcl recorder starts at 01/05/22 17:00:31 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:00:31 ###########


########## Tcl recorder starts at 01/05/22 17:00:32 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_lc4256v.bl2\" -omod \"i2c_test_lc4256v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_lc4256v -lci i2c_test_lc4256v.lct -log i2c_test_lc4256v.imp -err automake.err -tti i2c_test_lc4256v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -blifopt i2c_test_lc4256v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_lc4256v.bl2 -sweep -mergefb -err automake.err -o i2c_test_lc4256v.bl3 @i2c_test_lc4256v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -diofft i2c_test_lc4256v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_lc4256v.bl3 -family AMDMACH -idev van -o i2c_test_lc4256v.bl4 -oxrf i2c_test_lc4256v.xrf -err automake.err @i2c_test_lc4256v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -prefit i2c_test_lc4256v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_lc4256v.bl4 -out i2c_test_lc4256v.bl5 -err automake.err -log i2c_test_lc4256v.log -mod io_pins @i2c_test_lc4256v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_lc4256v.bl5 -o i2c_test_lc4256v.sif"] {
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
	puts $rspFile "-nodal -src i2c_test_lc4256v.bl5 -type BLIF -presrc i2c_test_lc4256v.bl3 -crf i2c_test_lc4256v.crf -sif i2c_test_lc4256v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci i2c_test_lc4256v.lct
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

########## Tcl recorder end at 01/05/22 17:00:32 ###########


########## Tcl recorder starts at 01/05/22 17:02:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8_6_2.vhd -o slicer8_6_2.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:02:22 ###########


########## Tcl recorder starts at 01/05/22 17:04:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8_6_2.vhd -o slicer8_6_2.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:04:03 ###########


########## Tcl recorder starts at 01/05/22 17:04:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8_6_2.vhd -o slicer8_6_2.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:04:37 ###########


########## Tcl recorder starts at 01/05/22 17:05:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8_6_2.vhd -o slicer8_6_2.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:05:02 ###########


########## Tcl recorder starts at 01/05/22 17:06:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer8_6_2.vhd -o slicer8_6_2.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:06:10 ###########


########## Tcl recorder starts at 01/05/22 17:07:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slice862.vhd -o slice862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:07:46 ###########


########## Tcl recorder starts at 01/05/22 17:07:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slice862.vhd -o slice862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:07:50 ###########


########## Tcl recorder starts at 01/05/22 17:09:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer862.vhd -o slicer862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:09:34 ###########


########## Tcl recorder starts at 01/05/22 17:09:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer862.vhd -o slicer862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:09:55 ###########


########## Tcl recorder starts at 01/05/22 17:10:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer862.vhd -o slicer862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:10:03 ###########


########## Tcl recorder starts at 01/05/22 17:10:12 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer862.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer862.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_lc4256v.sty
PROJECT: slicer862
WORKING_PATH: \"$proj_dir\"
MODULE: slicer862
VHDL_FILE_LIST: slicer862.vhd
OUTPUT_FILE_NAME: slicer862
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer862 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer862.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer862.edi -out slicer862.bl0 -err automake.err -log slicer862.log -prj i2c_test_lc4256v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:10:12 ###########


########## Tcl recorder starts at 01/05/22 17:10:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer862.vhd -o slicer862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:10:47 ###########


########## Tcl recorder starts at 01/05/22 17:10:52 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer862.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer862.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_lc4256v.sty
PROJECT: slicer862
WORKING_PATH: \"$proj_dir\"
MODULE: slicer862
VHDL_FILE_LIST: slicer862.vhd
OUTPUT_FILE_NAME: slicer862
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer862 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer862.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer862.edi -out slicer862.bl0 -err automake.err -log slicer862.log -prj i2c_test_lc4256v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:10:52 ###########


########## Tcl recorder starts at 01/05/22 17:12:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" slicer862.vhd -o slicer862.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:12:06 ###########


########## Tcl recorder starts at 01/05/22 17:12:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open slicer862.cmd w} rspFile] {
	puts stderr "Cannot create response file slicer862.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_lc4256v.sty
PROJECT: slicer862
WORKING_PATH: \"$proj_dir\"
MODULE: slicer862
VHDL_FILE_LIST: slicer862.vhd
OUTPUT_FILE_NAME: slicer862
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e slicer862 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete slicer862.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf slicer862.edi -out slicer862.bl0 -err automake.err -log slicer862.log -prj i2c_test_lc4256v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:12:16 ###########


########## Tcl recorder starts at 01/05/22 17:12:33 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" slicer862"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:12:33 ###########


########## Tcl recorder starts at 01/05/22 17:14:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:14:41 ###########


########## Tcl recorder starts at 01/05/22 17:14:47 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:14:47 ###########


########## Tcl recorder starts at 01/05/22 17:14:52 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:14:52 ###########


########## Tcl recorder starts at 01/05/22 17:14:53 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" slicer862.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_lc4256v.bl2\" -omod \"i2c_test_lc4256v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_lc4256v -lci i2c_test_lc4256v.lct -log i2c_test_lc4256v.imp -err automake.err -tti i2c_test_lc4256v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -blifopt i2c_test_lc4256v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_lc4256v.bl2 -sweep -mergefb -err automake.err -o i2c_test_lc4256v.bl3 @i2c_test_lc4256v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -diofft i2c_test_lc4256v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_lc4256v.bl3 -family AMDMACH -idev van -o i2c_test_lc4256v.bl4 -oxrf i2c_test_lc4256v.xrf -err automake.err @i2c_test_lc4256v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -prefit i2c_test_lc4256v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_lc4256v.bl4 -out i2c_test_lc4256v.bl5 -err automake.err -log i2c_test_lc4256v.log -mod io_pins @i2c_test_lc4256v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i i2c_test_lc4256v.bl5 -o i2c_test_lc4256v.sif"] {
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
	puts $rspFile "-nodal -src i2c_test_lc4256v.bl5 -type BLIF -presrc i2c_test_lc4256v.bl3 -crf i2c_test_lc4256v.crf -sif i2c_test_lc4256v.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci i2c_test_lc4256v.lct
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

########## Tcl recorder end at 01/05/22 17:14:53 ###########


########## Tcl recorder starts at 01/05/22 17:25:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open i2c_test_lc4256v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_lc4256v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_lc4256v.bl5 -lci i2c_test_lc4256v.lct -d m4s_256_64 -lco i2c_test_lc4256v.lco -html_rpt -fti i2c_test_lc4256v.fti -fmt PLA -tto i2c_test_lc4256v.tt4 -nojed -eqn i2c_test_lc4256v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_lc4256v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_lc4256v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_lc4256v.bl5 -lci i2c_test_lc4256v.lct -d m4s_256_64 -lco i2c_test_lc4256v.lco -html_rpt -fti i2c_test_lc4256v.fti -fmt PLA -tto i2c_test_lc4256v.tt4 -eqn i2c_test_lc4256v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_lc4256v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_lc4256v.rs1
file delete i2c_test_lc4256v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_lc4256v.bl5 -o i2c_test_lc4256v.tda -lci i2c_test_lc4256v.lct -dev m4s_256_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_lc4256v -if i2c_test_lc4256v.jed -j2s -log i2c_test_lc4256v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:25:32 ###########


########## Tcl recorder starts at 01/05/22 17:30:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourcenull.vhd -o sourcenull.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:30:38 ###########


########## Tcl recorder starts at 01/05/22 17:32:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" sourcenull.vhd -o sourcenull.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:32:00 ###########


########## Tcl recorder starts at 01/05/22 17:32:06 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open sourceNull.cmd w} rspFile] {
	puts stderr "Cannot create response file sourceNull.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: i2c_test_lc4256v.sty
PROJECT: sourceNull
WORKING_PATH: \"$proj_dir\"
MODULE: sourceNull
VHDL_FILE_LIST: sourcenull.vhd
OUTPUT_FILE_NAME: sourceNull
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e sourceNull -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete sourceNull.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf sourceNull.edi -out sourceNull.bl0 -err automake.err -log sourceNull.log -prj i2c_test_lc4256v -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:32:06 ###########


########## Tcl recorder starts at 01/05/22 17:32:23 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" sourceNull"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:32:23 ###########


########## Tcl recorder starts at 01/05/22 17:33:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" io_pins.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:33:11 ###########


########## Tcl recorder starts at 01/05/22 17:33:14 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup io_pins.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bls\" -o \"io_pins.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:33:14 ###########


########## Tcl recorder starts at 01/05/22 17:33:18 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" io_pins.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:33:18 ###########


########## Tcl recorder starts at 01/05/22 17:33:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i io_pins.bl0 -o io_pins.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" sourceNull.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"io_pins.bl1\" -o \"i2c_test_lc4256v.bl2\" -omod \"i2c_test_lc4256v\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj i2c_test_lc4256v -lci i2c_test_lc4256v.lct -log i2c_test_lc4256v.imp -err automake.err -tti i2c_test_lc4256v.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -blifopt i2c_test_lc4256v.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" i2c_test_lc4256v.bl2 -sweep -mergefb -err automake.err -o i2c_test_lc4256v.bl3 @i2c_test_lc4256v.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -diofft i2c_test_lc4256v.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" i2c_test_lc4256v.bl3 -family AMDMACH -idev van -o i2c_test_lc4256v.bl4 -oxrf i2c_test_lc4256v.xrf -err automake.err @i2c_test_lc4256v.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci i2c_test_lc4256v.lct -dev lc4k -prefit i2c_test_lc4256v.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp i2c_test_lc4256v.bl4 -out i2c_test_lc4256v.bl5 -err automake.err -log i2c_test_lc4256v.log -mod io_pins @i2c_test_lc4256v.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open i2c_test_lc4256v.rs1 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_lc4256v.rs1: $rspFile"
} else {
	puts $rspFile "-i i2c_test_lc4256v.bl5 -lci i2c_test_lc4256v.lct -d m4s_256_64 -lco i2c_test_lc4256v.lco -html_rpt -fti i2c_test_lc4256v.fti -fmt PLA -tto i2c_test_lc4256v.tt4 -nojed -eqn i2c_test_lc4256v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open i2c_test_lc4256v.rs2 w} rspFile] {
	puts stderr "Cannot create response file i2c_test_lc4256v.rs2: $rspFile"
} else {
	puts $rspFile "-i i2c_test_lc4256v.bl5 -lci i2c_test_lc4256v.lct -d m4s_256_64 -lco i2c_test_lc4256v.lco -html_rpt -fti i2c_test_lc4256v.fti -fmt PLA -tto i2c_test_lc4256v.tt4 -eqn i2c_test_lc4256v.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@i2c_test_lc4256v.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete i2c_test_lc4256v.rs1
file delete i2c_test_lc4256v.rs2
if [runCmd "\"$cpld_bin/tda\" -i i2c_test_lc4256v.bl5 -o i2c_test_lc4256v.tda -lci i2c_test_lc4256v.lct -dev m4s_256_64 -family lc4k -mod io_pins -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj i2c_test_lc4256v -if i2c_test_lc4256v.jed -j2s -log i2c_test_lc4256v.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/05/22 17:33:21 ###########

