--2-number adder BCD
--https://vasanza.blogspot.com

--Library
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--Entity
entity AddBCD is
	port(	A: in std_logic_vector(3 downto 0);
			enbcd: in std_logic;
			D,U: out std_logic_vector(3 downto 0));--Tens,Units
end AddBCD;

--Architecture
architecture solve of AddBCD is
	-- Signals,Constants,Variables,Components
	signal temp,temp2: std_logic_vector(7 downto 0);
	begin
	process(enbcd)
	begin
		if enbcd='1' then
		temp <= ("0000"&A);
		if temp>9 then temp2 <= temp +"00000110"; else temp2<= temp;end if;
		D<= temp2(7 downto 4);--Tens
		U<= temp2(3 downto 0);--Units
		else D<="0000"; U<="0000";end if;
		end process;
end solve;