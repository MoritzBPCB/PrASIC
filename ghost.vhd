----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 02:36:49 PM
-- Design Name: 
-- Module Name: ghost - Behavioral
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
use IEEE.numeric_std.ALL;

use work.PacMan_data.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ghost is
  Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        pixel25: in std_logic;
        color : out std_logic_vector(11 downto 0);
        fend: in std_logic;
--        framecnt: in integer range 0 to 2**15-1;
        exists: out boolean;
        reset: in std_logic;
        btnC: in std_logic;
        level_1: in maze_array
  );
end ghost;

architecture Behavioral of ghost is

    signal pos_h : integer range 0 to  640;
    signal pos_v: integer range 0 to 480;
    signal left: boolean;
    signal right: boolean;
    signal up: boolean;
    signal down: boolean;
    signal current_dir: integer range 0 to 3; 
    signal randbit: bit_vector(11 downto 0);  
    
-- graphic bit map
type maze_array is 
    array (0 to 399) of std_logic;
    
signal ghost : maze_array :=(
'0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0',
'0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0',
'0','0','1','1','1','1','1','0','1','1','1','0','1','1','1','1','1','0','0','0',
'0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0',
'0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0',
'0','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','0','0',
'0','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','0','0',
'1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'
); 
    
begin
move : process(pixel25, reset, btnC)
    constant length_h: integer := 20;
    constant length_v: integer := 20;
    constant  step : integer := 1;

begin
     if reset = '1' or btnC = '1' then
        current_dir <= 2;
        pos_h <= 3*20+1;   
        pos_v <= 21;
        randbit <= x"555";
     elsif rising_edge(pixel25) then
        if fend = '1' then
            randbit <= randbit sll 1; 
            randbit(0) <= randbit(11) xnor randbit(10) xnor randbit(9) xnor randbit(4);
        -- check umliegende Felder
            if level_1(((pos_h-1)/20 + ((pos_v)/20) * 32)) = '0' and level_1(((pos_h-1)/20 + ((pos_v+19)/20) * 32)) = '0' then
                left <= true;
            else
                left <= false;
            end if;
            if level_1((pos_h/20 + ((pos_v-1)/20) * 32)) = '0' and level_1(((pos_h+19)/20 + ((pos_v-1)/20) * 32)) = '0' then
                up <= true;
            else 
                up <= false;
            end if;
            if level_1(((pos_h+20)/20 + (pos_v/20) * 32)) = '0' and level_1(((pos_h+20)/20 + ((pos_v+19)/20) * 32)) = '0' then
                right <= true;
            else
                right <= false;
            end if;
            if level_1((pos_h/20 + ((pos_v-1)/20+1) * 32)) = '0' and level_1(((pos_h+19)/20 + ((pos_v-1)/20+1) * 32)) = '0' then
                down <= true;
            else
                down <= false;
            end if;
            --- eine weitere Richtung möglich
            if right and current_dir /= 3 and not(up and down)then
                current_dir <= 2;
            elsif left and current_dir /= 2 and not (up and down) then
                current_dir <= 3;
            elsif   up  and current_dir /= 1 and not (right and left) then
                current_dir <= 0;
            elsif down and current_dir /= 0  and not (right and left) then
                current_dir <= 1;
            -- zwei weitere Richtungen möglich
            elsif left and right and (up xor down) then
                if randbit(11) = '1' then
                    current_dir <= 3;
                else
                    current_dir <= 2;
                end if;
            elsif left and up and (right xor down) then
                 if randbit(11) = '1' then
                    current_dir <= 3;
                else
                    current_dir <= 0;
                end if;
            elsif left and down and (right xor up) then
                 if randbit(11) = '1' then
                    current_dir <= 3;
                else
                    current_dir <= 1;
                end if;            
            elsif right and up and (left xor down) then
                 if randbit(11) = '1' then
                    current_dir <= 2;
                else
                    current_dir <= 0;
                end if;
            elsif right and down and (left xor up) then
                 if randbit(11) = '1' then
                    current_dir <= 2;
                else
                    current_dir <= 1;
                end if;
            elsif up and down and (left xor right) then
                if randbit(11) = '1' then
                    current_dir <= 0;
                else
                    current_dir <= 1;
                end if;
            --- drei weitere Richtungen möglich
            elsif left and right and up and down then
                current_dir <=  (1 + current_dir + to_integer(unsigned(to_stdlogicvector(randbit(10 downto 9))))) mod 4;
            -- Sackgasse geh zurück
            else 
                case current_dir is
                when 0 =>
                    current_dir <= 1;
                when 1 =>
                    current_dir <= 0;
                when 2 =>
                    current_dir <= 3;
                when 3 =>
                    current_dir <= 2;
                end case;
            end if;
            
            if pos_h < 640 - length_h and pos_v < 480 - length_v then
                if current_dir = 0 then
                    pos_v <= pos_v - step;
                 elsif current_dir = 1 then
                    pos_v <= pos_v + step;
                  elsif current_dir = 2 then
                    pos_h <= pos_h + step;
                  elsif current_dir = 3 then
                     pos_h <= pos_h - step;
                  end if;
            else 
                pos_h <= 21;
                pos_v <= 21;
            end if;
        end if;
    end if;
end process move;

draw : process(v_cnt, h_cnt, pos_v, pos_h)
    constant length_h: integer := 20;
    constant length_v: integer := 20;
begin
--    if framecnt mod 600 < 300 then
--        color <= x"F00";
--    else
--        color <= x"00F";
--    end if;
    color<= x"FF5";
    
    if v_cnt >= pos_v and v_cnt < pos_v+length_v and h_cnt >= pos_h and h_cnt < pos_h+length_h then
        if ghost(h_cnt - pos_h + (v_cnt - pos_v)*20) = '1' then
            exists <= True;
        else
            exists <= False;
        end if;
    else
        exists <= False;
    end if;
end process draw;


end Behavioral;
