library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;  

entity adc_comp is port(
		clk 			: in  std_logic;
		reset			: in  std_logic;
		data_in		: in  std_logic;
		degre_in		: in  std_logic;
		clk_1meg		: out std_logic;
		cs				: out std_logic;
		continue 	: in std_logic;
		ss		   	: in std_logic;
		data_valid  : out std_logic;
				led            : out std_logic_vector(11 downto 0);

		out_pwm     : out std_logic
		
);
end entity adc_comp;


architecture main of adc_comp is 

	signal	sig_cmd_compas		 :  std_logic;
	signal	sig_cmd_adc  		 :  std_logic;
	signal	sig_ack   		    :  std_logic;
	signal	sig_data_out ,sig_data_outs		 :  std_logic_vector(11 downto 0);
	--signal	sig_led      		 :  std_logic_vector(11 downto 0);
	signal   cs_sig     			 :  std_logic;
	signal   position_sig       :  std_logic_vector(11 downto 0);
	signal   data_compas_sig    :  std_logic_vector(8 downto 0);
	signal   data_valid_sig     :  std_logic;
	signal   out_1s_sig			 :  std_logic;

component adc_cmp is
	port (
		acknowledge_external_connection_export : in  std_logic                     := '0';             -- acknowledge_external_connection.export
		clk_clk                                : in  std_logic                     := '0';             --                             clk.clk
		cmd_adc_external_connection_export     : out std_logic;                                        --     cmd_adc_external_connection.export
		cmd_compas_external_connection_export  : out std_logic;                                        --  cmd_compas_external_connection.export
		continue_external_connection_export    : in  std_logic                     := '0';             --    continue_external_connection.export
		data_valid_external_connection_export  : out std_logic;                                        --  data_valid_external_connection.export
		degre_in_external_connection_export    : in  std_logic_vector(8 downto 0)  := (others => '0'); --    degre_in_external_connection.export
		position_in_external_connection_export : in  std_logic_vector(11 downto 0) := (others => '0'); -- position_in_external_connection.export
		reset_reset_n                          : in  std_logic                     := '0';             --                           reset.reset_n
		ss_external_connection_export          : in  std_logic                     := '0'              --          ss_external_connection.export
	);
end component;

component compass_2 is 
port(
	clk, razn, in_pwm, continu, start_stop :in std_logic;
	data_valid: out std_logic:='0';
	out_1s : out std_logic;
	data_compas : out std_logic_vector(8 downto 0);
	out_pwm : out std_logic
	
);
end component;

component SPI_ADC is 
	port (
		clk 		: in  std_logic;
		reset		: in  std_logic;
		cmd		: in  std_logic;
		data_in	: in  std_logic;
		cs			: out std_logic;
		clk_1meg	: out std_logic;
		ack      : out std_logic;
		data_out : out std_logic_vector(11 downto 0);
		LED_out : out std_logic_vector(11 downto 0)

	);
end component;

begin

nios : adc_cmp
port map
	(		
			sig_ack,
			clk,
			sig_cmd_adc,
			sig_cmd_compas,
			continue,
			data_valid,
			data_compas_sig,
			sig_data_out,
			reset,
			ss
	);

Convertisseur	: SPI_ADC
port map
	(
		clk,
		reset,
		sig_cmd_adc,
		data_in,
		cs,
		clk_1meg,
		sig_ack,
		sig_data_out,
		led

	);
	
	
Compas : compass_2
port map
(
	clk, 
	reset, 
	degre_in, 
	'0', 
	sig_cmd_compas,
	data_valid_sig,
	out_1s_sig,
	data_compas_sig,
	out_pwm
);
	
	--csl<=sig_cmd;
	--cs_main<=cs_sig;

end architecture;