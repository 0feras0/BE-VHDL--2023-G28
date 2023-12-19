library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity div8 is port(
	clk_div8 : in std_logic;
	e_div8: in std_logic_vector(7 downto 0);
	S_div8: out std_logic);
end entity;


architecture dv of div8 is
signal sig : integer range 0 to 25000000;
signal S2: std_logic;
begin
process(clk_div8)
begin

IF clk_div8 'event and clk_div8 = '1' THEN
sig <= sig + 1 ;


IF sig = e_div8 THEN
S2 <= (not S2) ;
sig <= 0;

end if;
end if;
S_div8 <= S2;
end process;

end architecture dv ;
