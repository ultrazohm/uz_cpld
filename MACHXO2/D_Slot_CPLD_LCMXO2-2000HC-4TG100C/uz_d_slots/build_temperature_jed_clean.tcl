# Rebuild only the uz_d_temperature_ltc2983 implementation and retain only its
# source directory and the generated JEDEC file.
#
# Run with Lattice Diamond:
#   pnmainc.exe build_temperature_jed_clean.tcl
#
# The script may be started from any working directory.

set script_dir [file normalize [file dirname [info script]]]
set project_file [file join $script_dir "uz_d_slots.ldf"]
set implementation_title "uz_d_temperature_ltc2983"
set implementation_dir "uz_d_temperature_ltc2983"

proc clean_implementation {project_root implementation_dir keep_jed} {
    set project_root [file normalize $project_root]
    set implementation_path [file normalize \
        [file join $project_root $implementation_dir]]

    # Refuse to delete outside the D-slot project or the project root itself.
    set root_prefix "${project_root}/"
    if {$implementation_path eq $project_root ||
        ![string equal -length [string length $root_prefix] \
            $root_prefix "${implementation_path}/"]} {
        error "Unsafe implementation path: $implementation_path"
    }

    if {![file isdirectory $implementation_path]} {
        error "Implementation directory does not exist: $implementation_path"
    }

    foreach entry [glob -nocomplain -directory $implementation_path * .*] {
        set name [file tail $entry]

        if {$name eq "." || $name eq ".." || $name eq "source"} {
            continue
        }

        if {$keep_jed && [string equal -nocase [file extension $entry] ".jed"]} {
            continue
        }

        file delete -force -- $entry
    }
}

proc format_duration {seconds} {
    set seconds [expr {int($seconds)}]
    set hours [expr {$seconds / 3600}]
    set minutes [expr {($seconds % 3600) / 60}]
    set seconds [expr {$seconds % 60}]

    if {$hours > 0} {
        return [format "%dh %02dm %02ds" $hours $minutes $seconds]
    }

    return [format "%02dm %02ds" $minutes $seconds]
}

proc print_step {step_index step_total title step_name build_start} {
    set percent [expr {int((($step_index - 1) * 100) / $step_total)}]
    puts [format "%3d%% | step %d/%d %-10s | %s | elapsed %s" \
        $percent \
        $step_index \
        $step_total \
        $step_name \
        $title \
        [format_duration [expr {[clock seconds] - $build_start}]]]
    flush stdout
}

set step_total 6
set build_start [clock seconds]

puts "Building D-slot implementation: $implementation_title"
puts "Removing old build artifacts and programming file..."
flush stdout

clean_implementation $script_dir $implementation_dir 0

prj_project open $project_file

if {[catch {
    print_step 1 $step_total $implementation_title "active" $build_start
    prj_impl active $implementation_title

    print_step 2 $step_total $implementation_title "synthesis" $build_start
    prj_run Synthesis -impl $implementation_title -forceAll

    print_step 3 $step_total $implementation_title "translate" $build_start
    prj_run Translate -impl $implementation_title -forceAll

    print_step 4 $step_total $implementation_title "map" $build_start
    prj_run Map -impl $implementation_title -forceAll

    print_step 5 $step_total $implementation_title "par" $build_start
    prj_run PAR -impl $implementation_title -forceAll

    print_step 6 $step_total $implementation_title "jedec" $build_start
    prj_run Export -impl $implementation_title -task Jedecgen -forceAll
} message options]} {
    prj_project close
    puts stderr "BUILD FAILED: $implementation_title"
    puts stderr $message
    error $message
}

prj_project close

puts "Removing intermediate files and BIT files..."
clean_implementation $script_dir $implementation_dir 1

puts ""
puts "BUILD PASSED: $implementation_title"
puts "Only the source directory and JED file were retained."
puts "Elapsed [format_duration [expr {[clock seconds] - $build_start}]]"
