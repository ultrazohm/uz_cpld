Check the top_level.abl to see the implemented logic, it starts after the keyword EQUATIONS.
A detailed description can be found on docs.ultrazohm.com -> CPLD 

ispLEVER Project Files

files that are checked into git 
*.abl    ABEL logic file, this is the main file including all input and output constraints, pull-down configurations and the logic. Check and modify this file to change the behavior of a project. 
*.jed    resulting bitstream to be flashed onto the CPLD (including useful comments about inputs and ouputs) 
*.html   report file summarizing the project
*.syn    ispLEVER project file, open this to create the bitstream. 

files that can be useful but are not tracked 
*.sch    schematic (graphical description)
*.tcl    tcl script to compile project 
*.lct    resulting constraint file - no need to check in since it is generated from ABL file 


Diamond Programmer Files 

*.xcf    file with programming instructions for Diamond Programmer 
