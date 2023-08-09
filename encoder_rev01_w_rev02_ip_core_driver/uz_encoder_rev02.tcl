
########## Tcl recorder starts at 04/07/22 09:43:35 ##########

set version "2.1"
set proj_dir "C:/GIT/UltraZohm/software/cpld_lattice/encoder_rev01_w_rev02_ip_core_driver"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level.abl -mod UZ_CPLD -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"UZ_CPLD.bl1\" -o \"uz_encoder_rev02.bl2\" -omod \"uz_encoder_rev02\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_encoder_rev02 -lci uz_encoder_rev02.lct -log uz_encoder_rev02.imp -err automake.err -tti uz_encoder_rev02.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder_rev02.lct -blifopt uz_encoder_rev02.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_encoder_rev02.bl2 -sweep -mergefb -err automake.err -o uz_encoder_rev02.bl3 @uz_encoder_rev02.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder_rev02.lct -dev lc4k -diofft uz_encoder_rev02.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_encoder_rev02.bl3 -family AMDMACH -idev van -o uz_encoder_rev02.bl4 -oxrf uz_encoder_rev02.xrf -err automake.err @uz_encoder_rev02.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_encoder_rev02.lct -dev lc4k -prefit uz_encoder_rev02.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_encoder_rev02.bl4 -out uz_encoder_rev02.bl5 -err automake.err -log uz_encoder_rev02.log -mod UZ_CPLD @uz_encoder_rev02.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_encoder_rev02.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder_rev02.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_encoder_rev02.bl5 -lci uz_encoder_rev02.lct -d m4s_128_64 -lco uz_encoder_rev02.lco -html_rpt -fti uz_encoder_rev02.fti -fmt PLA -tto uz_encoder_rev02.tt4 -nojed -eqn uz_encoder_rev02.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_encoder_rev02.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_encoder_rev02.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_encoder_rev02.bl5 -lci uz_encoder_rev02.lct -d m4s_128_64 -lco uz_encoder_rev02.lco -html_rpt -fti uz_encoder_rev02.fti -fmt PLA -tto uz_encoder_rev02.tt4 -eqn uz_encoder_rev02.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_encoder_rev02.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_encoder_rev02.rs1
file delete uz_encoder_rev02.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_encoder_rev02.bl5 -o uz_encoder_rev02.tda -lci uz_encoder_rev02.lct -dev m4s_128_64 -family lc4k -mod UZ_CPLD -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_encoder_rev02 -if uz_encoder_rev02.jed -j2s -log uz_encoder_rev02.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/22 09:43:35 ###########

