library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity produs is
	port(a,b:in std_logic_vector(0 to 7);
	p:out std_logic_vector(0 to 7));
end entity ;
architecture produsa of produs is
component sum8bit is
	port(a,b:in std_logic_vector(0 to 7);
	s:out std_logic_vector(0 to 7)); -- sumator 8 biti
end component;
signal p0,p1,p2,p3,p4,p5,p6,p7,rez1,rez2,rez3,rez4,rez5,rez6,rez7,rez8,rez9:std_logic_vector(0 to 7);
-- semnale p0-p7 pentru shiftare la stanga ( sau daca e 0). Vor avea valoarea lui b	
-- rez1-rez9 locale dupa ce se aduna p-urile
signal f0,f00,f000,f0000,f00000,f000000,f0000000,f1,f11,f111,f1111,f11111,f111111,f2,f22,f222,f2222,f22222,f3,f33,f333,f3333,f4,f44,f444,f55,f5,f6:std_logic_vector(0 to 7);
-- valori shiftate: f0, shiftare b dupa prima cifra lui a, o data
-- f00 shiftare b dupa prima cifra lui a, de 2 ori 
-- f1 shiftarea lui b dupa a doua cifra lui a, 1 data
-- etc
begin
	process
	variable q7,q6,q5,q4,q3,q2,q1,q0:std_logic_vector(0 to 7); -- variabile, au acelasi lucru ca p
	begin
		if(a(7)='0') then  -- se verifica daca ultima cifra e 0, sa se decida daca se va shifta b sau 0
			q7:="00000000"; --e echivalent cu ultima cifra a lui a ori b
		else q7:=b;
		end if;
		if(a(6)='0') then -- acelasi lucru pt a 7-a cifra a lui a
			q6:="00000000";
		else q6:=b;
		end if;	
		if(a(5)='0') then-- a 6-a cifra 
			q5:="00000000";
		else q5:=b;
		end if;
		if(a(4)='0') then --etc
			q4:="00000000";
		else q4:=b;
		end if;	
		if(a(3)='0') then
			q3:="00000000";
		else q3:=b;
		end if;
		if(a(2)='0') then
			q2:="00000000";
		else q2:=b;
		end if;
		if(a(1)='0') then
			q1:="00000000";
		else q1:=b;
		end if;
		if(a(0)='0') then-- prima  cifra
			q0:="00000000";
		else q0:=b;
		end if;
		p7<=q7 ;-- se copiaza variabilele construite in semnale
		p6<=q6 ; 
		p5<=q5 ;
		p4<=q4 ;
		p3<=q3 ;
		p2<=q2 ;
		p1<=q1 ;
		p0<=q0 ;
		wait for 50 ns;
	end process;
	rez1<= "00000000"; -- pentru adunarea finala, nu va aduna nimic, e pt sumator
	-- ultima cifra nu e shl
	-- shl se face prin dublarea nr prin insumare
	x6: sum8bit port map(a=>p6,b=>p6,s=>f6);--shl o data pt al 7 lea semnal, se pune in f6
	x5: sum8bit port map(a=>p5,b=>p5,s=>f5);-- shl o data pt al 6 lea semnal
	x55: sum8bit port map(a=>f5,b=>f5,s=>f55);--shl de 2 ori pt al 6 lea semnal, val finala
	x4: sum8bit port map(a=>p4,b=>p4,s=>f4);-- etc pt al 5 lea semnal
	x44: sum8bit port map(a=>f4,b=>f4,s=>f44);-- shl de 2 ori pt semnalul al 5 lea
	x444: sum8bit port map(a=>f44,b=>f44,s=>f444);-- shl de3 ori pt al 5 lea semnal p4 
	x3: sum8bit port map(a=>p3,b=>p3,s=>f3);
	x33: sum8bit port map(a=>f3,b=>f3,s=>f33);
	x333: sum8bit port map(a=>f33,b=>f33,s=>f333);
	x3333: sum8bit port map(a=>f333,b=>f333,s=>f3333); -- shl de 4 ori pt al 4 lea semnal p3
	x2: sum8bit port map(a=>p2,b=>p2,s=>f2);
	x22: sum8bit port map(a=>f2,b=>f2,s=>f22);  
	x222: sum8bit port map(a=>f22,b=>f22,s=>f222);
	x2222: sum8bit port map(a=>f222,b=>f222,s=>f2222);
	x22222: sum8bit port map(a=>f2222,b=>f2222,s=>f22222);-- shl de 5 ori pt al 3 lea semnal p2
	x1: sum8bit port map(a=>p1,b=>p1,s=>f1);
	x11: sum8bit port map(a=>f1,b=>f1,s=>f11);
	x111: sum8bit port map(a=>f11,b=>f11,s=>f111);
	x1111: sum8bit port map(a=>f111,b=>f111,s=>f1111);--etc
	x11111: sum8bit port map(a=>f1111,b=>f1111,s=>f11111);
	x111111: sum8bit port map(a=>f11111,b=>f11111,s=>f111111);-- shl de 6 ori pt al 2 lea semnal p1
	x0: sum8bit port map(a=>p0,b=>p0,s=>f0);-- shl 1 data
	x00: sum8bit port map(a=>f0,b=>f0,s=>f00);-- 2 ori  pt primul semnal
	x000: sum8bit port map(a=>f00,b=>f00,s=>f000);-- 3 ori 
	x0000: sum8bit port map(a=>f000,b=>f000,s=>f0000);-- etc
	x00000: sum8bit port map(a=>f0000,b=>f0000,s=>f00000);
	x000000: sum8bit port map(a=>f00000,b=>f00000,s=>f000000);
	x0000000: sum8bit port map(a=>f000000,b=>f000000,s=>f0000000);-- shl de 7 ori pt primul semnal p0
	n1: sum8bit port map(a=>p7,b=>rez1,s=>rez2);-- se pune in rez 2 fiecare shiftare, aici e de 0 ori
	n2: sum8bit port map(a=>f6,b=>rez2,s=>rez3);-- in rez 2 si shiftarea o data, pt a 7 ea cifra a lui a
	n3: sum8bit port map(a=>f55,b=>rez3,s=>rez4);-- se poate aduna si 0 daca e cazul, daca cifra respectiva a lui a e  0
	n4: sum8bit port map(a=>f444,b=>rez4,s=>rez5);  -- etc
	n5: sum8bit port map(a=>f3333,b=>rez5,s=>rez6);-- acelasi procedeu pt fiecare shiftare, se aduna cu suma anterioara
	n6: sum8bit port map(a=>f22222,b=>rez6,s=>rez7); 
	n7: sum8bit port map(a=>f111111,b=>rez7,s=>rez8);
	n8: sum8bit port map(a=>f0000000,b=>rez8,s=>rez9);
	p<=rez9 ;-- atribui la iesire 
end produsa;