library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity TopLevel is
  generic (bits : integer := 4);
  port (clk : in  std_logic;
        Ain_top : in  std_logic_vector (bits-1 downto 0);
        Bin_top : in  std_logic_vector (bits-1 downto 0);
		SELin_top : in  STD_LOGIC_VECTOR(1 downto 0);
        Cin_top : in  std_logic;
		OVF_top : out std_logic;
        Cathode_top   : out std_logic_vector(7 downto 0);
        Anode_top  : out std_logic_vector(7 downto 0));
end TopLevel;

architecture Structural of TopLevel is

component ArithmeticTop is
  generic (n : integer);
  port (A : in  std_logic_vector (n-1 downto 0);
        B : in  std_logic_vector (n-1 downto 0);
	   SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        C : in  std_logic;
		OVF : out std_logic;
        SUM_padded  : out std_logic_vector(31 downto 0));
end component ArithmeticTop;

component SSD_logic is
    Port (clk : in      STD_LOGIC;    
           input : in STD_LOGIC_VECTOR (31 downto 0); -- 4 bytes * 8 ssd
           Cathode : out STD_LOGIC_VECTOR (7 downto 0);
           Anode : out STD_LOGIC_VECTOR (7 downto 0));
end component SSD_logic;

  signal SUM_padded_temp : std_logic_vector (31 downto 0);

begin
  Arithmetic : ArithmeticTop
    generic map (n => bits)
    port map (  A => Ain_top, 
                B => Bin_top, 
                SEL => SELin_top, 
                C => Cin_top, 
                OVF => OVF_top, 
                SUM_padded => SUM_padded_temp);
    
    --setting first two outputs to display inputs

  SSD : SSD_logic
    port map (clk => clk, input => SUM_padded_temp, Cathode => Cathode_top, Anode => Anode_top);

end Structural;
