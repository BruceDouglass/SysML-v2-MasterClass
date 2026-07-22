package ThermostatModel {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* ========================================================================= */
    /* 1. INFORMATIONAL DEFINITIONS (Items and Attributes)                        */
    /* ========================================================================= */
    item def SetpointChangeSignal;
    attribute def TemperatureValue :> Real;
    /* ========================================================================= */
    /* 2. STRUCTURAL DEFINITIONS (Parts)                                         */
    /* ========================================================================= */
    part def Sensor {
        attribute tempReading : TemperatureValue;
        part def Heater {
            attribute isHeating : Boolean := false;
        }
    }
    part def Thermostat {
        attribute setPoint : TemperatureValue := 20.0;
        ref part controlledHeater : inputSensor::Heater;
        ref part inputSensor : Sensor;
        action startHeating {
            assign controlledHeater.isHeating := true;
        }
        action stopHeating {
            assign controlledHeater.isHeating := false;
        }
        state def ControlStates {
            state Idle;
            state Heating {
                entry startHeating;
                exit stopHeating;
            }
            state CoolDown;
            /* --------------------------------------------------------------------- */
            /* TRANSITIONS (Defining the state sequencing)                           */
            /* --------------------------------------------------------------------- */
            transition idle_to_heating first Idle if inputSensor.tempReading < setPoint - 2.0 then Heating;
            transition heating_to_cooldown first Heating if inputSensor.tempReading >= setPoint then CoolDown;
            transition cooldown_to_idle first CoolDown accept SetpointChangeSignal then Idle;
        }
        state controlStateMachine [1] : ControlStates;
    }
    view 'ThermostatModel View' : DS_Views::SymbolicViews::gv;
}
