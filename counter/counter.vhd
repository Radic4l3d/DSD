library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port ( clk : in  STD_LOGIC;
           T : in  STD_LOGIC_VECTOR (2 downto 0);
           Q : inout  STD_LOGIC_VECTOR (2 downto 0);
           Qn : inout  STD_LOGIC_VECTOR (2 downto 0));
end counter;

architecture Behavioral of counter is
	signal reloj: std_logic;
	signal Div: std_logic_vector(25 downto 0);
	signal con: std_logic_vector(1 downto 0);
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
			if T(2) = '0' then 
				Q(2) <= Q(2);
				Qn(2) <= not Q(2);
			else
				Q(2) <= not Q(2);
				Qn(2) <= Q(2);
			end if;
			con(1) <= Q(2);
		end if;
	end process;
	
	process(con(1))
	begin
		if con(1)'event and con(1) = '1' then
			if T(1) = '0' then 
				Q(1) <= Q(1);
				Qn(1) <= not Q(1);
			else
				Q(1) <= not Q(1);
				Qn(1) <= Q(1);
			end if;
			con(0) <= Q(1);
		end if;
	end process;
	
	process(con(0))
	begin
		if con(0)'event and con(0) = '1' then
			if T(0) = '0' then 
				Q(0) <= Q(0);
				Qn(0) <= not Q(0);
			else
				Q(0) <= not Q(0);
				Qn(0) <= Q(0);
			end if;
		end if;
	end process;
	
	

end Behavioral;