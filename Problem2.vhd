--Notice that in this problem we don't have a "SET", "CLEAR" or "RESET"
--Also this problem has only one "MAIN-INPUT", but that "Main-Input" has 2 variations
library IEEE;
use IEEE.std_logic_1164.all;


entity Finite_State_Machine is                         
        port ( 
                x1, x2 : in std_logic;                     --These are the inputs inside the Logic
                clk : in std_logic;                        --This is the CLOCK
                Z : out std_logic);                         --This is one of the "MAIN-OUTPUTS"
                Y : out std_logic_vector(1 downto 0);       --This is the other "MAIN-OUTPUTS" that has a variation of "2". We manually represent the "PRESENT-STATE"
        
end Finite_State_Machine;


architecture behavioral of Finite_State_Machine is                      -- architecture

        type state_type is (ST0,ST1,ST2);                  --create "TEMPORARY-VARIABLES" for the three "STATES" (Notice they are "TYPE-state_type")
        signal PS,NS : state_type;                      --Here we create Temporary "SIGNALS" for "Present-State" and "Next-State"

        begin
                 sync_proc: process(CLK,NS)                      --This is the "SYNCHRONOUS" part 
                        begin                                   --Notice that this part is simple because we don't have a button
                                if (rising_edge(CLK)) then      
                                        PS <= NS;               --Any conditions that make the "Present-State" move to the "Next-State" can ony happen at a "CLOCK" tick
                                end if;
                 end process sync_proc;

                comb_proc: process(PS,x1, x2)                           --This is the "COMBINATORIAL" part (Remember this process is SEQUENTIAL)
                        begin
                        Z <= '0';                               -- Remember we must always set the output to "0" at the beggining of the SEQUENCE
                                case PS is
                                        when ST0 =>                             -- When the "Preset-State" is "ST0"  the indexed condition below is executed
                                                if ( x1 = '0') then              --Notice that here we only rely on one of the variations of the "MAIN-INPUT" 
                                                         NS <= ST0; Z <= '0';   --"Next-State" does not change and the "OUTPUT" needed was "0" (MEALY)
                                                else 
                                                         NS <= ST2; Z <= '0';   --"Next-State" Changes and the "OUTPUT" needed was "0" (This is what is required to go to the Other-State
                                                end if;
                                        when ST1 =>                     -- When the "Preset-State" is "ST1"
                                                if (x2 = '0') then              --If this variation of the "INPUT" is "0"
                                                         NS <= ST0; Z <= '1';     --If also, the "OUTPUT" is "1", then it will move to the "Next-State" of "ST0"
                                                else 
                                                         NS <= ST1; Z <= '0';     --If the "OUTPUT" is instead "0", then the "Next-State" will be "ST1"
                                                end if;

                                        when ST2 =>                     -- When the "Preset-State" is "ST2" (The same conditions as the examples above are followed)
                                                if (x2 = '0') then 
                                                          NS <= ST0; Z <= '1';
                                                else 
                                                          NS <= ST1; Z <= '0';
                                                end if;
                                        when others =>                  -- This is the Catch-All condition (only added as a good practice)
                                                Z <= '0'; 
                                                NS <= ST0;
                                end case;
                end process comb_proc;

        with PS select                           --Here we use "SELECTED-SIGNAL-ASSIGNEMTN"
                Y <=    "10" when ST0,              --This is the First State represeted in the STATE-DIAGRAM as "(a)"
                        "11" when ST1,              -- (b)
                        "01" when ST2,              -- (c)
                        "10" when others;          --Any other combination of input/output not specified in the "COMBINATORIAL-PROCESS" will make it go back to first state (Not necessary but it is good VHDL practice)

end behavioral;
