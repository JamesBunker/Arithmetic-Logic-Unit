library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SSD is
    Port (byte : in STD_LOGIC_VECTOR (3 downto 0);
	  CATHODE_SSD : out STD_LOGIC_VECTOR (7 downto 0));
end SSD;

architecture Structural of SSD is

begin
    CATHODE_SSD <= 
    "00000011" WHEN (byte = "0000") ELSE --0
    "10011111" WHEN (byte = "0001") ELSE --1
    "00100101" WHEN (byte = "0010") ELSE --2
    "00001101" WHEN (byte = "0011") ELSE --3
    "10011001" WHEN (byte = "0100") ELSE --4
    "01001001" WHEN (byte = "0101") ELSE --5
    "01000001" WHEN (byte = "0110") ELSE --6
    "00011111" WHEN (byte = "0111") ELSE --7 
    "00000001" WHEN (byte = "1000") ELSE --8
    "00001001" WHEN (byte = "1001") ELSE --9 
    "00010001" WHEN (byte = "1010") ELSE --A
    "11000001" WHEN (byte = "1011") ELSE --B
    "01100011" WHEN (byte = "1100") ELSE --C
    "10000101" WHEN (byte = "1101") ELSE --D
    "01100001" WHEN (byte = "1110") ELSE --E
    "01110001" WHEN (byte = "1111") ELSE --F
    "00000000";     
    
end Structural;
