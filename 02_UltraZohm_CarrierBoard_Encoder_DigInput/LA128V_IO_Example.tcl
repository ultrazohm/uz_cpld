
########## Tcl recorder starts at 02/24/19 17:04:36 ##########

set version "2.0"
set proj_dir "D:/Work_Lattice/UltraZohm_CarrierBoard/UltraZohm_CarrierBoard_IO_Example"
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

########## Tcl recorder end at 02/24/19 17:04:36 ###########


########## Tcl recorder starts at 02/24/19 17:49:34 ##########

# Commands to make the Process: 
# Constraint Editor
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"la128v_io_example.bl2\" -omod \"la128v_io_example\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj la128v_io_example -lci la128v_io_example.lct -log la128v_io_example.imp -err automake.err -tti la128v_io_example.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -blifopt la128v_io_example.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" la128v_io_example.bl2 -sweep -mergefb -err automake.err -o la128v_io_example.bl3 @la128v_io_example.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -diofft la128v_io_example.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" la128v_io_example.bl3 -family AMDMACH -idev van -o la128v_io_example.bl4 -oxrf la128v_io_example.xrf -err automake.err @la128v_io_example.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -prefit la128v_io_example.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp la128v_io_example.bl4 -out la128v_io_example.bl5 -err automake.err -log la128v_io_example.log -mod top_level @la128v_io_example.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 02/24/19 17:49:34 ###########


########## Tcl recorder starts at 02/24/19 17:52:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open la128v_io_example.rs1 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs1: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -nojed -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open la128v_io_example.rs2 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs2: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@la128v_io_example.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete la128v_io_example.rs1
file delete la128v_io_example.rs2
if [runCmd "\"$cpld_bin/tda\" -i la128v_io_example.bl5 -o la128v_io_example.tda -lci la128v_io_example.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj la128v_io_example -if la128v_io_example.jed -j2s -log la128v_io_example.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/24/19 17:52:50 ###########


########## Tcl recorder starts at 02/24/19 17:53:10 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 02/24/19 17:53:10 ###########


########## Tcl recorder starts at 02/24/19 17:56:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open la128v_io_example.rs1 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs1: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -nojed -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open la128v_io_example.rs2 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs2: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@la128v_io_example.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete la128v_io_example.rs1
file delete la128v_io_example.rs2
if [runCmd "\"$cpld_bin/tda\" -i la128v_io_example.bl5 -o la128v_io_example.tda -lci la128v_io_example.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj la128v_io_example -if la128v_io_example.jed -j2s -log la128v_io_example.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/24/19 17:56:18 ###########


########## Tcl recorder starts at 02/24/19 17:56:20 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 02/24/19 17:56:20 ###########


########## Tcl recorder starts at 02/24/19 18:38:59 ##########

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

########## Tcl recorder end at 02/24/19 18:38:59 ###########


########## Tcl recorder starts at 02/24/19 18:39:41 ##########

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

########## Tcl recorder end at 02/24/19 18:39:41 ###########


########## Tcl recorder starts at 02/24/19 18:39:52 ##########

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

########## Tcl recorder end at 02/24/19 18:39:52 ###########


########## Tcl recorder starts at 02/24/19 18:39:56 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"la128v_io_example.bl2\" -omod \"la128v_io_example\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj la128v_io_example -lci la128v_io_example.lct -log la128v_io_example.imp -err automake.err -tti la128v_io_example.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -blifopt la128v_io_example.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" la128v_io_example.bl2 -sweep -mergefb -err automake.err -o la128v_io_example.bl3 @la128v_io_example.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -diofft la128v_io_example.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" la128v_io_example.bl3 -family AMDMACH -idev van -o la128v_io_example.bl4 -oxrf la128v_io_example.xrf -err automake.err @la128v_io_example.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -prefit la128v_io_example.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp la128v_io_example.bl4 -out la128v_io_example.bl5 -err automake.err -log la128v_io_example.log -mod top_level @la128v_io_example.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open la128v_io_example.rs1 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs1: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -nojed -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open la128v_io_example.rs2 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs2: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@la128v_io_example.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete la128v_io_example.rs1
file delete la128v_io_example.rs2
if [runCmd "\"$cpld_bin/tda\" -i la128v_io_example.bl5 -o la128v_io_example.tda -lci la128v_io_example.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj la128v_io_example -if la128v_io_example.jed -j2s -log la128v_io_example.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/24/19 18:39:56 ###########


########## Tcl recorder starts at 04/04/19 08:40:44 ##########

set version "2.0"
set proj_dir "D:/Work_Lattice/UltraZohm_CarrierBoard/UltraZohm_CarrierBoard_GatePWMthroughCPLD"
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

########## Tcl recorder end at 04/04/19 08:40:44 ###########


########## Tcl recorder starts at 04/04/19 08:57:14 ##########

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

########## Tcl recorder end at 04/04/19 08:57:14 ###########


########## Tcl recorder starts at 04/04/19 09:19:13 ##########

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

########## Tcl recorder end at 04/04/19 09:19:13 ###########


########## Tcl recorder starts at 04/04/19 09:29:21 ##########

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

########## Tcl recorder end at 04/04/19 09:29:21 ###########


########## Tcl recorder starts at 04/04/19 09:30:13 ##########

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

########## Tcl recorder end at 04/04/19 09:30:13 ###########


########## Tcl recorder starts at 04/04/19 09:33:18 ##########

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

########## Tcl recorder end at 04/04/19 09:33:18 ###########


########## Tcl recorder starts at 04/04/19 09:33:31 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"la128v_io_example.bl2\" -omod \"la128v_io_example\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj la128v_io_example -lci la128v_io_example.lct -log la128v_io_example.imp -err automake.err -tti la128v_io_example.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -blifopt la128v_io_example.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" la128v_io_example.bl2 -sweep -mergefb -err automake.err -o la128v_io_example.bl3 @la128v_io_example.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -diofft la128v_io_example.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" la128v_io_example.bl3 -family AMDMACH -idev van -o la128v_io_example.bl4 -oxrf la128v_io_example.xrf -err automake.err @la128v_io_example.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -prefit la128v_io_example.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp la128v_io_example.bl4 -out la128v_io_example.bl5 -err automake.err -log la128v_io_example.log -mod top_level @la128v_io_example.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 04/04/19 09:33:31 ###########


########## Tcl recorder starts at 04/04/19 09:39:50 ##########

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

########## Tcl recorder end at 04/04/19 09:39:50 ###########


########## Tcl recorder starts at 04/04/19 09:39:59 ##########

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

########## Tcl recorder end at 04/04/19 09:39:59 ###########


########## Tcl recorder starts at 04/04/19 09:40:07 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"la128v_io_example.bl2\" -omod \"la128v_io_example\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj la128v_io_example -lci la128v_io_example.lct -log la128v_io_example.imp -err automake.err -tti la128v_io_example.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -blifopt la128v_io_example.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" la128v_io_example.bl2 -sweep -mergefb -err automake.err -o la128v_io_example.bl3 @la128v_io_example.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -diofft la128v_io_example.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" la128v_io_example.bl3 -family AMDMACH -idev van -o la128v_io_example.bl4 -oxrf la128v_io_example.xrf -err automake.err @la128v_io_example.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -prefit la128v_io_example.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp la128v_io_example.bl4 -out la128v_io_example.bl5 -err automake.err -log la128v_io_example.log -mod top_level @la128v_io_example.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 04/04/19 09:40:07 ###########


########## Tcl recorder starts at 04/04/19 10:02:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open la128v_io_example.rs1 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs1: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -nojed -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open la128v_io_example.rs2 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs2: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@la128v_io_example.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete la128v_io_example.rs1
file delete la128v_io_example.rs2
if [runCmd "\"$cpld_bin/tda\" -i la128v_io_example.bl5 -o la128v_io_example.tda -lci la128v_io_example.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj la128v_io_example -if la128v_io_example.jed -j2s -log la128v_io_example.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/04/19 10:02:35 ###########


########## Tcl recorder starts at 04/04/19 18:06:19 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 04/04/19 18:06:19 ###########


########## Tcl recorder starts at 04/05/19 17:01:22 ##########

set version "2.0"
set proj_dir "D:/Work_Lattice/UltraZohm_CarrierBoard/UltraZohm_CarrierBoard_GatePWMthroughCPLD_DigInput"
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 04/05/19 17:01:22 ###########


########## Tcl recorder starts at 04/05/19 17:08:13 ##########

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

########## Tcl recorder end at 04/05/19 17:08:13 ###########


########## Tcl recorder starts at 04/05/19 17:11:37 ##########

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

########## Tcl recorder end at 04/05/19 17:11:38 ###########


########## Tcl recorder starts at 04/05/19 17:11:43 ##########

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

########## Tcl recorder end at 04/05/19 17:11:43 ###########


########## Tcl recorder starts at 04/05/19 17:11:48 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"la128v_io_example.bl2\" -omod \"la128v_io_example\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj la128v_io_example -lci la128v_io_example.lct -log la128v_io_example.imp -err automake.err -tti la128v_io_example.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -blifopt la128v_io_example.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" la128v_io_example.bl2 -sweep -mergefb -err automake.err -o la128v_io_example.bl3 @la128v_io_example.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -diofft la128v_io_example.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" la128v_io_example.bl3 -family AMDMACH -idev van -o la128v_io_example.bl4 -oxrf la128v_io_example.xrf -err automake.err @la128v_io_example.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci la128v_io_example.lct -dev lc4k -prefit la128v_io_example.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp la128v_io_example.bl4 -out la128v_io_example.bl5 -err automake.err -log la128v_io_example.log -mod top_level @la128v_io_example.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i la128v_io_example.bl5 -o la128v_io_example.sif"] {
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
	puts $rspFile "-nodal -src la128v_io_example.bl5 -type BLIF -presrc la128v_io_example.bl3 -crf la128v_io_example.crf -sif la128v_io_example.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci la128v_io_example.lct
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

########## Tcl recorder end at 04/05/19 17:11:48 ###########


########## Tcl recorder starts at 04/05/19 17:27:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open la128v_io_example.rs1 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs1: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -nojed -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open la128v_io_example.rs2 w} rspFile] {
	puts stderr "Cannot create response file la128v_io_example.rs2: $rspFile"
} else {
	puts $rspFile "-i la128v_io_example.bl5 -lci la128v_io_example.lct -d m4s_128_64 -lco la128v_io_example.lco -html_rpt -fti la128v_io_example.fti -fmt PLA -tto la128v_io_example.tt4 -eqn la128v_io_example.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@la128v_io_example.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete la128v_io_example.rs1
file delete la128v_io_example.rs2
if [runCmd "\"$cpld_bin/tda\" -i la128v_io_example.bl5 -o la128v_io_example.tda -lci la128v_io_example.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj la128v_io_example -if la128v_io_example.jed -j2s -log la128v_io_example.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/05/19 17:27:48 ###########

