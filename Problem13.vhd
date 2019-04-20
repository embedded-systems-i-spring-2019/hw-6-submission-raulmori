--Remember that are more than one way to ENCODE the "STATE" outputs
--Remember the "STATE-TRANSITION" is controlled  by the MAIN "INPUT" and "CLOCK" tick

--One of the new things with this problem is that our "STATES" are labeled as 3-bits
--Another new thing with this problem is that we have 2 "TRANSITION-OUTPUTS" called "CS" and "RD"
--This problem also wants us to ENCODE the "STATE" outputs using 3-bit Representation
--Notice the "STATES" are sorted using, (a), (b), (c)

library IEEE;
use IEEE.std_logic_1164.all;


entity FSM is                               -- Entity     
        port (
               X1, X2 : in std_logic;                 --We have 1 "MAIN-INPUT" that has 2 variations
               clk : in std_logic;           
               CS, RD: out std_logic;                --These are the 2 MAIN "TRANSITION-OUTPUTS"
               Y : out std_logic_vector(2 downto 0)     --This is the ENCODED output, that we manually represent in 3-but form.
              ); 
        end FSM;



architecture behavioral of FSM is              -- Architecture

       type state_type is (ST0,ST1,ST2, ST3);                  --These are the TEMPORARY "TYPES" for all "STATES" (As done in the previous 2 examples)
       signal PS,NS : state_type;                              --These are the TEMPORARY "SIGNALS" for the "Present-State" and "Next-State"  (As done in the previous 2 examples)

       begin
              sync_proc: process(CLK,NS)                              --This is the "SYNCHRONOUS" part
                     begin
                            if (rising_edge(CLK)) then                              --Every action can only occur on a "CLOCK" tick. We don't have any buttons
                                     PS <= NS;
                     end if;

              end process sync_proc;
----------------------------------------------------------------------
       
              comb_proc: process(PS,X1, X2)                           --process inputs
                     begin
              
                     CS <= '0';                                       -- Before we being the SEQUENCE, we ground all the MAIN "OUTPUTS"
                     RD <= '0';
              
                            case PS is
                                   when ST0 =>                                      -- When the "Present-State" is "ST0"
                                          if ( x1 = '0') then                       --If the MAIN "INPUT" variation "X1" is LOW. Remember the "TRANSITION-OUTPUTS" are not conditions
                                                     NS <= ST1;                             --we move on to a different "STATE"
                                                     CS <= '0';                                 --It outputs "CS" as LOW
                                                     RD <= '1';                                 --It outputs "RD" as HIGH
                                          else                                      --If the MAIN "INPUT" variation "X1" is instead HIGH
                                                     NS <= ST2; 
                                                     CS <= '1';
                                                     RD <= '0';
                                          end if;
                                   when ST1 =>                                             -- items regarding state ST1
                                          NS <= ST2;                                                     --regardless of input go to next state
                                          CS <= '1';
                                          RD <= '1';
                                   when ST2 =>                                             -- items regarding state ST2
                                          if (x2 = '0') then                        --Everything Below is a "MEALY" output (It depends on "Current-State" and "INPUT"
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
              with PS select                                          --SELECTED-SIGNAL ASSIGNMENT
                     Y <=   "001" when ST0,                         --This is the first "STATE" represented as (a)
                            "010" when ST1,                         --This is represented by (b)
                            "100" when ST2,                         --This is represented by (c)
                            "001" when others;                                     --This makes us go back to first state (Not necessary but it shows good practice)

end behavioral;
