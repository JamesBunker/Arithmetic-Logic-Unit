library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity nBitAdder is
Generic(n:integer);
    Port ( Ain : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Bin : in  STD_LOGIC_VECTOR (n-1 downto 0);
		   Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
end nBitAdder;

architecture Structural of nBitAdder is
    COMPONENT FullAdder
    PORT(
        A_FA : IN std_logic;
        B_FA : IN std_logic;
        Cin_FA : IN std_logic;          
        Sum_FA : OUT std_logic;
        Cout_FA : OUT std_logic
        );
    END COMPONENT;
    signal C : std_logic_vector(n downto 0);
begin
C(0) <= Cin;
-- Generate Statement to instatiate full adders
FA_array: For i in 0 to n-1 generate
    FA_instant: FullAdder PORT MAP(
        A_FA => Ain(i),
        B_FA => Bin(i),
        Cin_FA => C(i),
        Sum_FA => S(i),
		-- Cout to Cin of the next FA
        Cout_FA => C(i+1) 
    );
end generate FA_array;
-- Final Cout/overflow 
Cout <= C(n);
end Structural;
