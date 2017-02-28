library ieee;
use ieee.std_logic_1164.all;

package tank_pos_const is

   constant slow1  : std_logic_vector := "00010110";--1
	constant med1   : std_logic_vector := "00011110";--2
	constant fast1  : std_logic_vector := "00100110";--3
	constant right1 : std_logic_vector := "00100011";--d
	constant left1  : std_logic_vector := "00011100";--a
	
	constant slow2  : std_logic_vector := "01101100";--7
	constant med2   : std_logic_vector := "01110101";--8
	constant fast2  : std_logic_vector := "01111101";--9
	constant right2 : std_logic_vector := "01111010";--3
	constant left2  : std_logic_vector := "01101001";--1
	
	
end package tank_pos_const;