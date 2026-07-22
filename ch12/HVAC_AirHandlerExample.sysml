package HVAC_AirHandlerExample {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    item evTempUpdate;
    item evFaultDetected;
    item evFaultCleared;
    item evFireDetected;
    item evEmergencyCoolingRequest;
    item evRestart;
    /* Top-level behavioral mode machine */
    state def AirHandlerStates {
        /* attribute used by guard conditions */
        attribute desiredTemp : TemperatureValue;
        attribute currentTemp : TemperatureValue;
        /* Initialization */
        entry action init;
        then Idle;
        /* --- Top-level states --- */
        state Idle;
        /* Composite state: Operating */
        state Operating {
            entry action enableFans;
            /* Two nested states refine the operating mode */
            state Heating {
                entry action engageHeater;
                do action regulateHeat;
                exit action disengageHeater;
            }
            state Cooling {
                entry action engageCooler;
                do action regulateCooling;
                exit action disengageCooler;
            }
            /* Initial nested state */
            first start then Heating;
            /* Transitions between nested states */
            transition toCooling first Heating accept evTempUpdate if currentTemp > desiredTemp then Cooling;
            transition toHeating first Cooling accept evTempUpdate if currentTemp < desiredTemp then Heating;
        }
        /* Fault handling (simple, top-level state) */
        state Fault {
            entry action recordFault;
            exit action clearFaultLog;
        }
        state SupressingFire {
            entry action releaseFoam;
        }
        /* Transitions at the top level */
        transition fromIdle first Idle accept evTempUpdate if currentTemp != desiredTemp then Operating;
        transition toFault first Operating accept evFaultDetected then Fault;
        transition fromFault first Fault accept evFaultCleared then Idle;
        transition Operating.Heating accept evFireDetected then SupressingFire;
        transition SupressingFire accept after 10 [min] then Idle;
        transition SupressingFire accept evEmergencyCoolingRequest then Operating.Cooling;
        transition Operating accept evRestart then Idle;
    }
    part def AirHandler {
        state airHandler : AirHandlerStates [1];
    }
    view AirHandlerStateMachineView : DS_Views::SymbolicViews::gv;
}
