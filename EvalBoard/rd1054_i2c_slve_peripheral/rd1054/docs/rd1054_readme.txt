                    I2C Slave/PeripheralReference Design
===================================================================================================
 
File List 
 1. /RD1054/docs/rd1054.pdf                                 --> I2C slave design document
    /RD1054/docs/rd1054_readme.txt                          --> Read me file (this file)
    /RD1054/docs/I2C_Bus_specification.pdf                  --> I2C spec version 2.1

 2. /RD1054/Project/<DEVICE_NAME>/verilog/*.ldf 	          -->Lattice Diamond file to load the project.   
     /RD1054/Project/<DEVICE_NAME>/verilog/*.sty 	          -->Lattice Diamond Strategy file.
    /RD1054/Project/<DEVICE_NAME>/verilog/*.lpf 	          -->Lattice Diamond Constraint file.

     /RD1054/Project/<DEVICE_NAME>/vhdl/*.ldf 	          -->Lattice Diamond file to load the project.   
     /RD1054/Project/<DEVICE_NAME>/vhdl/*.sty 	          -->Lattice Diamond Strategy file.
    /RD1054/Project/<DEVICE_NAME>/vhdl/*.lpf 	          -->Lattice Diamond Constraint file.
									   										  
 3. /RD1054/Simulation/verilog/rtl_verilog.do 	       --> RTL simulation script file for verilog
    /RD1054/Simulation/verilog/timing_verilog.do            --> Timing simulation script file for verilog
    /RD1054/Simulation/vhdl/rtl_vhdl.do 		       --> RTL simulation script file for vhdl
    /RD1054/Simulation/vhdl/timing_vhdl.do 	       --> Timing simulation script file for vhdl

 4. /RD1054/source/verilog/i2c_slave.v                      --> verilog source file
    /RD1054/source/vhdl/i2c_slave.vhd                       --> VHDL source file

 5. /RD1054/testbench/verilog/i2c_peri_tf.v                 --> Testbench for verilog and VHDL simulation - top-level
    /RD1054/testbench/verilog/i2c_mstr.v                    --> Testbench for verilog and VHDL simulation
    /RD1054/testbench/i2c.mem                               --> Memory file for Verilog and VHDL simulation

===================================================================================================  
!!IMPORTANT NOTES:!!
1. Unzip the RD1054_revyy.y.zip file using the existing folder names, where yy.y is the current
   version of the zip file
2. If there is lpf file or lci file available for the reference design:
	2.1 copy the content of the provided lpf file to the <project_name>.lpf file under your ispLEVER project, 
	2.2 use Constraint Files >> Add >> Exiting File to import the lpf to Diamond project and set it to be active,
	2.3 copy the content of the provided lct file to the <project_name>.lct under your cpld project.  
3. If there is sty file (strategy file for Diamond) available for the design, go to File List tab on the left 
   side of the GUI. Right click on Strategies >> Add >> Existing File. Then right click on the imported file 
   name and select "Set as Active Strategy".
   
===================================================================================================  
Using ispLEVER or ispLEVER Classic software
---------------------------------------------------------------------------------------------------
HOW TO CREATE A ISPLEVER OR ISPLEVER CLASSIC PROJECT:
1. Bring up ISPLEVER OR ISPLEVER CLASSIC software, in the GUI, select File >> New Project
2. In the New Project popup, select the Project location, provide a Project name, select Design Entry Type 
   and click Next.
3. Use RD1054.pdf to see which device /speedgrade should be selected to achieve the desired timing result
4. Add the necessary source files from the RD1054\source directory, click Next
5. Click Finish. Now the project is successfully created. 
6. Make sure the provided lpf or lct is used in the current directory.

---------------------------------------------------------------------------------------------------
HOW TO RUN SIMULATION FROM ISPLEVER OR ISPLEVER CLASSIC PROJECT:
0. Make sure the i2c.mem is in the same directory as the project file (.syn)
1. Import the top-level testbench into the project as test fixture and associate with the device
	1.1 Import the rest as Testbench Dependency File by highligh and right click on the test bench file
2. In the Project Navigator, highlight the testbench file on the left-side panel, user will see 3 
   simulation options on the right panel.
3. For functional simulation, double click on Verilog (or VHDL) Functional Simulation with Aldec 
   Active-HDL. Aldec simulator will be brought up, click yes to overwrite the existing file. The 
   simulator will initialize and run for 1us.
4. Type "run 37 us" for vhdl or "run -all" for verilog in the Console panel. A script similar to this 
   will be in the Console panel:      
                    0: Starting I2C Slave Simulation
 
                    0: Initializing Test Bench
 
                    0: Starting I2C Slave Simulation
 
                    0: Initializing Test Bench
 
                  150: Reading I2C Register
                  150: Reading I2C Register
                 1002: Data Read = c0
                 1002: Checking with memory contents...DATA MATCH
                 1452: Data Read = 35
                 1452: Checking with memory contents...DATA MATCH
                 1902: Data Read = 11
                 1902: Checking with memory contents...DATA MATCH
                 2062: Writing I2C Register starting at 06
                 2906: Wait for slave to release scl
                 6164: Data Write = 11
                 6608: Data Write = 22
                 7058: Data Write = 33
                 7508: Data Write = 44
                 7687: Writing I2C Register to read from 01
 
                 8531: Reading I2C Register starting at 01
                 9502: Data Read = 35
                 9502: Checking with memory contents...DATA MATCH
                 9952: Data Read = 11
                 9952: Checking with memory contents...DATA MATCH
                10124: Writing I2C Register to read from 0a
 
                10956: Reading I2C Register starting at 0a
                11927: Data Read = 00
                11927: Checking with memory contents...DATA MATCH
                12377: Data Read = 55
                12377: Checking with memory contents...DATA MATCH
 
                12537: Writing I2C Register at 0a
                13833: Data Write = 55
 
                14012: Writing I2C Register at 0e
                15308: Data Write = 66
 
                15487: Writing I2C Register at 0a
                16783: Data Write = 77
 
                16962: Writing I2C Register at 0e
                18258: Data Write = 88
 
                18437: I2C Simulation Complete                

5. For timing simulation, double click on Verilog (or VHDL) Post-Route Timing Simulation with Aldec 
   Active-HDL. Similar message will be shown in the console panel of the Aldec Active-HDL simulator.
   5.1 Type "run -all" for Verilog or "run 37 us" for VHDL to see the complete simulation
   5.1 In timing simulation you may see some warnings about narrow widths or vital glitches. These 
       warnings can be ignored. 
   5.2 Vital glitches can be removed by added a vsim command in the udo file. Use the udo.example 
       under the \project directory

===================================================================================================    
How to create a project in Diamond:
1. Bring up Diamond software, in the GUI, select File >> New Project, click Next
2. In the New Project popup, select the Project location and provide a Project name, click Next.
   Note: default project location is \RDxxxx\project\<device_family>_diamond\<language>
         default project name is i2c
3. Add the necessary source files from the RDxxxx\source directory, click Next
4. Select device, speedgrade,package, click Next
5. Click Finish. Now the project is successfully created. 
   
How to run simulation under Diamond:
1. Go to \RDxxxx\simulation directory, open rtl_<language>.do or timing_<language>.do to modify the paths to point to current directory
	 1.1 create the directory location for your simulation, \RDxxxx\simulation\<language>\rtl or \RDxxxx\simulation\<language>\timing are default locations
	 1.2 Make sure i2c.mem is copied into the simulation directory 
2. Bring up Active-HDL from Diamond environment. Click cancel when pop up windows come up.
3. For functional simulation, go to Tools >> Execute Macros, browse to \RDxxxx\simulation\<language>, select rtl_<language>.do. This should run 
   simulation all the way to the end. Error in this stage is often caused by incorrect paths for source / testbench, etc. 
4. For timing simulation, go to Tools >> Execute Macros, browse to \RDxxxx\simulation\<language>, select timing_<language>.do. Make sure the post-route
   netlist file is available in the correct location. This should run simulation all the way to the end. Error in this stage is often caused by 
   incorrect paths for source / testbench, etc. 

===================================================================================================
Using Diamond Software
---------------------------------------------------------------------------------------------------  
HOW TO CREATE A PROJECT IN DIAMOND:
1. Launch Diamond software, in the GUI, select File >> New Project, click Next
2. In the New Project popup, select the Project location and provide a Project name and implementation 
   name, click Next.
3. Add the necessary source files from the RD1054\source directory, click Next
4. Select the desired part and speedgrade. You may use RD1054.pdf to see which device and speedgrade 
   can be selected to achieve the published timing result 
5. Click Finish. Now the project is successfully created. 
6. MAKE SURE the provided lpf and/or sty files are used in the current directory. 
      
----------------------------------------------------------------------------------------------------      
HOW TO RUN SIMULATION UNDER DIAMOND:
0. Make sure the i2c.mem is in the same directory as the project file (.ldf)
1. Bring up the Simulation Wizard under the Tools menu 
2. Next provide a name for simulation project, and select RTL or post-route simulation
	2.1 For post-route simulation, must export verilog or vhdl simulation file after Place and Route
3. Next add the test bench files form the RD1054\TestBench directory 
	3.1 For VHDL, make sure the top-level test bench is last to be added
4. Next click Finish, this will bring up the Aldec simulator automatically
5. In Aldec environment, you can manually activate the simulation or you can use a script
	5.1 Use the provided script in the RD1054\Simulation\<language> directory
	  a. For functional simulation, change the library name to the device family
	  	i) MachXO: ovi_machxo for verilog, machxo for vhdl
	  	ii)XP2: ovi_xp2 for verilog, xp2 for vhdl
	  	iii)Platform Manager: ovi_lptm for verilog, lptm for vhdl
	  	iv) ECP3: ovi_ecp3 for verilog, ecp3 for vhdl
	  b. For POST-ROUTE simulation, first generate the timing simulation file(.vo/.vho) from the diamond project, open the script and then make the following change:
		i) The sdf file name and the path pointing to your sdf file.
		   The path usually looks like "../../simulation/<sdf_file_name>.sdf"
	        ii) Change the library name using the library name described above
	  c. Click Tools > Execute Macro and select the xxx.do file to run the simulation
	  d. This will run the simulation until finish
	5.2 Manually activate the simulation
		a. Click Simulation > Initialize Simulation
		b. Click File > New > Waveform, this will bring up the Waveform panel
		c. Click on the top-level testbench, drag all the signals into the Waveform panel
		d. At the Console panel, type "run 37us" for VHDL simulation, or "run -all" for Verilog 
		   simulation
		e. For timing simulation, please note that a timing simulation file(.vo/.vho) needs to be generated from the diamond project. Then, you must manually add 
		   -sdfmax u1="./i2c_slave/<sdf_file_name>_vo.sdf"
		   into the asim or vsim command. Use the command in timing_xxx.do as an example
6. The simulation result will be similar to the one described in ispLEVER simulation section.