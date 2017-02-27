--Decode position(speed) for tank
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

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

begin
process(reset, clk, scan_ready)
variable delta1 : integer :=0;
variable delta2 : integer :=0;
variable sig_pos_x1 : integer :=0;
variable sig_pos_y1 : integer :=0;
variable sig_pos_x2 : integer :=0;
variable sig_pos_y2 : integer :=0;

begin
	pos_x1 <=0;	
	pos_x2 <=0;
	if (rising_edge(clk)) then
		if (rising_edge(scan_ready)) then
			if (reset = '1') then
			sig_pos_x1 := 0;
			sig_pos_y1 := 0;
			sig_pos_x2 := 0;
			sig_pos_y2 := 480;
			
			else
				case scan_code is --speed decoder
					when slow1 =>  --tank1 slow 1
						delta1 := 1;
					when med1 =>  --med 2
						delta1 := 50;
					when fast1 =>  --fast 3
						delta1 := 100;					
					when slow2 => --tank2 slow 7
						delta2 := 1;
					when med2 =>  -- med 8
						delta2 := 50;
					when fast2 =>  --fast 9
						delta2 := 100;
					when others =>
						delta1 := 1;
						delta2 := 1;
				end case;
				case scan_code is -- position decoder
					when right1 => --tank1 right d
						sig_pos_x1 := sig_pos_x1 + delta1;
					when left1 =>--left a
						sig_pos_x1 := sig_pos_x1 - delta1;
					when right2 =>
						sig_pos_x2 := sig_pos_x2 + delta2;
					when left2 =>
						sig_pos_x2 := sig_pos_x2 - delta2;
					when others =>
						sig_pos_x1 := sig_pos_x1 + 0;
						sig_pos_x2 := sig_pos_x2 + 0;
				end case;
				pos_x1 <= sig_pos_x1;
				pos_x2 <= sig_pos_x2;
			end if;
		-- else		
			-- pos_x1 <= 0;
			-- pos_y1 <= 0;
			-- pos_x2 <= 0;
			-- pos_y2 <= 0;
		end if;
	end if;
end process;
end pos_gen;

		

