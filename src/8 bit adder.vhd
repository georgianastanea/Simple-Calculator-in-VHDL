library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity sum8bit is
	port(a,b:in std_logic_vector(0 to 7);
	s:out std_logic_vector(0 to 7));
end entity ;
architecture sum8bita of sum8bit is	

component sumator2bit is -- sumator 2 biti
	port(a,b,cin:in std_logic;
	s,cout:out std_logic);
end component ;

signal sgn: std_logic_vector(0 to 7);	  -- sumator 8 biti facut cu sumator complet pe 1 bit
begin  -- se aduna bit cu bit pe rand si cout ii da cin la cel din stanga lui
	f1: sumator2bit port map (a=>a(7),b=>b(7),cin=>'0',s=>s(7),cout=>sgn(7));
	f2: sumator2bit port map (a=>a(6),b=>b(6),cin=>sgn(7),s=>s(6),cout=>sgn(6));
	f3: sumator2bit port map (a=>a(5),b=>b(5),cin=>sgn(6),s=>s(5),cout=>sgn(5));
	f4: sumator2bit port map (a=>a(4),b=>b(4),cin=>sgn(5),s=>s(4),cout=>sgn(4));
	f5: sumator2bit port map (a=>a(3),b=>b(3),cin=>sgn(4),s=>s(3),cout=>sgn(3));
	f6: sumator2bit port map (a=>a(2),b=>b(2),cin=>sgn(3),s=>s(2),cout=>sgn(2));
	f7: sumator2bit port map (a=>a(1),b=>b(1),cin=>sgn(2),s=>s(1),cout=>sgn(1));
	f8: sumator2bit port map (a=>a(0),b=>b(0),cin=>sgn(1),s=>s(0),cout=>sgn(0));
end sum8bita;