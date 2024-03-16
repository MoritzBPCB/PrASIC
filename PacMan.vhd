----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 10:56:21 AM
-- Design Name: 
-- Module Name: PacMan - Behavioral
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

entity PacMan is
  Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        pos_h_pacman : in integer range 0 to 640;
        pos_v_pacman : in integer range 0 to 480
  );
end PacMan;
--Laufbahn breite ca. 20 Pixel

architecture Behavioral of PacMan is
    
signal pacman : pm_box :=(
'0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0',
'0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0',
'0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0',
'1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1',
'0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0',
'0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'
);


begin

draw : process(v_cnt, h_cnt, pos_v_pacman, pos_h_pacman)
    constant length_h: integer := 19;
    constant length_v: integer := 19;
begin  
    color <= x"F0F";
    if v_cnt >= pos_v_pacman and v_cnt < pos_v_pacman+length_v and h_cnt >= pos_h_pacman and h_cnt < pos_h_pacman+length_h then
        if pacman(h_cnt - pos_h_pacman + (v_cnt - pos_v_pacman)*19) = '1' then
            exists <= True;
        else
            exists <= False;
        end if;
    else
        exists <= False;
    end if;
end process draw;


end Behavioral;
