package FlowDefExamplePkg {
    item def ControlSignal;
    part def Sensor {
        out item cs : ControlSignal;
    }
    part def Actuator {
        in item myCS : ControlSignal;
    }
    part def Thermostat {
        part heater : Actuator;
        part thermometer : Sensor;
        flow : SA from thermometer to heater;
    }
    part def RobotArm {
        part posSensor : Sensor;
        part motor : Actuator;
        flow : SA from posSensor to motor;
    }
    flow def SA {
        end Sensor;
        end Actuator;
        flow ControlSignal from Sensor to Actuator;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
