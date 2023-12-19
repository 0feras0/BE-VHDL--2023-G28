library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity cmpt8 is port(
	E_cmpt8 : in std_logic;
	S_cmpt8: out std_logic_vector (7 downto 0));
end entity;


architecture com of cmpt8 is
signal sig: std_logic_vector (7 downto 0);
begin
process(E_cmpt8)
begin
IF E_cmpt8 'event and E_cmpt8 = '1' THEN
sig <= sig + 1 ;
end if;
S_cmpt8 <= sig;
end process;
end architecture com ;