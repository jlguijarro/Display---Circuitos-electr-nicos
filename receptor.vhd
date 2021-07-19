----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:01 10/03/2018 
-- Design Name: 
-- Module Name:    receptor - Behavioral 
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

entity receptor is
    Port ( CLK : in  STD_LOGIC; -- reloj FPGA
           LIN : in  STD_LOGIC; -- Linea de entrada de datos
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6); -- Salida displays
           AN : out  STD_LOGIC_VECTOR (3 downto 0)); -- Activacion individual
end receptor;

architecture a_receptor of receptor is

constant UMBRAL0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral ceros
constant UMBRAL1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral unos



component div_reloj
     Port ( CLK : in STD_LOGIC;
            CLK_1ms : out STD_LOGIC);
end component;
component detector_flanco
      Port ( CLK_1ms : in STD_LOGIC; -- reloj
             LIN : in STD_LOGIC; -- Línea de datos
             VALOR : out STD_LOGIC); -- Valor detectado en el flanco
end component;
component aut_duracion
     Port ( CLK_1ms : in STD_LOGIC; -- reloj de 1 ms
            ENTRADA : in STD_LOGIC; -- línea de entrada de datos
            VALID : out STD_LOGIC; -- salida de validación de dato
            DATO : out STD_LOGIC; -- salida de dato (0 o 1)
            DURACION : out STD_LOGIC_VECTOR (15 downto 0)); -- salida de duración del dato
end component;
component comp_16
      Port ( P : in STD_LOGIC_VECTOR (15 downto 0);
             Q : in STD_LOGIC_VECTOR (15 downto 0);
             P_GT_Q : out STD_LOGIC);
end component;
component comp_16_1
      Port ( P : in STD_LOGIC_VECTOR (15 downto 0);
             Q : in STD_LOGIC_VECTOR (15 downto 0);
             P_GT_Q : out STD_LOGIC);
end component;
component aut_control
      Port (  CLK_1ms : in STD_LOGIC; -- reloj
              VALID : in STD_LOGIC; -- entrada de dato válido
              DATO : in STD_LOGIC; -- dato (0 o 1)
              C0 : in STD_LOGIC; -- resultado comparador de ceros
              C1 : in STD_LOGIC; -- resultado comparador de unos
              CODIGO : out STD_LOGIC_VECTOR (7 downto 0); -- código morse obtenido
              VALID_DISP : out STD_LOGIC); -- validación del display
end component;

component visualizacion
      Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada siguiente carácter
             EN : in STD_LOGIC; -- Activación para desplazamiento
             CLK_1ms : in STD_LOGIC; -- Entrada de reloj de refresco
             SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Salida para los displays
             AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activación individual
 end component;
 
signal N_VAL_DISP : STD_LOGIC;
signal N_VALID : STD_LOGIC;
SIGNAL N_DATO : STD_LOGIC;
signal N_VALOR  :STD_LOGIC;
signal N_CODIGO :STD_LOGIC_VECTOR (7 downto 0);
signal N_C0 : STD_LOGIC;
signal N_C1  :STD_LOGIC;
signal N_CLK_1ms : STD_LOGIC;
signal N_DURA_COMP  :STD_LOGIC_VECTOR (15 downto 0);

-- Interconnections


begin
		 
U0 : div_reloj
	Port map (
		CLK => CLK,
		CLK_1ms => N_CLK_1ms
		);
		
		
U1 : detector_flanco
	Port map(
		LIN => LIN,
		CLK_1ms => N_CLK_1ms,
		VALOR => N_VALOR
		);
		
U2 : aut_duracion
	Port map(
		CLK_1ms => N_CLK_1ms,
		ENTRADA => N_VALOR,
		VALID => N_VALID,
		DATO => N_DATO,
		DURACION => N_DURA_COMP
		);
		
U3: comp_16
	Port map (
		P => N_DURA_COMP,
		Q => UMBRAL0,
		P_GT_Q => N_C0
		);
		
U4: comp_16_1
	Port map (
		P => N_DURA_COMP,
		Q => UMBRAL1,
		P_GT_Q => N_C1
		);
		
U5: aut_control
	Port map (
		CLK_1ms => N_CLK_1ms,
		VALID => N_VALID,
		DATO => N_DATO,
		C0 => N_C0,
		C1 => N_C1,
		CODIGO => N_CODIGO,
		VALID_DISP => N_VAL_DISP
		);
		
U6: visualizacion
	Port map (
		E0 => N_CODIGO,
		EN => N_VAL_DISP,
		CLK_1ms => N_CLK_1ms,
		SEG7 => SEG7,
		AN => AN
	);
	
end a_receptor;
		




