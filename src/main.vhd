library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( n0 : in STD_LOGIC;-- buton 0
           n1 : in STD_LOGIC;-- buton 1
           n2 : in STD_LOGIC;-- buton 2
           n3 : in STD_LOGIC;-- buton 3
           n4 : in STD_LOGIC;-- buton 4
           n5 : in STD_LOGIC;-- buton 5
           n6 : in STD_LOGIC;-- buton 6
           n7 : in STD_LOGIC;-- buton 7
           n8 : in STD_LOGIC;-- buton 8
           n9 : in STD_LOGIC;-- buton 9
           plus : in STD_LOGIC;-- buton +
           minus : in STD_LOGIC;-- buton -
           ori : in STD_LOGIC;-- buton *
           div : in STD_LOGIC;-- buton /
           numar_out: inout STD_LOGIC_VECTOR(0 to 7);-- rezultatul unei anumite operatii
           rest_out: inout std_logic_vector(4 to 7);-- restul de la impartire
		   semn_out: inout std_logic;-- semn final rezultat
           enter,clk : in STD_LOGIC;-- buton enter de afisare si clock de la placa
           cancel,entercif: in STD_LOGIC;--buton de cancel si de confirmare cifra/ operatii succesive
           anod : out STD_LOGIC_VECTOR (3 downto 0);-- 4 anozi
           catod : out STD_LOGIC_VECTOR (6 downto 0));-- 7 catozi
end main;

architecture Behavioral of main is 
component saptesgm is -- afisare 7 segm
    Port ( clock_placa,semn,div : in STD_LOGIC;
           numar: in std_logic_vector(0 to 7);
           reset : in STD_LOGIC; -- reset
           anod : out STD_LOGIC_VECTOR (3 downto 0);
           rest_out: in std_logic_vector(4 to 7);
           catod : out STD_LOGIC_VECTOR (6 downto 0));
end component;
component codi is -- codificator pentru introducere de cifre
    Port ( n0 : in STD_LOGIC;
           n1 : in STD_LOGIC;
           n2,n3,n4,n5,n6,n7,n8,n9 ,plus,minus,ori,imp: in STD_LOGIC;
           reset,enterc : in STD_LOGIC;
           semn1,semn2 : out STD_LOGIC;
	numarout1,numarout2,numar_out: inout std_logic_vector(0 to 7);
	semn_out: inout std_logic;
	enter: in std_logic);
end component ;
component sumator_scazator is  -- sumatorul/scazator
	port(  s1,s2: in STD_LOGIC;
	a,b:in STD_LOGIC_VECTOR(0 to 7);
	n:out STD_LOGIC_VECTOR(0 to 7);
	sn:out STD_LOGIC);
end component ;	

component produs is -- produsul
	port(a,b:in std_logic_vector(0 to 7);
	p:out std_logic_vector(0 to 7));
end component ;
component divider is -- impartirea
	port(a,b:in std_logic_vector(0 to 7);
	p:out std_logic_vector(0 to 7);
	rest1: out std_logic_vector(0 to 7));
end component ;
component debouncer is -- debouncer pentru enter si enterc
  Port ( nr,clk: in std_logic;
  clk_bun:out std_logic
  );
end component;
component decision is
  Port ( 
  e: in std_logic;
  minus,plus,ori,div,semn_ad,semn1,semn2: in std_logic;
  suma,inm,imp,rest: in std_logic_vector(0 to 7);
  semn_out: out std_logic;
  numar_out:out std_logic_vector(0 to 7);
  rest_out:out std_logic_vector(4 to 7)
  );
end component;
signal suma,inm,imp,citire1,citire2,rest: std_logic_vector(0 to 7); -- unde retinem suma/diferenta, produsul, numerele construite si restul 
signal semn1,semn2,semn_ad,ccc,e: std_logic;	-- semnele celor 2 numere, semn de la adunare,ccc e noul clock de la entercif, e noul clock pt enter
signal num_out:   std_logic_vector(0 to 7);-- rezultatul final 
begin  
	de: debouncer port map (nr=>entercif,clk=>clk,clk_bun=>ccc);-- debouncer pt enterc/entercif
	de1: debouncer port map (nr=>enter,clk=>clk,clk_bun=>e);--debouncer pt enter
	-- retin numerele create in citire 1 si citire 2
	citire: codi port map(n0=>n0,n1=>n1,n2=>n2,n3=>n3,n4=>n4,n5=>n5,n6=>n6,n7=>n7,n8=>n8,n9=>n9,plus=>plus,minus=>minus,ori=>ori,imp=>div,reset=>cancel,enterc=>ccc,semn1=>semn1,semn2=>semn2,numarout1=>citire1,numarout2=>citire2,numar_out=>numar_out,semn_out=>semn_out,enter=>enter); 
	ad: sumator_scazator port map(s1=>semn2,s2=>semn1,a=>citire2,b=>citire1,n=>suma,sn=>semn_ad);-- suma/diferenta 
    mult: produs port map(a=>citire2,b=>citire1,p=>inm);--inmultire
    impa: divider port map(a=>citire2,b=>citire1,p=>imp,rest1=>rest);--impartire
	-- aleg ce pun in rezultat // suma diferenta produs impartire
	al: decision port map(e=>e,minus=>minus,plus=>plus,ori=>ori,div=>div,semn_ad=>semn_ad,semn1=>semn1,semn2=>semn2,suma=>suma,inm=>inm,imp=>imp,rest=>rest,semn_out=>semn_out,numar_out=>numar_out,rest_out=>rest_out);
	-- pun pe 7 segmente
    sgm: saptesgm port map(clock_placa=>clk,semn=>semn_out,div=>div,numar=>numar_out,reset=>cancel,anod=>anod,rest_out=>rest_out,catod=>catod);
end Behavioral;	   
-- procedeul e ciclic, se pastreaza valoarea anterioara

 

