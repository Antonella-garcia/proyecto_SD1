--Synchronous Sequential Machine (Sequential Loading)
--https://vasanza.blogspot.com

--Library
library ieee;
use ieee.std_logic_1164.all;

--Entity
entity mss_sl is
	port(
		resetn,clk,start,cero: in std_logic;
		est: out std_logic_vector(2 downto 0);
		enbcd,endown,resetp,fin: out std_logic);
end mss_sl;

--Architecture
architecture solve of mss_sl is
	-- Signals,Constants,Variables,Components
	--ta,tb,tc,td
	--start
	
	type estado is (ta,tb,tc,td,te,tf);
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
					when td =>y <= te;
					when te =>
								if start='0' then y <= te;
							  else y <= tf; end if;	
					when tf =>
								if start='1' then y <= tf;
							  else y <= ta; end if;							  
				end case;
			end if;
	end process;
	--Process #2: State Indicator
	process(y)-- moore
	--Sequential programming
		begin
			enbcd<='0';
			endown<='0';
			est<="000";
			case y is
				when ta => est<="000"; --start 0
				when tb => est<="001"; --start 1
				when tc => enbcd<='1';endown <='1'; est<="010";
				when td => est<="011"; 
				when te => est<="100"; 
				when tf => est<="101"; 
			
			end case;
	end process;
			fin<= '1' when (y=te) or (y=tf) else '0';
			resetp<= '0' when y=ta else '1';
end solve;
