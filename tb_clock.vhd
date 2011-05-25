-------------------------------------------------------------------------------
--
-- TRW Ltd owns the copyright in this source file and all rights are
-- reserved. It must not be used for any purpose other than that for which it
-- is supplied and must not be copied in whole or in part, or disclosed to
-- others without prior written consent of TRW Ltd.
-- Any copy of this source file made by any method must also contain a copy
-- of this legend.
-- -------------------------------------------------------------------------------
-- Copyright (c) 2011 TRW Limited

--
--  $URL::                                                                    $
-- This Revision:
--         $Revision::                                                        $
--   $LastModifiedBy::                                                        $
--             $Date::                                                        $
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------------------------------------------------------------------------------------

entity tb_clock is

end entity tb_clock;

----------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture test of tb_clock is

    -- component ports
    signal resetAX       : std_logic;
    signal second_enable : std_logic := '1';
    signal sh_ms          : std_logic_vector(2 downto 0);
    signal sh_ls          : std_logic_vector(3 downto 0);
    signal sm_ms          : std_logic_vector(2 downto 0);
    signal sm_ls          : std_logic_vector(3 downto 0);
    signal ss_ms          : std_logic_vector(2 downto 0);
    signal ss_ls          : std_logic_vector(3 downto 0);
    signal vh_ms          : std_logic_vector(2 downto 0);
    signal vh_ls          : std_logic_vector(3 downto 0);
    signal vm_ms          : std_logic_vector(2 downto 0);
    signal vm_ls          : std_logic_vector(3 downto 0);
    signal vs_ms          : std_logic_vector(2 downto 0);
    signal vs_ls          : std_logic_vector(3 downto 0);

    -- clock
    signal Clk : std_logic := '1';
    -- finished?
    signal finished : std_logic;

begin  -- architecture test

    -- component instantiation
    DUTs: entity work.clock(signals)
        port map (
            resetAX       => resetAX,
            clk           => clk,
            second_enable => second_enable,
            h_ms          => Sh_ms,
            h_ls          => Sh_ls,
            m_ms          => Sm_ms,
            m_ls          => Sm_ls,
            s_ms          => Ss_ms,
            s_ls          => Ss_ls);

    DUTv: entity work.clock(variables)
        port map (
            resetAX       => resetAX,
            clk           => clk,
            second_enable => second_enable,
            h_ms          => vh_ms,
            h_ls          => vh_ls,
            m_ms          => vm_ms,
            m_ls          => vm_ls,
            s_ms          => vs_ms,
            s_ls          => vs_ls);

    -- clock generation
    Clk <= not Clk after 10 ns when finished /= '1' else '0';
    resetAX <= '0','1' after 50 ns;
    -- waveform generation
    WaveGen_Proc: process
        constant maxticks : integer := 24*60*60;
        --constant maxticks : integer := 0;
    begin
        finished <= '0';
        wait until resetAX = '1';
        report "Started";
        for i in 0 to integer'(maxticks) loop
            if i mod 1000 = 0 then
        report "Stime "
            & integer'image(to_integer(unsigned(sh_ms)))
            & integer'image(to_integer(unsigned(sh_ls)))
            &":"
            & integer'image(to_integer(unsigned(sm_ms)))
            & integer'image(to_integer(unsigned(sm_ls)))
            &":"
            & integer'image(to_integer(unsigned(ss_ms)))
            & integer'image(to_integer(unsigned(ss_ls)))
            & CR
            & "Vtime "
            & integer'image(to_integer(unsigned(vh_ms)))
            & integer'image(to_integer(unsigned(vh_ls)))
            &":"
            & integer'image(to_integer(unsigned(vm_ms)))
            & integer'image(to_integer(unsigned(vm_ls)))
            &":"
            & integer'image(to_integer(unsigned(vs_ms)))
            & integer'image(to_integer(unsigned(vs_ls)));
            end if;
            wait until rising_edge(clk);
        end loop;  -- i
        -- insert signal assignments here
        finished <= '1';
        report (time'image(now) & " Finished");
        wait;
    end process WaveGen_Proc;
    testing: process is
    begin  -- process testing
        wait until rising_edge(clk);
        assert vh_ms = sh_ms report "h_ms" severity error;
        assert vh_ls = sh_ls report "h_ls" severity error;
        assert vm_ms = sm_ms report "m_ms" severity error;
        assert vm_ls = sm_ls report "h_ls" severity error;
        assert vs_ms = ss_ms report "s_ms" severity error;
        assert vs_ls = ss_ls report "s_ls" severity error;
    end process testing;
end architecture test;

----------------------------------------------------------------------------------------------------------------------------------

configuration tb_clock_test_cfg of tb_clock is
    for test
    end for;
end tb_clock_test_cfg;

----------------------------------------------------------------------------------------------------------------------------------
