
########## Tcl recorder starts at 01/03/22 10:45:35 ##########

set version "2.0"
set proj_dir "C:/Users/ga92wum/git/UltraZohm/Software/CPLD/uz_d_30rx"
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
# JEDEC File
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_30rx.abl -mod UZ_CPLD -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" UZ_CPLD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"UZ_CPLD.bl1\" -o \"uz_cpld_30rx.bl2\" -omod \"uz_cpld_30rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_cpld_30rx -lci uz_cpld_30rx.lct -log uz_cpld_30rx.imp -err automake.err -tti uz_cpld_30rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_cpld_30rx.lct -blifopt uz_cpld_30rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_cpld_30rx.bl2 -sweep -mergefb -err automake.err -o uz_cpld_30rx.bl3 @uz_cpld_30rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_cpld_30rx.lct -dev lc4k -diofft uz_cpld_30rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_cpld_30rx.bl3 -family AMDMACH -idev van -o uz_cpld_30rx.bl4 -oxrf uz_cpld_30rx.xrf -err automake.err @uz_cpld_30rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_cpld_30rx.lct -dev lc4k -prefit uz_cpld_30rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_cpld_30rx.bl4 -out uz_cpld_30rx.bl5 -err automake.err -log uz_cpld_30rx.log -mod UZ_CPLD @uz_cpld_30rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_cpld_30rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_cpld_30rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_cpld_30rx.bl5 -lci uz_cpld_30rx.lct -d m4s_128_64 -lco uz_cpld_30rx.lco -html_rpt -fti uz_cpld_30rx.fti -fmt PLA -tto uz_cpld_30rx.tt4 -nojed -eqn uz_cpld_30rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_cpld_30rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_cpld_30rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_cpld_30rx.bl5 -lci uz_cpld_30rx.lct -d m4s_128_64 -lco uz_cpld_30rx.lco -html_rpt -fti uz_cpld_30rx.fti -fmt PLA -tto uz_cpld_30rx.tt4 -eqn uz_cpld_30rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_cpld_30rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_cpld_30rx.rs1
file delete uz_cpld_30rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_cpld_30rx.bl5 -o uz_cpld_30rx.tda -lci uz_cpld_30rx.lct -dev m4s_128_64 -family lc4k -mod UZ_CPLD -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_cpld_30rx -if uz_cpld_30rx.jed -j2s -log uz_cpld_30rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/03/22 10:45:35 ###########


########## Tcl recorder starts at 01/03/22 10:46:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_30rx.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/03/22 10:46:52 ###########


########## Tcl recorder starts at 01/03/22 10:46:52 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_30rx.abl -mod UZ_CPLD -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" UZ_CPLD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"UZ_CPLD.bl1\" -o \"uz_cpld_30rx.bl2\" -omod \"uz_cpld_30rx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_cpld_30rx -lci uz_cpld_30rx.lct -log uz_cpld_30rx.imp -err automake.err -tti uz_cpld_30rx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_cpld_30rx.lct -blifopt uz_cpld_30rx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_cpld_30rx.bl2 -sweep -mergefb -err automake.err -o uz_cpld_30rx.bl3 @uz_cpld_30rx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_cpld_30rx.lct -dev lc4k -diofft uz_cpld_30rx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_cpld_30rx.bl3 -family AMDMACH -idev van -o uz_cpld_30rx.bl4 -oxrf uz_cpld_30rx.xrf -err automake.err @uz_cpld_30rx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_cpld_30rx.lct -dev lc4k -prefit uz_cpld_30rx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_cpld_30rx.bl4 -out uz_cpld_30rx.bl5 -err automake.err -log uz_cpld_30rx.log -mod UZ_CPLD @uz_cpld_30rx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_cpld_30rx.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_cpld_30rx.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_cpld_30rx.bl5 -lci uz_cpld_30rx.lct -d m4s_128_64 -lco uz_cpld_30rx.lco -html_rpt -fti uz_cpld_30rx.fti -fmt PLA -tto uz_cpld_30rx.tt4 -nojed -eqn uz_cpld_30rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_cpld_30rx.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_cpld_30rx.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_cpld_30rx.bl5 -lci uz_cpld_30rx.lct -d m4s_128_64 -lco uz_cpld_30rx.lco -html_rpt -fti uz_cpld_30rx.fti -fmt PLA -tto uz_cpld_30rx.tt4 -eqn uz_cpld_30rx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_cpld_30rx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_cpld_30rx.rs1
file delete uz_cpld_30rx.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_cpld_30rx.bl5 -o uz_cpld_30rx.tda -lci uz_cpld_30rx.lct -dev m4s_128_64 -family lc4k -mod UZ_CPLD -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_cpld_30rx -if uz_cpld_30rx.jed -j2s -log uz_cpld_30rx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/03/22 10:46:52 ###########


########## Tcl recorder starts at 01/03/22 10:47:04 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i uz_cpld_30rx.bl5 -o uz_cpld_30rx.sif"] {
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
	puts $rspFile "-nodal -src uz_cpld_30rx.bl5 -type BLIF -presrc uz_cpld_30rx.bl3 -crf uz_cpld_30rx.crf -sif uz_cpld_30rx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_cpld_30rx.lct
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

########## Tcl recorder end at 01/03/22 10:47:04 ###########

