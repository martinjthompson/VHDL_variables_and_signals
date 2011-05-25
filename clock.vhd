library ieee;
use ieee.std_logic_1164.all;

entity clock is
    port (
        resetAX       : in  std_logic;                     -- Asynchronous reset, active low
        clk           : in  std_logic;                     -- Clock signal, runs faster than 1/second
        second_enable : in  std_logic;                     -- Signal active (high) only when seconds to be incremented
        h_ms          : out std_logic_vector(2 downto 0);  -- MS digit of hour (0, 1, 2)
        h_ls          : out std_logic_vector(3 downto 0);  -- LS digit of hour (0-9)
        m_ms          : out std_logic_vector(2 downto 0);  -- MS digit of minute (0-5)
        m_ls          : out std_logic_vector(3 downto 0);  -- LS digit of minute (0-9)
        s_ms          : out std_logic_vector(2 downto 0);  -- MS digit of second (0-5)
        s_ls          : out std_logic_vector(3 downto 0)   -- LS digit of second (0-9)
    );
end clock;

