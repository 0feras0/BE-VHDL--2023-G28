library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity sevenseg is port(
	E: in std_logic_vector (3 downto 0);
	S: out std_logic_vector (6 downto 0));
end entity;


architecture seg7 of 7seg is
begin
	with E select
		S <= "1000000" when 0,
			"1111001" when 1,
			"0100100" when 2,
			"0110000" when 3,
			"0011001" when 4,
			"0010010" when 5,
			"0000010" when 6,
			"1111000" when 7,
			"0000000" when 8,
			"0010000" when 9,
			"0001000" when 10,
			"0000000" when 11,
			"1000110" when 12,
			"1000000" when 13,
			"0000110" when 14,
			"0001110" when 15,
			"1000000" when others;
end architecture seg7 ;


