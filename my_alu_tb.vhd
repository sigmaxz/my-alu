--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:40:43 10/11/2013
-- Design Name:   
-- Module Name:   /home/csmajs/svill017/my_alu/my_alu_tb.vhd
-- Project Name:  my_alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_alu_m
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
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY my_alu_tb IS
END my_alu_tb;
 
ARCHITECTURE behavior OF my_alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_alu_m
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         opcode : IN  std_logic_vector(2 downto 0);
         result : OUT  std_logic_vector(3 downto 0);
         carryout : OUT  std_logic;
         overflow : OUT  std_logic;
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal opcode : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(3 downto 0);
   signal carryout : std_logic;
   signal overflow : std_logic;
   signal zero : std_logic;
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
 	signal clk: std_logic;
   constant clk_period : time := 10 ns;
	

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_alu_m PORT MAP (
          A => A,
          B => B,
          opcode => opcode,
          result => result,
          carryout => carryout,
          overflow => overflow,
          zero => zero
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns ;	

      -- insert stimulus here 
		-- unsigned add_____________________________________
		opcode <= "000";
		-- test of normal case add 
		A <= "0110";
		B <= "0010";
		-- expected result: 1000 overflow: 0 zero: 0 carryout: 0 
		-- test for overflow carryout 
		wait for 30 ns ;
		A <= "1100";
		B <= "0100";
		-- expected result : 0000 overflow:1 zero:1 carryout : 1
		wait for 30 ns ;
		--check for 0 add 
		A <= "0000";
		B <= "0000";
		-- expected result : 0000 overflow: 0 zero:1 carryout: 0
		
		wait for 30 ns ;
		--signed add ____________________________________________
		opcode <= "001";
		-- adding a postive to its negative for a zero
		A <= "0001";
		B <= "1111";
		-- expected result: 0000 overflow:1 zero:1 carryout:0
		
		wait for 30 ns ;
		-- adding signed normal case with positive result 
		A <= "0100";
		B <= "1100";
		-- expected result: 0001 overflow:0 zero:0 carryout:0
		
		wait for 30 ns ;
		-- adding signed normal case with negative result
		A <= "0010";
		B <= "1100";
		--expected result: 1110 overflow: 0 zero:0 carryout:0 
		
		wait for 30 ns;
		-- subtracting a number from itself for zero check
		--unsigned sub_____________________________________________
		opcode <= "010";
		A<= "1111";
		B <= "1111";
		--expected result: 0000 overflow: 0 zero:1 carryout:0 
		
		wait for 30ns;
		-- subtracting by very large number
		A <= "1000";
		B <= "1110";
		-- expected result: 1010 overflow:1 zero:0 carryout:0
		
		wait for 30ns;
		-- subtracting by smaller negative
		A <= "1101";
		B <= "0001";
		-- exptected result: 1100 overflow:0 zero:0 carryout:0 
		
		wait for 30 ns;

		--signed sub_____________________________________________
		-- subtracting a number from negative self for added check
		opcode <= "011";
		A<= "0001";
		B <= "1111";
		--expected result: 0010 overflow: 0 zero:0 carryout:0 
		
		wait for 30ns;
		-- subtracting two very large number negatives
		A <= "1000";
		B <= "1110";
		-- expected result: 0001 overflow:1 zero:0 carryout:0
		
		wait for 30ns;
		-- subtracting by
		A <= "1101";
		B <= "0001";
		-- exptected result: 1011 overflow:0 zero:0 carryout:0 
		
		wait for 30 ns;

		--and_____________________________________________
		-- anding with zero gives zero
		opcode <= "100";
		A<= "0000";
		B <= "1111";
		--expected result: 0000 overflow: 0 zero:0 carryout:0 
		
		wait for 30ns;
		-- anding with identity 1111
		A <= "1010";
		B <= "1111";
		-- expected result: 1010 overflow:0 zero:0 carryout:0
		
		wait for 30ns;
		-- normal case
		A <= "1101";
		B <= "1001";
		-- exptected result: 1001 overflow:0 zero:0 carryout:0 
		
		wait for 30 ns;

		--or_____________________________________________
		-- oring with zero gives back the number
		opcode <= "101";
		A<= "0000";
		B <= "1111";
		--expected result: 1111 overflow: 0 zero:0 carryout:0 
		
		wait for 30ns;
		-- oring simple case
		A <= "1010";
		B <= "0100";
		-- expected result: 1110 overflow:0 zero:0 carryout:0
		
		wait for 30ns;
		-- normal case
		A <= "1101";
		B <= "1001";
		-- exptected result: 1101 overflow:0 zero:0 carryout:0 
		
		wait for 30 ns;

		--xor_____________________________________________
		-- xoring with zero gives back the number
		opcode <= "110";
		A<= "0000";
		B <= "1111";
		--expected result: 1111 overflow: 0 zero:0 carryout:0 
		
		wait for 30ns;
		-- oring simple case
		A <= "1010";
		B <= "0100";
		-- expected result: 1110 overflow:0 zero:0 carryout:0
		
		wait for 30ns;
		-- there is a non exclusive bits
		A <= "1101";
		B <= "1001";
		-- exptected result: 0100 overflow:0 zero:0 carryout:0 
		
		wait for 30 ns;

		--divide2_____________________________________________
		-- dividing zero
		opcode <= "111";
		A<= "0000";
		B <= "0000";
		--expected result: 0  overflow: 0 zero:0 carryout:0 
		
		wait for 30ns;
		-- divide simple case
		A <= "1010";
		B <= "0000";
		-- expected result: 0101 overflow:0 zero:0 carryout:0
		
		wait for 30ns;
		-- dividing the odd
		A <= "1101";
		B <= "0000";
		-- exptected result: 0110 overflow:0 zero:0 carryout:0 

      wait;
   end process;

END;
