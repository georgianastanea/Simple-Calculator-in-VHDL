library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bis_d is
 Port ( d,clk: in std_logic;
 d_out:out std_logic
 );
end bis_d;

architecture Behavioral of bis_d is

begin
process(clk)
begin
if(clk='1' and clk'event) then --BISTABIL D
d_out<=d;
end if;
end process;
end Behavioral;

