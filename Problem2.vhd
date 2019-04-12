library IEEE;
use IEEE.std_logic_1164.all;


entity problem2_FSM is                          -- entity
        port ( 
                x1, x2, clk : in std_logic;                       --Notice we have a clock and two inputs
                Y : out std_logic_vector(1 downto 0);            
                Z : out std_logic);
end problem2_FSM;


architecture behavioral of problem2_FSM is                      -- architecture

        type state_type is (ST0,ST1,ST2);                  --create new type
        signal PS,NS : state_type;                      --present state, next state

        begin

                 sync_proc: process(CLK,NS)                      --process states
                        begin
                                if (rising_edge(CLK)) then
                                        PS <= NS;
                                end if;

                 end process sync_proc;

        comb_proc: process(PS,x1, x2)                           --process inputs
                begin
                Z <= '0';                               -- pre-assign the outputs
                        case PS is
                                when ST0 =>                             -- items regarding state ST0
                                        if ( x1 = '0') then
                                                 NS <= ST0; Z <= '0';
                                        else 
                                                 NS <= ST2; Z <= '0';
                                        end if;
                                when ST1 =>                     -- items regarding state ST1
                                        if (x2 = '0') then 
                                                 NS <= ST0; Z <= '1';
                                        else 
                                                 NS <= ST1; Z <= '0';
                                        end if;

                                when ST2 =>                     -- items regarding state ST2
                                        if (x2 = '0') then 
                                                  NS <= ST0; Z <= '1';
                                        else 
                                                  NS <= ST1; Z <= '0';
                                        end if;
                                when others =>                  -- the catch all condition
                                        Z <= '0'; 
                                        NS <= ST0;
                        end case;
        end process comb_proc;

        with PS select                                          --select state
                Y <=    "10" when ST0,
                        "11" when ST1,
                        "01" when ST2,
                        "10" when others;                               --go back to first state

end behavioral;
