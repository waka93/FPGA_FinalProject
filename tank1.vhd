LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.tank_pos_const.all;

entity tank1 is
port(	clk	  :	in std_logic;
		reset : in std_logic;
		scan_code	: in std_logic_vector(7 downto 0);
		scan_ready  : in std_logic;
		
		pos_x1	: out integer;
		pos_y1  : out integer
	);
end tank1;

architecture structure of tank1 is
type state_type is (reset_tank, go_right, go_left, right1, left1);
signal state      : state_type;
--signal counter    : integer range 0 to 639 := 0;
signal sig_pos_x1 : integer := 0;
signal sig_pos_y1 : integer := 0;

begin
pos_x1 <= sig_pos_x1;
pos_y1 <= sig_pos_y1;

process(clk, reset) is
begin
		
	if(reset = '1') then
		state <= reset_tank;
	elsif(rising_edge(scan_ready)) then
		
	elsif(rising_edge(clk)) then
		case state is
			when reset_tank =>
				sig_pos_x1 <= 0;
				sig_pos_y1 <= 0;
				state <= go_right;
			when go_right =>
				if(sig_pos_x1 = 0 and sig_pos_x1 > 0 and sig_pos_x1 < 559) then
					sig_pos_x1 <= sig_pos_x1 + 1;
					sig_pos_y1 <= 0;
					state <= go_right;
				else
					sig_pos_x1 <= sig_pos_x1 + 0;
					sig_pos_y1 <= 0;
					state <= go_left;
				end if;
			when go_left =>
				if(sig_pos_x1 > 0 and sig_pos_x1 < 559 and sig_pos_x1 = 559) then
					sig_pos_x1 <= sig_pos_x1 - 1;
					sig_pos_y1 <= 0;
					state <= go_left;
				else
				    sig_pos_x1 <= sig_pos_x1 + 0;
					sig_pos_y1 <= 0;
					state <= go_right;
				end if;
		end case;
	end if;
			
end process;
end structure;

