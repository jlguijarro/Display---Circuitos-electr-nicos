----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:49 11/29/2018 
-- Design Name: 
-- Module Name:    aut_duracion - Behavioral 
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



entity aut_duracion is
    Port ( CLK_1ms : in  STD_LOGIC;
           ENTRADA : in  STD_LOGIC;
           VALID : out  STD_LOGIC;
           DATO : out  STD_LOGIC;
           DURACION : out  STD_LOGIC_VECTOR (15 downto 0));
end aut_duracion;

architecture a_aut_duracion of aut_duracion is

type STATE_TYPE is (CERO,ALM_CERO,VALID_CERO,UNO,ALM_UNO,VALID_UNO,VALID_FIN);

signal ST : STATE_TYPE := CERO;
signal cont : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal reg : STD_LOGIC_VECTOR (15 downto 0) :="0000000000000000";

	begin
		process (CLK_1ms) -- autómata
			begin
				if (CLK_1ms'event and CLK_1ms='1') then
				case ST is
				when CERO =>
				cont<=cont+"0000000000000001";
							if (cont>"00000001001011000") then
								ST <= VALID_FIN;
							elsif (ENTRADA='0') then
								ST<=CERO;
							else
								ST<=ALM_CERO;
							end if;
							
							
				
				when VALID_CERO => ST <= UNO;
				
				when ALM_CERO => 
									reg<=cont;
									cont<="0000000000000000";
									ST<= VALID_CERO;
									
				when ALM_UNO=>
						reg<=cont;
						cont<="0000000000000000";
						ST<= VALID_UNO;
				
				when VALID_UNO =>
						ST <= CERO;
				
				when UNO =>
						cont <= cont+1;
						if (ENTRADA = '0') THEN
							ST <= ALM_UNO;
						else 
							ST <= UNO;
						end if;
						
						
				when VALID_FIN =>
						reg <= cont;
						cont<="0000000000000000";
						ST<=CERO;
						
				end case;
				end if;
				
			end process;
									

  -- PARTE COMBINACIONAL

 VALID<= '1' when (ST=VALID_CERO or ST=VALID_UNO or ST=VALID_FIN) else '0';
 DATO <= '1' when (ST=VALID_UNO or ST=ALM_UNO or ST=UNO) else '0';
 DURACION <=reg;

end a_aut_duracion;

