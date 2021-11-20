
-- Load the standard libraries

library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;

-- Define the 8-bit ALU inputs and outputs

entity ALU is
  port (
    LEFT        : in  std_logic_vector(7 downto 0);  -- Left operand
    RIGHT       : in  std_logic_vector(7 downto 0);  -- Right operand
    OPCODE      : in  std_logic_vector(3 downto 0);  -- ALU operation
    C_IN        : in  std_logic;                     -- Carry input
    RESULT      : out std_logic_vector(7 downto 0);  -- ALU output
    C_OUT       : out std_logic;                     -- Carry output
    N_OUT       : out std_logic;                     -- Negative flag output
    V_OUT       : out std_logic;                     -- Overflow flag output
    Z_OUT       : out std_logic                      -- Zero flag output
  );
end entity ALU;

-- Define the behavior of the 8-bit ALU

architecture BEHAVIORAL of ALU is

begin

  P_ALU : process (LEFT, RIGHT, OPCODE, C_IN) is

    variable result8  : unsigned(7 downto 0);
    variable result9  : unsigned(8 downto 0);
    variable right_op : unsigned(7 downto 0);

  begin

    case OPCODE is

      when "0000" | "0001" => -- Addition or subtraction

        if (OPCODE = "0000") then
          right_op := unsigned(RIGHT);     -- Addition
        else
          right_op := unsigned(not RIGHT); -- Subtraction
        end if;

        result9 := ('0' & unsigned(LEFT)) +
                   unsigned(right_op) +
                   unsigned(std_logic_vector'(""& C_IN));
        result8 := result9(7 downto 0);
	-- C flag
        C_OUT <= result9(8);
        -- V flag
        V_OUT <= (LEFT(7) XOR result8(7)) AND (right_op(7) XOR result8(7));

      when "0010" => result8 := unsigned(LEFT) + 1;        -- Increment
      when "0011" => result8 := unsigned(LEFT) - 1;        -- Decrement
      when "0101" => result8 := unsigned(LEFT and RIGHT);  -- Bitwise AND
      when "0110" => result8 := unsigned(LEFT or  RIGHT);  -- Bitwise OR
      when "0111" => result8 := unsigned(LEFT xor RIGHT);  -- Bitwise XOR
      when others => result8 := (others => 'X');           -- don't care

    end case;

    RESULT <= std_logic_vector(result8);

    N_OUT <= result8(7);                      -- N flag

    if (result8 = 0) then                     -- Z flag
      Z_OUT <= '1';
    else
      Z_OUT <= '0';
    end if;

  end process P_ALU;

end architecture BEHAVIORAL;
