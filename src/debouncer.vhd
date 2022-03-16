library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
  Port ( nr,clk: in std_logic; -- semnalul de enable, si clock de la placa
  clk_bun:out std_logic-- rezultatul
  );
end debouncer;

architecture Behavioral of debouncer is
component bis_d is
 Port ( d,clk: in std_logic; -- bistabil d
 d_out:out std_logic
 );
end component;
signal s: std_logic_vector(0 to 20); -- semnalde iesire d_out
begin -- se pun 20 de bis d care vor da semnal una la alta pt debouncer
d1: bis_d port map (d=>nr,clk=>clk,d_out=>s(0));
d2: bis_d port map (d=>s(0),clk=>clk,d_out=>s(1));
d3: bis_d port map (d=>s(1),clk=>clk,d_out=>s(2));
d4: bis_d port map (d=>s(2),clk=>clk,d_out=>s(3));
d5: bis_d port map (d=>s(3),clk=>clk,d_out=>s(4));
d6: bis_d port map (d=>s(4),clk=>clk,d_out=>s(5));
d7: bis_d port map (d=>s(5),clk=>clk,d_out=>s(6));
d8: bis_d port map (d=>s(6),clk=>clk,d_out=>s(7));
d9: bis_d port map (d=>s(7),clk=>clk,d_out=>s(8));
d10: bis_d port map (d=>s(8),clk=>clk,d_out=>s(9));
d11: bis_d port map (d=>s(9),clk=>clk,d_out=>s(10));
d12: bis_d port map (d=>s(10),clk=>clk,d_out=>s(11));
d13: bis_d port map (d=>s(11),clk=>clk,d_out=>s(12));
d14: bis_d port map (d=>s(12),clk=>clk,d_out=>s(13));
d15: bis_d port map (d=>s(13),clk=>clk,d_out=>s(14));
d16: bis_d port map (d=>s(14),clk=>clk,d_out=>s(15));
d17: bis_d port map (d=>s(15),clk=>clk,d_out=>s(16));
d18: bis_d port map (d=>s(16),clk=>clk,d_out=>s(17));
d19: bis_d port map (d=>s(17),clk=>clk,d_out=>s(18));
d20: bis_d port map (d=>s(18),clk=>clk,d_out=>s(19));
clk_bun<= s(0) and s(1) and s(2) and s(3) and s(4) and s(5) and s(6) and s(7) and s(8) and s(9) and s(10) and s(11) and s(12) and s(13) and s(14) and s(15) and s(16) and s(17) and s(18) and s(19); 
-- se face AND pentru toate rezultatele de la cele 20 de bistabile
end Behavioral;
