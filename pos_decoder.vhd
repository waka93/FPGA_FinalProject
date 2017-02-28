--Decode position(speed) for tank
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- zz
use work.tank_pos_const.all;

entity pos_decoder is
	port(	clk : in std_logic;
		   reset : in std_logic;
			scan_code : in std_logic_vector(7 downto 0);
			scan_ready : in std_logic;
						
			pos_x1 : out integer ;
			pos_y1 : out integer ;
			pos_x2 : out integer ;
			pos_y2 : out integer 
						
	);
end entity;

architecture pos_gen of pos_decoder is


signal sig_pos_x1 : integer :=0;
signal sig_pos_y1 : integer :=0;
signal sig_pos_x2 : integer :=0;
signal sig_pos_y2 : integer :=420;



begin

pos_y1 <= sig_pos_y1;
pos_y2 <= sig_pos_y2;
pos_x1 <= sig_pos_x1;
pos_x2 <= sig_pos_x2;

dcd : process(scan_ready) is
variable temp	: integer :=0;
variable delta1: integer :=1;
variable delta2: integer :=1;

  begin
		if (rising_edge(scan_ready)) then
			case scan_code is 
					when slow1 =>
						delta1 := 1;
					when med1 =>
						delta1 := 3;
					when fast1 =>
						delta1 := 6;
					when right1 => 
						temp := sig_pos_x1;
						sig_pos_x1 <= temp + delta1;
					when left1  => 
						temp := sig_pos_x1;
						sig_pos_x1 <= temp - delta1;
					when others =>
						temp := sig_pos_x1;
						sig_pos_x1 <= temp + 0;
			end case;
		end if;
end process dcd;



end architecture pos_gen;

		

