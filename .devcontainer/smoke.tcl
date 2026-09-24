if {[llength [info commands prj_project]] == 0} {
    puts stderr "Diamond project commands are unavailable"
    exit 1
}
puts "Diamond project Tcl is available (Tcl [info patchlevel])"
if {[info exists ::env(DIAMOND_SMOKE_SYNTHESIS)] && $::env(DIAMOND_SMOKE_SYNTHESIS) eq "1"} {
    if {[catch {
        set fp [open smoke.vhdl w]
        puts $fp {library ieee;
use ieee.std_logic_1164.all;
entity smoke is port(a : in std_logic; y : out std_logic); end;
architecture rtl of smoke is begin y <= not a; end;}
        close $fp
        prj_project new -name smoke -impl impl1 -dev LCMXO2-2000HC-4TG100C
        prj_syn set lse
        prj_src add smoke.vhdl
        prj_project save
        prj_run Synthesis -impl impl1
        prj_project close
    } message]} {
        puts stderr "LSE smoke test failed: $message"
        exit 1
    }
}
exit 0
