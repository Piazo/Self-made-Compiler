----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 11:33:45
-- Design Name: 
-- Module Name: test_UAL - Behavioral
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

entity test_UAL is
end test_UAL;

architecture Behavioral of test_UAL is


COMPONENT UAL
    Port ( N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (15 downto 0);
           A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0));
end COMPONENT;

--INPUTS
signal testa : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal testb : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal testCtrlAlu : STD_LOGIC_VECTOR (1 downto 0) := "00";

--OUTPUTS
signal testn : STD_LOGIC;
signal testo : STD_LOGIC;
signal testz : STD_LOGIC;
signal testc : STD_LOGIC;
signal tests : STD_LOGIC_VECTOR(15 downto 0);


begin
Label_uut : UAL PORT MAP(
    A => testa,
    B => testb,
    Ctrl_Alu => testCtrlAlu,
    N => testn,
    O => testo,
    Z => testz,
    C => testc,
    S => tests);
    
testa <= X"0001";
testb <= X"0005";
testCtrlAlu <= "00";


end Behavioral;
