
########## Tcl recorder starts at 12/20/19 17:47:17 ##########

set version "2.0"
set proj_dir "C:/XilinxEyke/CPLDs/Work_Lattice/03_UltraZohm_CarrierBoard_GatePWMthroughCPLD_withEnable"
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
if [runCmd "\"$cpld_bin/sch2jhd\" ../04_ultrazohm_digitaloptical_v2/top_level.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/20/19 17:47:17 ###########


########## Tcl recorder starts at 12/20/19 17:48:30 ##########

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

########## Tcl recorder end at 12/20/19 17:48:30 ###########


########## Tcl recorder starts at 12/20/19 17:48:36 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"cpld_digital_opticalv2.bl2\" -omod \"cpld_digital_opticalv2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj cpld_digital_opticalv2 -lci cpld_digital_opticalv2.lct -log cpld_digital_opticalv2.imp -err automake.err -tti cpld_digital_opticalv2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -blifopt cpld_digital_opticalv2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" cpld_digital_opticalv2.bl2 -sweep -mergefb -err automake.err -o cpld_digital_opticalv2.bl3 @cpld_digital_opticalv2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -dev lc4k -diofft cpld_digital_opticalv2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" cpld_digital_opticalv2.bl3 -family AMDMACH -idev van -o cpld_digital_opticalv2.bl4 -oxrf cpld_digital_opticalv2.xrf -err automake.err @cpld_digital_opticalv2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -dev lc4k -prefit cpld_digital_opticalv2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp cpld_digital_opticalv2.bl4 -out cpld_digital_opticalv2.bl5 -err automake.err -log cpld_digital_opticalv2.log -mod top_level @cpld_digital_opticalv2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open cpld_digital_opticalv2.rs1 w} rspFile] {
	puts stderr "Cannot create response file cpld_digital_opticalv2.rs1: $rspFile"
} else {
	puts $rspFile "-i cpld_digital_opticalv2.bl5 -lci cpld_digital_opticalv2.lct -d m4s_128_64 -lco cpld_digital_opticalv2.lco -html_rpt -fti cpld_digital_opticalv2.fti -fmt PLA -tto cpld_digital_opticalv2.tt4 -nojed -eqn cpld_digital_opticalv2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open cpld_digital_opticalv2.rs2 w} rspFile] {
	puts stderr "Cannot create response file cpld_digital_opticalv2.rs2: $rspFile"
} else {
	puts $rspFile "-i cpld_digital_opticalv2.bl5 -lci cpld_digital_opticalv2.lct -d m4s_128_64 -lco cpld_digital_opticalv2.lco -html_rpt -fti cpld_digital_opticalv2.fti -fmt PLA -tto cpld_digital_opticalv2.tt4 -eqn cpld_digital_opticalv2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@cpld_digital_opticalv2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete cpld_digital_opticalv2.rs1
file delete cpld_digital_opticalv2.rs2
if [runCmd "\"$cpld_bin/tda\" -i cpld_digital_opticalv2.bl5 -o cpld_digital_opticalv2.tda -lci cpld_digital_opticalv2.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj cpld_digital_opticalv2 -if cpld_digital_opticalv2.jed -j2s -log cpld_digital_opticalv2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/20/19 17:48:36 ###########


########## Tcl recorder starts at 12/20/19 17:51:00 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [runCmd "\"$cpld_bin/timer\" -inp \"cpld_digital_opticalv2.tt4\" -lci \"cpld_digital_opticalv2.lct\" -stamp \"cpld_digital_opticalv2.stamp\" -exf \"top_level.exf\" -lco \"cpld_digital_opticalv2.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i cpld_digital_opticalv2.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/20/19 17:51:00 ###########


########## Tcl recorder starts at 02/04/20 08:59:04 ##########

set version "2.0"
set proj_dir "C:/Users/ga92wum/git/UltraZohm/Software/CPLD/03_UltraZohm_CarrierBoard_GatePWMthroughCPLD_withEnable"
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

########## Tcl recorder end at 02/04/20 08:59:04 ###########


########## Tcl recorder starts at 02/04/20 08:59:10 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"cpld_digital_opticalv2.bl2\" -omod \"cpld_digital_opticalv2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj cpld_digital_opticalv2 -lci cpld_digital_opticalv2.lct -log cpld_digital_opticalv2.imp -err automake.err -tti cpld_digital_opticalv2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -blifopt cpld_digital_opticalv2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" cpld_digital_opticalv2.bl2 -sweep -mergefb -err automake.err -o cpld_digital_opticalv2.bl3 @cpld_digital_opticalv2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -dev lc4k -diofft cpld_digital_opticalv2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" cpld_digital_opticalv2.bl3 -family AMDMACH -idev van -o cpld_digital_opticalv2.bl4 -oxrf cpld_digital_opticalv2.xrf -err automake.err @cpld_digital_opticalv2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -dev lc4k -prefit cpld_digital_opticalv2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp cpld_digital_opticalv2.bl4 -out cpld_digital_opticalv2.bl5 -err automake.err -log cpld_digital_opticalv2.log -mod top_level @cpld_digital_opticalv2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open cpld_digital_opticalv2.rs1 w} rspFile] {
	puts stderr "Cannot create response file cpld_digital_opticalv2.rs1: $rspFile"
} else {
	puts $rspFile "-i cpld_digital_opticalv2.bl5 -lci cpld_digital_opticalv2.lct -d m4s_128_64 -lco cpld_digital_opticalv2.lco -html_rpt -fti cpld_digital_opticalv2.fti -fmt PLA -tto cpld_digital_opticalv2.tt4 -nojed -eqn cpld_digital_opticalv2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open cpld_digital_opticalv2.rs2 w} rspFile] {
	puts stderr "Cannot create response file cpld_digital_opticalv2.rs2: $rspFile"
} else {
	puts $rspFile "-i cpld_digital_opticalv2.bl5 -lci cpld_digital_opticalv2.lct -d m4s_128_64 -lco cpld_digital_opticalv2.lco -html_rpt -fti cpld_digital_opticalv2.fti -fmt PLA -tto cpld_digital_opticalv2.tt4 -eqn cpld_digital_opticalv2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@cpld_digital_opticalv2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete cpld_digital_opticalv2.rs1
file delete cpld_digital_opticalv2.rs2
if [runCmd "\"$cpld_bin/tda\" -i cpld_digital_opticalv2.bl5 -o cpld_digital_opticalv2.tda -lci cpld_digital_opticalv2.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj cpld_digital_opticalv2 -if cpld_digital_opticalv2.jed -j2s -log cpld_digital_opticalv2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/04/20 08:59:11 ###########


########## Tcl recorder starts at 02/04/20 08:59:43 ##########

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

########## Tcl recorder end at 02/04/20 08:59:43 ###########


########## Tcl recorder starts at 02/04/20 08:59:48 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"cpld_digital_opticalv2.bl2\" -omod \"cpld_digital_opticalv2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj cpld_digital_opticalv2 -lci cpld_digital_opticalv2.lct -log cpld_digital_opticalv2.imp -err automake.err -tti cpld_digital_opticalv2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -blifopt cpld_digital_opticalv2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" cpld_digital_opticalv2.bl2 -sweep -mergefb -err automake.err -o cpld_digital_opticalv2.bl3 @cpld_digital_opticalv2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -dev lc4k -diofft cpld_digital_opticalv2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" cpld_digital_opticalv2.bl3 -family AMDMACH -idev van -o cpld_digital_opticalv2.bl4 -oxrf cpld_digital_opticalv2.xrf -err automake.err @cpld_digital_opticalv2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci cpld_digital_opticalv2.lct -dev lc4k -prefit cpld_digital_opticalv2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp cpld_digital_opticalv2.bl4 -out cpld_digital_opticalv2.bl5 -err automake.err -log cpld_digital_opticalv2.log -mod top_level @cpld_digital_opticalv2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open cpld_digital_opticalv2.rs1 w} rspFile] {
	puts stderr "Cannot create response file cpld_digital_opticalv2.rs1: $rspFile"
} else {
	puts $rspFile "-i cpld_digital_opticalv2.bl5 -lci cpld_digital_opticalv2.lct -d m4s_128_64 -lco cpld_digital_opticalv2.lco -html_rpt -fti cpld_digital_opticalv2.fti -fmt PLA -tto cpld_digital_opticalv2.tt4 -nojed -eqn cpld_digital_opticalv2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open cpld_digital_opticalv2.rs2 w} rspFile] {
	puts stderr "Cannot create response file cpld_digital_opticalv2.rs2: $rspFile"
} else {
	puts $rspFile "-i cpld_digital_opticalv2.bl5 -lci cpld_digital_opticalv2.lct -d m4s_128_64 -lco cpld_digital_opticalv2.lco -html_rpt -fti cpld_digital_opticalv2.fti -fmt PLA -tto cpld_digital_opticalv2.tt4 -eqn cpld_digital_opticalv2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@cpld_digital_opticalv2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete cpld_digital_opticalv2.rs1
file delete cpld_digital_opticalv2.rs2
if [runCmd "\"$cpld_bin/tda\" -i cpld_digital_opticalv2.bl5 -o cpld_digital_opticalv2.tda -lci cpld_digital_opticalv2.lct -dev m4s_128_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj cpld_digital_opticalv2 -if cpld_digital_opticalv2.jed -j2s -log cpld_digital_opticalv2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/04/20 08:59:48 ###########

