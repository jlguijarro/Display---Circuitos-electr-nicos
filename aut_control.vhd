----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:30 11/29/2018 
-- Design Name: 
-- Module Name:    aut_control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity aut_control is
    Port ( CLK_1ms : in  STD_LOGIC; -- reloj
           VALID : in  STD_LOGIC; --entrada dato valido
           DATO : in  STD_LOGIC;	-- dato (1 o 0)
           C0 : in  STD_LOGIC; -- resultado comp de ceros
           C1 : in  STD_LOGIC; -- resultado comps de unos
           CODIGO : out  STD_LOGIC_VECTOR (7 downto 0); -- codigo morse obtenido
           VALID_DISP : out  STD_LOGIC); -- validacion del display
end aut_control;

architecture a_aut_control of aut_control is
type STATE_TYPE is (ESPACIO,RESET,SIMBOLO,ESPERA);
signal ST : STATE_TYPE := RESET;
signal s_ncod : STD_LOGIC_VECTOR (2 downto 0):="000";
signal s_cod : STD_LOGIC_VECTOR (4 downto 0):="00000";
signal n : INTEGER range 0 to 4;


begin
process (CLK_1ms)

		begin
		if (CLK_1ms'event and CLK_1ms='1') then
		case ST is
			when SIMBOLO =>
				s_ncod<=s_ncod+1;
				s_cod(n)<=C1; -- el resultado del comparador indica punto o raya
				n<=n-1;
				ST<=ESPERA;

			when ESPACIO => 
				ST<=RESET;
			
			when RESET =>
				n <= 4;
				s_ncod <= "000";
				s_cod <= "00000";
				if (VALID = '1' AND DATO = '1') THEN
					ST<=SIMBOLO;
				else
					ST<=RESET;
				end if;
				
			when ESPERA => 
				if ( VALID = '1' AND DATO = '1') THEN
					ST<=SIMBOLO;
				
				elsif (VALID = '1' AND DATO = '0' AND C0 = '1') THEN
				ST<=ESPACIO;
				
				elsif (VALID = '0' OR (VALID='1' AND DATO = '0' AND C0 = '0')) THEN
					ST<=ESPERA;
				
				end if;



 end case;
 end if;
 end process;

-- PARTE COMBINACIONAL
VALID_DISP<='1' when (ST=ESPACIO) else '0';
CODIGO(4 downto 0)<= s_cod; -- Complete las asignaciones
CODIGO(7 downto 5)<= s_ncod;

end a_aut_control ;