--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:00:45 12/04/2018
-- Design Name:   
-- Module Name:   C:/Users/alumno/Desktop/ultimate/nostraCeltini/Celt2018/Tb_MUX.vhd
-- Project Name:  Celt2018
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX4x8
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_MUX IS
END Tb_MUX;
 
ARCHITECTURE behavior OF Tb_MUX IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX4x8
    PORT(
         E0 : IN  std_logic_vector(7 downto 0);
         E1 : IN  std_logic_vector(7 downto 0);
         E2 : IN  std_logic_vector(7 downto 0);
         E3 : IN  std_logic_vector(7 downto 0);
         S : IN  std_logic_vector(1 downto 0);
         Y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal en0 : std_logic_vector(7 downto 0) ;
   signal en1 : std_logic_vector(7 downto 0) ;
   signal en2 : std_logic_vector(7 downto 0) ;
   signal en3 : std_logic_vector(7 downto 0) ;
   signal control : std_logic_vector(1 downto 0) ;

 	--Outputs
   signal salida : std_logic_vector(7 downto 0);
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX4x8 PORT MAP (
          E0 => en0,
          E1 => en1,
          E2 => en2,
          E3 => en3,
          S => control,
          Y => salida
        );

   test: process
		Begin
		
		en0 <= "00001000";
		en1 <= "00001001";
		en2 <= "00001010";
		en3 <= "00001011";
		control <= "00", "01" after 15 ns, "10" after 30 ns, "11" after 45 ns;
		wait;
		end process test;

END;
