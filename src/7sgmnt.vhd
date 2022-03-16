library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity saptesgm is
    Port ( clock_placa,semn,div : in STD_LOGIC; --clk 100mhz,semn iesire nr,buton de impartire
           numar: in STD_LOGIC_VECTOR(0 to 7);-- numarul care trebuie afisa
           reset : in STD_LOGIC; -- buton reset
           anod : out STD_LOGIC_VECTOR (3 downto 0);-- cei 4 anozi
           rest_out: in STD_LOGIC_VECTOR(4 to 7);-- restul care trebuie afisat de la impartire
           catod : out STD_LOGIC_VECTOR (6 downto 0));-- 7 catozi
end saptesgm;

architecture arhh of saptesgm is
signal num_sortat: STD_LOGIC_VECTOR (15 downto 0); -- fiecare anod, va avea valoarea afisata pe 4 biti stocata de 4 ori => 16 biti
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);-- valoarea afisata a anodului dupa selectia anodului pe rand care va fi luat din vectorul total, num_total 
signal refresh: STD_LOGIC_VECTOR (19 downto 0);-- pt basys 3 sa afiseze bine, trebuie frecventa de 100hz, acesta e contorul
signal selectie: std_logic_vector(1 downto 0);-- selectam pe rand fiecare anod 
signal rest1,rest2,rest3,nr1,nr2,nr3: std_logic_vector(0 to 7);-- semnale pentru descompunere nr
component divider is
	port(a,b:in std_logic_vector(0 to 7);
	p:out std_logic_vector(0 to 7);  --- componenta impartire
	rest1: out std_logic_vector(0 to 7));
end component ;
begin
process(LED_BCD) --verific ce valoare voi afisa intr-un moment de timp, pe anodul selectat inainte ( mai jos e procedeul)
begin
    case LED_BCD is -- pun pe catozi in functie de valoarea curenta, codul pentru fiecare numar
    when "0000" => catod <= "0000001"; -- "0"     
    when "0001" => catod <= "1001111"; -- "1" 
    when "0010" => catod <= "0010010"; -- "2" 
    when "0011" => catod <= "0000110"; -- "3" 
    when "0100" => catod <= "1001100"; -- "4" 
    when "0101" => catod <= "0100100"; -- "5" 
    when "0110" => catod <= "0100000"; -- "6" 
    when "0111" => catod <= "0001111"; -- "7" 
    when "1000" => catod <= "0000000"; -- "8"     
    when "1001" => catod <= "0000100"; -- "9" 
    when "1011" => catod <= "1100000"; -- -"a" -- in hexa pt rest
    when "1010" => catod <= "0000010"; -- "b"
    when "1100" => catod <= "0110001"; -- "c"
    when "1101" => catod <= "1000010"; -- "d"
    when "1110" => catod <= "1111111"; -- "null" -- nu afiseaza
    when "1111" => catod <= "1111110"; -- "minus"  
	when others => catod <="0000000";
	
        end case;
end process;
process(clock_placa,reset) -- divizor de frecventa de la 100Mgh la 100Hz, ca sa fie observabil de om
begin 
    if(reset='1') then
        refresh <= (others => '0'); -- daca e reset, se incepe de la inceput
    elsif(rising_edge(clock_placa)) then --clock de la placa 100Mhz
        refresh <= refresh + 1; -- numar pe 20 de biti pentru a obtine frecventa de refresh pentru a se vedea afisorul
    end if;-- pt basys 3 trebuie frecventa de 100hz pt afisor sa fie vizibil
end process;
 selectie <= refresh(19 downto 18); -- iau primele 2 valori din vectorul de refrsh, ca sa selectez pe rand fiecare anod la frecventa mai mica pe rand
process(selectie)
begin
    case selectie is -- selectez anodul
    when "00" => -- primul anod activat 
        anod <= "0111"; -- activez pe primul, ceilalti sunt dezactivazti
        LED_BCD <= num_sortat(15 downto 12); --se va afisa  valoarea stocata special pt primul anod
    when "01" => -- randul anodului 2
        anod <= "1011"; -- il activez, ceilalti se inchid 
        LED_BCD <= num_sortat(11 downto 8);-- valoare stocata special pt anodul 2
    when "10" => -- anodul 3 
        anod <= "1101"; -- se activeaza, ceilalti sunt inchisi
        LED_BCD <= num_sortat(7 downto 4);-- valoarea stocata pentru anodul 3
    when "11" => -- anodul 4 activ
        anod <= "1110"; -- acelasi prinipiu
        LED_BCD <= num_sortat(3 downto 0);   
		   when others => anod <= "0000";
    end case;
end process;
i1: divider port map(a=>numar,b=>"01100100",p=>nr1,rest1=>rest1);-- impart la 100, pt prima cif 
i2: divider port map(a=>rest1,b=>"00001010",p=>nr2,rest1=>rest2);-- impart la 10 pt a doua cifra, si a 3 a
num_sortat(15 downto 13)<="111";--primul anod e pentru semn, pregatesc val sa se afiseze
num_sortat(12)<=semn;-- ori minus, ori plus
process(div) -- verific daca am impartire
begin
    if(div='1') then -- daca da, fac loc pentru rest, catul e pe 2 cifre, restul pe 1
    num_sortat(11 downto 8)<=nr2(4 to 7); -- cifra 2
    num_sortat(7 downto 4)<=rest2(4 to 7);-- cifra 1
    num_sortat(3 downto 0)<=rest_out(4 to 7);-- rest
    else -- daca nu, afisez nr pe 3 cifre
    num_sortat(11 downto 8)<=nr1(4 to 7);-- cifra 3
    num_sortat(7 downto 4)<=nr2(4 to 7);-- cifra 2
    num_sortat(3 downto 0)<=rest2(4 to 7);-- cifra1 
    -- pregatim pentru urmatoarea afisare
    end if;
end process;
end arhh;    