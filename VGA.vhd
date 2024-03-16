----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2024 09:36:33 AM
-- Design Name: 
-- Module Name: VGA - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
  Port (
    pixel25: in std_logic;
    Hsync: out std_logic;
    Vsync: out std_logic; 
    vgaGreen: out std_logic_vector(3 downto 0);
    vgaBlue: out std_logic_vector(3 downto 0);
    vgaRed: out std_logic_vector(3 downto 0);
    reset : in std_logic;
    color: in std_logic_vector(11 downto 0);
    hcnt: out integer range 1 to 800;
    vcnt: out integer range 1 to 525;
    fend: out std_logic;
    framecnt: out integer range 0 to 2**15-1
    );
end VGA;

architecture Behavioral of VGA is
-- signals
--signal h_blank: std_logic := '0';
--signal v_blank: std_logic := '0';

constant fmax: integer := 2**15 -1;

signal h_cnt: integer range 1 to 800;
signal v_cnt: integer range 1 to 525;
signal frame_cnt: integer range 0 to fmax;

begin

hcnt <= h_cnt;
vcnt <= v_cnt;
framecnt <= frame_cnt;

clocked : process(reset, pixel25)

begin
if reset = '1' then
   h_cnt <= 1; 
   v_cnt <= 1;
   fend <= '0';
elsif rising_edge(pixel25) then
    fend <= '0';
    if h_cnt < 800 then 
      h_cnt <= h_cnt + 1;
    else 
      h_cnt <= 1;
      if v_cnt < 525 then 
        v_cnt <= v_cnt + 1;
      else 
        v_cnt <= 1;
        fend <= '1';
        if frame_cnt < fmax then
           frame_cnt <= frame_cnt + 1;
        else
          frame_cnt <= 0;
        end if;
      end if;
    end if;
 end if;
end process clocked;

sync: process(h_cnt, v_cnt, color)

begin
    if h_cnt >= 657 and h_cnt < 753 then
        Hsync <= '0';
    else
        Hsync <= '1';
    end if;
    
    if v_cnt >= 491 and v_cnt < 493 then
        Vsync <= '0';
    else
        Vsync <= '1';
    end if;
       
    if h_cnt <= 640 and v_cnt <= 480 then
        vgaGreen <= color(3 downto 0);
        vgaBlue <= color(7 downto 4);
        vgaRed <= color(11 downto 8);
    else
        vgaGreen <= x"0";
        vgaRed <= x"0";
        vgaBlue <= x"0";
    end if;
    
end process sync;

end Behavioral;
