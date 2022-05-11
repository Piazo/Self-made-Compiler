----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 10:12:35
-- Design Name: 
-- Module Name: UAL - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0));
end UAL;

architecture Behavioral of UAL is

    signal Aux : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
        
begin

    Aux <= (( X"00"&A) + ( X"00"&B)) when Ctrl_Alu = "00" else
           (( X"00"&A) - ( X"00"&B)) when Ctrl_Alu = "01" else 
           A * B when Ctrl_Alu = "10" else
           X"0000";
           
    
    N <= '1' when (Ctrl_Alu = "01" and (A < B)) else '0';
    O <= '1' when (Ctrl_Alu = "10" and Aux > X"00FF") else '0';
    Z <= '1' when (Aux = X"0000") else '0';
    C <= '1' when (Ctrl_Alu = "00" and Aux > X"00FF") else '0';
    S <= Aux(7 downto 0);
end Behavioral;
