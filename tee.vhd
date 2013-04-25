---Tee
---===
---
---Create two streams from one.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tee is

  generic(
    BITS : integer
  );
  port(
    CLK         : in  std_logic;
    RST         : in  std_logic;
    
    IN1         : in  std_logic_vector(BITS-1 downto 0);
    IN1_STB     : in  std_logic;
    IN1_ACK     : out std_logic;

    OUT1        : out std_logic_vector(BITS-1 downto 0);
    OUT1_STB    : out std_logic;
    OUT1_ACK    : in  std_logic;

    OUT2        : out std_logic_vector(BITS-1 downto 0);
    OUT2_STB    : out std_logic;
    OUT2_ACK    : in  std_logic
  );

end entity tee;

architecture RTL of tee is

  type STATE_TYPE is (READ, WRITE_1, WRITE_2);
  signal STATE : STATE_TYPE;

begin

  process
  begin
    wait until rising_edge(CLK);
    case STATE is
      when READ =>
        if IN1_STB = '1' then
          OUT1 <= IN1;
          OUT2 <= IN1;
          STATE <= WRITE_1;
        end if;

      when WRITE_1 =>
        if OUT1_ACK = '1' then
          STATE <= WRITE_2;
        end if;

      when WRITE_2 =>
        if OUT2_ACK = '1' then
          STATE <= READ;
        end if;
    end case;
    if RST = '1' then
      STATE <= READ;
    end if;
  end process;

  IN1_ACK  <= '1' when STATE = READ else '0';
  OUT1_STB <= '1' when STATE = WRITE_1 else '0';
  OUT2_STB <= '1' when STATE = WRITE_2 else '0';

end architecture RTL;
