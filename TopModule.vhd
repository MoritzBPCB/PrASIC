----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2024 09:35:13 AM
-- Design Name: 
-- Module Name: TopModule - Behavioral
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


entity Shitty_PacMan is
  Port ( clk : in std_logic;
  btnCpuReset : in std_logic;
  Hsync: out std_logic;
  Vsync: out std_logic; 
  vgaGreen: out std_logic_vector(3 downto 0);
  vgaBlue: out std_logic_vector(3 downto 0);
  vgaRed: out std_logic_vector(3 downto 0);
  btnU: in std_logic;
  btnD: in std_logic;
  btnL: in std_logic;
  btnR: in std_logic;
  btnC: in std_logic
  );
end Shitty_PacMan;

architecture Behavioral of Shitty_PacMan is

----------------------------------------------------------------------------------------------------------------
-- Component Declarations
----------------------------------------------------------------------------------------------------------------

component clk_wiz_0 
Port (clk_out1: out std_logic;
    reset: in std_logic;
    clk_in1: in std_logic);
end component clk_wiz_0;

component VGA
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
    framecnt: out integer range 0 to 2**15 - 1
    );
end component VGA;

component frame
Port (v_cnt : in integer range 1 to 525;
      h_cnt : in integer range 1 to 800;
      color : out std_logic_vector(11 downto 0);
      exists: out boolean;
      level_1: in maze_array
  );
end component frame; 

component PacMan
  Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        pos_h_pacman : in integer range 0 to 640;
        pos_v_pacman : in integer range 0 to 480
  );
end component PacMan;

component ghost
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
end component ghost;

component treat
  Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        raster_pos_h: in integer range 0 to 32;
        raster_pos_v: in integer range 0 to 24
  );
end component treat;


component treat2
   Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        raster_pos_h: in integer range 0 to 32;
        raster_pos_v: in integer range 0 to 24
  );
end component treat2;

component treat3
   Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        raster_pos_h: in integer range 0 to 32;
        raster_pos_v: in integer range 0 to 24
  );
end component treat3;

component treat4
   Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        raster_pos_h: in integer range 0 to 32;
        raster_pos_v: in integer range 0 to 24
  );
end component treat4;

component treat5
   Port (v_cnt : in integer range 1 to 525;
        h_cnt : in integer range 1 to 800;
        color : out std_logic_vector(11 downto 0);
        exists: out boolean;
        raster_pos_h: in integer range 0 to 32;
        raster_pos_v: in integer range 0 to 24
  );
end component treat5;

component Game_ctrl
    Port(
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
end component Game_ctrl;


---------------------------------------------------------------------------------------------
-- Signal Definitions
---------------------------------------------------------------------------------------------

-- display signals
signal pixel25 : std_logic;
signal reset: std_logic;
signal h_cnt_tm: integer range 1 to 800;
signal v_cnt_tm: integer range 1 to 525;
signal f_end_tm: std_logic; 
signal frame_cnt_tm: integer range 0 to 2**15-1;

--color signals
signal color_loser: std_logic_vector(11 downto 0);
signal color_prio: std_logic_vector(11 downto 0);
signal color_frame: std_logic_vector(11 downto 0);
signal color_pm: std_logic_vector(11 downto 0);
signal color_ghost: std_logic_vector(11 downto 0);
signal color_treat: std_logic_vector(11 downto 0);
signal color_treat2: std_logic_vector(11 downto 0);
signal color_treat3: std_logic_vector(11 downto 0);
signal color_treat4: std_logic_vector(11 downto 0);
signal color_treat5: std_logic_vector(11 downto 0);
signal color_win: std_logic_vector(11 downto 0);

-- exists signals
signal exists_pm: boolean;
signal exists_frame: boolean;
signal exists_ghost: boolean;
signal exists_treat: boolean;
signal exists_treat2: boolean;
signal exists_treat3: boolean;
signal exists_treat4: boolean;
signal exists_treat5: boolean;
signal exists_loser: boolean;

-- collision signals
signal col_pm_frame: boolean;
signal col_pm_ghost: boolean;
signal col_pm_treat: boolean;
signal col_pm_treat2: boolean;
signal col_pm_treat3: boolean;
signal col_pm_treat4: boolean;
signal col_pm_treat5: boolean;

--position signals
signal pos_h_pacman: integer range 0 to 640;
signal pos_v_pacman: integer range 0 to 480;
signal treat_pos_h1: integer range 0 to 32;
signal treat_pos_v1: integer range 0 to 24; 
signal treat_pos_h2: integer range 0 to 32;
signal treat_pos_v2: integer range 0 to 24;
signal treat_pos_h3: integer range 0 to 32;
signal treat_pos_v3: integer range 0 to 24; 
signal treat_pos_h4: integer range 0 to 32;
signal treat_pos_v4: integer range 0 to 24; 
signal treat_pos_h5: integer range 0 to 32;
signal treat_pos_v5: integer range 0 to 24; 

--counter signal
signal treat_cnt: integer range 0 to 5; 

--Graphics
signal level_1 : maze_array :=(
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1',
'1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1',
'1','0','1','1','1','1','0','1','1','1','1','1','1','1','0','1','1','1','0','1','1','1','1','0','1','1','1','1','0','1','0','1',
'1','0','1','1','1','1','0','0','0','0','1','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','1','0','1',
'1','0','0','0','0','0','0','1','1','0','1','0','1','1','1','1','0','1','1','1','1','0','1','0','1','1','1','1','0','1','0','1',
'1','0','1','1','1','1','0','1','1','0','1','0','1','1','1','1','0','1','0','0','1','0','1','0','1','0','0','0','0','1','0','1',
'1','0','1','1','1','1','0','1','1','0','1','0','1','1','1','1','0','1','1','0','1','0','1','0','1','0','1','0','1','1','0','1',
'1','0','1','1','1','1','0','1','1','0','0','0','0','0','0','0','0','1','1','0','1','0','0','0','0','0','1','0','0','0','0','1',
'1','0','1','1','1','1','0','0','0','0','0','1','1','1','1','1','0','1','1','0','1','0','1','0','1','0','1','1','1','1','0','1',
'1','0','0','0','0','0','0','1','1','1','0','0','0','1','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','1','0','1',
'1','1','1','1','1','1','1','1','1','1','1','1','0','1','0','1','0','1','1','0','1','0','1','0','1','1','0','1','1','1','1','1',
'1','0','1','0','0','0','0','0','0','1','1','1','0','1','0','1','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','1',
'1','0','1','0','1','1','1','1','0','0','0','0','0','1','0','1','0','1','1','1','1','1','0','1','1','1','0','1','0','1','0','1',
'1','0','1','0','1','1','1','1','0','1','1','1','0','1','0','1','0','1','1','1','1','1','0','1','1','1','0','1','0','1','0','1',
'1','0','0','0','0','0','0','0','0','1','1','1','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','1',
'1','0','1','0','1','1','0','1','0','1','1','1','0','1','0','1','1','1','1','0','1','1','1','1','1','0','1','1','0','1','0','1',
'1','0','1','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','1','0','1',
'1','0','1','0','1','1','0','1','0','1','1','1','1','1','0','1','1','1','0','1','0','1','0','1','1','1','1','1','0','1','1','1',
'1','0','1','0','0','0','0','1','0','0','0','0','0','0','0','1','1','1','0','1','0','1','0','0','0','1','0','0','0','0','0','1',
'1','0','0','0','1','0','1','1','1','1','1','1','0','1','0','0','0','0','0','1','0','1','0','1','0','1','0','1','1','1','0','1',
'1','1','1','0','1','0','1','0','0','0','0','0','0','1','1','1','1','1','0','1','0','1','0','1','0','1','0','1','1','1','0','1',
'1','1','1','0','1','0','1','0','1','1','1','1','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','1','1','1','0','1',
'1','1','1','0','0','0','0','0','1','1','1','1','0','1','0','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1',
'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'
);


signal loose: maze_array := (
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','1','0','1','0','1','1','1','0','1','0','1','0','0','0','1','0','0','0','1','1','1','0','1','1','1','0','1','1','1','0',
'0','0','1','0','1','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','0','0','0','0','1','0','0',
'0','0','1','0','1','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','0','0','0','0','1','0','0',
'0','0','1','1','1','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','1','1','0','0','1','0','0',
'0','0','0','1','0','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','0','0','1','0','0','1','0','0',
'0','0','0','1','0','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','0','0','1','0','0','1','0','0',
'0','0','0','1','0','0','1','1','1','0','1','1','1','0','0','0','1','1','1','0','1','1','1','0','1','1','1','0','0','1','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'
);

signal win: maze_array := (
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','1','0','1','0','1','1','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','0','0','1','0','1','0','0',
'0','0','1','0','1','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','1','0','1','0','1','0','0',
'0','0','1','0','1','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','1','0','1','0','1','0','0',
'0','0','1','1','1','0','1','0','1','0','1','0','1','0','0','0','1','0','0','0','1','0','1','0','1','0','1','1','0','1','0','0',
'0','0','0','1','0','0','1','0','1','0','1','0','1','0','0','0','1','0','1','0','1','0','1','0','1','0','1','1','0','0','0','0',
'0','0','0','1','0','0','1','0','1','0','1','0','1','0','0','0','1','0','1','0','1','0','1','0','1','0','0','1','0','1','0','0',
'0','0','0','1','0','0','1','1','1','0','1','1','1','0','0','0','0','1','0','1','0','0','1','0','1','0','0','1','0','1','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'
);

begin


----------------------------------------------
-- Component Init
------------------------------------------------
pixelClk: clk_wiz_0
    port map(
            clk_out1 => pixel25,
            reset => reset,
            clk_in1 => clk
            );

Controller : Game_ctrl
    port map(
            h_cnt => h_cnt_tm,
            v_cnt => v_cnt_tm,
            col_pm_frame => col_pm_frame,
            col_pm_ghost => col_pm_ghost,
            col_pm_treat => col_pm_treat,
            col_pm_treat2 => col_pm_treat2,
            col_pm_treat3 => col_pm_treat3,
            col_pm_treat4 => col_pm_treat4,
            col_pm_treat5 => col_pm_treat5,
            Frameend => f_end_tm,
            btnU => btnU,
            btnD => btnD,
            btnL => btnL,
            btnR => btnR,
            pixel25 => pixel25,
            reset => reset,
            pos_h_pacman => pos_h_pacman,
            pos_v_pacman => pos_v_pacman,
            pos_h_treat1 => treat_pos_h1,
            pos_v_treat1 => treat_pos_v1,
            pos_h_treat2 => treat_pos_h2,
            pos_v_treat2 => treat_pos_v2,
            pos_h_treat3 => treat_pos_h3,
            pos_v_treat3 => treat_pos_v3,
            pos_h_treat4 => treat_pos_h4,
            pos_v_treat4 => treat_pos_v4,
            pos_h_treat5 => treat_pos_h5,
            pos_v_treat5 => treat_pos_v5,
            exists_looser => exists_loser,
            color => color_loser,
            loose => loose
    );
    
          
object_border: frame
    port map(
            v_cnt => v_cnt_tm,
            h_cnt => h_cnt_tm,
            color => color_frame,
            level_1 => level_1,
        --    fend => f_end_tm,
            exists => exists_frame
        --    pixel25 => pixel25
    );
            
VGA_ports: VGA
    port map(
        Hsync => Hsync,
        Vsync => Vsync,
        vgaGreen => vgaGreen,
        vgaBlue => vgaBlue,
        vgaRed => vgaRed,
        reset => reset,
        color => color_prio,
        pixel25 => pixel25,
        vcnt => v_cnt_tm,
        hcnt => h_cnt_tm,
        fend => f_end_tm,
        framecnt => frame_cnt_tm
        );
        
PM: PacMan
    port map(
        v_cnt => v_cnt_tm,
        h_cnt => h_cnt_tm,
        color => color_pm,
        exists => exists_pm,
        pos_h_pacman => pos_h_pacman,
        pos_v_pacman => pos_v_pacman
    );
    
buh: ghost
    port map(
        v_cnt => v_cnt_tm,
        h_cnt => h_cnt_tm,
        pixel25 => pixel25,
        color => color_ghost,
        fend => f_end_tm,
        exists => exists_ghost,
        reset => reset,
--        framecnt => frame_cnt_tm,
        btnC => btnC,
        level_1 => level_1
    );
 
mhh: treat
  port map(
      v_cnt => v_cnt_tm,
      h_cnt => h_cnt_tm,
      color => color_treat,
      exists => exists_treat,
      raster_pos_h => treat_pos_h1,
      raster_pos_v => treat_pos_v1
   );
   
 mhh2: treat2
  port map(
      v_cnt => v_cnt_tm,
      h_cnt => h_cnt_tm,
      color => color_treat2,
      exists => exists_treat2,
      raster_pos_h => treat_pos_h2,
      raster_pos_v => treat_pos_v2
   );

mhh3: treat3
  port map(
      v_cnt => v_cnt_tm,
      h_cnt => h_cnt_tm,
      color => color_treat3,
      exists => exists_treat3,
      raster_pos_h => treat_pos_h3,
      raster_pos_v => treat_pos_v3
   );
mhh4: treat4
  port map(
      v_cnt => v_cnt_tm,
      h_cnt => h_cnt_tm,
      color => color_treat4,
      exists => exists_treat4,
      raster_pos_h => treat_pos_h4,
      raster_pos_v => treat_pos_v4
   );
mhh5: treat5
  port map(
      v_cnt => v_cnt_tm,
      h_cnt => h_cnt_tm,
      color => color_treat5,
      exists => exists_treat5,
      raster_pos_h => treat_pos_h5,
      raster_pos_v => treat_pos_v5
   );
    
    
    reset <= not btnCpuReset;

prioMux : process (color_frame, color_loser, color_pm, color_treat, color_treat2, color_treat3, color_treat4, color_treat5, color_ghost, color_win, exists_loser, exists_pm, exists_frame, exists_treat, exists_treat2, exists_treat3, exists_treat4, exists_treat5, exists_ghost, treat_cnt)
begin
    if treat_cnt = 5 then
        color_prio <= color_win;
    elsif exists_loser then
        color_prio <= color_loser;
    elsif exists_ghost then
        color_prio <= color_ghost;
    elsif exists_frame then
        color_prio <= color_frame;
    elsif exists_pm then
        color_prio <= color_pm;
    elsif exists_treat then
        color_prio <= color_treat;
    elsif exists_treat2 then
        color_prio <= color_treat2;
    elsif exists_treat3 then
        color_prio <= color_treat3;
    elsif exists_treat4 then
        color_prio <= color_treat4;
    elsif exists_treat5 then
        color_prio <= color_treat5;
    else
        color_prio <= x"000";
    end if;
end process prioMux;



--exists_pm, exists_frame, exists_treat, exists_ghost, f_end_tm)
ctrl : process(pixel25, reset)
begin
    if reset = '1' then
        col_pm_frame <= false;
        col_pm_treat <= false;
        col_pm_treat2 <= false;
        col_pm_treat3 <= false;
        col_pm_treat4 <= false;
        col_pm_treat5 <= false;
        col_pm_ghost <= false;
        treat_cnt <= 0;
    elsif rising_edge(pixel25) then
       if exists_pm and exists_frame then
            col_pm_frame <= true;
       end if;
       if exists_pm and exists_treat then
            col_pm_treat <= true;
            treat_cnt <= treat_cnt + 1;
       end if;
       if exists_pm and exists_treat2 then
            col_pm_treat2 <= true;
            treat_cnt <= treat_cnt + 1;
       end if;
       if exists_pm and exists_treat3 then
            col_pm_treat3 <= true;
            treat_cnt <= treat_cnt + 1;
       end if;
       if exists_pm and exists_treat4 then
            col_pm_treat4 <= true;
            treat_cnt <= treat_cnt + 1;
       end if;
       if exists_pm and exists_treat5 then
            col_pm_treat5 <= true;
            treat_cnt <= treat_cnt + 1;
       end if;
       if exists_ghost and exists_pm then
            col_pm_ghost <= True;
       end if;
       if f_end_tm = '1' then
            col_pm_frame <= false;
            col_pm_treat <= false;
            col_pm_treat2 <= false;
            col_pm_treat3 <= false;
            col_pm_treat4 <= false;
            col_pm_treat5 <= false;
       end if;
    end if;   
     
end process ctrl;


draw : process(h_cnt_tm, v_cnt_tm, win)
begin
    if h_cnt_tm <= 640 and v_cnt_tm <= 480 then
        if win((h_cnt_tm-1)/20 + ((v_cnt_tm-1)/20)*32) = '1' then
            color_win <= x"00F";
        else
            color_win <= x"000";
     end if;
     else 
        color_win <= x"000";
     end if;
end process draw;

end Behavioral;



