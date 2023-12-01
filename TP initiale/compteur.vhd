library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity compteur is port(
	clk : in std_logic;
	S: out std_logic_vector (3 downto 0));
end entity;


architecture com of compteur is
signal sig: std_logic_vector (3 downto 0);
begin
process(clk)
begin
IF clk 'event and clk = '1' THEN
sig <= sig + 1 ;
end if;
S <= sig;
end process;
end architecture com ;


