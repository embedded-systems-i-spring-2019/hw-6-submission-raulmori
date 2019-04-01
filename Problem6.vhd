

-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;


-- entity
entity problem6_FSM is
port ( X, clk : in std_logic;
       Y : out std_logic_vector(1 downto 0);
       Z1, Z2 : out std_logic);
end problem6_FSM;



-- architecture
architecture behavioral of problem6_FSM is

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
comb_proc: process(PS,X)

begin

-- pre-assign the outputs
Z1 <= '0'; 
Z2 <= '0';

case PS is

-- items regarding state ST0
when ST0 => 
--set z1 output
Z1 <= '1';

if ( x = '0') then
    NS <= ST2;
    Z2 <= '0';
else 
    NS <= ST0; 
    Z2 <= '0';
end if;

-- items regarding state ST1
when ST1 =>
--set z1 output
Z1 <= '0'; 

if (x = '0') then 
    NS <= ST3; 
    Z2 <= '0';
else 
    NS <= ST1; 
    Z2 <= '0';
end if;

-- items regarding state ST2
when ST2 =>
--set z1 output
Z1 <= '1'; 
if (x = '0') then 
    NS <= ST1; 
    Z2 <= '0';
else 
    NS <= ST0; 
    Z2 <= '0';
end if;

-- items regarding state ST3
when ST3 =>
--set z1 output
Z1 <= '0'; 
if (x = '0') then 
    NS <= ST0; 
    Z2 <= '1';
else 
    NS <= ST1; 
    Z2 <= '0';
end if;

-- the catch all condition
when others => 
Z1 <= '0';
Z2 <= '0'; 
NS <= ST0;
end case;

end process comb_proc;

--select state
with PS select
Y <= "00" when ST0,
"01" when ST1,
"10" when ST2,
"11" when ST3,
--go back to first state
"00" when others;

end behavioral;
