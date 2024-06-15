--Practica DADO sin Displays

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity codigo is
    Port ( clk : in  STD_LOGIC;
           stp : in  STD_LOGIC;
			  state_out : out STD_LOGIC_VECTOR (2 downto 0));
end codigo;

architecture Behavioral of codigo is
	type state_type is(s1, s2, s3, s4, s5, s6);
	signal state, next_state: state_type;
	signal reloj: std_logic;
	signal Div: std_logic_vector(8 downto 0);
	
begin

process(clk)
	begin
		if clk'event and clk='1' then
			Div <= Div + 1;
		end if;
	end process;
	
	reloj <= Div(8);
	
	process(reloj, stp)
	begin
			
		if(reloj'event and reloj = '1') then
			state <= next_state;
		end if;
		
	end process;
	
	process(state, stp)
	begin
		if stp = '0' then 
		case state is
			when s1 => 
				next_state <= s2;
			when s2 => 
				next_state <= s3;
			when s3 => 
				next_state <= s4;
			when s4 => 
				next_state <= s5;
			when s5 => 
				next_state <= s6;
			when s6 => 
				next_state <= s1;
			when others => 
				next_state <= s1;
			end case;
		else
				case state is
			when s1 => 
				next_state <= s1;
			when s2 => 
				next_state <= s2;
			when s3 => 
				next_state <= s3;
			when s4 => 
				next_state <= s4;
			when s5 => 
				next_state <= s5;
			when s6 => 
				next_state <= s6;
			when others => 
				next_state <= s6;
			end case;
		end if;
	end process;
	
	process(state)
	begin
		case state is
			when s1 => 
				state_out <= "001";
			when s2 => 
				state_out <= "010";
			when s3 => 
				state_out <= "011";
			when s4 => 
				state_out <= "100";
			when s5 => 
				state_out <= "101";
			when s6 => 
				state_out <= "110";
			when others => 
				state_out <= "000";
			end case;
	end process;
			

end Behavioral;

