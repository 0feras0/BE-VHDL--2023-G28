library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity continu_component is port(
	clk_continu : in std_logic;
	sig_entree,sig_entree2: in std_logic_vector(8 downto 0);
	--sorite_valid: out std_logic;
	sortie: out std_logic_vector(8 downto 0));
end entity;


architecture cc of continu_component is
signal sig: std_logic_vector(8 downto 0);
--signal data: std_logic;
begin
process(clk_continu)
begin
if clk_continu 'event and clk_continu = '1' then
if sig_entree2="000000000" then 
sig<=sig_entree;
--data<='1';
end if;
end if;
end process;
sortie<=sig;
--sorite_valid<=data;

end architecture cc ;
