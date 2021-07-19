-----------------------------------------------------------------
--   Dpto. de Ingeniería Electrónica, ETSI Telecomunicación
--   Universidad Politécnica de Madrid
--
-----------------
-- Prueba de la visualización
--
-- Presenta un mensaje que se va desplazando por la pantalla
-- El mensaje dice: ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prueba_visualizacion is
    Port ( CLK  : in   STD_LOGIC;
	        SEG7 : out  STD_LOGIC_VECTOR (0 to 6);      -- Salida para los displays 
           AN   : out  STD_LOGIC_VECTOR (3 downto 0)); -- Activación individual;
end prueba_visualizacion;

architecture a_prueba_visualizacion of prueba_visualizacion is

component visualizacion
    Port ( E0   : in  STD_LOGIC_VECTOR (7 downto 0);   -- Entrada siguiente carácter
	        EN   : in  STD_LOGIC;                       -- Activación para desplazamiento
           CLK_1ms  : in  STD_LOGIC;                       -- Entrada de reloj de refresco
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6);      -- Salida para los displays 
           AN   : out  STD_LOGIC_VECTOR (3 downto 0)); -- Activación individual
end component;

signal s_clk    : STD_LOGIC;
signal cont     : STD_LOGIC_VECTOR (15 downto 0);
signal contador : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal dir      : STD_LOGIC_VECTOR (7 downto 0):="00000000";
signal S_EN : STD_LOGIC :='0';
signal S_E0 : STD_LOGIC_VECTOR (7 downto 0);

type STATE_TYPE is (VALIDA,INCREMENTA,ESPERA);
signal ST : STATE_TYPE := ESPERA ;

begin

  -- Autómata que temporiza a 500 ms y presenta los caracteres

  U1 : process (s_clk)
  begin
  if (s_clk'event and s_clk='1') then
	 case ST is
	   when ESPERA =>
		  contador<=contador+1;
		  if (contador=500) then   --- cada 500 ms
			 contador<=(others=>'0');
			 ST<=VALIDA;
		  end if;
		  when VALIDA =>
          S_EN<='1';
          ST<=INCREMENTA;
        when INCREMENTA =>			 
		    dir<=dir+1;
			 S_EN<='0';
			 ST<=ESPERA;
	 end case;
  end if;	   
  end process;
  
  -- Interconexiones
  
  U2 : process(CLK)
  begin
  if (CLK'event and CLK='1') then
    cont<=cont+1;
	 if (cont=25000) then          -- semiperiodo de 500 us
	   cont<=(others=>'0');
		s_clk<=not s_clk;
	 end if;
  end if;
  
  end process;

  U3 : with dir select S_E0<=
    "01001000" when "00000000", -- A 
	 "10010000" when "00000001", -- B 
	 "10010100" when "00000010", -- C 
	 "01110000" when "00000011", -- D 
	 "00100000" when "00000100", -- E 
	 "10000100" when "00000101", -- F 
	 "01111000" when "00000110", -- G 
	 "10000000" when "00000111", -- H 
	 "01000000" when "00001000", -- I 
	 "10001110" when "00001001", -- J 
	 "01110100" when "00001010", -- K 
	 "10001000" when "00001011", -- L 
	 "01011000" when "00001100", -- M 
	 "01010000" when "00001101", -- N 
	 "01111100" when "00001110", -- O 
	 "10001100" when "00001111", -- P 
	 "10011010" when "00010000", -- Q 
	 "01101000" when "00010001", -- R 
	 "01100000" when "00010010", -- S 
	 "00110000" when "00010011", -- T 
	 "01100100" when "00010100", -- U 
	 "10000010" when "00010101", -- V 
	 "01101100" when "00010110", -- W 
	 "10010010" when "00010111", -- X 
	 "10010110" when "00011000", -- Y 
	 "10011000" when "00011001", -- Z 
	 "10101111" when "00011010", -- 1 
	 "10100111" when "00011011", -- 2 
	 "10100011" when "00011100", -- 3 
	 "10100001" when "00011101", -- 4 
	 "10100000" when "00011110", -- 5 
	 "10110000" when "00011111", -- 6 
	 "10111000" when "00100000", -- 7 
	 "10111100" when "00100001", -- 8 
	 "10111110" when "00100010", -- 9 
	 "10111111" when "00100011", -- 0 
    "01011000" when others;
	 
  U4 : visualizacion
       port map (E0 => S_E0,
	              EN => S_EN,
                 CLK_1ms => s_clk,
                 SEG7 => SEG7,
                 AN => AN);

end a_prueba_visualizacion ;
