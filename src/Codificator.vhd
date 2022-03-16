library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity codi is
    Port ( n0 : in STD_LOGIC;-- butoane de intrare, cif de la 0 la 9
           n1 : in STD_LOGIC;-- la fel 
           n2,n3,n4,n5,n6,n7,n8,n9 ,plus,minus,ori,imp: in STD_LOGIC;-- mai sunt operatorii, +,-+*,/
           reset,enterc: in STD_LOGIC;-- buton reset, confirmare cifra/ urmatoarea operatie
           semn1,semn2 : out STD_LOGIC;-- semnele celor 2 nr
	numarout1,numarout2,numar_out: inout std_logic_vector(0 to 7);--numarul creat 1 si 2, si rezultatul final
	semn_out: inout std_logic;-- semnul de iesire
	enter: in std_logic); -- buton de afisare pe afisor
end entity ;



architecture convertora of codi is
signal n00,n11: std_logic_vector(0 to 7);--semnale pt cele 2 nr
begin
    
    n11<=numarout2;-- numerele curente sunt puse in semnale ca sa fie prelucrate 
	n00<=numarout1;
    process(enterc,reset,numarout1,enter)
	variable v1,v2: std_logic_vector(0 to 7);-- var pt numere
	begin 
	   v2:=numarout1;-- al 2 lea nr
	   v1:=numarout2;-- primul nr
		if(reset='1' ) then -- daca resetez, pun 0
		  v2:="00000000";
		   v1:="00000000";
		   semn1<='0';	-- semn nr 2
		      if(v1="00000000" and v2="00000000" and minus='1' ) then-- daca tocmai resetez, si activez minus, semnul la primul nr e minus
	          semn2<='1';-- semn primul nr ( e invers ) e minus
	          else semn2<='0';
	        end if;
			     
		else
		if(enterc='1' and enterc'event) then -- dau confirmare cifra/ next
		     if(enter='1') then-- daca tocmai am afisat si enter e 1, rezultatul final merge in primul nr (operatie succesiva)
	           v2:="00000000";-- nr 2 e 0
	           semn1<='0';-- setez semn plus
	           semn2<=semn_out;-- ia semnul de iesire
	           v1:=numar_out;-- ia nr de iesire
		     elsif((plus='1'or minus='1' or ori='1' or imp='1') and v1>"00000000"  )	then-- daca am operator activ si primul nr e >0 ( deja construit), construiesc nr 2
			    v2:=n00+n00;-- inmultesc cu 10 nr 2
				v2:=v2+n00;-- prin adunare de 10 ori cu acel nr 2
				v2:=v2+n00;
				v2:=v2+n00;
				v2:=v2+n00;
				v2:=v2+n00;
				v2:=v2+n00;
				v2:=v2+n00;
				v2:=v2+n00;
				if(minus='1') then semn1<='1';-- daca si minus e activ, semn nr 2 e minus ( e invers)
				end if;
				
			if(n1='1') then -- adun cifra 1 daca e activa
			v2:=v2+1;
			elsif(n2='1') then-- adun cifra 2 
			v2:=v2+2;
			elsif(n3='1') then-- etc pt fiecare cifra
			v2:=v2+3;
			elsif(n4='1') then
			v2:=v2+4;
			elsif(n5='1') then
			v2:=v2+5;
			elsif(n6='1') then
			v2:=v2+6;
			elsif(n7='1') then
			v2:=v2+7;
			elsif(n8='1') then
			v2:=v2+8;
			elsif(n9='1') then
			v2:=v2+9;
			elsif(n0='1') then
			v2:=v2+0;
			end if;
			else -- daca nu am operator activ, construiesc primul nr
			 v1:=n11+n11;-- adun de 10 ori nr11
				v1:=v1+n11;
				v1:=v1+n11;
				v1:=v1+n11;
				v1:=v1+n11;
				v1:=v1+n11;
				v1:=v1+n11;
				v1:=v1+n11;
				v1:=v1+n11;

				
			if(n1='1') then 
			v1:=v1+1;-- adun cifra dorita
			elsif(n2='1') then
			v1:=v1+2;
			elsif(n3='1') then
			v1:=v1+3;
			elsif(n4='1') then
			v1:=v1+4;
			elsif(n5='1') then
			v1:=v1+5;
			elsif(n6='1') then
			v1:=v1+6;
			elsif(n7='1') then
			v1:=v1+7;
			elsif(n8='1') then
			v1:=v1+8;
			elsif(n9='1') then
			v1:=v1+9;
			elsif(n0='1') then -- etc, adun cifra
			v1:=v1+0;
			end if;
			end if;
			end if;
			end if;
			
    n00<=v2;-- copiez var in semnale
	n11<=v1;
	end process;
	numarout1<=n00;-- copiez semnalele in numarul final : e nr 2 logic
	numarout2<=n11;-- nr 1 logic in ordine
end convertora;-- asa semnalele si numerele vor fi retinute, pana se va schimba ceva