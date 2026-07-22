package HeaterControlExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    public import Time::*;
    /* === Domain data === */
    item def TempReading {
        attribute value : TemperatureValue;
    }
    /* Command payload to recover from Fault / shut down */
    item def HeaterShutdownCmd;
    /* Pure temporal marker: "we entered Fault now" */
    event occurrence heaterFault;
    /* Simple sink to receive fault notifications */
    part def Display {
        state displayStates : DisplayStateMachine;
        state def DisplayStateMachine {
            state displaying;
            accept heaterFault do action print { in msg : String = "OMG We\'re all gonna die!"; }
            then displaying;
        }
    }
    /* === Structural context === */
    part def Heater {
        attribute targetTemp : TemperatureValue = 22 ['°C'];
        attribute currentTemp : TemperatureValue = 20 ['°C'];
        attribute powerOn : Boolean = false;
        port pSensor;
        port pCommand;
        ref part display : Display;
        /* State machine usage (executes for each Heater instance) */
        state heaterControl [1] : HeaterControl {
            /* optional initial jump demonstrating a usage-local transition */
            transition Actions::Action::start then Cooling;
        }
        /* === State machine definition (nested inside Heater) === */
        state def HeaterControl {
            /* Controller states */
            state Idle;
            state Heating;
            state Cooling;
            /* Fault state declares and sends an event occurrence on entry */
            state Fault {
                /* Notify display on entry (no payload; just the moment) */
                entry send heaterFault to display;
            }
            /* === Transitions triggered in different ways === */
            /* 1) Item transfer trigger — new reading arrives */
            transition Idle accept reading : TempReading via pSensor then Heating;
            /* 2) Change trigger — when currentTemp exceeds targetTemp */
            transition Heating accept when currentTemp > targetTemp then Cooling;
            /* 3) Relative time trigger — safety timeout while Heating */
            transition Heating accept after 10 [min] then Fault;
            /* 4) Absolute time trigger — scheduled cooldown boundary */
            transition Cooling accept at 24 [h] then Idle;
            /* 5) Payload trigger out of Fault — recover on command */
            transition Fault accept cmd : HeaterShutdownCmd via pCommand then Idle;
            /* Optional safety constraint while controller is active */
            assert constraint {
                currentTemp <= targetTemp + 5 ['°C']
            }
        }
    }
    part display : Display;
    part heater : Heater;
    flow heaterFault from heater to display;
    view 'Heater Control State View' : DS_Views::SymbolicViews::stv;
}
