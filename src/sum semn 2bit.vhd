library ieee;
use ieee.std_logic_1164.all;
entity sumator is
	port(s1,s2: in STD_LOGIC;
	x,y: in STD_LOGIC_VECTOR(0 to 7);
	a,b,cin:in STD_LOGIC;
	cout,s:out STD_LOGIC);
end entity ; 
architecture arh of sumator is 
component comparator is
	port(x,y: in STD_LOGIC_VECTOR(0 to 7);
	cmp:out STD_LOGIC);
end component;
signal c,va,vb: STD_LOGIC;
begin 
	C1 : comparator port map (x=>x,y=>y,cmp=>c);-- valoarea de comparatie intre x si y
	va<= (((not c) or (s1 xnor s2))and a) or (( c and not a) and  (s1 xor s2)); -- functia din caiet
	vb<= (( c or (s1 xnor s2))and b) or (( (not c) and not b) and  (s1 xor s2));-- la fel
	s<= a xor b xor cin;-- functia clasica pentru sumator
	cout<= (va and vb) or (va and cin) or (vb and cin);--functia clasica pentru cout/borrow dar cu va si vb
end arh;