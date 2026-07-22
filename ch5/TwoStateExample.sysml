package TwoStateExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    item def ModeEvent;
    action def EnterStateA;
    action def ExitStateA;
    action def EnterStateB;
    action def ExitStateB;
    action def OnTransition;
    state def TwoStateMachine {
        in attribute okToSwitch : Boolean;
        entry;
        then stateA;
        state stateA {
            entry action onEntryA : EnterStateA;
            exit action onExitA : ExitStateA;
        }
        state stateB {
            entry action onEntryB : EnterStateB;
            exit action onExitB : ExitStateB;
        }
        transition A_to_B first stateA accept ModeEvent if okToSwitch do action effect : OnTransition then stateB;
    }
}
