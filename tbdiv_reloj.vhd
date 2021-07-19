--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:06:14 11/22/2018
-- Design Name:   
-- Module Name:   C:/Users/alumno/Desktop/CELT/Celt2018/tbdiv_reloj.vhd
-- Project Name:  Celt2018
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: div_reloj
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
 
ENTITY tbdiv_reloj IS
END tbdiv_reloj;
 
ARCHITECTURE behavior OF tbdiv_reloj IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT div_reloj
    PORT(
         CLK : IN  std_logic;
         CLK_1ms : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal CLK_1ms : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant CLK_1ms_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: div_reloj PORT MAP (
          CLK => CLK,
          CLK_1ms => CLK_1ms
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 150 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
