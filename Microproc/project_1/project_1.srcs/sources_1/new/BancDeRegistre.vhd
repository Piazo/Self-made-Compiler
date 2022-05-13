----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 10:07:47
-- Design Name: 
-- Module Name: BancDeRegistre - Behavioral
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

entity BancDeRegistre is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           addrW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end BancDeRegistre;

architecture Behavioral of BancDeRegistre is

    type tabVal is array(0 to 15) of std_logic_vector(7 downto 0);
    signal Registres: tabVal;

begin

process
begin
    wait until rising_edge(CLK);
    -- on ecrit la valeur de DATA dans Registres a l'adresse addrW
    if ( W = '1') then 
        Registres(to_integer(unsigned(addrW))) <= DATA;
    end if;
    --On fait le reset
    if ( RST = '0') then
        Registres(0 to 15) <= (others => X"00");
    end if;
end process;

    QA <= DATA when (A = addrW and rising_edge(CLK) and W='1') else Registres(to_integer(unsigned(A)));
    QB <= DATA when (B = addrW and rising_edge(CLK) and W='1') else Registres(to_integer(unsigned(B)));

end Behavioral;
