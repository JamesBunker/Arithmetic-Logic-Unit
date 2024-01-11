library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A_FA : in  STD_LOGIC;
           B_FA : in  STD_LOGIC;
           Cin_FA : in  STD_LOGIC;
           Sum_FA : out  STD_LOGIC;
           Cout_FA : out  STD_LOGIC);
end FullAdder;

architecture Structural of FullAdder is
	signal COUT_TEMP0 : STD_LOGIC;
	signal COUT_TEMP1  : STD_LOGIC;
	signal SUM_TEMP  : STD_LOGIC;
	component HalfAdder is 
		Port ( A_HA : in  STD_LOGIC;
           B_HA : in  STD_LOGIC;
           Sum_HA : out  STD_LOGIC;
           Cout_HA : out  STD_LOGIC);
	end component HalfAdder;
begin
	HA0 : HalfAdder 
		port map (A_HA=>A_FA, B_HA=>B_FA , Sum_HA=> SUM_TEMP, Cout_HA=>COUT_TEMP0);
					
	HA1 : HalfAdder 
		port map (A_HA=>SUM_TEMP, B_HA=>Cin_FA , Sum_HA=> Sum_FA, Cout_HA=>COUT_TEMP1);
	Cout_FA<= COUT_TEMP0 or COUT_TEMP1;
end Structural;