library ieee;
use ieee.std_logic_1164.all;
entity comparator is
	port(x,y: in STD_LOGIC_VECTOR(0 to 7);-- numerele de comparatie
	cmp:out STD_LOGIC);-- 0 pentru a<b si 1 pentru a>=b
end entity ;
architecture arh of comparator is
begin -- functia dezvoltata dupa comparatorul de 2 biti invatat
	cmp <= (x(0) and not y(0)) or ( (x(0) xnor y(0)) and ( x(1) and not y(1))) or  ((x(0) xnor y(0) ) and (x(1) xnor y(1)) and (x(2) and not y(2))) or (	(x(0) xnor y(0)) and (x(1) xnor y(1))  and (x(2) xnor y(2)) and ( x(3) and not y(3))) or ( (x(0) xnor y(0)) and (x(1) xnor y(1))  and (x(2) xnor y(2)) and (x(3) xnor y(3)) and (x(4) and not y(4))) or (  (x(0) xnor y(0)) and (x(1) xnor y(1))  and (x(2) xnor y(2)) and (x(3) xnor y(3)) and (x(4) xnor y(4)) and (x(5) and not y(5))) or (	(x(0) xnor y(0)) and (x(1) xnor y(1))  and (x(2) xnor y(2)) and (x(3) xnor y(3)) and (x(4) xnor y(4))	and (x(5) xnor y(5)) and (x(6) and not y(6))) or (	(x(0) xnor y(0)) and (x(1) xnor y(1))  and (x(2) xnor y(2)) and (x(3) xnor y(3)) and (x(4) xnor y(4))	and (x(5) xnor y(5)) and (x(6) xnor y(6)) and (x(7) and not y(7)));
end arh;