----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Silva
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell - Behavioral 
-- Description: 		Shell for completing CE3
-- Editted by Austin Bolinger
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

------------------------
--prime numbers
------------------------
--entity MooreElevatorController_Shell is
--    Port ( clk : in  STD_LOGIC;
--           reset : in  STD_LOGIC;
--           stop : in  STD_LOGIC;
--           up_down : in  STD_LOGIC;
--           floor : out  STD_LOGIC_VECTOR (4 downto 0));
--			  
--end MooreElevatorController_Shell;

--------------------------
--change inputs
--------------------------
entity MooreElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           floorGoTo : in STD_LOGIC_VECTOR (2 downto 0);
           floor : out  STD_LOGIC_VECTOR (2 downto 0));
			  
end MooreElevatorController_Shell;


architecture Behavioral of MooreElevatorController_Shell is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
-----------------------
--prime numbers
-----------------------
--type floor_state_type is (floor1, floor2, floor3, floor4, floor5, floor6, floor7, floor8);


---------------------------
--change inputs
--------------------------
signal floor_state : std_logic_vector(2 downto 0);


-----------------------
--prime numbers
-----------------------
--type floor_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

-----------------------------
--
-----------------------------
floor_state_machine: process(clk)
begin
if clk'event and clk ='1' then
	if reset ='1' then
		floor_state <="000";
	else
		case floor_state is
			when "000" =>--0
				if(floorGoTo = "000") then
					floor_state <= "000";
				else
					floor_state<= "001";
				end if;
			when "001" =>--1
				if(floorGoTo < "001") then
					floor_state <= "000";
				elsif(floorGoTo = "001") then
					floor_state <= "001";
				else
					floor_state<="010";
				end if;
			when "010" =>--2
				if(floorGoTo < "010") then
					floor_state <= "001";
				elsif(floorGoTo = "010") then
					floor_state <= "010";
				else
					floor_state<="011";
				end if;
			when "011" =>--3
				if(floorGoTo < "011") then
					floor_state <= "010";
				elsif(floorGoTo = "011") then
					floor_state <= "011";
				else
					floor_state<="100";
				end if;
			when "100" =>--4
				if(floorGoTo < "100") then
					floor_state <= "011";
				elsif(floorGoTo = "100") then
					floor_state <= "100";
				else
					floor_state<="101";
				end if;
			when "101" =>--5
				if(floorGoTo < "101") then
					floor_state <= "100";
				elsif(floorGoTo = "101") then
					floor_state <= "101";
				else
					floor_state<="110";
				end if;
			when "110" =>--6
				if(floorGoTo < "110") then
					floor_state <= "101";
				elsif(floorGoTo = "110") then
					floor_state <= "110";
				else
					floor_state<="111";
				end if;
			when "111" =>--7
				if(floorGoTo < "111") then
					floor_state <= "110";
				else
					floor_state<="111";
				end if;
			when others =>
					floor_state <= "000";
		end case;
	end if;
end if;
end process;
floor <= "000" when (floor_state = "000") else
			"001" when (floor_state = "001") else
			"010" when (floor_state = "010") else
			"011" when (floor_state = "011") else
			"100" when (floor_state = "100") else
			"101" when (floor_state = "101") else
			"110" when (floor_state = "110") else
			"111" when (floor_state = "111") else
			"000";


------------------------------
--prime numbers
------------------------------
--floor_state_machine: process(clk)
--begin
--	if clk'event and clk='1' then
--		if reset='1' then
--			floor_state <= floor1;
--		else
--			case floor_state is
--				when floor1 =>
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor2;
--					else
--						floor_state <= floor1;
--					end if;
--				when floor2 => 
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor3; 			
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor1;
--					else
--						floor_state <= floor2;
--					end if;
--				when floor3 =>
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor4;
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor2;	
--					else
--						floor_state <= floor3;	
--					end if;
--				when floor4 =>
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor5;
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor2;	
--					else
--						floor_state <= floor4;	
--					end if;
--				when floor5 =>
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor6;
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor4;	
--					else
--						floor_state <= floor5;	
--					end if;
--				when floor6 =>
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor7;
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor5;	
--					else
--						floor_state <= floor6;	
--					end if;
--				when floor7 =>
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor8;
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor6;	
--					else
--						floor_state <= floor7;	
--					end if;
--				when floor8 =>
--					if (up_down='0' and stop='0') then 
--						floor_state <= floor7;	
--					else 
--						floor_state <= floor8;	
--					end if;
--				when others =>
--					floor_state <= floor1;
--			end case;
--		end if;
--	end if;
--end process;

---------------------------------
--prime numbers
---------------------------------
--floor <= "00010" when (floor_state = floor1) else
--			"00011" when (floor_state = floor2) else
--			"00101" when (floor_state = floor3) else
--			"00111" when (floor_state = floor4) else
--			"01011" when (floor_state = floor5) else
--			"01101" when (floor_state = floor6) else
--			"10001" when (floor_state = floor7) else
--			"10011" when (floor_state = floor8) else
--			"00001";

end Behavioral;

