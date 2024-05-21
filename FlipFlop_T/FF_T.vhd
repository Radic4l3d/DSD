library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity fft is
    Port ( clk : in  STD_LOGIC;
           T : in  STD_LOGIC;
           Q : inout  STD_LOGIC;
           Qn : inout  STD_LOGIC);
end fft;

architecture Behavioral of fft is
	signal reloj: std_logic;
	signal Div: std_logic_vector(25 downto 0);
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			Div <= Div + 1;
		end if;
	end process;
	
	reloj <= Div(25);
	
	process(reloj)
	begin
		if reloj'event and reloj = '1' then
			if T = '0' then 
				Q <= Q;
				Qn <= not Q;
			else
				Q <= not Q;
				Qn <= Q;
			end if;
		end if;
	end process;
			
end Behavioral;