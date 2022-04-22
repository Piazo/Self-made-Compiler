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
USE ieee.std_logic_unsigned.all;
USE ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancMemoire is
    Port ( Adr : in STD_LOGIC_VECTOR (7 downto 0);
           Input : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end BancMemoire;

architecture Behavioral of BancMemoire is

    Type RegisterArray is Array(15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    signal Memory : RegisterArray;
    
begin

    process
        
    begin
    
        wait until CLK'Event and CLK = '1';
        if RST = '1' then
            Memory <= (others => X"00");
        elsif RW = '0' then
            Memory(to_integer(unsigned(Adr))) <= Input;
        else 
            Output <= Memory(to_integer(unsigned(Adr)));
        end if;
        
    end process;
    
end Behavioral;