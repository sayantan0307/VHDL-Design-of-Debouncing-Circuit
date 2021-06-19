----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:13 06/18/2021 
-- Design Name: 
-- Module Name:    debouncer_2 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer_2 is
	generic(
		N: natural := 19
	);
	port(
		clk, reset: in std_logic;
		sw: in std_logic;
		db_out: out std_logic
	);
end debouncer_2;

architecture Behavioral of debouncer_2 is
	type state_type is (zero, one_wait, one, zero_wait);
	signal state_reg, state_next: state_type;
	signal q_reg, q_next: unsigned(N-1 downto 0);
	signal m_tick: std_logic;
begin
 --State Registers logic
	process(clk,reset)
	begin
		if(reset='1') then
			state_reg <= zero;
			q_reg		 <= (others =>'0');
		elsif rising_edge(clk) then
			state_reg <= state_next;
			q_reg		 <= q_next;
		end if;
	end process;
 -- Next State Logic 
	process(state_reg, q_reg)
	begin
		state_next <= state_reg;
		q_next <= q_reg;
		m_tick <= '0';
		case state_reg is
			when zero =>
				db_out <= '0';
				q_next <= (others =>'0');
				if sw = '1' then
					state_next <= one_wait;
				end if;
			when one_wait =>
				db_out <= '1';
				q_next <= q_reg + 1;
				m_tick <= '1' when q_reg = 0
								  else '0';
				if(m_tick = '1') then
					state_next <= one;
				end if;
			when one =>
				db_out <= '1';
				q_next <= (others =>'0');
				if sw = '0' then
					state_next <= zero_wait;
				end if;
			when zero_wait =>
				db_out <= '0';
				q_next <= q_reg + 1;
				m_tick <= '1' when q_reg = 0 
								  else '0';
				if(m_tick = '1') then
					state_next <= zero;
				end if;
		end case;
	end process;

end Behavioral;

