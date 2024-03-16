----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 11:07:34 AM
-- Design Name: 
-- Module Name: Game_ctrl - Behavioral
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

entity Game_ctrl is
  Port ( 
        v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        col_pm_frame: in boolean;
        col_pm_ghost: in boolean;
        col_pm_treat: in boolean;
        col_pm_treat2: in boolean;
        col_pm_treat3: in boolean;
        col_pm_treat4: in boolean;
        col_pm_treat5: in boolean;
        btnU: in std_logic;
        btnD: in std_logic;
        btnL: in std_logic;
        btnR: in std_logic;
        Frameend: in std_logic;
        pixel25:in std_logic;
        reset: in std_logic;
        pos_h_pacman : out integer range 0 to 640;
        pos_v_pacman : out integer range 0 to 480;
        pos_h_treat1: out integer range 0 to 32;
        pos_v_treat1 : out integer range 0 to 24;
        pos_h_treat2: out integer range 0 to 32;
        pos_v_treat2 : out integer range 0 to 24;
        pos_h_treat3: out integer range 0 to 32;
        pos_v_treat3 : out integer range 0 to 24;
        pos_h_treat4: out integer range 0 to 32;
        pos_v_treat4 : out integer range 0 to 24;
        pos_h_treat5: out integer range 0 to 32;
        pos_v_treat5 : out integer range 0 to 24;
        loose: in maze_array;
        exists_looser: out boolean;
        color: out std_logic_vector(11 downto 0)
        
  );
end Game_ctrl;

architecture Behavioral of Game_ctrl is
signal pos_h_pm : integer range 0 to  640;
signal pos_v_pm: integer range 0 to 480;
signal prev_dir: integer range 0 to 3;
--signal exists_loser: boolean;



begin
pos_h_pacman <= pos_h_pm;
pos_v_pacman <= pos_v_pm;
move_pm : process(pixel25, reset)
    constant length_h: integer := 20;
    constant length_v: integer := 20;
    constant  step : integer := 1;

begin
     if reset = '1' then
        pos_h_pm <= 320;   
        pos_v_pm <= 240;
        pos_h_treat1 <= 1;
        pos_v_treat1 <= 3;
        pos_h_treat2 <= 30;
        pos_v_treat2 <= 5;--9
        pos_h_treat3 <= 18;
        pos_v_treat3 <= 5;
        pos_h_treat4 <= 12;
        pos_v_treat4 <= 22;
        pos_h_treat5 <= 30;
        pos_v_treat5 <= 16;
        exists_looser <= false;
     elsif rising_edge(pixel25) then
        if Frameend = '1' then
            if col_pm_treat then
                pos_h_treat1 <= 0;
                pos_v_treat1 <= 0;
            end if;
            if col_pm_treat2 then
                pos_h_treat2 <= 0;
                pos_v_treat2 <= 0;
            end if;
            if col_pm_treat3 then
                pos_h_treat3 <= 0;
                pos_v_treat3 <= 0;
            end if;
            if col_pm_treat4 then
                pos_h_treat4 <= 0;
                pos_v_treat4 <= 0;
            end if;
            if col_pm_treat5 then
                pos_h_treat5 <= 0;
                pos_v_treat5 <= 0;
            end if;
            if col_pm_ghost then
                exists_looser <= true;
            end if;
            if col_pm_frame then
                case prev_dir is
                when 0 =>
                    pos_v_pm <= pos_v_pm - step;
                when 1 =>
                    pos_v_pm <= pos_v_pm + step;
                when 2 =>
                    pos_h_pm <= pos_h_pm - step;
                when 3 =>
                    pos_h_pm <= pos_h_pm + step;
                end case;
            else
                if pos_h_pm < 640 - length_h and pos_v_pm < 480 - length_v then
                    if btnD = '1' then
                        pos_v_pm <= pos_v_pm + step;
                        prev_dir <= 0;
                    elsif btnU = '1' then
                        pos_v_pm <= pos_v_pm - step;
                        prev_dir <= 1;
                    elsif btnR = '1' then
                        pos_h_pm <= pos_h_pm + step;
                        prev_dir <= 2;
                    elsif btnL = '1' then
                        pos_h_pm <= pos_h_pm - step;
                        prev_dir <= 3;
                    end if;
                 else 
                    pos_h_pm <= 320;
                    pos_v_pm <= 240;
                 end if;
            end if;
        end if;
    end if;
end process move_pm;

draw : process(h_cnt, v_cnt, loose)
begin
    if h_cnt <= 640 and v_cnt <= 480 then
        if loose((h_cnt-1)/20 + ((v_cnt-1)/20)*32) = '1' then
            color <= x"F00";
        else
            color <= x"000";
     end if;
     else 
        color <= x"000";
     end if;
end process draw;


end Behavioral;
