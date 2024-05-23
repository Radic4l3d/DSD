library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ff_T is
    Port ( clk : in  STD_LOGIC;
           Q : inout  STD_LOGIC;
           Qn : inout  STD_LOGIC;
           set : in  STD_LOGIC;
           clr : in  STD_LOGIC );
end ff_T;

architecture Behavioral of ff_T is
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
	
	--FF 2
	process(reloj, set, clr)
	begin
		
		if reloj'event and reloj = '1' then
			if set = '1' and clr = '0' then	-- Q set en 1
				Q <= '1';
				Qn <= not Q;
			elsif set = '0' and clr = '1' then	-- Q clear a 0
				Q <= '0';
				Qn <= not Q;
			else
				Q <= not Q;
				Qn <= Q;
			end if;
		end if;
	end process;
	--fin de FF 2
	
	

end Behavioral;