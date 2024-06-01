--Maquina de Moore
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mqEdo1 is
    Port ( clk : in  STD_LOGIC;
           x1 : in  STD_LOGIC;
           x2 : in  STD_LOGIC;
           f : out  STD_LOGIC);
end mqEdo1;

architecture Behavioral of mqEdo1 is
	type estados is (A, B, C, D, E);
	signal reloj: std_logic;
	signal Div: std_logic_vector(25 downto 0);
	signal est_ant, est_sig: estados;
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			Div <= Div + 1;
		end if;
	end process;

	reloj <= Div(25);

	proceso_1: process(est_ant, reloj, x1, x2)
	begin
		case est_ant is
		when A => F <= '0';
			if (x1 = '0' and x2 ='0') then est_sig <= B;
			elsif (x1 = '1' and x2 = '1') then est_sig <= B;
			else est_sig <= A;
			end if;
			
		when B => F <= '0';
			if (x1 = '0' and x2 ='0') then est_sig <= C;
			elsif (x1 = '1' and x2 = '1') then est_sig <= C;
			else est_sig <= A;
			end if;
			
		when C => F <= '0';
			if (x1 = '0' and x2 ='0') then est_sig <= D;
			elsif (x1 = '1' and x2 = '1') then est_sig <= D;
			else est_sig <= A;
			end if;
			
		when D => F <= '0';
			if (x1 = '0' and x2 ='0') then est_sig <= E;
			elsif (x1 = '1' and x2 = '1') then est_sig <= E;
			else est_sig <= A;
			end if;
			
		when E => F <= '1';
			if (x1 = '0' and x2 ='0') then est_sig <= E;
			elsif (x1 = '1' and x2 = '1') then est_sig <= E;
			else est_sig <= A;
			end if;
		end case;
	end process proceso_1;
	
	proceso_2: process(reloj)
	begin
		if(reloj'event and reloj = '1') then
			est_ant <= est_sig;
		end if;
	end process proceso_2;
			


end Behavioral;