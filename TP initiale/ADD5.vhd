library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity ADD5 is port(
	A,B: in std_logic_vector (4 downto 0);
	Cin: in std_logic;
	S: out std_logic_vector (4 downto 0);
	Cout: out std_logic);
end entity;


architecture addition5 of ADD5 is
signal C: std_logic_vector (5 downto 0); 
begin
	C <= ('0' & A)+ b + cin;
	S <= C(4 downto 0);
	Cout <= C(5);
			
end architecture addition5;

