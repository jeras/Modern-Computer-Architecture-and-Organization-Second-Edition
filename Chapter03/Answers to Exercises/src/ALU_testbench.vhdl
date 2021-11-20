
library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;

entity ALU_TESTBENCH is
end entity ALU_TESTBENCH;

architecture BEHAVIORAL of ALU_TESTBENCH is

    signal LEFT   : std_logic_vector(7 downto 0);  -- Left operand
    signal RIGHT  : std_logic_vector(7 downto 0);  -- Right operand
    signal OPCODE : std_logic_vector(3 downto 0);  -- ALU operation
    signal C_IN   : std_logic;                     -- Carry input
    signal RESULT : std_logic_vector(7 downto 0);  -- ALU output
    signal C_OUT  : std_logic;                     -- Carry output
    signal N_OUT  : std_logic;                     -- Negative flag output
    signal V_OUT  : std_logic;                     -- Overflow flag output
    signal Z_OUT  : std_logic;                     -- Zero flag output

begin

    -- design under test instance
    DUT : entity work.ALU
    port map (
      LEFT   => LEFT  ,
      RIGHT  => RIGHT ,
      OPCODE => OPCODE,
      C_IN   => C_IN  ,
      RESULT => RESULT,
      C_OUT  => C_OUT ,
      N_OUT  => N_OUT ,
      V_OUT  => V_OUT ,
      Z_OUT  => Z_OUT
    );

  TEST : process
  begin

    OPCODE <= B"0000";  -- addition
    C_IN   <= '0';      -- no carry

    LEFT  <= std_logic_vector(to_signed(126, 8));
    RIGHT <= std_logic_vector(to_signed(  1, 8));
    wait for 1 ns;

    report to_hstring(LEFT) & " + " & to_hstring(RIGHT) & " = " & to_hstring(C_OUT & RESULT) & ", V_OUT = " & std_logic'image(V_OUT);
    wait for 9 ns;

    LEFT  <= std_logic_vector(to_signed(127, 8));
    RIGHT <= std_logic_vector(to_signed(  1, 8));
    wait for 1 ns;

    report to_hstring(LEFT) & " + " & to_hstring(RIGHT) & " = " & to_hstring(C_OUT & RESULT) & ", V_OUT = " & std_logic'image(V_OUT);
    wait for 9 ns;

    LEFT  <= std_logic_vector(to_signed(-127, 8));
    RIGHT <= std_logic_vector(to_signed(  -1, 8));
    wait for 1 ns;

    report to_hstring(LEFT) & " + " & to_hstring(RIGHT) & " = " & to_hstring(C_OUT & RESULT) & ", V_OUT = " & std_logic'image(V_OUT);
    wait for 9 ns;

    LEFT  <= std_logic_vector(to_signed(-128, 8));
    RIGHT <= std_logic_vector(to_signed(  -1, 8));
    wait for 1 ns;

    report to_hstring(LEFT) & " + " & to_hstring(RIGHT) & " = " & to_hstring(C_OUT & RESULT) & ", V_OUT = " & std_logic'image(V_OUT);
    wait for 9 ns;
    wait;

  end process TEST;

end architecture BEHAVIORAL;
