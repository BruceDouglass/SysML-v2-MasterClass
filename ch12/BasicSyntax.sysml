package BasicSyntax {
    public import ScalarValues::*;
    item evGo;
    event occurrence myEO :> evGo;
    action startUp;
    action initialAction;
    action exitingBehavior;
    action onGoing;
    action transBehavior;
    state def ExampleStates {
        attribute guardExpr : Boolean;
        entry action startup;
        then PredecessorState;
        state PredecessorState {
            entry initialAction;
            do onGoing;
            exit exitingBehavior;
        }
        state SubsequentState;
        transition t1 first PredecessorState accept evGo if guardExpr do transBehavior then SubsequentState;
    }
}
view BasicSyntax : DS_Views::SymbolicViews::gv;
package TriggerComparisonExample {
    public import ScalarValues::*;
    item def ControlSignal {
        attribute value : Boolean;
    }
    item triggerItem : ControlSignal;
    event occurrence TemporalMarker :> triggerItem;
    state def Monitor {
        state Waiting;
        state Processing;
        state Synchronization;
        transition Waiting accept msg : triggerItem if msg.value == true then Processing;
        transition Processing accept TemporalMarker then Synchronization;
    }
}
view ItemvsEventOccurrenceTriggerExample : DS_Views::SymbolicViews::gv;
