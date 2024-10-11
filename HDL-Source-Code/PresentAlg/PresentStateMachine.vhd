library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.kody.ALL;

entity PresentStateMachine is
	generic (
		w_5 : integer := 5
	);
	port (
		clk, reset, start : in std_logic;
		ready, cnt_res, ctrl_mux, RegEn: out std_logic;
		num : in std_logic_vector (w_5-1 downto 0)
	);
end PresentStateMachine;

architecture Behavioral of PresentStateMachine is
	
	signal state : stany;
	signal next_state : stany;	
	
	begin
		States : process(state, start, num)
			begin
				case state is
				    ---- Waiting for start
					when NOP =>
						ready <= '0';
						cnt_res <= '0';
						ctrl_mux <= '0';
						RegEn <= '0';
						if (start = '1') then 
							next_state <= SM_START;
						else 
							next_state <= NOP;
						end if;
					-- Decoding
					when SM_START =>
						ready <= '0';
						RegEn <= '1';
						cnt_res <= '1';
						if (start = '1') then
						    -- control during first start
							if (num = "00000") then
								ctrl_mux <= '0';
								next_state <= SM_START;
							-- last iteration
							elsif (num = "11111") then
								ctrl_mux <= '1';
								next_state <= SM_READY;
							-- rest iterations
							else
								ctrl_mux <= '1';
								next_state <= SM_START;
							end if;
						else
							ctrl_mux <= '0';
							next_state <= NOP;
						end if;
					-- Decoding end
					when SM_READY =>
						cnt_res <= '0';
						RegEn <= '0';
						ready <= '1';
						if (start = '1') then
							ctrl_mux <= '1';
							next_state <= SM_READY;
						else
							ctrl_mux <= '0';
							next_state <= NOP;
						end if;
				end case;
		end process States;
		
		SM : process (clk, reset)
			begin
				if (reset = '1') then
					state <= NOP;				
				elsif (clk'Event and clk = '1') then
					state <= next_state;
				end if;
			end process SM;

	end Behavioral;

