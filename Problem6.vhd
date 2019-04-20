--The new part about this problem is that we now have 4 "STATES", and we are asked to represent the "STATES" as Encoded "OUTPUTS"
--Also, we now only have 1 "MAIN-INPUT".
-- We continue having  2 "MAIN-OUTPUTS" as the previous problem. One is the "STATE-OUTPUT", the other one is the "TRANSITION-OUTPUT"
--

library IEEE;                                    -- library declaration
use IEEE.std_logic_1164.all;


entity FiniteStateMachine is                           -- Entity
       port ( 
              X : in std_logic;                         --This is the "MAIN-INPUT" we only have 1 variation of it.
              clk : in std_logic;                       
              Z1 : out std_logic;                         --This is the "STATE-OUTPUT"
              Z2 : out std_logic;                       --This is the "TRANSITION-OUTPUT"
              Y : out std_logic_vector(1 downto 0)      --This is the Manual Representation of the "STATES" as an output of bits
            );  
end FiniteStateMachine;                                 


architecture behavioral of FiniteStateMachine is              --Architecture

       type state_type is (ST0,ST1,ST2, ST3);                  --These are the TEMPORARY "TYPES" for the "STATES"
       signal PS,NS : state_type;                              --Here we declare the TEMPORARY" Signals for the "Present-State" and the "Next-State"

       begin
              sync_proc: process(CLK,NS)                             --process states
                     begin
                            if (rising_edge(CLK)) then                              --init works as a reset
                                    PS <= NS;
                     end if;

              end process sync_proc;
----------------------------------------------------------------------
              comb_proc: process(PS,X)                                --process inputs
                     begin
       
                     Z1 <= '0';                                              -- pre-assign the outputs
                     Z2 <= '0';
       
                     case PS is
                            when ST0 =>                                             -- When the "Present-State" is on "ST0"
                            Z1 <= '1';                                              --This is a "MOORE" output
                                   if ( x = '0') then                        --If the "INPUT" is LOW
                                              NS <= ST2;                            --We move to a different "STATE" on the next CLOCK tick
                                              Z2 <= '0';                            --The new "STATE" has a "STATE-OUTPUT" that is LOW
                                   else                                     --If the "INPUT" is instead HIGH
                                              NS <= ST0;                            --We remain in the same "STATE"
                                              Z2 <= '0';                            --The "STATE-OUTPUT" also remains the same
                                   end if;
                            when ST1 =>                                             -- items regarding state ST1
                            Z1 <= '0';                                              --set z1 output
                                   if (x = '0') then 
                                              NS <= ST3; 
                                              Z2 <= '0';
                                   else 
                                              NS <= ST1; 
                                              Z2 <= '0';
                                   end if;
                            when ST2 =>                                             -- items regarding state ST2
                            Z1 <= '1';                                              --set z1 output
                                   if (x = '0') then 
                                              NS <= ST1; 
                                              Z2 <= '0';
                                   else 
                                              NS <= ST0; 
                                              Z2 <= '0';
                                   end if;
                            when ST3 =>                                             -- items regarding state ST3
                            Z1 <= '0';                                              --set z1 output
                                   if (x = '0') then 
                                              NS <= ST0; 
                                              Z2 <= '1';
                                   else 
                                              NS <= ST1; 
                                              Z2 <= '0';
                                   end if;
       
                            when others =>                                          -- the catch all condition
                                   Z1 <= '0';
                                   Z2 <= '0'; 
                                   NS <= ST0;
                     end case;
       
              end process comb_proc;
                            
              with PS select                                     --Here we use "SELECTED-SIGNAL-ASSIGMENT" method
                     Y <=   "00" when ST0,
                            "01" when ST1,
                            "10" when ST2,
                            "11" when ST3,
                            "00" when others;                                --go back to first state (This is just good practice, we don't have to do it)

end behavioral;
