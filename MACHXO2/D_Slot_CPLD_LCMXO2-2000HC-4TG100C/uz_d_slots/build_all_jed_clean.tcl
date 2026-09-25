# Rebuild every implementation in uz_d_slots.ldf and retain only its source
# directory and the generated JEDEC file.
#
# Run with Lattice Diamond 3.13:
#   pnmainc.exe build_all_jed_clean.tcl
#
# The script may be started from any working directory.

set script_dir [file normalize [file dirname [info script]]]
set project_file [file join $script_dir "uz_d_slots.ldf"]

proc read_implementations {project_file} {
    set handle [open $project_file r]
    set project_xml [read $handle]
    close $handle

    set implementations {}
    set matches [regexp -all -inline \
        {<Implementation[^>]*title="([^"]+)"[^>]*dir="([^"]+)"} \
        $project_xml]

    foreach {complete_match title directory} $matches {
        lappend implementations [list $title $directory]
    }

    if {[llength $implementations] == 0} {
        error "No implementations found in $project_file"
    }

    return $implementations
}

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

proc progress_bar {current total width} {
    if {$total <= 0} {
        set total 1
    }

    set filled [expr {int(($current * $width) / $total)}]
    if {$filled > $width} {
        set filled $width
    }

    set empty [expr {$width - $filled}]
    return "[string repeat # $filled][string repeat . $empty]"
}

proc print_progress {implementation_index implementation_total step_index step_total title step_name build_start} {
    set completed_steps [expr {(($implementation_index - 1) * $step_total) + ($step_index - 1)}]
    set total_steps [expr {$implementation_total * $step_total}]
    set percent [expr {int(($completed_steps * 100) / $total_steps)}]
    set elapsed [expr {[clock seconds] - $build_start}]

    if {$completed_steps > 0} {
        set eta_seconds [expr {int((double($elapsed) / $completed_steps) * ($total_steps - $completed_steps))}]
        set eta_text [format_duration $eta_seconds]
    } else {
        set eta_text "unknown"
    }

    puts [format "\[%s\] %3d%% | implementation %02d/%02d | step %d/%d %-10s | %s | elapsed %s | ETA %s" \
        [progress_bar $completed_steps $total_steps 30] \
        $percent \
        $implementation_index \
        $implementation_total \
        $step_index \
        $step_total \
        $step_name \
        $title \
        [format_duration $elapsed] \
        $eta_text]
    flush stdout
}

set implementations [read_implementations $project_file]
set failures {}
set implementation_total [llength $implementations]
set step_total 6
set build_start [clock seconds]

puts "Found $implementation_total D-slot implementations."
puts "Removing old build artifacts and programming files..."
flush stdout

foreach implementation $implementations {
    lassign $implementation title directory
    clean_implementation $script_dir $directory 0
}

prj_project open $project_file

set implementation_index 0
foreach implementation $implementations {
    incr implementation_index
    lassign $implementation title directory
    puts ""
    puts "=== Building $title ($implementation_index/$implementation_total) ==="
    flush stdout

    if {[catch {
        print_progress $implementation_index $implementation_total 1 $step_total $title "active" $build_start
        prj_impl active $title

        print_progress $implementation_index $implementation_total 2 $step_total $title "synthesis" $build_start
        prj_run Synthesis -impl $title -forceAll

        print_progress $implementation_index $implementation_total 3 $step_total $title "translate" $build_start
        prj_run Translate -impl $title -forceAll

        print_progress $implementation_index $implementation_total 4 $step_total $title "map" $build_start
        prj_run Map -impl $title -forceAll

        print_progress $implementation_index $implementation_total 5 $step_total $title "par" $build_start
        prj_run PAR -impl $title -forceAll

        print_progress $implementation_index $implementation_total 6 $step_total $title "jedec" $build_start
        prj_run Export -impl $title -task Jedecgen -forceAll
    } message options]} {
        puts stderr "BUILD FAILED: $title"
        puts stderr $message
        lappend failures $title
    } else {
        set completed_steps [expr {$implementation_index * $step_total}]
        set total_steps [expr {$implementation_total * $step_total}]
        puts [format "\[%s\] %3d%% | BUILD PASSED: %s | elapsed %s" \
            [progress_bar $completed_steps $total_steps 30] \
            [expr {int(($completed_steps * 100) / $total_steps)}] \
            $title \
            [format_duration [expr {[clock seconds] - $build_start}]]]
        flush stdout
    }
}

prj_project close

puts ""
puts "Removing intermediate files and BIT files..."

foreach implementation $implementations {
    lassign $implementation title directory
    clean_implementation $script_dir $directory 1
}

if {[llength $failures] != 0} {
    puts stderr ""
    puts stderr "Failed implementations: [join $failures {, }]"
    error "[llength $failures] implementation(s) failed"
}

puts ""
puts "All [llength $implementations] implementations built successfully."
puts "Only source directories and JED files were retained."
