-- VHDL netlist-file
library mach;
use mach.components.all;

library ieee;
use ieee.std_logic_1164.all;
entity CPLD_Encoder is
  port (
    zynq_0 : out std_logic;
    zynq_1 : in std_logic;
    zynq_2 : in std_logic;
    zynq_3 : in std_logic;
    zynq_4 : in std_logic;
    zynq_5 : out std_logic;
    zynq_6 : in std_logic;
    zynq_7 : in std_logic;
    zynq_8 : in std_logic;
    zynq_9 : in std_logic;
    zynq_10 : in std_logic;
    zynq_11 : out std_logic;
    zynq_12 : out std_logic;
    zynq_13 : out std_logic;
    zynq_14 : out std_logic;
    zynq_15 : out std_logic;
    zynq_16 : out std_logic;
    zynq_17 : out std_logic;
    zynq_18 : in std_logic;
    zynq_19 : in std_logic;
    zynq_20 : out std_logic;
    zynq_21 : in std_logic;
    zynq_22 : in std_logic;
    zynq_23 : in std_logic;
    zynq_24 : in std_logic;
    zynq_25 : out std_logic;
    zynq_26 : out std_logic;
    zynq_27 : out std_logic;
    zynq_28 : out std_logic;
    zynq_29 : in std_logic;
    d_0 : in std_logic;
    d_1 : out std_logic;
    d_2 : out std_logic;
    d_3 : out std_logic;
    d_4 : out std_logic;
    d_5 : in std_logic;
    d_6 : out std_logic;
    d_7 : out std_logic;
    d_8 : out std_logic;
    d_9 : out std_logic;
    d_10 : out std_logic;
    d_11 : in std_logic;
    d_12 : in std_logic;
    d_13 : in std_logic;
    d_14 : in std_logic;
    d_15 : in std_logic;
    d_16 : in std_logic;
    d_17 : in std_logic;
    d_18 : out std_logic;
    d_19 : out std_logic;
    d_20 : in std_logic;
    d_21 : out std_logic;
    d_22 : out std_logic;
    d_23 : out std_logic;
    d_24 : out std_logic;
    d_25 : in std_logic;
    d_26 : in std_logic;
    d_27 : in std_logic;
    d_28 : in std_logic;
    d_29 : in std_logic
  );
end CPLD_Encoder;

architecture NetList of CPLD_Encoder is

  signal zynq_0COM : std_logic;
  signal zynq_1PIN : std_logic;
  signal zynq_2PIN : std_logic;
  signal zynq_3PIN : std_logic;
  signal zynq_4PIN : std_logic;
  signal zynq_5COM : std_logic;
  signal zynq_6PIN : std_logic;
  signal zynq_7PIN : std_logic;
  signal zynq_8PIN : std_logic;
  signal zynq_9PIN : std_logic;
  signal zynq_10PIN : std_logic;
  signal zynq_11COM : std_logic;
  signal zynq_12COM : std_logic;
  signal zynq_13COM : std_logic;
  signal zynq_14COM : std_logic;
  signal zynq_15COM : std_logic;
  signal zynq_16COM : std_logic;
  signal zynq_17COM : std_logic;
  signal zynq_18PIN : std_logic;
  signal zynq_19PIN : std_logic;
  signal zynq_20COM : std_logic;
  signal zynq_21PIN : std_logic;
  signal zynq_22PIN : std_logic;
  signal zynq_23PIN : std_logic;
  signal zynq_24PIN : std_logic;
  signal zynq_25COM : std_logic;
  signal zynq_26COM : std_logic;
  signal zynq_27COM : std_logic;
  signal zynq_28COM : std_logic;
  signal zynq_29PIN : std_logic;
  signal d_0PIN : std_logic;
  signal d_1COM : std_logic;
  signal d_2COM : std_logic;
  signal d_3COM : std_logic;
  signal d_4COM : std_logic;
  signal d_5PIN : std_logic;
  signal d_6COM : std_logic;
  signal d_7COM : std_logic;
  signal d_8COM : std_logic;
  signal d_9COM : std_logic;
  signal d_10COM : std_logic;
  signal d_11PIN : std_logic;
  signal d_12PIN : std_logic;
  signal d_13PIN : std_logic;
  signal d_14PIN : std_logic;
  signal d_15PIN : std_logic;
  signal d_16PIN : std_logic;
  signal d_17PIN : std_logic;
  signal d_18COM : std_logic;
  signal d_19COM : std_logic;
  signal d_20PIN : std_logic;
  signal d_21COM : std_logic;
  signal d_22COM : std_logic;
  signal d_23COM : std_logic;
  signal d_24COM : std_logic;
  signal d_25PIN : std_logic;
  signal d_26PIN : std_logic;
  signal d_27PIN : std_logic;
  signal d_28PIN : std_logic;
  signal d_29PIN : std_logic;

begin
  OUT_zynq_0_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_0, 
            I0=>zynq_0COM );
  IN_zynq_1_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_1PIN, 
            I0=>zynq_1 );
  IN_zynq_2_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_2PIN, 
            I0=>zynq_2 );
  IN_zynq_3_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_3PIN, 
            I0=>zynq_3 );
  IN_zynq_4_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_4PIN, 
            I0=>zynq_4 );
  OUT_zynq_5_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_5, 
            I0=>zynq_5COM );
  IN_zynq_6_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_6PIN, 
            I0=>zynq_6 );
  IN_zynq_7_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_7PIN, 
            I0=>zynq_7 );
  IN_zynq_8_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_8PIN, 
            I0=>zynq_8 );
  IN_zynq_9_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_9PIN, 
            I0=>zynq_9 );
  IN_zynq_10_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_10PIN, 
            I0=>zynq_10 );
  OUT_zynq_11_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_11, 
            I0=>zynq_11COM );
  OUT_zynq_12_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_12, 
            I0=>zynq_12COM );
  OUT_zynq_13_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_13, 
            I0=>zynq_13COM );
  OUT_zynq_14_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_14, 
            I0=>zynq_14COM );
  OUT_zynq_15_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_15, 
            I0=>zynq_15COM );
  OUT_zynq_16_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_16, 
            I0=>zynq_16COM );
  OUT_zynq_17_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_17, 
            I0=>zynq_17COM );
  IN_zynq_18_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_18PIN, 
            I0=>zynq_18 );
  IN_zynq_19_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_19PIN, 
            I0=>zynq_19 );
  OUT_zynq_20_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_20, 
            I0=>zynq_20COM );
  IN_zynq_21_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_21PIN, 
            I0=>zynq_21 );
  IN_zynq_22_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_22PIN, 
            I0=>zynq_22 );
  IN_zynq_23_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_23PIN, 
            I0=>zynq_23 );
  IN_zynq_24_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_24PIN, 
            I0=>zynq_24 );
  OUT_zynq_25_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_25, 
            I0=>zynq_25COM );
  OUT_zynq_26_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_26, 
            I0=>zynq_26COM );
  OUT_zynq_27_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_27, 
            I0=>zynq_27COM );
  OUT_zynq_28_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_28, 
            I0=>zynq_28COM );
  IN_zynq_29_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>zynq_29PIN, 
            I0=>zynq_29 );
  IN_d_0_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_0PIN, 
            I0=>d_0 );
  OUT_d_1_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_1, 
            I0=>d_1COM );
  OUT_d_2_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_2, 
            I0=>d_2COM );
  OUT_d_3_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_3, 
            I0=>d_3COM );
  OUT_d_4_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_4, 
            I0=>d_4COM );
  IN_d_5_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_5PIN, 
            I0=>d_5 );
  OUT_d_6_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_6, 
            I0=>d_6COM );
  OUT_d_7_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_7, 
            I0=>d_7COM );
  OUT_d_8_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_8, 
            I0=>d_8COM );
  OUT_d_9_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_9, 
            I0=>d_9COM );
  OUT_d_10_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_10, 
            I0=>d_10COM );
  IN_d_11_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_11PIN, 
            I0=>d_11 );
  IN_d_12_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_12PIN, 
            I0=>d_12 );
  IN_d_13_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_13PIN, 
            I0=>d_13 );
  IN_d_14_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_14PIN, 
            I0=>d_14 );
  IN_d_15_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_15PIN, 
            I0=>d_15 );
  IN_d_16_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_16PIN, 
            I0=>d_16 );
  IN_d_17_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_17PIN, 
            I0=>d_17 );
  OUT_d_18_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_18, 
            I0=>d_18COM );
  OUT_d_19_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_19, 
            I0=>d_19COM );
  IN_d_20_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_20PIN, 
            I0=>d_20 );
  OUT_d_21_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_21, 
            I0=>d_21COM );
  OUT_d_22_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_22, 
            I0=>d_22COM );
  OUT_d_23_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_23, 
            I0=>d_23COM );
  OUT_d_24_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>d_24, 
            I0=>d_24COM );
  IN_d_25_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_25PIN, 
            I0=>d_25 );
  IN_d_26_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_26PIN, 
            I0=>d_26 );
  IN_d_27_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_27PIN, 
            I0=>d_27 );
  IN_d_28_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_28PIN, 
            I0=>d_28 );
  IN_d_29_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d_29PIN, 
            I0=>d_29 );
  GATE_zynq_0_I_1:   BUFF port map ( I0=>d_0PIN, 
            O=>zynq_0COM );
  GATE_zynq_5_I_1:   BUFF port map ( I0=>d_5PIN, 
            O=>zynq_5COM );
  GATE_zynq_11_I_1:   BUFF port map ( I0=>d_11PIN, 
            O=>zynq_11COM );
  GATE_zynq_12_I_1:   BUFF port map ( I0=>d_12PIN, 
            O=>zynq_12COM );
  GATE_zynq_13_I_1:   BUFF port map ( I0=>d_13PIN, 
            O=>zynq_13COM );
  GATE_zynq_14_I_1:   BUFF port map ( I0=>d_14PIN, 
            O=>zynq_14COM );
  GATE_zynq_15_I_1:   BUFF port map ( I0=>d_15PIN, 
            O=>zynq_15COM );
  GATE_zynq_16_I_1:   BUFF port map ( I0=>d_16PIN, 
            O=>zynq_16COM );
  GATE_zynq_17_I_1:   BUFF port map ( I0=>d_17PIN, 
            O=>zynq_17COM );
  GATE_zynq_20_I_1:   BUFF port map ( I0=>d_20PIN, 
            O=>zynq_20COM );
  GATE_zynq_25_I_1:   BUFF port map ( I0=>d_25PIN, 
            O=>zynq_25COM );
  GATE_zynq_26_I_1:   BUFF port map ( I0=>d_26PIN, 
            O=>zynq_26COM );
  GATE_zynq_27_I_1:   BUFF port map ( I0=>d_27PIN, 
            O=>zynq_27COM );
  GATE_zynq_28_I_1:   BUFF port map ( I0=>d_28PIN, 
            O=>zynq_28COM );
  GATE_d_1_I_1:   BUFF port map ( I0=>zynq_1PIN, 
            O=>d_1COM );
  GATE_d_2_I_1:   BUFF port map ( I0=>zynq_2PIN, 
            O=>d_2COM );
  GATE_d_3_I_1:   BUFF port map ( I0=>zynq_3PIN, 
            O=>d_3COM );
  GATE_d_4_I_1:   BUFF port map ( I0=>zynq_4PIN, 
            O=>d_4COM );
  GATE_d_6_I_1:   BUFF port map ( I0=>zynq_6PIN, 
            O=>d_6COM );
  GATE_d_7_I_1:   BUFF port map ( I0=>zynq_7PIN, 
            O=>d_7COM );
  GATE_d_8_I_1:   BUFF port map ( I0=>zynq_8PIN, 
            O=>d_8COM );
  GATE_d_9_I_1:   BUFF port map ( I0=>zynq_9PIN, 
            O=>d_9COM );
  GATE_d_10_I_1:   BUFF port map ( I0=>zynq_10PIN, 
            O=>d_10COM );
  GATE_d_18_I_1:   BUFF port map ( I0=>zynq_18PIN, 
            O=>d_18COM );
  GATE_d_19_I_1:   BUFF port map ( I0=>zynq_19PIN, 
            O=>d_19COM );
  GATE_d_21_I_1:   BUFF port map ( I0=>zynq_21PIN, 
            O=>d_21COM );
  GATE_d_22_I_1:   BUFF port map ( I0=>zynq_22PIN, 
            O=>d_22COM );
  GATE_d_23_I_1:   BUFF port map ( I0=>zynq_23PIN, 
            O=>d_23COM );
  GATE_d_24_I_1:   BUFF port map ( I0=>zynq_24PIN, 
            O=>d_24COM );

end NetList;
