LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity game_top is 
	port( reset : in std_logic;
			
			--keyboard clock
			keyboard_clk, keyboard_data, clock_50MHz : in std_logic;
			--VGA clock
			--CLOCK_50 --RESET_N	: in std_logic;
	
			--VGA output
			VGA_RED, VGA_GREEN, VGA_BLUE 					   : out std_logic_vector(9 downto 0); 
			HORIZ_SYNC, VERT_SYNC, VGA_BLANK, VGA_CLK		: out std_logic;
			--LED output
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0);
			HEX4 : out std_logic_vector(6 downto 0);
			HEX5 : out std_logic_vector(6 downto 0);
			HEX6 : out std_logic_vector(6 downto 0);
			HEX7 : out std_logic_vector(6 downto 0)
			);
end entity game_top;

architecture structural of game_top is

-- keyboard->pos_docoder signal
signal scan_code  : std_logic_vector(7 downto 0);
signal scan_ready : std_logic;
signal hist3 : std_logic_vector(7 downto 0);
signal hist2 : std_logic_vector(7 downto 0);
signal hist1 : std_logic_vector(7 downto 0);
signal hist0 : std_logic_vector(7 downto 0);
-- pos_docoder->VGA_top signal
signal pos_x1: integer;
signal pos_y1: integer;
signal pos_x2: integer;
signal pos_y2: integer;


component ps2 is
	port( 	
			keyboard_clk, keyboard_data, clock_50MHz ,
			reset : in std_logic;--, read : in std_logic;
			
			scan_code : out std_logic_vector( 7 downto 0 );
			scan_readyo : out std_logic;
			
			hist3 : out std_logic_vector(7 downto 0);
			hist2 : out std_logic_vector(7 downto 0);
			hist1 : out std_logic_vector(7 downto 0);
			hist0 : out std_logic_vector(7 downto 0);
			
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0);
			HEX4 : out std_logic_vector(6 downto 0);
			HEX5 : out std_logic_vector(6 downto 0);
			HEX6 : out std_logic_vector(6 downto 0);
			HEX7 : out std_logic_vector(6 downto 0)		
		);
end component ps2;

component pos_decoder is 
	port(	clk : in std_logic;
		   reset : in std_logic;
			scan_code : in std_logic_vector(7 downto 0);
			scan_ready : in std_logic;
						
			pos_x1 : out integer ;
			pos_y1 : out integer ;
			pos_x2 : out integer ;
			pos_y2 : out integer 
						
	);
end component pos_decoder;

component VGA_top_level is
	port(
			CLOCK_50 										: in std_logic;
			RESET_N											: in std_logic;
			pos_x1,pos_y1,pos_x2,pos_y2				: in integer;
			--VGA 
			VGA_RED, VGA_GREEN, VGA_BLUE 					: out std_logic_vector(9 downto 0); 
			HORIZ_SYNC, VERT_SYNC, VGA_BLANK, VGA_CLK	: out std_logic

		);
end component VGA_top_level;





begin

p1: ps2 port map (	
				keyboard_clk => keyboard_clk,
				keyboard_data => keyboard_data,
				clock_50MHz => clock_50MHz,
				reset => reset,
				
				scan_code => scan_code,
				scan_readyo => scan_ready,
				
				hist3 => hist3,
				hist2 => hist2,
				hist1 => hist1,
				hist0 => hist0,
				
				HEX0 => HEX0,
				HEX1 => HEX1,
				HEX2 => HEX2,
				HEX3 => HEX3,
				HEX4 => HEX4,
				HEX5 => HEX5,
				HEX6 => HEX6,
				HEX7 => HEX7
			);
			
p2: pos_decoder port map (
			clk =>clock_50MHz,
		   reset => reset,
			scan_code => scan_code,
			scan_ready => scan_ready,
						
			pos_x1 => pos_x1,
			pos_y1 => pos_y1,
			pos_x2 => pos_x2,
			pos_y2 => pos_y2 

			);

p3: VGA_top_level port map (
				CLOCK_50 => clock_50MHz,
				RESET_N =>reset ,
				pos_x1 => pos_x1,
				pos_y1 => pos_y1,
				pos_x2 => pos_x2,
				pos_y2 => pos_y2,
				VGA_RED => VGA_RED, 
				VGA_GREEN => VGA_GREEN, 
				VGA_BLUE => VGA_BLUE,
				HORIZ_SYNC => HORIZ_SYNC, 
				VERT_SYNC => VERT_SYNC, 
				VGA_BLANK => VGA_BLANK, 
				VGA_CLK => VGA_CLK
			);	

end architecture structural;


			