--Notice that we are using "PROCESS-STATEMENT" method. One process is for the actual "Finite State Machine" states. The
--other process is for the INPUTS

library IEEE;                        -- library declaration
use IEEE.std_logic_1164.all;


entity problem4_FSM is                    -- entity
       port ( 
              X1, X2, clk : in std_logic;
              Z1, Z2 : out std_logic);
end problem4_FSM;

       
architecture behavioral of problem4_FSM is              -- architecture

       type state_type is (ST0,ST1,ST2);                       --create new type
       signal PS,NS : state_type;                       --present state, next state

       begin
--------------------------------------------------------------------
              sync_proc: process(CLK,NS)                      --process states
                     begin                                            --init works as a reset
                            if (rising_edge(CLK)) then                --init works as a reset
                                    PS <= NS;
                     end if;
              end process sync_proc;
------------------------------------------------------------------------

              comb_proc: process(PS,X1, X2)               --PROCESS inputs
                     begin
                            Z1 <= '0';                                -- pre-assign the outputs
                            Z2 <= '0';
                     
                            case PS is

                            when ST0 =>                                      -- items regarding state ST0
                                   Z1 <= '0';                                       --set z1 output
                                   if ( x1 = '0') then
                                              NS <= ST2;
                                              Z2 <= '0';
                                   else 
                                              NS <= ST1; 
                                              Z2 <= '1';
                                   end if;

                            when ST1 =>                                      -- items regarding state ST1
                            Z1 <= '1';                                                                   --set z1 output
                                   if (x2 = '0') then 
                                              NS <= ST2; 
                                              Z2 <= '1';
                                   else 
                                              NS <= ST0; 
                                              Z2 <= '0';
                                   end if;
                            when ST2 =>                                                           -- items regarding state ST2
                            Z1 <= '1';                                                            --set z1 output
                                   if (x1 = '0') then 
                                              NS <= ST0; 
                                              Z2 <= '1';
                                   else 
                                              NS <= ST1; 
                                              Z2 <= '1';
                                   end if;
                                   when others =>                                          -- the catch all condition
                                             Z1 <= '0';
                                             Z2 <= '0'; 
                                             NS <= ST0;
                            end case;
                end process comb_proc;
end behavioral;
