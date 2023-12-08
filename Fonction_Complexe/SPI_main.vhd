library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;  

entity SPI_main is port(
		clk_main 		: in  std_logic;
		reset_main		: in  std_logic;
		data_in_main	: in  std_logic;
		cs_main			: out std_logic;
				csl      : out std_logic;
		led            : out std_logic_vector(11 downto 0);
		clk_1meg_main	: out std_logic
);
end entity SPI_main;


architecture SPI of SPI_main is 

	signal	sig_cmd		 :  std_logic;
	signal	sig_ack      :  std_logic;
	signal	sig_data_out :  std_logic_vector(11 downto 0);
	signal	sig_led      :  std_logic_vector(11 downto 0);

	signal   cs_sig       :  std_logic;

component nios_spi is
	port (
		acknowledge_external_connection_export : in  std_logic                     := '0';             -- acknowledge_external_connection.export
		clk_clk                                : in  std_logic                     := '0';             --                             clk.clk
		command_external_connection_export     : out std_logic;                                        --     command_external_connection.export
		data_external_connection_export        : in  std_logic_vector(11 downto 0) := (others => '0'); --        data_external_connection.export
		reset_reset_n                          : in  std_logic                     := '0'              --                           reset.reset_n
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

nios : nios_spi
port map
	(
			acknowledge_external_connection_export => sig_ack,
			clk_clk                                => clk_main,
			command_external_connection_export     => sig_cmd,
			data_external_connection_export        => sig_data_out,
			reset_reset_n                  			=> reset_main
	);

Convertisseur	: SPI_ADC
port map
	(
		clk 		=> clk_main,
		reset 	=> reset_main,
		cmd 		=> sig_cmd,
		data_in 	=> data_in_main,
		cs 		=> cs_main,
		clk_1meg => clk_1meg_main,
		ack		=> sig_ack,
		data_out => sig_data_out,
		LED_out  => led

	);
	
	csl<=sig_cmd;
	--cs_main<=cs_sig;

end architecture;