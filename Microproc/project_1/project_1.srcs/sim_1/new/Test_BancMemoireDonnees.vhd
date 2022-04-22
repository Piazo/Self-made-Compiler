----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 10:30:29
-- Design Name: 
-- Module Name: Test_BancMemoireDonnees - Behavioral
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

entity Test_BancMemoireDonnees is
end Test_BancMemoireDonnees;

architecture Behavioral of Test_BancMemoireDonnees is

COMPONENT BancMemoireDonnees
    Port ( Adr : in STD_LOGIC_VECTOR (7 downto 0);
          Vect_IN : in STD_LOGIC_VECTOR (7 downto 0);
          RW : in STD_LOGIC;
          RST : in STD_LOGIC;
          CLK : in STD_LOGIC;
          Vect_OUT : out STD_LOGIC_VECTOR(7 downto 0));
end COMPONENT;

--INPUTS
signal testAdr : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testIn : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal testRW : STD_LOGIC := '0';
signal testRST : STD_LOGIC := '0';
signal testCLK : STD_LOGIC := '0';
constant CLK_Period: TIME := 10 ns;

--OUTPUTS
signal testOUT : STD_LOGIC_VECTOR (7 downto 0);

begin

process
begin
    testCLK <= not(testCLK);
    wait for (CLK_period/2);
end process;

Label_uut : BancMemoireDonnees PORT MAP(
    Adr => testAdr,
    Vect_IN => testIN,
    RW => testRW,
    RST => testRST,
    CLK => testCLK,
    Vect_OUT => testOUT);

testRW <= '0';
testIN <= X"08";
testAdr <= X"02";
testRST <= '1';

end Behavioral;
