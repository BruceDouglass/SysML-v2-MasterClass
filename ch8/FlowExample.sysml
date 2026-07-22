package FlowExample {
    public import ScalarValues::*;
    public import SI::*;
    /* Define the flowing medium */
    item def Air {
        attribute temperature : TemperatureValue;
        attribute density : Real;
    }
    /* Port definition with flow features */
    port def AirFlowPort {
        in flowRate : VolumeFlowRateValue;
        /* incoming airflow rate */
        in pressure : PressureValue;
        /* static pressure at inlet */
        out air : Air;
        /* outgoing air properties */
    }
    /* A simple intake component using the port */
    part def AirIntake {
        port inlet : AirFlowPort;
        port outlet : ~AirFlowPort;
        attribute efficiency : Real default 0.95;
        /* Valid equality bindings */
        bind outlet.flowRate = inlet.flowRate;
        /* Relationship expressed as a constraint */
        assert constraint {
            outlet.pressure == inlet.pressure * efficiency
        }
    }
    /* System context connecting two components */
    part def EngineSystem {
        part intake : AirIntake;
        part sensor : PressureSensor;
        /* Connect the intake outlet to the sensor inlet */
        connection flowLink connect intake.outlet to sensor.inlet;
    }
    part def PressureSensor {
        port inlet : ~AirFlowPort;
    }
    action getSpeed { out value :> speed; }
    part def Controller {
        in targetSpeed :> speed;
        out throttleCommand : Real;
        attribute currentSpeed :> speed;
        action controlSpeed {
            in tSpeed :> speed = targetSpeed;
            out cmd : Real = throttleCommand;
            perform action readSpeed : getSpeed;
            action a1 assign currentSpeed := readSpeed.value;
            action a2 assign cmd := tSpeed - currentSpeed;
            first start then readSpeed;
            first readSpeed then a1;
            first a1 then a2;
            first a2 then done;
        }
    }
}
