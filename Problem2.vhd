--Notice that we are using "PROCESS-STATEMENT" method. One process is for the actual "Finite State Machine" states. The

--The only New thing in this problem is that we have 2 "MAIN-OUTPUTS". One for "State-Switching", and Another one for the actual "STATE"
--Also this problem does not asks to Represent the TOTAL "STATE" outputs in the actual physical circuit
--Notice that in this problem, similar to the previous problem, we do not have a "SET", "CLEAR", or "RESET" button.

library IEEE;                       
use IEEE.std_logic_1164.all;


entity FiniteStateMachine is                    -- Entity
       port ( 
              X1, X2 : in std_logic;
              clk : in std_logic;
              Z1, Z2 : out std_logic);
end FiniteStateMachine;

       
architecture behavioral of FiniteStateMachine is              -- architecture

       type state_type is (ST0,ST1,ST2);                       --Here we create TEMPORARY "TYPES" for the "STATES"
       signal PS,NS : state_type;                       --Here we create TEMPORARY "SIGNALS" for the "Present-State" and "Next-State"

       begin
--------------------------------------------------------------------
              sync_proc: process(CLK,NS)                      --This is the "SYNCHRONOUS" part (Similar to previous problem)
                     begin                                            --
                            if (rising_edge(CLK)) then                --
                                    PS <= NS;               --Remember, after we have all the logic required to move "STATES" we still need a "CLOCK" tick to do so.
                     end if;
              end process sync_proc;
------------------------------------------------------------------------

              comb_proc: process(PS,X1, X2)               --PROCESS inputs
                     begin
                            Z1 <= '0';                 --Remember that before we go through the first Logic Round, we must first Ground the "OUTPUTS". This is the "OUTPUT" of the inside the "STATE" Remember this is a MOORE "OUTPUT".
                            Z2 <= '0';                --This is the second "OUTPUT". this one is on the Outside and is involved with "State-Transition"               
                     
                            case PS is

                            when ST0 =>                                      -- Whenn "ST0" is the "Present-State"
                                   Z1 <= '0';                                   -- Remember that when the "Present-State" is "ST0" then "Z1" is low, so here we ground it.This is a "MOORE" output. This is repetitive and something we do just in case because the book says so.
                                   if ( x1 = '0') then                      --If the "INPUT" variation here is LOW then statements below occur
                                              NS <= ST2;
                                              Z2 <= '0';
                                   else                                     --This is if the "INPUT" variation "X1" is HIGH
                                              NS <= ST1;                    --then we move to a different "STATE"
                                              Z2 <= '1';                    --And we set its corresponding "STATE-OUTPUT" 
                                   end if;

                            when ST1 =>                                      -- items regarding state ST1
                            Z1 <= '1';                                      --Since the "Present-State" is "ST1" then we set "Z1" as LOW, so here we ground it (NOTICE THIS IS A REPRETITION BECAUSE THE z1 was also declared Above.)
                                   if (x2 = '0') then                       --If the "INPUT" variation "X2" is LOW
                                              NS <= ST2;                    
                                              Z2 <= '1';
                                   else 
                                              NS <= ST0; 
                                              Z2 <= '0';
                                   end if;
                            when ST2 =>                                        -- items regarding state ST2
                            Z1 <= '1';                                          --Notice that "Z1=1" was already declared above. So this process may seem repetitive.
                                   if (x1 = '0') then 
                                              NS <= ST0; 
                                              Z2 <= '1';
                                   else 
                                              NS <= ST1; 
                                              Z2 <= '1';
                                   end if;
                                   when others =>                             -- the catch all condition. It grounds the both "MAIN-OUTPUTS" and returns the "Present-State" to the first one (We don't need it, but the book says it is good practice to include it)
                                             Z1 <= '0';
                                             Z2 <= '0'; 
                                             NS <= ST0;
                            end case;
                end process comb_proc;
end behavioral;
