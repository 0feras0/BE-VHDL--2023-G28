Library	ieee;
use	ieee.std_logic_1164.all;

package lib_tp is

component addition is port (
	A1, B1, Cin: in bit;
	S, Cout: out bit);
end component;

component ADD3 is port(
	A1,A2,A3,B1,B2,B3,Cin: in bit;
	S1,S2,S3,Cout: out bit);
end component;

component ADD5 is port(
	A,B: in std_logic_vector (4 downto 0);
	Cin: in std_logic;
	S: out std_logic_vector (4 downto 0);
	Cout: out std_logic);
end component;


component div is port(
	clk : in std_logic;
	S: out std_logic);
end component;


component compteur is port(
	clk : in std_logic;
	S: out std_logic_vector (3 downto 0));
end component;


component seg is port(
	E: in std_logic_vector (3 downto 0);
	S: out std_logic_vector (6 downto 0));
end component;

end lib_tp;
