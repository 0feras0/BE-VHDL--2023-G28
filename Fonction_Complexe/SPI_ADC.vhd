library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;  

entity SPI_ADC is port(
	clk 		: in  std_logic;
	reset		: in  std_logic;
	cmd		: in  std_logic;
	data_in	: in  std_logic;
	cs			: out std_logic:='1';
	clk_1meg	: out std_logic;
	ack      : out std_logic;
	--daa      : out std_logic;
	--meg1      : out std_logic;
	data_out : out std_logic_vector(11 downto 0);
	LED_out : out std_logic_vector(11 downto 0)

);
end entity;


architecture ADC of SPI_ADC is 
	type state is (
		E_initial,
		E_begin,
		E_attente,
		E_lecture,
		E_end
	);
	

signal EP, ES : state;

signal clk_1m					: std_logic;
Signal timer_100 	  			: std_logic;
Signal timer_1 	 			: std_logic;
signal start_timer_100		: std_logic;
signal start_timer_1			: std_logic;
signal start_lecture			: std_logic;
signal start_cpt_clk			: std_logic;
signal start_cpt_data		: std_logic;
signal cpt_clk_1m				: std_logic_vector(4 downto 0);
signal cpt_clk  			   : std_logic_vector(1 downto 0);
signal cpt_data 	  			: std_logic_vector(3 downto 0);
signal compteur_100 			: std_logic_vector(2 downto 0);
signal compteur_1 			: std_logic_vector(5 downto 0);
signal data						: std_logic_vector(11 downto 0);
signal data_memoire			: std_logic_vector(11 downto 0);
signal sig_ack             : std_logic;
begin
		process(clk,reset)
		begin
			if (reset = '0') then
				EP <= E_end;
			elsif clk'event and clk='1' then
				EP <= ES;
			end if;
		end process;
		
		process(EP, cmd, timer_100, cpt_clk, cpt_data, timer_1)
		begin
			case EP is
				when E_initial =>
					if cmd ='0' then
						ES <= E_begin;
					else 
						ES <= EP;
					end if;
					
				when E_begin =>
					if timer_100 ='1' then
						ES <= E_attente;
					else 
						ES <= EP;
					end if;
					
				when E_attente =>
					if cpt_clk = "10" then
						ES <= E_lecture;
					else 
						ES <= EP;
					end if;
					
				when E_lecture =>
					if cpt_data ="1111" then
						ES <= E_end;
					else 
						ES <= EP;
					end if;
						
				when E_end =>
					if timer_1 ='1' then
						ES <= E_initial;
					else 
						ES <= EP;
					end if;
					
			end case;
		end process;
		
		
			process(EP)
			begin
			case EP is
				when E_initial =>
					--Cs <= '1';	
					start_timer_1 <= '0';
			
				when E_begin =>
					Cs <= '0';
					sig_ack <= '0';
					start_timer_100 <= '1';
					
				when E_attente =>
					Start_cpt_clk <= '1';
					start_timer_100 <= '0';
					
				when E_lecture =>
					Start_lecture  <= '1';
					Start_cpt_clk <= '0';
					start_cpt_data <= '1';
						
				when E_end =>
					Cs <= '1';
					sig_ack <= '1';
					start_timer_1 <= '1';
					Start_lecture  <= '0';
					start_cpt_data <= '0';
					
			end case;
		end process;
		
		-- end machine d'état--
		
		process(clk) --clk 1 Mhz
			begin
			if clk'event and clk='1' then
				cpt_clk_1m <= cpt_clk_1m + 1;
			if cpt_clk_1m = "11000" then
				clk_1m <= not clk_1m;
				cpt_clk_1m <= "00000";
			end if;
			end if;
			
		end process;
		
		
		process(clk) --compteur 100ns
			begin
			if clk'event and clk='1' then
				if start_timer_100 = '0' then				
					timer_100 <= '0';
				elsif start_timer_100 = '1' then		
					compteur_100 <= compteur_100 + 1;
				if compteur_100 = "101" then
					timer_100 <='1';
					--start_timer_100 <= '0';
					compteur_100 <= "000";
				end if;
				end if;
			end if;
		
		end process;
		
		
		process(clk) --compteur 1us
			begin
			if clk'event and clk='1' then
				if start_timer_1 = '0' then				
					timer_1 <= '0';
				elsif start_timer_1 = '1' then		
					compteur_1 <= compteur_1 + 1;
				if compteur_1 = "110010" then
					timer_1 <='1';
					--start_timer_1 <= '0';
					compteur_1 <= "000000";
				end if;
				end if;
			end if;
		
		end process;
		
		
		process(clk_1m) --compteur 2
			begin
			if clk_1m'event and clk_1m='1' then
			if Start_cpt_clk = '0' then
				cpt_clk <= "00";
			else
				cpt_clk <= cpt_clk + 1;
			--if cpt_clk = "10" then
				--Start_cpt_clk <= '0';
			--end if;
			end if;
			end if;
			
		end process;
		
		process(clk_1m) --compteur data
			begin
			if clk_1m'event and clk_1m='1' then
			if Start_cpt_data = '0' then
				cpt_data <= "0000";
			else
				cpt_data <= cpt_data + 1;
			--if cpt_data = "1101" then
				--Start_cpt_data <= '0';
			--end if;
			end if;
			end if;
			
		end process;
		
		process(clk_1m) -- lecture data
		begin
		if clk_1m'event and clk_1m='1' then
			if start_lecture ='0' then 
				data_memoire <= data;
			else
				data(11 downto 0) <= data(10 downto 0) &  data_in;
			end if;
		end if;
		end process;
	ack <= sig_ack;
	data_out <= data_memoire;
	LED_out <= data_memoire;
	clk_1meg <= clk_1m;
	--daa<=data_in;
	--meg1<=clk_1m;
end architecture; 
