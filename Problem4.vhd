-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;


-- entity
entity problem4_FSM is
port ( X1, X2, clk : in std_logic;
       Z1, Z2 : out std_logic);
end problem4_FSM;



-- architecture
architecture behavioral of problem4_FSM is

--create new type
type state_type is (ST0,ST1,ST2);

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
Z1 <= '0'; 
Z2 <= '0';

case PS is

-- items regarding state ST0
when ST0 => 
--set z1 output
Z1 <= '0';

if ( x1 = '0') then
    NS <= ST2;
    Z2 <= '0';
else 
    NS <= ST1; 
    Z2 <= '1';
end if;

-- items regarding state ST1
when ST1 =>
--set z1 output
Z1 <= '1'; 

if (x2 = '0') then 
    NS <= ST2; 
    Z2 <= '1';
else 
    NS <= ST0; 
    Z2 <= '0';
end if;

-- items regarding state ST2
when ST2 =>
--set z1 output
Z1 <= '1';
 
if (x1 = '0') then 
    NS <= ST0; 
    Z2 <= '1';
else 
    NS <= ST1; 
    Z2 <= '1';
end if;

-- the catch all condition
when others => 
Z1 <= '0';
Z2 <= '0'; 
NS <= ST0;
end case;

end process comb_proc;


end behavioral;
