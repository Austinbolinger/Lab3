----------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: Austin Bolinger
-- 
-- Create Date:    12:43:25 07/07/2012 
-- Module Name:    Nexys2_Lab3top - Behavioral 
-- Target Devices: Nexys2 Project Board
-- Tool versions: 
-- Description: This file is a shell for implementing designs on a NEXYS 2 board
-- 


--Documentation: C3C Pluger: I did not understand the logic translation from java 
--			to vhdl. So, Pluger walked me through the process that required changing
--			the inputs with three switches.



--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--for basic functionality 
entity Nexys2_top_shell is
    Port ( 	clk_50m : in STD_LOGIC;
				btn : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
				switch : in STD_LOGIC_VECTOR (7 DOWNTO 0);
				SSEG_AN : out STD_LOGIC_VECTOR (3 DOWNTO 0);
				SSEG : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				LED : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end Nexys2_top_shell;

architecture Behavioral of Nexys2_top_shell is

---------------------------------------------------------------------------------------
--This component converts a nibble to a value that can be viewed on a 7-segment display
--Similar in function to a 7448 BCD to 7-seg decoder
--Inputs: 4-bit vector called "nibble"
--Outputs: 8-bit vector "sseg" used for driving a single 7-segment display
---------------------------------------------------------------------------------------
	COMPONENT nibble_to_sseg
	PORT(
		nibble : IN std_logic_vector(3 downto 0);          
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

---------------------------------------------------------------------------------------------
--This component manages the logic for displaying values on the NEXYS 2 7-segment displays
--Inputs: system clock, synchronous reset, 4 8-bit vectors from 4 instances of nibble_to_sseg
--Outputs: 7-segment display select signal (4-bit) called "sel", 
--         8-bit signal called "sseg" containing 7-segment data routed off-chip
---------------------------------------------------------------------------------------------
	COMPONENT nexys2_sseg
	GENERIC ( CLOCK_IN_HZ : integer );
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		sseg0 : IN std_logic_vector(7 downto 0);
		sseg1 : IN std_logic_vector(7 downto 0);
		sseg2 : IN std_logic_vector(7 downto 0);
		sseg3 : IN std_logic_vector(7 downto 0);          
		sel : OUT std_logic_vector(3 downto 0);
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
-------------------------------------------------------------------------------------
--This component divides the system clock into a bunch of slower clock speeds
--Input: system clock 
--Output: 27-bit clockbus. Reference module for the relative clock speeds of each bit
--			 assuming system clock is 50MHz
-------------------------------------------------------------------------------------
	COMPONENT Clock_Divider
	PORT(
		clk : IN std_logic;          
		clockbus : OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;

-------------------------------------------------------------------------------------
--Below are declarations for signals that wire-up this top-level module.
-------------------------------------------------------------------------------------

signal nibble0, nibble1, nibble2, nibble3, currentNibble0, currentNibble1 : std_logic_vector(3 downto 0);
signal sseg0_sig, sseg1_sig, sseg2_sig, sseg3_sig : std_logic_vector(7 downto 0);
signal ClockBus_sig : STD_LOGIC_VECTOR (26 downto 0);
signal floorBitNo : std_logic_vector(2 downto 0);


--------------------------------------------------------------------------------------
--Insert your design's component declaration below	
--------------------------------------------------------------------------------------
-------------------------
--prime numbers
-------------------------
--Component MooreElevatorController_Shell
--		Port(clk: in std_logic;
--			  reset : in std_logic;
--			  stop : in  STD_LOGIC;
--           up_down : in  STD_LOGIC;
--			  floor : out std_logic_vector(4 downto 0));	
--	end component mooreElevatorController_Shell;

----------------------------
--change inputs
----------------------------
Component MooreElevatorController_Shell
		Port(clk: in std_logic;
			  reset : in std_logic;
			  floorGoTo : in std_logic_vector(2 downto 0);
			  floor : out std_logic_vector(2 downto 0));	
	end component mooreElevatorController_Shell;

-------------------------------
--for basic functionality
-------------------------------
--Component MealyElevatorController_Shell
--		Port(clk: in std_logic;
--			  reset : in std_logic;
--			  stop : in std_logic;
--			  up_down : in std_logic;
--			  floor : out std_logic_vector(3 downto 0);
--			  nextfloor : out std_logic_vector(3 downto 0));	
--	end component MealyElevatorController_Shell;

--------------------------------------------------------------------------------------
--Insert any required signal declarations below
--------------------------------------------------------------------------------------


begin

----------------------------
--code below tests the LEDs:
----------------------------
LED <= CLOCKBUS_SIG(26 DOWNTO 19);

--------------------------------------------------------------------------------------------	
--This code instantiates the Clock Divider. Reference the Clock Divider Module for more info
--------------------------------------------------------------------------------------------
	Clock_Divider_Label: Clock_Divider PORT MAP(
		clk => clk_50m,
		clockbus => ClockBus_sig
	);

--------------------------------------------------------------------------------------	
--Code below drives the function of the 7-segment displays. 
--Function: To display a value on 7-segment display #0, set the signal "nibble0" to 
--				the value you wish to display
--				To display a value on 7-segment display #1, set the signal "nibble1" to 
--				the value you wish to display...and so on
--Note: You must set each "nibble" signal to a value. 
--		  Example: if you are not using 7-seg display #3 set nibble3 to "0000"
--------------------------------------------------------------------------------------



--This code converts a nibble to a value that can be displayed on 7-segment display #0
	sseg0: nibble_to_sseg PORT MAP(
		nibble => nibble0,
		sseg => sseg0_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #1
	sseg1: nibble_to_sseg PORT MAP(
		nibble => nibble1,
		sseg => sseg1_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #2
	sseg2: nibble_to_sseg PORT MAP(
		nibble => nibble2,
		sseg => sseg2_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #3
	sseg3: nibble_to_sseg PORT MAP(
		nibble => nibble3,
		sseg => sseg3_sig
	);
	
--This module is responsible for managing the 7-segment displays, you don't need to do anything here
	nexys2_sseg_label: nexys2_sseg 
	generic map ( CLOCK_IN_HZ => 50E6 )
	PORT MAP(
		clk => clk_50m,
		reset => '0',
		sseg0 => sseg0_sig,
		sseg1 => sseg1_sig,
		sseg2 => sseg2_sig,
		sseg3 => sseg3_sig,
		sel => SSEG_AN,
		sseg => SSEG
	);


-----------------------------------------------------------------------------
--Instantiate the design you with to implement below and start wiring it up!:
-----------------------------------------------------------------------------

------------------------------
--for basic functionality
-------------------------------
--Inst_MealyElevatorController_Shell: MealyElevatorController_Shell PORT MAP(
--		clk => ClockBus_sig(25),
--		reset => switch(7),
--		stop => switch(1),
--		up_down => switch(0),
--		floor => nibble3,
--		nextfloor=> nibble0
--	);
---------------------------
--for basic functionality
---------------------------
--for basic functionality
--nibble1 <= "1010";--display A for floor A or next floor
--nibble2 <= "1111";--display F for Floor


------------------------
--change inputs
------------------------
Inst_MooreElevatorController_Shell: MooreElevatorController_Shell PORT MAP(
	clk=> ClockBus_sig(25),
	reset => switch(7),
	floorGoTo(0) => switch(0),
	floorGoTo(1) => switch(1),
	floorGoTo(2) => switch(2),
	floor => floorBitNo
	);
nibble0 <= "0" & floorBitNo(2 downto 0);
nibble1 <= "0000";
nibble2 <= "1111"; 
nibble3 <= "0000";

	--------------------------------------
	--prime numbers elevator
	--------------------------------------
--	nibble3 <= "1111";
--	nibble2 <= "1111";
--process(floorBitNo) 
--	begin		
--		case (floorBitNo) is 
--			when "00010" => 			
--				nibble1 <= "0000";--0
--				nibble0 <= "0010";--2
--				currentNibble1 <= "0000";
--				currentNibble0 <= "0010";
--			when "00011" =>
--				nibble1 <= "0000";--0
--				nibble0 <= "0011";--3	
--				currentNibble1 <= "0000";	
--				currentNibble0 <= "0011";				
--			when "00101" =>						
--				nibble1 <= "0000";--0
--				nibble0 <= "0101";--5
--				currentNibble1 <= "0000";
--				currentNibble0 <= "0101";
--			when "00111" =>			
--				nibble1 <= "0000";--0
--				nibble0 <= "0111";--7
--				currentNibble1 <= "0000";
--				currentNibble0 <= "0111";
--			when "01011" => 			
--				nibble1 <= "0001";--1
--				nibble0 <= "0001";--1
--				currentNibble1 <= "0001";
--				currentNibble0 <= "0001";
--			when "01101" =>
--				nibble1 <= "0001";--1
--				nibble0 <= "0011";--3
--				currentNibble1 <= "0001";
--				currentNibble0 <= "0011";
--			when "10001" =>			
--				nibble1 <= "0001";--1
--				nibble0 <= "0111";--7			
--				currentNibble1 <= "0001";
--				currentNibble0 <= "0111";
--			when "10011" =>			
--				nibble1 <= "0001";--1
--				nibble0 <= "1001";--9
--				currentNibble1 <= "0001";
--				currentNibble0 <= "1001";
--			when others =>		
--				nibble1 <= currentNibble1;			
--				nibble0 <= currentNibble0;	
--		end case;	
--end process;


end Behavioral;

