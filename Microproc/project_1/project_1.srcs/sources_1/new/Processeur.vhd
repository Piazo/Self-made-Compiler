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
signal LC : STD_LOGIC := '0';
signal RST_Proc : STD_LOGIC := '1';
signal MUX_BR : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

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

process
begin
wait until rising_edge(CLK);
memoire_instructions_16: MemInstruct Port Map (
   Adr => IP,
   CLK => CLK,
   Vect_OUT_Instr => FullInstruct
);

--Sortie de la memoire des instructions dans la pipeline LI/DI
OP_LI_DI <=  FullInstruct(31 downto 24);
A_LI_DI <= FullInstruct(24 downto 16);
B_LI_DI <= FullInstruct(15 downto 8);
C_LI_DI <= FullInstruct(7 downto 0);

--Pipeline DI/EX
A_DI_EX <= A_LI_DI;
if (OP_LI_DI = X"06") then
    B_DI_EX <= B_LI_DI; --cas ou on ne passe pas dans le multiplexeur (AFC)
end if;
C_DI_EX <= C_LI_DI;
OP_DI_EX <= OP_LI_DI;

--Pipeline EX/Mem
A_EX_Mem <= A_DI_EX;
if (OP_LI_DI = X"06" or OP_LI_DI = X"05") then
    B_EX_Mem <= B_DI_EX; --cas ou on ne passe pas dans le multiplexeur (AFC, COP)
end if;
OP_EX_Mem <= OP_DI_EX;

--Pipeline Mem/RE
A_Mem_RE <= A_EX_Mem;
if (OP_LI_DI /= X"07" and OP_LI_DI /= X"08") then
    B_Mem_RE <= B_EX_Mem; --cas ou on ne passe pas dans le multiplexeur (AFC, COP, ADD, MUL, DIV, SOU)
end if;
OP_Mem_RE <= OP_EX_Mem;

if (OP_Mem_RE = X"07" or OP_Mem_RE = X"08") then 
    LC <= '0'; --cas ou on n'a pas besoin d'écrire (LDR et STR)
else 
    LC <='1';
end if;


MUX_BR <= B_LI_DI when OP_LI_DI = X"06";


banc_registre : BancRegistre Port Map (
    A => B_LI_DI (3 downto 0),
    B => C_LI_DI (3 downto 0),
    addrW => A_LI_DI (3 downto 0),
    W => LC,
    DATA => B_MEM_RE,
    RST => RST_Proc,
    CLK => CLK,
    QA => MUX_BR,
    QB => C_DI_EX
);

end process;

end Behavioral;















