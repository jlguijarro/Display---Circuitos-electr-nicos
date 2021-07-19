----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:56:00 11/26/2018 
-- Design Name: 
-- Module Name:    visualizacion - Behavioral 
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
entity visualizacion is
	Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada sig. carácter
		EN : in STD_LOGIC; -- Activación para desplazamiento
		CLK_1ms : in STD_LOGIC; -- Entrada de reloj
		SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Segmentos displays
		AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activación displays
	end visualizacion;


architecture a_visualizacion of visualizacion is

component MUX4x8
	Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 0
		E1 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 1
		E2 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 2
		E3 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 3
		S : in STD_LOGIC_VECTOR (1 downto 0); -- Señal de control
		Y : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida
	end component;

component decodmorsea7s
	Port ( SIMBOLO : in STD_LOGIC_VECTOR (7 downto 0);
		SEGMENTOS : out STD_LOGIC_VECTOR (0 to 6));
	end component;

component refresco
	Port ( CLK_1ms : in STD_LOGIC; -- reloj
		S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
		AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays
		end component;
		
component rdesp_disp
	Port ( CLK_1ms : in STD_LOGIC; -- entrada de reloj
		EN : in STD_LOGIC; -- enable
		E : in STD_LOGIC_VECTOR (7 downto 0); -- entrada de datos
		Q0 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q0
		Q1 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q1
		Q2 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q2
		Q3 : out STD_LOGIC_VECTOR (7 downto 0)); -- salida Q3
	end component;
	
	
	
signal s_ref : STD_LOGIC_VECTOR (1 downto 0);
signal s_desp0 : STD_LOGIC_VECTOR (7 downto 0);
signal s_desp1 : STD_LOGIC_VECTOR (7 downto 0);
signal s_desp2 : STD_LOGIC_VECTOR (7 downto 0);
signal s_desp3 : STD_LOGIC_VECTOR (7 downto 0);
signal s_mux : STD_LOGIC_VECTOR (7 downto 0);


begin

U1 : decodmorsea7s
		port map (
			SIMBOLO=>s_mux,
			SEGMENTOS=>SEG7
			); 
			
U2 : MUX4x8
		port map (
			E0=>s_desp0,
			E1=>s_desp1,
			E2=>s_desp2,
			E3=>s_desp3,
			S=>s_ref,
			Y=>s_mux
			); 
			
U3 : refresco
		port map (
			CLK_1ms=>CLK_1ms,
			S=>s_ref,
			AN=>AN
			); 

U4 : rdesp_disp
		port map (
			CLK_1ms=>CLK_1ms,
			EN=>EN,
			E=>E0,
			Q0=>s_desp0,
			Q1=>s_desp1,
			Q2=>s_desp2,
			Q3=>s_desp3
			); 			

			
end a_visualizacion;
