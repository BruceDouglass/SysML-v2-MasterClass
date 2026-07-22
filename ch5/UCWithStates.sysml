package UCWithStates {
    public import ScalarValues::*;
    action def OpenValve;
    action def CloseValve;
    action def AdjustFlowRate;
    part def DrugVaporizer {
        attribute outputConc : Real;
    }
    part def Clinician;
    /* ── use-case definition that binds the machine ─── */
    use case DeliverInhalantDrug {
        subject vaporizer : DrugVaporizer;
        in commandedConc : Real;
        in faultCleared : Boolean;
        actor clinician : Clinician;
        in commandedConc : Real;
        /* events of interest */
        item powerOn;
        item enable;
        item disable;
        item sensorFault;
        item reset;
        /* ── state-machine definition ── */
        state def VaporizerDeliverySM {
            /* states */
            state Off {
                entry action shut : CloseValve;
            }
            state Idle;
            state Regulating {
                do action regulate : AdjustFlowRate;
            }
            state Alarm {
                entry action stop : CloseValve;
            }
            /* transitions */
            transition Actions::Action::start then Off;
            transition Off_to_Idle first Off accept powerOn then Idle;
            transition Idle_to_Regulating first Idle accept enable if commandedConc > 0.0 then Regulating;
            transition Regulating_to_Idle first Regulating accept disable then Idle;
            transition Regulating_to_Alarm first Regulating accept sensorFault then Alarm;
            transition Alarm_to_Idle first Alarm accept reset if faultCleared then Idle;
        }
        state ucStates [1] : VaporizerDeliverySM;
        objective {
            doc /* Maintain delivered drug concentration within ±0.5 % of the commanded value whenever the vaporizer is in the Regulating state. */
        }
    }
}
view 'UCWithStates View' : DS_Views::SymbolicViews::gv;
