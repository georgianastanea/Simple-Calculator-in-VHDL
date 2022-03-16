library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity decision is
  Port ( 
  e: in std_logic;
  minus,plus,ori,div,semn_ad,semn1,semn2: in std_logic;
  suma,inm,imp,rest: in std_logic_vector(0 to 7);
  semn_out: out std_logic;
  numar_out:out std_logic_vector(0 to 7);
  rest_out:out std_logic_vector(4 to 7)
  );
end decision;

architecture Behavioral of decision is

begin
process(e) -- alegere
	begin 
		if(e='1' and e'event) then	-- noul semnal de la debouncer de la enter, daca enter e activ
		
		  if((minus='1' or plus='1')) then -- daca e minus/plus, pregatesc la afisare suma/diferenta in functie de semn
			semn_out<=semn_ad;
			numar_out<=suma;
			rest_out<="0000";-- restul e 0
		  elsif(ori='1' ) then-- rezultatul e inmultire
			semn_out<=semn1 xor semn2;-- semnul la inmultire e clar xor intre semne
			numar_out<=inm;
			rest_out<="0000";
		  elsif(div='1')   then
			 semn_out<=semn1 xor semn2;-- la fel si aici ca la produs
			numar_out<=imp;
			rest_out<=rest(4 to 7);	-- restul il afisez doar pe 4 biti ca nu mai e loc
		  end if;
		
		end if;
	end process;

end Behavioral;