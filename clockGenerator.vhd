library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity clockGenerator is 
port( 
	CLOCK_50 			: in std_logic;
	TANK_CLOCK			: out std_logic;
);

architecture behavioral of clockGenerator is

begin

process(CLOCK_50) is 

variable count : integer := 0;

begin
	TANK_CLOCK <= '0';
	if(rising_edge(CLOCK_50)) then
		if(count < 500000) then
			count := count + 1;
		else
			TANK_CLOCK <= not TANK_CLOCK;
			count := 0;
		end if;
	end if;
		
end process;

end architecture;