

library IEEE;                                    -- library declaration
use IEEE.std_logic_1164.all;


entity problem6_FSM is                           -- entity
       port ( 
              X, clk : in std_logic;
              Y : out std_logic_vector(1 downto 0);
              Z1, Z2 : out std_logic);
end problem6_FSM;


architecture behavioral of problem6_FSM is              -- architecture

       type state_type is (ST0,ST1,ST2, ST3);                  --create new type
       signal PS,NS : state_type;                              --present state, next state

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
                     when ST0 =>                                             -- items regarding state ST0
                     Z1 <= '1';                                              --set z1 output
                            if ( x = '0') then
                                       NS <= ST2;
                                       Z2 <= '0';
                            else 
                                       NS <= ST0; 
                                       Z2 <= '0';
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
                     
       with PS select                                     --select state
              Y <=   "00" when ST0,
                     "01" when ST1,
                     "10" when ST2,
                     "11" when ST3,
                     "00" when others;                                --go back to first state

end behavioral;
