library IEEE;
use IEEE.std_logic_1164.all;


entity problem13_FSM is                               -- entity     
port ( X1, X2, clk : in std_logic;
       Y : out std_logic_vector(2 downto 0);
       CS, RD: out std_logic);
end problem13_FSM;



architecture behavioral of problem13_FSM is              -- architecture

       type state_type is (ST0,ST1,ST2, ST3);                  --create new type
       signal PS,NS : state_type;                              --present state, next state

       begin
              sync_proc: process(CLK,NS)                              --process states
                     begin
                            if (rising_edge(CLK)) then                              --init works as a reset
                                     PS <= NS;
                     end if;

              end process sync_proc;
----------------------------------------------------------------------
       
comb_proc: process(PS,X1, X2)                           --process inputs
       begin

       CS <= '0';                                       -- pre-assign the outputs
       RD <= '0';

              case PS is
                     when ST0 =>                                      -- items regarding state ST0
                            if ( x1 = '0') then
                                       NS <= ST1;
                                       CS <= '0';
                                       RD <= '1';
                            else 
                                       NS <= ST2; 
                                       CS <= '1';
                                       RD <= '0';
                            end if;
                     when ST1 =>                                             -- items regarding state ST1
                            NS <= ST2;                                                     --regardless of input go to next state
                            CS <= '1';
                            RD <= '1';
                     when ST2 =>                                             -- items regarding state ST2
                            if (x2 = '0') then 
                                       NS <= ST0; 
                                       CS <= '0';
                                       RD <= '0';
                            else 
                                       NS <= ST2; 
                                       CS <= '0';
                                       RD <= '0';
                            end if;
                     when others =>                                         -- the catch all condition
                            CS <= '0';    
                            RD <= '0'; 
                            NS <= ST0;
               end case;

end process comb_proc;
----------------------------------------------------------------------
       with PS select                                          --select state
              Y <=   "001" when ST0,
                     "010" when ST1,
                     "100" when ST2,
                     "001" when others;                                     --go back to first state

end behavioral;
