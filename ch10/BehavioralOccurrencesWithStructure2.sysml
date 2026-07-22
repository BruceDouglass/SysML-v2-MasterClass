package BehavioralOccurrencesWithStructure2 {
    public import ScalarValues::*;
    public import SI::*;
    public import Time::*;
    /* === Action types (what can be done) === */
    action def InitializeSensors;
    action def AcquireData;
    action def TransmitData;
    /* Orchestration action that expects two participant parts */
    action def ExecuteSurveillance {
        in part sensor : Sensor;
        in part comms : CommSystem;
        ref action initializeSensor = sensor.init;
        ref action acquireData = sensor.acquire;
        ref action uploadData = comms.uplink;
        first start then initializeSensor;
        first initializeSensor then acquireData;
        first acquireData then uploadData;
        /* Timing over behavioral event points (see “Modeling Time”) */
        assert constraint {
            DurationOf(sensor.init) < 2 [s]
        }
        assert constraint {
            TimeOf(sensor.acquire.done) - TimeOf(sensor.init.start) < 10 [s]
        }
    }
    /* === Structural participants that own actions (who does it) === */
    part def Sensor {
        action init : InitializeSensors;
        action acquire : AcquireData;
    }
    part def CommSystem {
        action uplink : TransmitData;
    }
    /* === Mission as an occurrence definition (does NOT specialize the action) === */
    occurrence def SurveillanceMission {
        /* Name the concrete participants in this mission pattern */
        part aircraftTracker : Sensor;
        part telemetryRadio : CommSystem;
        /* Own a usage of the orchestration action and bind its participants */
        action runMission : ExecuteSurveillance {
            in part sensor = aircraftTracker;
            in part comms = telemetryRadio;
        }
    }
    view 'Behavioral-Structural View' : DS_Views::SymbolicViews::gv;
}
