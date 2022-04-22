
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 10:57:10
-- Design Name: 
-- Module Name: test_BancDeRegistre - Behavioral
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

entity test_BancDeRegistre is
end test_BancDeRegistre;

architecture Behavioral of test_BancDeRegistre is

COMPONENT BancDeRegistre is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           addrW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

--INPUTS
signal tA : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal tB : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal taddrW : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal tDATA : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal tW : STD_LOGIC := '1';
signal tRST : STD_LOGIC := '1';
signal tCLK : STD_LOGIC := '0';
constant CLK_Period: TIME := 10 ns;


--OUTPUTS
signal tQA : STD_LOGIC_VECTOR (7 downto 0);
signal tQB : STD_LOGIC_VECTOR (7 downto 0);


begin

process
begin
    tCLK <= not(tCLK);
    wait for (CLK_period/2);
end process;

Label_uut : BancDeRegistre PORT MAP(
    A => tA,
    B => tB,
    addrW => taddrW,
    DATA => tDATA,
    W => tW,
    RST => tRST,
    CLK => tCLK,
    QA => tQA,
    QB => tQB);
    

tB <= X"8";
taddrW <= X"2";
tDATA <= X"4F";
tA <= X"2";

end Behavioral;