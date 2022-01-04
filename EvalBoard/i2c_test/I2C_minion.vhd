------------------------------------------------------------
-- File      : I2C_minion.vhd
------------------------------------------------------------
-- Author    : Peter Samarin <peter.samarin@gmail.com>
------------------------------------------------------------
-- Copyright (c) 2019 Peter Samarin
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------
entity I2C_minion is
  generic (
    MINION_ADDR            : std_logic_vector(6 downto 0) := "0011101"; --1D 
--    MINION_ADDR            : std_logic_vector(6 downto 0) := "0101101"; --2D
--    MINION_ADDR            : std_logic_vector(6 downto 0) := "0111101"; --3D
--    MINION_ADDR            : std_logic_vector(6 downto 0) := "1001101"; --4D
--    MINION_ADDR            : std_logic_vector(6 downto 0) := "1011101"; --5D
    -- noisy SCL/SDA lines can confuse the minion
    -- use low-pass filter to smooth the signal
    -- (this might not be necessary!)
    USE_INPUT_DEBOUNCING   : boolean := false;
    -- play with different number of wait cycles
    -- larger wait cycles increase the resource usage
    DEBOUNCING_WAIT_CYCLES : integer := 4);
  port (
    scl              : inout std_logic;
    sda              : inout std_logic;
    clk              : in    std_logic;
    rst              : in    std_logic;
    -- User interface
    read_req         : out   std_logic;
    data_to_master   : in    std_logic_vector(7 downto 0);
    data_valid       : out   std_logic;
    IO_Select_0_7      : out   std_logic_vector(7 downto 0);
    IO_Select_8_15     : out   std_logic_vector(7 downto 0);
    IO_Select_16_23    : out   std_logic_vector(7 downto 0);
    IO_Select_24_29_OE : out   std_logic_vector(7 downto 0);
    CPLD_DigIO_out     : out   std_logic_vector(7 downto 0);
    byte_step_LSB    : out   std_logic :='1'; --indicators for value of byte_step
    byte_step_MSB    : out   std_logic :='1'); --indicators for value of byte_step
end entity I2C_minion;
------------------------------------------------------------
architecture arch of I2C_minion is
  type state_t is (idle, get_address_and_cmd,
                   answer_ack_start, write,
                   read, read_ack_start,
                   read_ack_got_rising, read_stop);
  -- I2C state management
  signal state_reg          : state_t              := idle;
  signal cmd_reg            : std_logic            := '0';
  signal bits_processed_reg : integer range 0 to 8 := 0;
  signal reg_or_data_receive: std_logic		   := '0';
  signal continue_reg       : std_logic            := '0';

  signal scl_reg       : std_logic := 'Z';
  signal sda_reg       : std_logic := 'Z';
  signal scl_debounced : std_logic := 'Z';
  signal sda_debounced : std_logic := 'Z';

  signal scl_pre_internal : std_logic := 'Z';
  signal scl_internal     : std_logic := '1';
  signal sda_pre_internal : std_logic := 'Z';
  signal sda_internal     : std_logic := '1';

  -- Helpers to figure out next state
  signal start_reg       : std_logic := '0';
  signal stop_reg        : std_logic := '0';
  signal scl_rising_reg  : std_logic := '0';
  signal scl_falling_reg : std_logic := '0';

  -- Address and data received from master
  signal addr_reg             : std_logic_vector(6 downto 0) := (others => '0');
  signal data_reg             : std_logic_vector(6 downto 0) := (others => '0');
  signal target_reg           : std_logic_vector(7 downto 0) := (others => '0');
  signal read_reg             : std_logic_vector(7 downto 0) := (others => '0');
  signal data_from_master_reg : std_logic_vector(7 downto 0) := (others => '0');

  signal scl_prev_reg : std_logic := 'Z';
  -- Minion writes on scl
  signal scl_wen_reg  : std_logic := '0';
  signal scl_o_reg    : std_logic := '0';  -- unused for now
  signal sda_prev_reg : std_logic := 'Z';
  -- Minion writes on sda
  signal sda_wen_reg  : std_logic := '0';
  signal sda_o_reg    : std_logic := '0';

  -- User interface
  signal data_valid_reg     : std_logic                    := '0';
  signal read_req_reg       : std_logic                    := '0';
  signal data_to_master_reg : std_logic_vector(7 downto 0) := (others => '0');
  signal data_0             : std_logic_vector(7 downto 0) := (others => '0');
  signal data_1             : std_logic_vector(7 downto 0) := (others => '0');
  signal data_2             : std_logic_vector(7 downto 0) := (others => '0');
  signal data_3             : std_logic_vector(7 downto 0) := (others => '0');
  signal data_4             : std_logic_vector(7 downto 0) := (others => '0');

begin

  debounce : if USE_INPUT_DEBOUNCING generate
    -- debounce SCL and SDA
    SCL_debounce : entity work.debounce
      generic map (
        WAIT_CYCLES => DEBOUNCING_WAIT_CYCLES)
      port map (
        clk        => clk,
        signal_in  => scl,
        signal_out => scl_debounced);

    -- it might not make sense to debounce SDA, since master
    -- and minion can both write to it...
    SDA_debounce : entity work.debounce
      generic map (
        WAIT_CYCLES => DEBOUNCING_WAIT_CYCLES)
      port map (
        clk        => clk,
        signal_in  => sda,
        signal_out => sda_debounced);

    scl_pre_internal     <= scl_debounced;
    sda_pre_internal <= sda_debounced;
  end generate debounce;

  dont_debounce : if (not USE_INPUT_DEBOUNCING) generate
    process (clk) is
    begin
      if rising_edge(clk) then
        scl_pre_internal     <= scl;
        sda_pre_internal <= sda;
      end if;
    end process;
  end generate dont_debounce;


  scl_internal <= '0' when scl_pre_internal = '0' else '1';
  sda_internal <= '0' when sda_pre_internal = '0' else '1';


  process (clk) is
  begin
    if rising_edge(clk) then
      -- Delay SCL and SDA by 1 clock cycle
      scl_prev_reg   <= scl_internal;
      sda_prev_reg   <= sda_internal;
      -- Detect rising and falling SCL
      scl_rising_reg <= '0';
      if scl_prev_reg = '0' and scl_internal = '1' then
        scl_rising_reg <= '1';
      end if;
      scl_falling_reg <= '0';
      if scl_prev_reg = '1' and scl_internal = '0' then
        scl_falling_reg <= '1';
      end if;

      -- Detect I2C START condition
      start_reg <= '0';
      stop_reg  <= '0';
      if scl_internal = '1' and scl_prev_reg = '1' and
        sda_prev_reg = '1' and sda_internal = '0' then
        start_reg <= '1';
        stop_reg  <= '0';
      end if;

      -- Detect I2C STOP condition
      if scl_prev_reg = '1' and scl_internal = '1' and
        sda_prev_reg = '0' and sda_internal = '1' then
        start_reg <= '0';
        stop_reg  <= '1';
      end if;

    end if;
  end process;

  ----------------------------------------------------------
  -- I2C state machine
  ----------------------------------------------------------
  process (clk) is
  begin
    if rising_edge(clk) then
      -- Default assignments
      sda_o_reg      <= '0';
      sda_wen_reg    <= '0';
      -- User interface
      data_valid_reg <= '0';
      read_req_reg   <= '0';

      case state_reg is

        when idle =>
          if start_reg = '1' then
            state_reg          <= get_address_and_cmd;
            bits_processed_reg <= 0;
          end if;

        when get_address_and_cmd =>
          if scl_rising_reg = '1' then
            if bits_processed_reg < 7 then
              bits_processed_reg             <= bits_processed_reg + 1;
              addr_reg(6-bits_processed_reg) <= sda_internal;
            elsif bits_processed_reg = 7 then
              bits_processed_reg <= bits_processed_reg + 1;
              cmd_reg            <= sda_internal;
            end if;
          end if;

          if bits_processed_reg = 8 and scl_falling_reg = '1' then
            bits_processed_reg <= 0;
            if addr_reg = MINION_ADDR then  -- check req address
              state_reg <= answer_ack_start;
              if cmd_reg = '1' then  -- issue read request 
                read_req_reg       <= '1';
--                data_to_master_reg <= data_to_master;
		
		-- decode read registers
		if read_reg = x"1F" then 
			data_to_master_reg <= data_0; 
		elsif read_reg = x"20" then
			data_to_master_reg <= data_1;
		elsif read_reg = x"21" then
			data_to_master_reg <= data_2;
		elsif read_reg = x"22" then
			data_to_master_reg <= data_3;
		else 
			data_to_master_reg <= data_to_master;
		end if;


              end if;
            else
              assert false
                report ("I2C: target/minion address mismatch (data is being sent to another minion).")
                severity note;
              state_reg <= idle;
            end if;
          end if;

        ----------------------------------------------------
        -- I2C acknowledge to master
        ----------------------------------------------------
        when answer_ack_start =>
          sda_wen_reg <= '1';
          sda_o_reg   <= '0';
          if scl_falling_reg = '1' then
            if cmd_reg = '0' then
              state_reg <= write;
            else
              state_reg <= read;
            end if;
          end if;

        ----------------------------------------------------
        -- WRITE
        ----------------------------------------------------
        when write =>
          if scl_rising_reg = '1' then
	    bits_processed_reg <= bits_processed_reg + 1;
	    if bits_processed_reg < 7 then
              data_reg(6-bits_processed_reg) <= sda_internal;
            else
              data_from_master_reg <= data_reg & sda_internal;
	      bits_processed_reg <= bits_processed_reg + 1;	      
              data_valid_reg       <= '1';
            end if;
          end if; -- end rising edge

		byte_step_LSB <= '1';
		byte_step_MSB <= '0';	

          if scl_falling_reg = '1' and bits_processed_reg = 8 then
            state_reg          <= answer_ack_start;
            bits_processed_reg <= 0;

		if reg_or_data_receive = '0' then -- receive target register
			target_reg <= data_from_master_reg;
			--byte_step_LSB <= '0';
			--byte_step_MSB <= '1';
			reg_or_data_receive <= '1';

		elsif reg_or_data_receive = '1' then -- receive data for target register
			
			if target_reg = x"1F" then -- register 1F for on board LEDs
			data_0 <= data_from_master_reg;
			--byte_step_LSB <= '1';
			--byte_step_MSB <= '0';
			elsif target_reg = x"20" then -- register 20 for 7-segment display
			data_1 <= data_from_master_reg;
			--byte_step_LSB <= '0';
			--byte_step_MSB <= '1';
			elsif target_reg = x"21" then -- register 21
			data_2 <= data_from_master_reg;
			--byte_step_LSB <= '0';
			--byte_step_MSB <= '0';
			elsif target_reg = x"22" then -- register 22
			data_3 <= data_from_master_reg;
			--byte_step_LSB <= '1';
			--byte_step_MSB <= '1';
			elsif target_reg = x"23" then
			data_4 <= data_from_master_reg;
			elsif target_reg = x"7F" then -- this is the read request register
			read_reg <= data_from_master_reg; -- store the register to read from in the next read action
			end if;
			
		reg_or_data_receive <= '0';
		end if;

          end if;

        ----------------------------------------------------
        -- READ: send data to master
        ----------------------------------------------------
        when read =>
          sda_wen_reg <= '1';
          if data_to_master_reg(7-bits_processed_reg) = '0' then -- with this approach MSB gets lost!!!
            sda_o_reg <= '0';
         else
            sda_o_reg <= '1'; --actively driving 1 is not allowed but works instead of Z
          end if;

--	sda_o_reg <= data_to_master_reg(7-bits_processed_reg); -- with this approach LSB gets lost!!!

          if scl_falling_reg = '1' then
            if bits_processed_reg < 7 then
              bits_processed_reg <= bits_processed_reg + 1;
            elsif bits_processed_reg = 7 then
              state_reg          <= read_ack_start;
              bits_processed_reg <= 0;
            end if;
          end if;

        ----------------------------------------------------
        -- I2C read master acknowledge
        ----------------------------------------------------
        when read_ack_start =>
          if scl_rising_reg = '1' then
            state_reg <= read_ack_got_rising;
            if sda_internal = '1' then  -- nack = stop read
              continue_reg <= '0';
            else  -- ack = continue read
              continue_reg       <= '1';
              read_req_reg       <= '1';  -- request reg byte
              data_to_master_reg <= data_to_master;
            end if;
          end if;

        when read_ack_got_rising =>
          if scl_falling_reg = '1' then
            if continue_reg = '1' then
              if cmd_reg = '0' then
                state_reg <= write;
              else
                state_reg <= read;
              end if;
            else
              state_reg <= read_stop;
            end if;
          end if;

        -- Wait for START or STOP to get out of this state
        when read_stop =>
          null;

        -- Wait for START or STOP to get out of this state
        when others =>
          assert false
            report ("I2C: error: ended in an impossible state.")
            severity error;
          state_reg <= idle;
      end case;

      --------------------------------------------------------
      -- Reset counter and state on start/stop
      --------------------------------------------------------
      if start_reg = '1' then
        state_reg          <= get_address_and_cmd;
        bits_processed_reg <= 0;
      end if;

      if stop_reg = '1' then
        state_reg          <= idle;
        bits_processed_reg <= 0;
      end if;

      if rst = '1' then
        state_reg <= idle;
      end if;
    end if;
  end process;

  ----------------------------------------------------------
  -- I2C interface
  ----------------------------------------------------------
  sda <= sda_o_reg when sda_wen_reg = '1' else
         'Z';
  scl <= scl_o_reg when scl_wen_reg = '1' else
         'Z';
  ----------------------------------------------------------
  -- User interface
  ----------------------------------------------------------
  -- Master writes
  data_valid       	<= data_valid_reg;
  IO_Select_0_7  	<= data_0;   
  IO_Select_8_15    	<= data_1;
  IO_Select_16_23   	<= data_2;
  IO_Select_24_29_OE	<= data_3;
  CPLD_DigIO_out	<= data_4;
  -- Master reads
  read_req         	<= read_req_reg;
end architecture arch;
