library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity compass is port(
clk, razn, in_pwm, continu, start_stop :in std_logic;
data_valid: out std_logic:='0';
 out_1s : out std_logic;
data_compas : out std_logic_vector(8 downto 0);
out_pwm : out std_logic
	
);
end entity;

architecture C of compass is 

signal sig1,sig5,pwm_sig,sig_data_valid : std_logic;
signal sig2,sig3,sig6,sig7,sig8,sig_continu,sig_ss : std_logic_vector(8 downto 0);
signal sig4 : std_logic_vector(1 downto 0);


component div_compa is
port (
   clk_div : in std_logic;
	S_div: out std_logic);
end component;

component div_compa2 is
port (
   clk_div : in std_logic;
	S_div: out std_logic);
end component;

component  deg_compa is
 port(
	deg_in,in_pwm : in std_logic;
	deg_s, deg_s2: out std_logic_vector(8 downto 0));
end component;

component pwm_q18 is
 port(
	clk_pwm, reset_pwm: in std_logic;
	--freq_pwm, duty_pwm: in std_logic_vector(7 downto 0);
	s_pwm : out std_logic
);
end component;


component continu_component is 
port(
	clk_continu : in std_logic;
	sig_entree,sig_entree2: in std_logic_vector(8 downto 0);
	--sorite_valid: out std_logic;
	sortie: out std_logic_vector(8 downto 0));
end component;

component ss_component is 
port(
	start,raz : in std_logic;
	sig_entree,sig_entree2: in std_logic_vector(8 downto 0);
	--sorite_valid: out std_logic;
	sortie: out std_logic_vector(8 downto 0));
end component;

begin
dv_compas : div_compa
port map ( clk_div=>clk , S_div=>sig1 );
dv_compas_2 : div_compa2
port map ( clk_div=>sig1 , S_div=>sig5 );
dv_pwm : pwm_q18
port map(clk_pwm=>clk, reset_pwm=>'0',s_pwm=>pwm_sig);
dv_deg : deg_compa
port map(deg_in=>sig1, in_pwm=>pwm_sig, deg_s=>sig6, deg_s2=>sig8);
dv_continu: continu_component
port map(clk_continu=>sig5, sig_entree=>sig6 , sig_entree2=>sig8, sortie=>sig_continu);
dv_ss: ss_component
port map(start=>start_stop, sig_entree=>sig6, raz=>razn , sig_entree2=>sig8, sortie=>sig_ss); 



process(clk)
begin

if clk 'event and clk = '1' then
if razn ='1' then
if continu='0' and start_stop='1' then
sig7<=sig_ss;
sig_data_valid<='1';
elsif continu='0' and start_stop='0' then
sig_data_valid<='0';
elsif continu='1' then
sig7<=sig_continu;
sig_data_valid<='1';
end if;
elsif razn ='0' then
sig7<="000000000";
end if;
end if;

end process;


out_1s<=sig5;
data_compas<=sig7;
out_pwm<=pwm_sig;
data_valid<=sig_data_valid;

end architecture; 
