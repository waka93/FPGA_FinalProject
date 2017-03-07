library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.graphic_const.all;

entity hit is
port(
	clk,rst						: in clk;
	pos_x1,pos_y1,pos_x2,pos_y2	: in integer;
	b_x1,b_y1,b_x2,b_y2			: in integer;
	score1,score2				: out integer;
);
end entity;

architecture behavioral of hit is


begin
	
reset:process(rst)
begin
	score1 <= 0;
	score2 <= 0;
end process;

count:process(clk,pos_x1,pos_y1,pos_x2,pos_y2,b_x1,b_y1,b_x2,b_y2)
begin
	if(rising_edge(clk)) then
		if ((b_x1 + BULLET_WIDTH/2) > pos_x2 and (b_x1 - BULLET_WIDTH/2) < (pos_x2 + TANK_WIDTH) and b_y1 > pos_y2) or  
		((b_x1 + BULLET_WIDTH/2) > (pos_x2 + TANK_WIDTH/2 - BARREL_WIDTH/2) and (b_x1 - BULLET_WIDTH/2) < (pos_x2 + TANK_WIDTH/2 + BARREL_WIDTH/2) and b_y1 > (pos_y2 - BARREL_HEIGHT))
		then
			score1 <= score1 + 1;
		elsif ((b_x2 + BULLET_WIDTH/2) > pos_x1 and (b_x2 - BULLET_WIDTH/2) < (pos_x1 + TANK_WIDTH) and b_y2 < pos_y1) or
		((b_x2 + BULLET_WIDTH/2) > (pos_x1 + TANK_WIDTH/2 - BARREL_WIDTH/2) and (b_x2 - BULLET_WIDTH/2) < (pos_x1 + TANK_WIDTH/2 + BARREL_WIDTH/2) and b_y2 < (pos_y1 + TANK_HEIGHT + BARREL_HEIGHT))
		then
			score2 <= score2 + 1;
		else
			score1 <= score1 + 0;
			score2 <= score2 + 0;
		end if;
	end if;
end process;
	
end architecture;