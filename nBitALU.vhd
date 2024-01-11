library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity nBitALU is
Generic(n:integer);
    Port ( A_nBitALU : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B_nBitALU : in  STD_LOGIC_VECTOR (n-1 downto 0);
		   SEL_nBitALU : in  STD_LOGIC_VECTOR (2 downto 0);
           Aout_nBitALU : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Bout_nBitALU : out  STD_LOGIC_VECTOR (n-1 downto 0));
end nBitALU;

architecture Structural of nBitALU is
    COMPONENT ALU
    Port ( A_ALU : in  STD_LOGIC;
           B_ALU : in  STD_LOGIC;
		   SEL_ALU : in  STD_LOGIC_VECTOR(2 downto 0); --set c in to s statement
           Aout_ALU : out  STD_LOGIC;
           Bout_ALU : out  STD_LOGIC);
    END COMPONENT;
begin
-- Generate Statement to instatiate ALUs
ALU_array: For i in 0 to n-1 generate
    ALU_instant: ALU PORT MAP(
        A_ALU => A_nBitALU(i),
        B_ALU => B_nBitALU(i),
		SEL_ALU => SEL_nBitALU,
		Aout_ALU => Aout_nBitALU(i),
		Bout_ALU => Bout_nBitALU(i)
    );
end generate ALU_array;

end Structural;
