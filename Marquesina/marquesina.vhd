--Practica Marquesina

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Marquesina is
    Port ( clk : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           pulso : inout STD_LOGIC;
           pulso_r : inout STD_LOGIC;

           x : in STD_LOGIC;
           out_bcd : out STD_LOGIC_VECTOR (6 downto 0));
           an: inout STD_LOGIC_VECTOR(3 downto 0);
end Marquesina;

architecture Behavioral of Marquesina is
	type estados is(a0, a1, a2, a3, a4, a5, a6, a7, a8);
    signal E_ACT, E_SIG, ESTADOS;
    signal clk_aux, clk_rapido : STD_LOGIC := '0';
    signal contador, contador2 : integer range 0 to 100000000 := 0;

    type subestados is (s0, s1, s2, s3, s4);
    signal SUB_E_ACT, SUB_E_SIG, SUBESTADOS;
    
    --
    signal reloj: std_logic;
	signal Div: std_logic_vector(8 downto 0);
	
begin

    divisor_freq: process(clk)
        begin
            if rising_edge (clk) then
                if (contador = 25000000) then 
                    clk_aux <= NOT (clk_aux);
                    contador <=0;
                else
                    contador <= contador+1;
                end if;
            end if;
    end process;

    pulso <= clk_aux;   --pulso lento para la marquesina

    Frecuencia_rapida: process(clk)
        begin
            if rising_edge (clk) then
                if (contador = 100000) then 
                    clk_rapido <= NOT (clk_rapido);
                    contador2 <=0;
                else
                    contador2 <= contador2+1;
                end if;
            end if;
    end process;

    pulso_r <= clk_rapido;   --pulso rapido para la marquesina

    Secuencia: process (clear, pulso)
        begin
            if clear = '1' then
                E_ACT <= a8;
            elsif rising_edge(pulse) then
                E_ACT <= E_SIG;
            end if;
    end process Secuencia;

    SubSecuencia: process (clear, pulso_r)
        begin
            if clear = '1' then
                SUB_E_ACT <= s4;    --Todo apagado
            elsif rising_edge(pulso_r) then
                SUB_E_ACT <= SUB_E_SIG;
            end if;
    end process SubSecuencia;

    contadecadas: process (x, E_ACT)
        begin
            case E_ACT is
                when a0 =>
                    if x = '1' then     --Asc
                        E_SIG <= a1;
                    else                --Desc
                        E_SIG <= a8;
                    end if;
                when a1 =>
                    if x = '1' then     --Asc
                        E_SIG <= a2;
                    else                --Desc
                        E_SIG <= a0;
                end if;
                when a2 =>
                    if x = '1' then     --Asc
                        E_SIG <= a3;
                    else                --Desc
                        E_SIG <= a1;
                    end if;
                when a3 =>
                    if x = '1' then     --Asc
                        E_SIG <= a4;
                    else                --Desc
                        E_SIG <= a2;
                end if;
                when a4 =>
                    if x = '1' then     --Asc
                        E_SIG <= a5;
                    else                --Desc
                        E_SIG <= a3;
                end if;
                when a5 =>
                    if x = '1' then     --Asc
                        E_SIG <= a6;
                    else                --Desc
                        E_SIG <= a4;
                    end if;
                when a6 =>
                    if x = '1' then     --Asc
                        E_SIG <= a7;
                    else                --Desc
                        E_SIG <= a5;
                    end if;
                when a7 =>
                    if x = '1' then     --Asc
                        E_SIG <= a8;
                    else                --Desc
                        E_SIG <= a6;
                end if;
                when a8 =>
                    if x = '1' then     --Asc
                        E_SIG <= a0;
                    else                --Desc
                        E_SIG <= a7;
                end if;
            end case;
        end process contadecadas;
    
        --

        parteSecuencial: process(E_ACT, SUB_E_ACT, pulso_r)
        begin
            case E_ACT is
                when a0 =>
                    an <= "1110";
                    out_bcd <= "0001001"; --H

                when a1 => 
                    case SUB_E_ACT is
                        when s0 =>
                            an <= "1101";
                            out_bcd <= "0001001"; --H
                            SUB_E_SIG <= s1;
                        when s1 =>
                            an <= "1110";
                            out_bcd <= "1000000"; --O
                            SUB_E_SIG <= s0;
                        when others =>
                            an <= "1111";
                            out_bcd <= "1111111";
                            SUB_E_SIG <= s0;
                    end case;
                
                when a2 => 
                    case SUB_E_ACT is
                        when s0 =>
                            an <= "1011";
                            out_bcd <= "0001001"; --H
                            SUB_E_SIG <= s1;
                        when s1 =>
                            an <= "1101";
                            out_bcd <= "1000000"; --O
                            SUB_E_SIG <= s2;
                        when s2 =>
                            an <= "1110";
                            out_bcd <= "1100011"; --L
                            SUB_E_SIG <= s0;
                        when others =>
                            an <= "1111";
                            out_bcd <= "1111111";
                            SUB_E_SIG <= s0;
                    end case;
                
                when a3 => 
                    case SUB_E_ACT is
                        when s0 =>
                            an <= "0111";
                            out_bcd <= "0001001"; --H
                            SUB_E_SIG <= s1;
                        when s1 =>
                            an <= "1011";
                            out_bcd <= "1000000"; --O
                            SUB_E_SIG <= s2;
                        when s2 =>
                            an <= "1101";
                            out_bcd <= "1100011"; --L
                            SUB_E_SIG <= s3;
                        when s3 =>
                            an <= "1101";
                            out_bcd <= "0001000"; --A
                            SUB_E_SIG <= s0;
                        when others =>
                            an <= "1111";
                            out_bcd <= "1111111";
                            SUB_E_SIG <= s0;
                    end case;

                when a4 => 
                    case SUB_E_ACT is
                        when s0 =>
                            an <= "0111";
                            out_bcd <= "1000000"; --O
                            SUB_E_SIG <= s1;
                        when s1 =>
                            an <= "1011";
                            out_bcd <= "1100011"; --L
                            SUB_E_SIG <= s2;
                        when s2 =>
                            an <= "1101";
                            out_bcd <= "0001000"; --A
                            SUB_E_SIG <= s3;
                        when others =>
                            an <= "1111";
                            out_bcd <= "1111111";
                            SUB_E_SIG <= s0;
                    end case;

                when a5 => 
                    case SUB_E_ACT is
                        when s0 =>
                            an <= "0111";
                            out_bcd <= "1100011"; --L
                            SUB_E_SIG <= s1;
                        when s1 =>
                            an <= "1011";
                            out_bcd <= "0001000"; --A
                            SUB_E_SIG <= s2;
                        when others =>
                            an <= "1111";
                            out_bcd <= "1111111";
                            SUB_E_SIG <= s0;
                    end case;
                when a6 => 
                    an <= "0111";
                    out_bcd <= "0001000"; --A        
                when others =>
                    an <= "1111";
                    out_bcd <= "1111111";
                end case;
            end process parteSecuencial;
        end Behavioral;
                


                
    
