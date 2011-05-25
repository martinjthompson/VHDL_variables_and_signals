-- From http://stackoverflow.com/questions/6116054/implementing-a-digital-clock-in-vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture variables of clock is
begin

    COUNT : process(resetAX, clk)
        variable h_ms_int    :       integer range 0 to 2;
        variable h_ls_int    :       integer range 0 to 9;
        variable m_ms_int    :       integer range 0 to 5;
        variable m_ls_int    :       integer range 0 to 9;
        variable s_ms_int    :       integer range 0 to 5;
        variable s_ls_int    :       integer range 0 to 9;
        variable wrapped     :       boolean;
        procedure inc_wrap (i : inout integer; maximum : positive; wrapped : inout boolean) is
        begin
            if i = maximum then
                wrapped := true;
                i       := 0;
            else
                wrapped := false;
                i       := i + 1;
            end if;
        end procedure;
    begin
        if resetAX = '0' then
            h_ms_int := 0;
            h_ls_int := 0;
            m_ms_int := 0;
            m_ls_int := 0;
            s_ms_int := 0;
            s_ls_int := 0;
        elsif clk'event and clk = '1' then
            if second_enable = '1' then
                inc_wrap(s_ls_int, 9, wrapped);
                if wrapped then
                    inc_wrap(s_ms_int, 5, wrapped);
                end if;
                if wrapped then
                    inc_wrap(m_ls_int, 9, wrapped);
                end if;
                if wrapped then
                    inc_wrap(m_ms_int, 5, wrapped);
                end if;
                if wrapped then
                    if h_ms_int < 2 then
                        inc_wrap(h_ls_int, 9, wrapped);
                    else
                        inc_wrap(h_ls_int, 3, wrapped);
                    end if;
                end if;
                if wrapped then
                    inc_wrap(h_ms_int, 2, wrapped);
                end if;
            end if;
        end if;
        h_ms <= std_logic_vector(to_unsigned(h_ms_int, h_ms'length));
        h_ls <= std_logic_vector(to_unsigned(h_ls_int, h_ls'length));
        m_ms <= std_logic_vector(to_unsigned(m_ms_int, m_ms'length));
        m_ls <= std_logic_vector(to_unsigned(m_ls_int, m_ls'length));
        s_ms <= std_logic_vector(to_unsigned(s_ms_int, s_ms'length));
        s_ls <= std_logic_vector(to_unsigned(s_ls_int, s_ls'length));

    end process COUNT;

end variables;
