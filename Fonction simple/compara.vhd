library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity compara is port(
	e_compara,duty_compara: in std_logic_vector(7 downto 0);	
	S_compara: out std_logic);
end entity;


architecture cp of compara is
signal sig: std_logic;
begin
process(e_compara)
begin
IF e_compara > duty_compara THEN
sig <= '0' ;
else
sig <= '1' ;

end if;

S_compara <= sig;
end process;

end architecture cp ;
