library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
	generic (
		w_5 : integer := 5
	);
	port (
		clk, reset, cnt_res : in std_logic;
		num : out std_logic_vector (w_5-1 downto 0)
	);
end counter;

architecture Behavioral of counter is
	signal cnt : std_logic_vector(w_5-1 downto 0) := (others => '0');
	begin
		licznik : process (clk, reset, cnt)
			begin
				if (reset = '1') then
					cnt <= (others => '0');
				elsif (clk'Event and clk = '1') then
					if (cnt_res = '1') then
						cnt <= cnt + 1;
					end if;
				end if;
			end process licznik;
			num <= cnt;
	end Behavioral;

