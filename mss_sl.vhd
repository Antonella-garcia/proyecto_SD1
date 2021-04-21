--Synchronous Sequential Machine (Sequential Loading)
--https://vasanza.blogspot.com

--Library
library ieee;
use ieee.std_logic_1164.all;

--Entity
entity mss_sl is
	port(
		resetn,clk,start,cero: in std_logic;
		est: out std_logic_vector(1 downto 0);
		enbcd,endown,fin: out std_logic);
end mss_sl;

--Architecture
architecture solve of mss_sl is
	-- Signals,Constants,Variables,Components
	--s0,s1,s2,s3,s4,s5
	--start
	
	type estado is (ta,tb,tc,td);
	signal y: estado;
	begin
	--Process #1: Next state decoder and state memory
	process(resetn,clk)
	--Sequential programming
		begin
			if resetn = '0' then y<= ta;
			elsif (clk'event and clk = '1') then
				case y is
					when ta => 
							  if start='1' then y <= tb;
							  else y <= ta; end if;	
					when tb => 
							  if start='0' then y <= tc;
							  else y <= tb; end if;	
					when tc => 
							  if cero='1' then y <= td;
							  else y <= tc; end if;
					when td =>y <= ta;
				end case;
			end if;
	end process;
	--Process #2: State Indicator
	process(y)-- mealy ->(y,d,n)
	--Sequential programming
		begin
			enbcd<='0';
			endown<='0';
			fin<='0';
			est<="00";
			case y is
				when ta => est<="00"; --start 0
				when tb => est<="01"; --start 1
				when tc => enbcd<='1';if cero='1' then endown<='0';else endown <='1'; end if; est<="10";
				when td => fin<='1'; est<="11"; 
				
				
			end case;
	end process;
end solve;