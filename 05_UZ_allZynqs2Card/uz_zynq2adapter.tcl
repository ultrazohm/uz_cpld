
########## Tcl recorder starts at 01/22/21 17:50:43 ##########

set version "2.0"
set proj_dir "C:/Users/ga92wum/git/UltraZohm/Software/CPLD/05_UZ_allZynqs2Card"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:50:43 ###########


########## Tcl recorder starts at 01/22/21 17:51:17 ##########

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

########## Tcl recorder end at 01/22/21 17:51:17 ###########


########## Tcl recorder starts at 01/22/21 17:51:18 ##########

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

########## Tcl recorder end at 01/22/21 17:51:18 ###########


########## Tcl recorder starts at 01/22/21 17:51:19 ##########

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

########## Tcl recorder end at 01/22/21 17:51:19 ###########


########## Tcl recorder starts at 01/22/21 17:51:20 ##########

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

########## Tcl recorder end at 01/22/21 17:51:20 ###########


########## Tcl recorder starts at 01/22/21 17:51:25 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_zynq2adapter.bl2\" -omod \"uz_zynq2adapter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_zynq2adapter -lci uz_zynq2adapter.lct -log uz_zynq2adapter.imp -err automake.err -tti uz_zynq2adapter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -blifopt uz_zynq2adapter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_zynq2adapter.bl2 -sweep -mergefb -err automake.err -o uz_zynq2adapter.bl3 @uz_zynq2adapter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -diofft uz_zynq2adapter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_zynq2adapter.bl3 -family AMDMACH -idev van -o uz_zynq2adapter.bl4 -oxrf uz_zynq2adapter.xrf -err automake.err @uz_zynq2adapter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -prefit uz_zynq2adapter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_zynq2adapter.bl4 -out uz_zynq2adapter.bl5 -err automake.err -log uz_zynq2adapter.log -mod CPLD_Encoder @uz_zynq2adapter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_zynq2adapter.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -nojed -eqn uz_zynq2adapter.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_zynq2adapter.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -eqn uz_zynq2adapter.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_zynq2adapter.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_zynq2adapter.rs1
file delete uz_zynq2adapter.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_zynq2adapter.bl5 -o uz_zynq2adapter.tda -lci uz_zynq2adapter.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec top_level_encoder.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:51:25 ###########


########## Tcl recorder starts at 01/22/21 17:51:35 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -vec -ovec top_level_encoder.tmv  -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:51:35 ###########


########## Tcl recorder starts at 01/22/21 17:52:19 ##########

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

########## Tcl recorder end at 01/22/21 17:52:19 ###########


########## Tcl recorder starts at 01/22/21 17:52:23 ##########

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

########## Tcl recorder end at 01/22/21 17:52:23 ###########


########## Tcl recorder starts at 01/22/21 17:52:26 ##########

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

########## Tcl recorder end at 01/22/21 17:52:26 ###########


########## Tcl recorder starts at 01/22/21 17:52:27 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -mod CPLD_Encoder -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" CPLD_Encoder.bl0 -o CPLD_Encoder.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:52:27 ###########


########## Tcl recorder starts at 01/22/21 17:52:35 ##########

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
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_zynq2adapter.bl2\" -omod \"uz_zynq2adapter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_zynq2adapter -lci uz_zynq2adapter.lct -log uz_zynq2adapter.imp -err automake.err -tti uz_zynq2adapter.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci uz_zynq2adapter.lct -touch uz_zynq2adapter.imp
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

########## Tcl recorder end at 01/22/21 17:52:35 ###########


########## Tcl recorder starts at 01/22/21 17:52:41 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -blifopt uz_zynq2adapter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_zynq2adapter.bl2 -sweep -mergefb -err automake.err -o uz_zynq2adapter.bl3 @uz_zynq2adapter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -diofft uz_zynq2adapter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_zynq2adapter.bl3 -family AMDMACH -idev van -o uz_zynq2adapter.bl4 -oxrf uz_zynq2adapter.xrf -err automake.err @uz_zynq2adapter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -prefit uz_zynq2adapter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_zynq2adapter.bl4 -out uz_zynq2adapter.bl5 -err automake.err -log uz_zynq2adapter.log -mod CPLD_Encoder @uz_zynq2adapter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i uz_zynq2adapter.bl5 -o uz_zynq2adapter.sif"] {
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
	puts $rspFile "-nodal -src uz_zynq2adapter.bl5 -type BLIF -presrc uz_zynq2adapter.bl3 -crf uz_zynq2adapter.crf -sif uz_zynq2adapter.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_128_64.dev\" -lci uz_zynq2adapter.lct
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

########## Tcl recorder end at 01/22/21 17:52:41 ###########


########## Tcl recorder starts at 01/22/21 17:52:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open uz_zynq2adapter.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -nojed -eqn uz_zynq2adapter.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_zynq2adapter.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -eqn uz_zynq2adapter.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_zynq2adapter.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_zynq2adapter.rs1
file delete uz_zynq2adapter.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_zynq2adapter.bl5 -o uz_zynq2adapter.tda -lci uz_zynq2adapter.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec top_level_encoder.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:52:56 ###########


########## Tcl recorder starts at 01/22/21 17:52:59 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -vec -ovec top_level_encoder.tmv  -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:52:59 ###########


########## Tcl recorder starts at 01/22/21 17:54:38 ##########

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

########## Tcl recorder end at 01/22/21 17:54:38 ###########


########## Tcl recorder starts at 01/22/21 17:54:51 ##########

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

########## Tcl recorder end at 01/22/21 17:54:51 ###########


########## Tcl recorder starts at 01/22/21 17:55:34 ##########

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

########## Tcl recorder end at 01/22/21 17:55:34 ###########


########## Tcl recorder starts at 01/22/21 17:55:38 ##########

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

########## Tcl recorder end at 01/22/21 17:55:38 ###########


########## Tcl recorder starts at 01/22/21 17:55:39 ##########

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

########## Tcl recorder end at 01/22/21 17:55:39 ###########


########## Tcl recorder starts at 01/22/21 17:55:40 ##########

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

########## Tcl recorder end at 01/22/21 17:55:40 ###########


########## Tcl recorder starts at 01/22/21 17:55:42 ##########

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

########## Tcl recorder end at 01/22/21 17:55:42 ###########


########## Tcl recorder starts at 01/22/21 17:55:53 ##########

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

########## Tcl recorder end at 01/22/21 17:55:53 ###########


########## Tcl recorder starts at 01/22/21 17:56:00 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_zynq2adapter.bl2\" -omod \"uz_zynq2adapter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_zynq2adapter -lci uz_zynq2adapter.lct -log uz_zynq2adapter.imp -err automake.err -tti uz_zynq2adapter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -blifopt uz_zynq2adapter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_zynq2adapter.bl2 -sweep -mergefb -err automake.err -o uz_zynq2adapter.bl3 @uz_zynq2adapter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -diofft uz_zynq2adapter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_zynq2adapter.bl3 -family AMDMACH -idev van -o uz_zynq2adapter.bl4 -oxrf uz_zynq2adapter.xrf -err automake.err @uz_zynq2adapter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -prefit uz_zynq2adapter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_zynq2adapter.bl4 -out uz_zynq2adapter.bl5 -err automake.err -log uz_zynq2adapter.log -mod CPLD_Encoder @uz_zynq2adapter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_zynq2adapter.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -nojed -eqn uz_zynq2adapter.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_zynq2adapter.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -eqn uz_zynq2adapter.eq3 -tmv top_level_encoder.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_zynq2adapter.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_zynq2adapter.rs1
file delete uz_zynq2adapter.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_zynq2adapter.bl5 -o uz_zynq2adapter.tda -lci uz_zynq2adapter.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec top_level_encoder.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:56:00 ###########


########## Tcl recorder starts at 01/22/21 17:56:07 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/ahdl2blf\" top_level_encoder.abl -vec -ovec top_level_encoder.tmv  -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:56:07 ###########


########## Tcl recorder starts at 01/22/21 17:58:48 ##########

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

########## Tcl recorder end at 01/22/21 17:58:48 ###########


########## Tcl recorder starts at 01/22/21 17:58:48 ##########

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

########## Tcl recorder end at 01/22/21 17:58:48 ###########


########## Tcl recorder starts at 01/22/21 17:58:50 ##########

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

########## Tcl recorder end at 01/22/21 17:58:50 ###########


########## Tcl recorder starts at 01/22/21 17:58:52 ##########

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

########## Tcl recorder end at 01/22/21 17:58:52 ###########


########## Tcl recorder starts at 01/22/21 17:58:53 ##########

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

########## Tcl recorder end at 01/22/21 17:58:53 ###########


########## Tcl recorder starts at 01/22/21 17:58:55 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" CPLD_Encoder.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"CPLD_Encoder.bl1\" -o \"uz_zynq2adapter.bl2\" -omod \"uz_zynq2adapter\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj uz_zynq2adapter -lci uz_zynq2adapter.lct -log uz_zynq2adapter.imp -err automake.err -tti uz_zynq2adapter.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -blifopt uz_zynq2adapter.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" uz_zynq2adapter.bl2 -sweep -mergefb -err automake.err -o uz_zynq2adapter.bl3 @uz_zynq2adapter.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -diofft uz_zynq2adapter.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" uz_zynq2adapter.bl3 -family AMDMACH -idev van -o uz_zynq2adapter.bl4 -oxrf uz_zynq2adapter.xrf -err automake.err @uz_zynq2adapter.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci uz_zynq2adapter.lct -dev lc4k -prefit uz_zynq2adapter.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp uz_zynq2adapter.bl4 -out uz_zynq2adapter.bl5 -err automake.err -log uz_zynq2adapter.log -mod CPLD_Encoder @uz_zynq2adapter.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open uz_zynq2adapter.rs1 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs1: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -nojed -eqn uz_zynq2adapter.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open uz_zynq2adapter.rs2 w} rspFile] {
	puts stderr "Cannot create response file uz_zynq2adapter.rs2: $rspFile"
} else {
	puts $rspFile "-i uz_zynq2adapter.bl5 -lci uz_zynq2adapter.lct -d m4s_128_64 -lco uz_zynq2adapter.lco -html_rpt -fti uz_zynq2adapter.fti -fmt PLA -tto uz_zynq2adapter.tt4 -eqn uz_zynq2adapter.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@uz_zynq2adapter.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete uz_zynq2adapter.rs1
file delete uz_zynq2adapter.rs2
if [runCmd "\"$cpld_bin/tda\" -i uz_zynq2adapter.bl5 -o uz_zynq2adapter.tda -lci uz_zynq2adapter.lct -dev m4s_128_64 -family lc4k -mod CPLD_Encoder -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj uz_zynq2adapter -if uz_zynq2adapter.jed -j2s -log uz_zynq2adapter.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/22/21 17:58:55 ###########

