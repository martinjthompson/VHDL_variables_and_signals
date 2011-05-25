-- From http://stackoverflow.com/questions/6116054/implementing-a-digital-clock-in-vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture signals of clock is
    signal h_ms_int : integer range 0 to 2;
    signal h_ls_int : integer range 0 to 9;
    signal m_ms_int : integer range 0 to 5;
    signal m_ls_int : integer range 0 to 9;
    signal s_ms_int : integer range 0 to 5;
    signal s_ls_int : integer range 0 to 9;
begin

    COUNT : process(resetAX, clk)
    begin
        if resetAX = '0' then
            h_ms_int <= 0;
            h_ls_int <= 0;
            m_ms_int <= 0;
            m_ls_int <= 0;
            s_ms_int <= 0;
            s_ls_int <= 0;
        elsif clk'event and clk = '1' then
            if second_enable = '1' then
                if s_ls_int = 9 then
                    if s_ms_int = 5 then
                        if m_ls_int = 9 then
                            if m_ms_int = 5 then
                                if (h_ls_int = 9 or (h_ls_int = 3 and h_ms_int = 2)) then
                                    if (h_ls_int = 3 and h_ms_int = 2) then
                                        h_ms_int <= 0;
                                    else
                                        h_ms_int <= h_ms_int + 1;
                                    end if;
                                    h_ls_int <= 0;
                                else
                                    h_ls_int <= h_ls_int + 1;
                                end if;
                                m_ms_int <= 0;
                            else
                                m_ms_int <= m_ms_int + 1;
                            end if;
                            m_ls_int <= 0;
                        else
                            m_ls_int <= m_ls_int + 1;
                        end if;
                        s_ms_int <= 0;
                    else
                        s_ms_int <= s_ms_int + 1;
                    end if;
                    s_ls_int <= 0;
                else
                    s_ls_int <= s_ls_int + 1;
                end if;
            end if;
        end if;
    end process COUNT;

    h_ms <= std_logic_vector(to_unsigned(h_ms_int, h_ms'length));
    h_ls <= std_logic_vector(to_unsigned(h_ls_int, h_ls'length));
    m_ms <= std_logic_vector(to_unsigned(m_ms_int, m_ms'length));
    m_ls <= std_logic_vector(to_unsigned(m_ls_int, m_ls'length));
    s_ms <= std_logic_vector(to_unsigned(s_ms_int, s_ms'length));
    s_ls <= std_logic_vector(to_unsigned(s_ls_int, s_ls'length));

end signals;
