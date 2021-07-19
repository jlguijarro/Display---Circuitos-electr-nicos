----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:37:55 11/29/2018 
-- Design Name: 
-- Module Name:    detector_flanco - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity detector_flanco is
    Port ( CLK_1ms : in  STD_LOGIC; -- reloj
           LIN		 : in  STD_LOGIC; -- Linea de datos
           VALOR	: out  STD_LOGIC); -- Valor detectado en el flanco
end detector_flanco;

architecture a_detector_flanco of detector_flanco is
constant UMBRAL0 : STD_LOGIC_VECTOR (7 downto 0) := "00000101"; -- 5 umbral para el 0
constant UMBRAL1 : STD_LOGIC_VECTOR (7 downto 0) := "00001111"; -- 15 umbral para el 1
signal s_valor : STD_LOGIC;
signal reg_desp : STD_LOGIC_VECTOR (19 downto 0):="00000000000000000000";
signal suma : STD_LOGIC_VECTOR (7 downto 0) :="00000000";

begin
 process (CLK_1ms)
	begin
	
		if (CLK_1ms'event and CLK_1ms='1') then
		suma <= suma + LIN - reg_desp(19);
	
		reg_desp(19 downto 1) <= reg_desp(18 downto 0);
		reg_desp(0) <= LIN;
	
		if (suma < UMBRAL0) then
		s_valor <= '0';
	
		elsif (suma > UMBRAL1) then
		s_valor <= '1';
		end if;
	
	end if;
	end process;
	VALOR <= s_valor;

end a_detector_flanco;