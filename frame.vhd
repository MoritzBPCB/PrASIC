----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2024 02:13:08 PM
-- Design Name: 
-- Module Name: frame - Behavioral
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

entity frame is
  Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        level_1: in maze_array
  );
end frame;

architecture Behavioral of frame is

--signal array_cnt : integer range 0 to 767; 
---------------------------------------------------------------------------------------------------
-- Level drawing array
---------------------------------------------------------------------------------------------------

begin


draw : process (h_cnt, v_cnt, level_1)
begin
    if h_cnt <= 640 and v_cnt <= 480 then
        color <= x"BBB";
        if level_1((h_cnt-1)/20 + ((v_cnt-1)/20)*32) = '1' then
            exists <= True;
        else
            exists <= False;
        end if;
        else
        color <= x"000";
        exists <= False;
     end if;
end process draw;




end Behavioral;
