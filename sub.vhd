---Subtractor
---==========
---
---Produces a stream of data *out1* by subtracting *in2* from *in1* item by item.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor is

  generic(
    BITS : integer
  );
  port(
    CLK         : in  std_logic;
    RST         : in  std_logic;
    
    IN1         : in  std_logic_vector(BITS-1 downto 0);
    IN1_STB     : in  std_logic;
    IN1_ACK     : out std_logic;

    IN2         : in  std_logic_vector(BITS-1 downto 0);
    IN2_STB     : in  std_logic;
    IN2_ACK     : out std_logic;

    OUT1        : out std_logic_vector(BITS-1 downto 0);
    OUT1_STB    : out std_logic;
    OUT1_ACK    : in  std_logic
  );

end entity subtractor;

architecture RTL of subtractor is

  type STATE_TYPE is (READ_A_B, WRITE_Z);
  signal STATE      : STATE_TYPE;

begin

  process
  begin
    wait until rising_edge(CLK);
      case STATE is

        when READ_A_B =>
          if IN1_STB = '1' and IN1_STB = '1' then
            IN1_ACK <= '1';
            IN2_ACK <= '1';
            OUT1_STB <= '1';
            OUT1 <= std_logic_vector(signed(IN1) - signed(IN2));
            STATE <= WRITE_Z;
          end if;

      when WRITE_Z =>
        IN1_ACK <= '0';
        IN2_ACK <= '0';
        if OUT1_ACK = '1' then
          OUT1_STB <= '0';
          STATE <= READ_A_B;
        end if;

    end case;
    if RST = '1' then
      STATE <= READ_A_B;
      IN1_ACK <= '0';
      IN2_ACK <= '0';
      OUT1_STB <= '0';
    end if;
  end process;

end architecture RTL;
