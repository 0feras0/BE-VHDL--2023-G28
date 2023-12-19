library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity compass_nios is 
	port(
		clk, razn, in_pwm :in std_logic;
		switch: in std_logic_vector(3 downto 0);
		data_valid: out std_logic:='0';
		--out_1s : out std_logic;
		data_compas : out std_logic_vector(8 downto 0);
		out_pwm : out std_logic
		);
end entity;

architecture c_n of compass_nios is
signal sig_ss, sig_dv,sig_out, sig_pwm: std_logic :='0';
signal sig_cd:  std_logic_vector(8 downto 0);
signal sig_led:  std_logic_vector(7 downto 0);


component compass_2 is 
	port(
		clk, razn, in_pwm, continu, start_stop :in std_logic;
		data_valid: out std_logic:='0';
		out_1s : out std_logic;
		data_compas : out std_logic_vector(8 downto 0);
		out_pwm : out std_logic
		);
end component;

component nios_compass is
	port (
		clk_clk           : in  std_logic                    := '0';             --        clk.clk
		data_valid_export : in  std_logic                    := '0';             -- data_valid.export
		leds_export       : out std_logic_vector(7 downto 0);                    --       leds.export
		reset_reset_n     : in  std_logic                    := '0';             --      reset.reset_n
		s_compass_export  : in  std_logic_vector(8 downto 0) := (others => '0'); --  s_compass.export
		start_stop_export : out std_logic;                                       -- start_stop.export
		switch_export     : in  std_logic_vector(3 downto 0) := (others => '0')  --     switch.export
	);
end component;

begin
c2:compass_2
port map( clk=>clk, razn=>razn, in_pwm=>sig_pwm, continu=>'0', start_stop=>sig_ss, data_valid=>sig_dv, out_1s=>sig_out, data_compas=>sig_cd, out_pwm=>sig_pwm);

nc:nios_compass
port map(clk_clk=>clk, data_valid_export=>sig_dv, leds_export=>sig_led,  reset_reset_n=>razn, s_compass_export=> sig_cd, start_stop_export=>sig_ss, switch_export=>switch);

end architecture;