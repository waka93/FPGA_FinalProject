library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.graphic_const.all;


entity frameGenerator is 
port(
	clk,rst						: in clk;
	pos_x1,pos_y1,pos_x2,pos_y2	: in integer;
	b_x1,b_y1,b_x2,b_y2			: in integer;
	pixel_row,pixel_column		: in std_logic_vector(9 downto 0);
	frame						: out VGA_ARRAY
);

architecture behavioral of frameGenerator is

-- constant color_red 	 	 : std_logic_vector(2 downto 0) := "000";
-- constant color_green	 : std_logic_vector(2 downto 0) := "001";
-- constant color_blue 	 : std_logic_vector(2 downto 0) := "010";
-- constant color_yellow 	 : std_logic_vector(2 downto 0) := "011";
-- constant color_magenta 	 : std_logic_vector(2 downto 0) := "100";
-- constant color_cyan 	 : std_logic_vector(2 downto 0) := "101";
-- constant color_black 	 : std_logic_vector(2 downto 0) := "110";
-- constant color_white	 : std_logic_vector(2 downto 0) := "111";

signal pixel_column_int,pixel_row_int : natural;

begin

pixel_column_int <= to_integer(unsigned(pixel_column));
pixel_row_int <= to_integer(unsigned(pixel_row));

reset:process(rst)
begin
	if(rising_edge(rst) then
		frame <= others(=> "000");
		frame((319-TANK_WIDTH/2) to (319+TANK_WIDTH/2),0 to (TANK_HEIGHT)) <= "001";
		frame((319-TANK_WIDTH/2) to (319+TANK_WIDTH/2),(479-TANK_HEIGHT) to 479) <= "010";
	end if;
end process;

framegenerate:process(clk,pixel_column_int,pixel_row_int,pos_x1,pos_x2,pos_y1,pos_y2)
begin
	if (rising_edge(clk)) then
		if(pixel_column_int > pos_x1  and pixel_column_int < (pos_x1 + TANK_WIDTH) and 
				pixel_row_int < pos_y1 + TANK_HEIGHT) then
				frame(pixel_column_int,pixel_row_int) <= "001";
		elsif(pixel_column_int > pos_x2 and pixel_column_int < (pos_x2 + TANK_WIDTH) and 
				pixel_row_int > pos_y2) then
				frame(pixel_column_int,pixel_row_int) <= "010";
		else
			frame(pixel_column_int,pixel_row_int) <= "000";
		end if;
	end if;
end process;

end architecture;