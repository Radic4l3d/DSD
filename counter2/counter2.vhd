library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter2 is
    Port ( clk : in  STD_LOGIC;
           Q : inout  STD_LOGIC_VECTOR (2 downto 0);
           Qn : inout  STD_LOGIC_VECTOR (2 downto 0) );
           
end counter2;

architecture Behavioral of counter2 is
	signal reloj: std_logic;
	signal Div: std_logic_vector(25 downto 0);
	signal T: std_logic_vector(2 downto 0);
	signal con: std_logic_vector(2 downto 0);
	signal set : std_logic_vector(2 downto 0):= "000";
   signal clr : std_logic_vector(2 downto 0):= "000";
	
begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			Div <= Div + 1;
		end if;
	end process;
	
	reloj <= Div(25);
	
	--FF 2
	process(reloj, set(2), clr(2), con(2), con(1), con(0))
	begin
		T(2) <= con(0) and (not (con(1) or con(2)));	--ECUACION
		
		if reloj'event and reloj = '1' then
			if set(2) = '1' and clr(2) = '0' then	-- Q set en 1
				Q(2) <= '1';
				Qn(2) <= '0';
			elsif 	set(2) = '0' and clr(2) = '1' then	-- Q clear a 0
				Q(2) <= '0';
				Qn(2) <= '1';
			elsif T(2) = '0' then 	--Comportamiento normal de FF T
				Q(2) <= Q(2);
				Qn(2) <= not Q(2);
			else
				Q(2) <= not Q(2);
				Qn(2) <= Q(2);
			end if;
			con(2) <= Q(2); --Señal para conectar con otro FF
		end if;
	end process;
	--fin de FF 2
	

--FF 1
process(reloj, set(1), clr(1), con(2), con(1), con(0))
begin
	T(1) <= not (con(1) and con(0));
    if reloj'event and reloj = '1' then
        if set(1) = '1' and clr(1) = '0' then  -- Q set en 1
            Q(1) <= '1';
            Qn(1) <= '0';
        elsif set(1) = '0' and clr(1) = '1' then  -- Q clear a 0
            Q(1) <= '1';
            Qn(1) <= '0';
        elsif T(1) = '0' then  -- Comportamiento normal de FF T
            Q(1) <= Q(1);
            Qn(1) <= not Q(1);
        else
            Q(1) <= not Q(1);
            Qn(1) <= Q(1);
        end if;
        con(1) <= Q(1);  -- Señal para conectar con otro FF
    end if;
end process;
--fin de FF 1

--FF 0
process(reloj, set(0), clr(0), con(2), con(1), con(0))
begin
	T(0) <= ( con(0) and con(1) ) or ((not con(1)) and con(2));
    if reloj'event and reloj = '1' then
        if set(0) = '1' and clr(0) = '0' then  -- Q set en 1
            Q(0) <= '1';
            Qn(0) <= '0';
        elsif set(0) = '0' and clr(0) = '1' then  -- Q clear a 0
            Q(0) <= '1';
            Qn(0) <= '0';
        elsif T(0) = '0' then  -- Comportamiento normal de FF T
            Q(0) <= Q(0);
            Qn(0) <= not Q(0);
        else
            Q(0) <= not Q(0);
            Qn(0) <= Q(0);
        end if;
        con(0) <= Q(0);  -- Señal para conectar con otro FF
    end if;
end process;
--fin de FF 0

	
	
	
	


end Behavioral;