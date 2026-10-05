--------------------------------------------------------------------------------
--
--  ·························································
--  · FileName:         main.vhd                            ·
--  · Dependencies:     spi_slave.vhd (v1.1)                ·
--  ·                   spi_bridge.vhd (v1.0)               ·
--  · Design Software:  Quartus II Version 16.0.0 build 211 ·
--  ·························································
--
--   Version History
--   Version 1.0 05/02/2017 M. Medel
--	  Version 2.0 21/07/2017 D. Arancibia
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY main IS
	PORT
	(
		clock			: IN	STD_LOGIC;  		--system clock
		reset_n		: IN	STD_LOGIC;
		trip			: IN	STD_LOGIC;

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
		
		DATA1			: out STD_LOGIC;
		DATA2			: out STD_LOGIC;
		DATA3			: out	STD_LOGIC;
		DATA4			: in	STD_LOGIC;
		DATA5			: in STD_LOGIC;
		DATA6			: in STD_LOGIC;
		DATA7			: in STD_LOGIC;
		DATA8			: in STD_LOGIC
	);

END main;

ARCHITECTURE logic OF main IS

	SIGNAL enable_S		: STD_LOGIC := '0';
	SIGNAL busy_S     	: STD_LOGIC;
	SIGNAL reset_S    	: STD_LOGIC := '1';
   SIGNAL cont_S			: STD_LOGIC := '0';
	
	SIGNAL sck_S     		: STD_LOGIC;
	SIGNAL mosi_S     	: STD_LOGIC;
	SIGNAL ss_n_S     	: STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL miso_S     	: STD_LOGIC := '0';
	SIGNAL miso2_S     	: STD_LOGIC := '0';
	SIGNAL miso3_S     	: STD_LOGIC := '0';
	
   SIGNAL rx_data_S   : STD_LOGIC_VECTOR(7 downto 0);

	
	COMPONENT spi_master IS
	GENERIC
	(
		slaves  : INTEGER := 1;  --number of spi slaves
		d_width : INTEGER := 8   --data bus width
	);
	PORT
	(
		clock   : IN     STD_LOGIC;                             --system clock
		reset_n : IN     STD_LOGIC;                             --asynchronous reset
		enable  : IN     STD_LOGIC;                             --initiate transaction
		cpol    : IN     STD_LOGIC;                             --spi clock polarity
		cpha    : IN     STD_LOGIC;                             --spi clock phase
		cont    : IN     STD_LOGIC;                             --continuous mode command
		clk_div : IN     INTEGER;                               --system clock cycles per 1/2 period of sclk
		addr    : IN     INTEGER;                               --address of slave
		tx_data : IN     STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
		miso    : IN     STD_LOGIC;                             --master in, slave out
		sclk    : BUFFER STD_LOGIC;                             --spi clock
		ss_n    : BUFFER STD_LOGIC_VECTOR(slaves-1 DOWNTO 0);   --slave select
		mosi    : OUT    STD_LOGIC;                             --master out, slave in
		busy    : OUT    STD_LOGIC;                             --busy / data ready signal
		rx_data : OUT    STD_LOGIC_VECTOR(d_width-1 DOWNTO 0)   --data received
	);
	END COMPONENT spi_master;
  
--=========================================================================================================================   
BEGIN


	spi_master_0 : spi_master
	PORT MAP
	(
		clock   => clock,                --system clock
		reset_n => reset_S,              --asynchronous reset
		enable  => enable_S,             --initiate transaction
		cpol    => '0',                  --spi clock polarity
		cpha    => '0',                  --spi clock phase
		cont    => cont_S,               --continuous mode command
		clk_div => 2,                    --system clock cycles per 1/2 period of sclk
		addr    => 1,                    --address of slave
		tx_data => "01011010",  				--data to transmit
		miso    => miso_S,               --master in, slave out
		sclk    => sck_S,                --spi clock
		ss_n    => ss_n_S,   				--slave select
		mosi    => mosi_S,               --master out, slave in
		busy    => busy_S,               --busy / data ready signal
		rx_data => rx_data_S    			--data received
	);
	

	PWM1	<= NOT rx_data_S(0);
	PWM2	<= NOT rx_data_S(1);
	PWM3	<= NOT rx_data_S(2);
	PWM4	<= NOT rx_data_S(3);
	PWM5	<= NOT rx_data_S(4);
	PWM6	<= NOT rx_data_S(5);
	PWM7	<= NOT rx_data_S(6);
	PWM8	<= NOT rx_data_S(7);
	PWM9	<= NOT '0';
	PWM10	<= NOT '0';
	PWM11	<= NOT '0';
	PWM12	<= NOT '0';
	
	PWM13	<= NOT busy_S;
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
	
	DATA1		<= sck_s;
	DATA2		<= mosi_s;
	DATA3 	<= ss_n_s(0);
	miso_s 	<= DATA4;
	enable_S <= DATA5;
	cont_S 	<= DATA6;
	reset_S 	<= DATA7;
	miso2_s 	<= DATA8;
	
END logic;
