library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity div_compa is port(
	clk_div : in std_logic;
	S_div: out std_logic);
end entity;


architecture dv of div_compa is
signal sig : std_logic_vector(11 downto 0);
signal S2: std_logic;
begin
process(clk_div)
begin

IF clk_div 'event and clk_div = '1' THEN
sig <= sig + 1 ;


IF sig = "100111000011" THEN
S2 <= (not S2) ;
sig <= "000000000000";

end if;
end if;
S_div <= S2;
end process;

end architecture dv ;
