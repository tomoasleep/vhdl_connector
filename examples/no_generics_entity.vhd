library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (
    a, b    : in  std_logic_vector(31 downto 0);
    control : in  std_logic_vector(2 downto 0);
    output  : out std_logic_vector(31 downto 0);
    zero    : out std_logic);
end alu;

architecture behave of alu is
begin
end behave;
