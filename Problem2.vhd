library IEEE;
use IEEE.std_logic_1164.all;


-- entity
entity problem2_FSM is
port ( x1, x2, clk : in std_logic;
        Y : out std_logic_vector(1 downto 0);
        Z : out std_logic);
end problem2_FSM;



-- architecture
architecture behavioral of problem2_FSM is

--create new type
type state_type is (ST0,ST1,ST2);

--present state, next state
signal PS,NS : state_type;


begin

--process states
sync_proc: process(CLK,NS)
begin

if (rising_edge(CLK)) then
    PS <= NS;
end if;

end process sync_proc;

--process inputs
comb_proc: process(PS,x1, x2)

begin

-- pre-assign the outputs
Z <= '0'; 

case PS is

-- items regarding state ST0
when ST0 => 
if ( x1 = '0') then
    NS <= ST0; Z <= '0';
else 
    NS <= ST2; Z <= '0';
end if;

-- items regarding state ST1
when ST1 => 
if (x2 = '0') then 
    NS <= ST0; Z <= '1';
else 
    NS <= ST1; Z <= '0';
end if;

-- items regarding state ST2
when ST2 => 
if (x2 = '0') then 
    NS <= ST0; Z <= '1';
else 
    NS <= ST1; Z <= '0';
end if;

-- the catch all condition
when others => 
Z <= '0'; 
NS <= ST0;
end case;

end process comb_proc;

--select state
with PS select
Y <= "10" when ST0,
"11" when ST1,
"01" when ST2,
--go back to first state
"10" when others;


end behavioral;
