----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:15 10/04/2013 
-- Design Name: 
-- Module Name:    my_alu_m - Behavioral 
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
use IEEE.STD_LOGIC_Arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu_m is
	 generic (
			  NUMBITS : natural := 4
	 );
    Port ( A : in  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           B : in  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end my_alu_m;

architecture Behavioral of my_alu_m is
	signal result_temp : STD_LOGIC_VECTOR (NUMBITS downto 0);
	signal result_temp2 : STD_LOGIC_VECTOR (NUMBITS downto 0);
	signal s_temp: STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
begin

process(A,B,opcode)
begin
	case opcode is
	when "000" => result <= A + B;
					s_temp <= A + B;
					result_temp <= ('0' & A) + ('0' & B);
					if result_temp(NUMBITS)= '1' then
						carryout <= '1';
						overflow <= '1';
					else 
						carryout <= '0';
						overflow <= '0';
					end if;
					
					if s_temp = "0000" then
						zero <= '0';
					else
						zero <= '1';
					end if;
					
						
	when "001" =>  result <= A + B;
					s_temp <= A + B;
					if A >= 0 then
						result_temp <= ('0' & A);
					else
						result_temp <= ('1' & A);
						result_temp(NUMBITS-1) <= '0';
					end if;
					
					if B >= 0 then
						result_temp2 <= ('0' & B);
					else
						result_temp2 <= ('1' & B);
						result_temp2(NUMBITS-1) <= '0';
					end if;
					result_temp <= result_temp + result_temp2;
					if result_temp(NUMBITS) = '1' then
						carryout <= '1';
					else 
						carryout <= '0';
					end if;
					
					if A(NUMBITS-1) = B(NUMBITS-1)  then
						if A(NUMBITS-1) /= result_temp(NUMBITS)  then
							overflow <= '1';
						else
							overflow <= '0';
						end if;
					else
						overflow <= '0';
					end if;

				if s_temp = "0000" then
						zero <= '1';
					else
						zero <= '0';
					end if;
					
	when "010" => result <= A-B;
					result_temp <= ('0' & A)-( '0' & B);
					s_temp <= A - B;
					if result_temp(NUMBITS) = '1' then
						carryout <= '1';
					else 
						carryout <= '0';
					end if;
					
					if A < B then
						overflow <= '1';
					else
						overflow <= '0';
					end if;
					if s_temp = "0000" then
						zero <= '0';
					else
						zero <= '1';
					end if;
	
	when "011" => result <= A - B;
					s_temp <= A - B;
					if A >= 0 then
						result_temp <= ('0' & A);
					else
						result_temp <= ('1' & A);
						result_temp(NUMBITS-1) <= '0';
					end if;
					
					if B >= 0 then
						result_temp2 <= ('0' & B);
					else
						result_temp2 <= ('1' & B);
						result_temp2(NUMBITS-1) <= '0';
					end if;
					result_temp <= result_temp + result_temp2;
					
					if result_temp(NUMBITS) = '1' then
						carryout <= '1';
					else 
						carryout <= '0';
					end if;
					
					if A(NUMBITS-1) = B(NUMBITS-1)  then
						if A(NUMBITS-1) /= result_temp(NUMBITS)  then
							overflow <= '1';
						else
							overflow <= '0';
						end if;
					else
						overflow <= '0';
					end if;
					
				if s_temp = "0000" then
						zero <= '1';
					else
						zero <= '0';
					end if;
	
	when "100" => result <= A and B;
					s_temp <= A and B;
					overflow <= '0';
					carryout <= '0';
					if s_temp = "0000" then
						zero <= '0';
					else
						zero <= '1';
					end if;
	
	when "101" => result <= A or B;
					s_temp <= A or B;
					overflow <= '0';
					carryout <= '0';
					if s_temp = "0000" then
						zero <= '1';
					else
						zero <= '0';
					end if;
	
	when "110" => result <= A xor B;
					s_temp <= A xor B;
					overflow <= '0';
					carryout <= '0';
					if s_temp = "0000" then
						zero <= '1';
					else
						zero <= '0';
					end if;
	
	when "111" => result <= '0' & A(NUMBITS-1 downto 1);
					result_temp <= "00" & A(NUMBITS-1 downto 1);
					overflow <= '0';
					carryout <= '0';
					
					if result_temp = "00000" then
						zero <= '0';
					else
						zero <= '1';
					end if;
	
	when others => result <= A; 
	end case;

end process;	

end Behavioral;

