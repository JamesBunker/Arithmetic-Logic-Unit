library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ArithmeticTop is
  generic (n : integer);
  port (A : in  std_logic_vector (n-1 downto 0);
        B : in  std_logic_vector (n-1 downto 0);
		SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        C : in  std_logic;
		OVF : out std_logic;
        SUM_padded  : out std_logic_vector(31 downto 0));
end ArithmeticTop;

architecture Structural of ArithmeticTop is

component nBitAdder is
Generic(n:integer);
    Port ( Ain : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Bin : in  STD_LOGIC_VECTOR (n-1 downto 0);
		   Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
end component nBitAdder;

component nBitALU is
Generic(n:integer);
    Port ( A_nBitALU : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B_nBitALU : in  STD_LOGIC_VECTOR (n-1 downto 0);
		   SEL_nBitALU : in  STD_LOGIC_VECTOR (2 downto 0);
           Aout_nBitALU : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Bout_nBitALU : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component nBitALU;

  signal SUM : std_logic_vector(n-1 downto 0);
  --signal SUM_padded : std_logic_vector (31 downto 0);
  signal SEL_TMP : std_logic_vector(2 downto 0); 
  signal Aout_nBitALU_temp : std_logic_vector(n-1 downto 0);
  signal Bout_nBitALU_temp : std_logic_vector(n-1 downto 0);

begin
SEL_TMP <= SEL & C;

  nBitArithmetic : nBitALU
    generic map (n => n)
	Port map ( A_nBitALU => A,
		   B_nBitALU => B,
		   SEL_nBitALU => SEL_TMP,
		   Aout_nBitALU => Aout_nBitALU_temp,
		   Bout_nBitALU => Bout_nBitALU_temp);


  nBitAddition : nBitAdder
    generic map (n => n)
    port map (Ain  => Aout_nBitALU_temp,
              Bin  => Bout_nBitALU_temp,
              Cin => C,
              S  => SUM,
              Cout => OVF);


    test: process(A, B, SUM)
    begin
        SUM_padded <= ((SUM_padded'length - 1) downto SUM'length => '0') & SUM;
        SUM_padded (31 downto 28) <= A(n-1 downto 0);
        SUM_padded (23 downto 20) <= B(n-1 downto 0);
    end process;

end Structural;
