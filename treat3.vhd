----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/29/2024 11:59:28 AM
-- Design Name: 
-- Module Name: treat2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.PacMan_data.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity treat3 is
  Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        raster_pos_h: in integer range 0 to 32;
        raster_pos_v: in integer range 0 to 24
  );
end treat3;

architecture Behavioral of treat3 is

signal pos_h : integer range 0 to 640;
signal pos_v : integer range 0 to 480;


    
signal treat : box20 :=(
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'
); 

begin
pos_h <= raster_pos_h * 20;
pos_v <= raster_pos_v * 20;


draw : process(v_cnt, h_cnt, pos_v, pos_h)
    constant length_h: integer := 20;
    constant length_v: integer := 20;

begin
    color <= x"00F";
    
    if v_cnt >= pos_v and v_cnt < pos_v+length_v and h_cnt >= pos_h and h_cnt < pos_h+length_h then
        if treat(h_cnt - pos_h + (v_cnt - pos_v)*20) = '1' then
            exists <= True;
        else
            exists <= False;
        end if;
    else
        exists <= False;
    end if;
end process draw;

end Behavioral;