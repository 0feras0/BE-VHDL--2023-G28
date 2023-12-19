library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity deg_compa is port(
	deg_in,in_pwm : in std_logic;
	deg_s, deg_s2: out std_logic_vector(8 downto 0));
end entity;


architecture dv of deg_compa is
signal sig2,sig3 : std_logic_vector(8 downto 0);
begin
process(deg_in)
begin
if deg_in 'event and deg_in = '1'  then

if in_pwm='1' then
sig2 <=sig2+1;

else
 sig2<="000000000";
 
end if;
if sig2>0 then
sig3<=sig2-1;

end if;

end if;
end process;
deg_s<=sig3;
deg_s2<=sig2;

end architecture dv ;
