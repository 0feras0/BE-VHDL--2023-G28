library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity div is port(
	clk : in std_logic;
	S: out std_logic);
end entity;


architecture div50 of div is
signal sig : integer range 0 to 25000000;
signal S2: std_logic;
begin
process(clk)
begin

IF clk 'event and clk = '1' THEN
sig <= sig + 1 ;


IF sig = 25000000 THEN
S2 <= (not S2) ;
sig <= 0;

end if;
end if;
S <= S2;
end process;

end architecture div50 ;


