library ieee;
use ieee.std_logic_1164.all;
entity sumator_scazator is 
	port(  s1,s2: in STD_LOGIC;-- semne nr
	a,b:in STD_LOGIC_VECTOR(0 to 7);--numerele
	n:out STD_LOGIC_VECTOR(0 to 7); --rezultatul
	sn:out STD_LOGIC);-- semn rez
end entity ;
architecture arh of sumator_scazator is 
component sumator is -- sumatorul pe 2 biti cu functiile demonstrate
	port( s1,s2: in STD_LOGIC; -- semne numere
	x,y: in STD_LOGIC_VECTOR(0 to 7);--numerele a si b pentru comparare
	a,b,cin:in STD_LOGIC;-- bitul lui a si b pe rand
	cout,s:out STD_LOGIC);-- suma si cout/ borrow
end component ;
component comparator is -- comparator 8 biti
	port(x,y: in STD_LOGIC_VECTOR(0 to 7);
	cmp:out STD_LOGIC);
end component ;
signal sig: STD_LOGIC_VECTOR(0 to 8); -- semnal pt cin/borrow
signal sc: STD_LOGIC; -- valoarea comparatiei dintre a si b
begin  
    -- se va face mapare clasica, ca la un sumator pe 8 biti
    -- cout/ cin va fi mapat unul de la altul
    -- se aduna/scade bit cu bit plus se adauga numerele initiale si semnele
    
	C0: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(7),b=>b(7),cin=>'0',cout=>sig(7),s=>n(7));
	C3: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(6),b=>b(6),cin=>sig(7),cout=>sig(6),s=>n(6));
	C4: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(5),b=>b(5),cin=>sig(6),cout=>sig(5),s=>n(5));
	C5: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(4),b=>b(4),cin=>sig(5),cout=>sig(4),s=>n(4));
	C6: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(3),b=>b(3),cin=>sig(4),cout=>sig(3),s=>n(3));
	C7: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(2),b=>b(2),cin=>sig(3),cout=>sig(2),s=>n(2));
	C1: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(1),b=>b(1),cin=>sig(2),cout=>sig(1),s=>n(1));
	C2: sumator port map (s1=>s1,s2=>s2,x=>a,y=>b,a=>a(0),b=>b(0),cin=>sig(1),cout=>sig(0),s=>n(0)); 
	C8: comparator port map (x=>a,y=>b,cmp=>sc); -- comparare intre numere, sc e rezultatul compararii
	sn<= (not sc and s2) or (sc and s1); --este functia SGN din caiet/ sau semn n (sn)
	-- functia din schema 
end arh;
	
	