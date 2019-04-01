library IEEE;
use IEEE.std_logic_1164.all;


-- entity
entity problem13_FSM is
port ( X1, X2, clk : in std_logic;
       Y : out std_logic_vector(2 downto 0);
       CS, RD: out std_logic);
end problem13_FSM;



-- architecture
architecture behavioral of problem13_FSM is

--create new type
type state_type is (ST0,ST1,ST2, ST3);

--present state, next state
signal PS,NS : state_type;


begin

--process states
sync_proc: process(CLK,NS)
begin
--init works as a reset

if (rising_edge(CLK)) then
    PS <= NS;
end if;

end process sync_proc;

--process inputs
comb_proc: process(PS,X1, X2)

begin

-- pre-assign the outputs
CS <= '0'; 
RD <= '0';

case PS is

-- items regarding state ST0
when ST0 => 

if ( x1 = '0') then
    NS <= ST1;
    CS <= '0';
    RD <= '1';
else 
    NS <= ST2; 
    CS <= '1';
    RD <= '0';
end if;

-- items regarding state ST1
when ST1 =>

--regardless of input go to next state
NS <= ST2;
CS <= '1';
RD <= '1';

-- items regarding state ST2
when ST2 =>

if (x2 = '0') then 
    NS <= ST0; 
    CS <= '0';
    RD <= '0';
else 
    NS <= ST2; 
    CS <= '0';
    RD <= '0';
end if;


-- the catch all condition
when others => 
CS <= '0';
RD <= '0'; 
NS <= ST0;
end case;

end process comb_proc;

--select state
with PS select
Y <= "001" when ST0,
"010" when ST1,
"100" when ST2,
--go back to first state
"001" when others;

end behavioral;
