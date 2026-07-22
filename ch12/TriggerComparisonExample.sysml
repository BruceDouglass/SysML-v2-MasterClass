package TriggerComparisonExample {
    public import ScalarValues::*;
    item def ControlSignal {
        attribute value : Boolean;
    }
    item triggerItem : ControlSignal;
    event occurrence TemporalMarker :> triggerItem;
    state def Monitor {
        state WaitingForData;
        state SynchronizationPoint;
        transition WaitingForData accept msg : triggerItem if msg.value == true then SynchronizationPoint;
        transition SynchronizationPoint accept TemporalMarker then WaitingForData;
    }
}
view TriggerCompasisonView : DS_Views::SymbolicViews::gv;
