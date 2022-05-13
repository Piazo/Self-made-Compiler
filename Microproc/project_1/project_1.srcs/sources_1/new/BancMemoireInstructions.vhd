----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 12:11:34
-- Design Name: 
-- Module Name: BancMemoire - Behavioral
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
use IEEE.Numeric_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancMemoire is
    Port ( Adr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Vect_OUT : out STD_LOGIC_VECTOR(31 downto 0));
end BancMemoire;

architecture Behavioral of BancMemoire is

    type tabVal is array(0 to 255) of std_logic_vector(31 downto 0);
    signal Registres: tabVal := (others => (31 downto 0 => '0'));
    
    
begin

process
begin
    wait until rising_edge(CLK);
    Vect_OUT <= Registres(to_integer(unsigned(Adr)));
end process;

end Behavioral;
