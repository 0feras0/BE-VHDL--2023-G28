library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity ni_compa is 
	port(
		clk, razn, in_pwm :in std_logic;
		switch: in std_logic_vector(3 downto 0);
		provisoire : in std_logic;
		data_valid: out std_logic:='0';
		out_1s : out std_logic;
		data_compass : out std_logic_vector(8 downto 0);
		out_pwm : out std_logic
		);
end entity;

architecture c_n of ni_compa is
signal sig_ss, sig_dv,sig_out, sig_pwm: std_logic :='0';
signal sig_cd,sig_deg:  std_logic_vector(8 downto 0);
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

component ni_compa_arch is
	port (
		clk_clk               : in  std_logic                    := '0';             --            clk.clk
		data_valid_in_export  : in  std_logic                    := '0';             --  data_valid_in.export
		data_valid_out_export : out std_logic;                                       -- data_valid_out.export
		degre_export          : in  std_logic_vector(8 downto 0) := (others => '0'); --          degre.export
		leds_degre_export     : out std_logic_vector(8 downto 0);                    --     leds_degre.export
		pwm_out_export        : out std_logic_vector(7 downto 0);                    --        pwm_out.export
		reset_reset_n         : in  std_logic                    := '0';             --          reset.reset_n
		ss_export             : out std_logic;                                       --             ss.export
		switch_export         : in  std_logic_vector(3 downto 0) := (others => '0')  --         switch.export
	);
end component;
begin
c2:compass_2
port map( clk=>clk, razn=>razn, in_pwm=>in_pwm, continu=>'0', start_stop=>sig_ss, data_valid=>sig_dv, out_1s=>out_1s, data_compas=>sig_deg, out_pwm=>out_pwm);

nc:ni_compa_arch
port map(clk_clk=>clk, data_valid_in_export=>sig_dv, data_valid_out_export=>data_valid , pwm_out_export=>sig_led,  reset_reset_n=>razn, degre_export=>sig_deg, ss_export=>sig_ss, switch_export=>switch, leds_degre_export=>data_compass);

end architecture;