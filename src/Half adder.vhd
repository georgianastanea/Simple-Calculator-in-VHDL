library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity sumator2bit is
	port(a,b,cin:in std_logic;
	s,cout:out std_logic);
end entity ;
architecture sumator2bita of sumator2bit is
begin -- sumator complet pe 2 biti
	s<= a xor b xor cin;
	cout<= (a and b) or (a and cin) or (b and cin);
end sumator2bita;
	