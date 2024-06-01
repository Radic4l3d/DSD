--Maquina de Mealy
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mqEdo2 is
    Port ( clk : in  STD_LOGIC;
           x1 : in  STD_LOGIC;
           x2 : in  STD_LOGIC;
           f : out  STD_LOGIC);
end mqEdo2;

architecture Behavioral of mqEdo2 is
	type estados is (A, B, C, D);
	signal est_ant, est_sig: estados;
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

	proceso_1: process(est_ant, reloj, x1, x2)
	begin
		case est_ant is
		when A => 
			if (x1 = '0' and x2 ='0') then est_sig <= B;
			elsif (x1 = '1' and x2 = '1') then est_sig <= B;
				f <= '0';
			else est_sig <= A;
				f <= '0';
			end if;
			
		when B =>
			if (x1 = '0' and x2 ='0') then est_sig <= D;
			elsif (x1 = '1' and x2 = '1') then est_sig <= D;
				f <= '0';
			else est_sig <= A;
				f <= '0';
			end if;
			
		when C =>
			if (x1 = '0' and x2 ='0') then est_sig <= D;
			elsif (x1 = '1' and x2 = '1') then est_sig <= D;
				f <= '0';
			else est_sig <= A;
				f <= '0';
			end if;
			
		when D =>
			if (x1 = '0' and x2 ='0') then est_sig <= D;
			elsif (x1 = '1' and x2 = '1') then est_sig <= D;
				f <= '1';
			else est_sig <= A;
				f <= '0';
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