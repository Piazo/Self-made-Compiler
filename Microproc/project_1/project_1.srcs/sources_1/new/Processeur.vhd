----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 10:11:12
-- Design Name: 
-- Module Name: Processeur - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UAL;
library BancMemoireDonnees;
library BancMemoireInstructions;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processeur is
   -- Port ()
end Processeur;

architecture Behavioral of Processeur is

signal CLK : STD_LOGIC := '0';
constant clock_period : TIME := 10 ns;
signal IP : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal FullInstruct : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

    component MemInstruct 
        port(   Adr : in STD_LOGIC_VECTOR (7 downto 0);
                CLK : in STD_LOGIC;
                Vect_OUT_Instr : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

--signaux pour la pipeline LI/DI
signal A_LI_DI: STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal OP_LI_DI: STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal B_LI_DI: STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal C_LI_DI: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    component BancRegistre
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               addrW : in STD_LOGIC_VECTOR (3 downto 0);
               W : in STD_LOGIC;
               DATA : in STD_LOGIC_VECTOR (7 downto 0);
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (7 downto 0);
               QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

--signaux pour la pipeline DI/EX
signal A_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal OP_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal B_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal C_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    component UAL
        port (N : out STD_LOGIC;
               O : out STD_LOGIC;
               Z : out STD_LOGIC;
               C : out STD_LOGIC;
               S : out STD_LOGIC_VECTOR (7 downto 0);
               A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
--signaux pour la pipeline EX/Mem
signal A_EX_Mem : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal OP_EX_Mem : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal B_EX_Mem : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    component MemDonneesInstructionComplete
        Port (  Adr : in STD_LOGIC_VECTOR (7 downto 0);
                Vect_IN : in STD_LOGIC_VECTOR (7 downto 0);
                RW : in STD_LOGIC;
                RST : in STD_LOGIC;
                CLK : in STD_LOGIC;
                Vect_OUT_Data : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
--signaux pour la pipeline Mem/RE
signal A_Mem_RE : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal OP_Mem_RE : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); 
signal B_Mem_RE : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    

begin

process
begin
    wait for clock_period/2;
    CLK <= not(CLK);
end process;

process
begin
    wait until rising_edge(CLK);
    IP <= IP + 1;
end process;

memoire_instructions_16: MemInstruct Port Map (
   Adr => IP,
   CLK => CLK,
   Vect_OUT_Instr => FullInstruct
);

OP_DI_EX <=  FullInstruct(31 downto 24);
A_DI_EX <= FullInstruct(24 downto 16);
B_DI_EX <= FullInstruct(15 downto 8);
C_DI_EX <= FullInstruct(7 downto 0);

    
end Behavioral;















