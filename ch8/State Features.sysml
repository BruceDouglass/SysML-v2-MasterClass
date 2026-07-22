package 'State Features' {
    event occurrence keyTurned;
    event occurrence throttlePressed;
    event occurrence throttleReleased;
    event occurrence keyRemoved;
    state def EngineStates {
        entry;
        then Off;
        state Off;
        accept keyTurned then Idle;
        state Idle;
        accept throttlePressed then Running;
        state Running;
        accept throttleReleased then Idle;
        accept keyRemoved then Off;
    }
    part def EngineController {
        state currentState : EngineStates;
    }
    part def Heater {
        event occurrence turnOn;
        event occurrence turnOff;
        state def HeaterStates {
            state Off;
            state Heating;
            entry;
            then Off;
            transition T1 first Off accept turnOn then Heating;
            transition Heating accept turnOff then Off;
        }
        state currentState : HeaterStates;
    }
    view 'State Features View' : DS_Views::SymbolicViews::gv;
}
