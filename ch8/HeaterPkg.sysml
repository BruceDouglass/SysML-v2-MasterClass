package HeaterPkg {
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
}
