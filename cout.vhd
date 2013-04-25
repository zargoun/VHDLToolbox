---Console Output
---==============
---Write a stream of data to the console.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;

entity console_output is

  generic(
    BITS : integer
  );
  port(
    CLK     : in std_logic;
    RST     : in std_logic;
   
    IN1     : in std_logic_vector(BITS-1 downto 0);
    IN1_STB : in std_logic;
    IN1_ACK : out std_logic
  );

end entity console_output;

architecture RTL of console_output is
begin

  process
    variable OUTPUT_LINE : line;
    variable INT  : integer;
  begin
    wait until rising_edge(CLK);

    if IN1_STB = '1' then
      INT := to_integer(signed(IN1));
      write(OUTPUT_LINE, INT);
      writeline(output, OUTPUT_LINE);
    end if;
  end process;
  IN1_ACK <= IN1_STB;

end RTL;
