--------------------------------------------------------------------------------
--
--  ·························································
--  · FileName:         main.vhd                            ·
--  · Dependencies:     i2c_slave.vhd (v1.0)                ·
--  ·                                 ·
--  · Design Software:  Quartus II Version 16.0.0 build 211 ·
--  ·························································
--
--   Version History
--	  Version 1.0 01/08/2018 D. Arancibia
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY main IS
	PORT
	(
		clock			:	IN		STD_LOGIC;  		--system clock
		reset_n		:	IN		STD_LOGIC;

		PWM1			: OUT STD_LOGIC;
		PWM2			: OUT STD_LOGIC;
		PWM3			: OUT STD_LOGIC;
		PWM4			: OUT STD_LOGIC;
		PWM5			: OUT STD_LOGIC;
		PWM6			: OUT STD_LOGIC;
		PWM7			: OUT STD_LOGIC;
		PWM8			: OUT STD_LOGIC;
		PWM9			: OUT STD_LOGIC;
		PWM10			: OUT STD_LOGIC;
		PWM11			: OUT STD_LOGIC;
		PWM12			: OUT STD_LOGIC;
		PWM13			: OUT STD_LOGIC;
		PWM14			: OUT STD_LOGIC;
		PWM15			: OUT STD_LOGIC;
		PWM16			: OUT STD_LOGIC;
		PWM17			: OUT STD_LOGIC;
		PWM18			: OUT STD_LOGIC;
		PWM19			: OUT STD_LOGIC;
		PWM20			: OUT STD_LOGIC;
		PWM21			: OUT STD_LOGIC;
		PWM22			: OUT STD_LOGIC;
		PWM23			: OUT STD_LOGIC;
		PWM24			: OUT STD_LOGIC;
		
		DATA1			: inout STD_LOGIC;
		DATA2			: inout STD_LOGIC;
		DATA3			: OUT STD_LOGIC;
		DATA4			: OUT STD_LOGIC;
		DATA5			: OUT STD_LOGIC;
		DATA6			: OUT STD_LOGIC;
		DATA7			: OUT STD_LOGIC;
		DATA8			: OUT STD_LOGIC
	);

END main;

ARCHITECTURE logic OF main IS
	
	SIGNAL read_req_S         : STD_LOGIC;
   SIGNAL data_to_master_S   : STD_LOGIC_VECTOR(7 downto 0);
   SIGNAL data_valid_S       : STD_LOGIC;
   SIGNAL data_from_master_S : STD_LOGIC_VECTOR(7 downto 0);
  
	COMPONENT i2c_slave is
   GENERIC 
	(
		SLAVE_ADDR : std_logic_vector(6 downto 0) := "0010000"
	);
   PORT 
	(
		--I2C IO Signals
		scl             : inout std_logic;
		sda             : inout std_logic;
        
		--Transaction is in progress
		in_progress     : out   std_logic;

		--READ command signals
		tx_done         : out   std_logic;
		tx_byte         : in    std_logic_vector(7 downto 0);

		--WRITE command signals
		rx_byte         : out   std_logic_vector(7 downto 0); 
		rx_data_rdy     : out   std_logic;

		--System clock
		clk             : in    std_logic
	);
	END COMPONENT i2c_slave;
  
--=========================================================================================================================   
BEGIN

	--instantiate I2C_slave component
	I2C_slave_0 : I2C_slave
	PORT MAP
	(
		scl              => DATA1,
		sda              => DATA2,
		clk              => clock,
		in_progress		=> DATA3,
		-- User interface
		tx_done         => read_req_S,
		tx_byte			   => "01010100",--data_to_master_S,
		rx_data_rdy       => data_valid_S,
		rx_byte 			=> data_from_master_S
	 );
	

	PWM1	<= NOT data_from_master_S(0); --'1';
	PWM2	<= NOT data_from_master_S(1); --'0';
	PWM3	<= NOT data_from_master_S(2); --'1';
	PWM4	<= NOT data_from_master_S(3); --'0';
	PWM5	<= NOT data_from_master_S(4); --'1';
	PWM6	<= NOT data_from_master_S(5); --'0';
	PWM7	<= NOT data_from_master_S(6); --'1';
	PWM8	<= NOT data_from_master_S(7); --'0';
	PWM9	<= NOT '0';
	PWM10	<= NOT '0';
	PWM11	<= NOT '0';
	PWM12	<= NOT '0';
	PWM13	<= NOT data_valid_S;
	PWM14	<= NOT '0';
	PWM15	<= NOT '0';
	PWM16	<= NOT '0';
	PWM17	<= NOT '0';
	PWM18	<= NOT '0';
	PWM19	<= NOT '0';
	PWM20	<= NOT '0';
	PWM21	<= NOT '0';
	PWM22	<= NOT '0';
	PWM23	<= NOT '0';
	PWM24	<= NOT '0';
	
--	DATA1	<= SCL_S;
--	DATA2	<= SDA_S;
--	DATA3	<= data_valid_S;
	DATA4	<= data_valid_S;
	DATA5	<= '1';
	DATA6	<= '1';
	DATA7	<= '1';
	DATA8	<= '1';
	
END logic;
