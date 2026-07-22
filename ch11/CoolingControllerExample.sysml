package CoolingControllerExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* === Domain items === */
    item def TemperatureReading {
        attribute value : TemperatureValue;
    }
    item def FanCommand {
        attribute on : Boolean;
    }
    item def ShutdownSignal;
    /* === Structural context === */
    part def CoolingController {
        attribute targetTemp : TemperatureValue = 30 ['°C'];
        attribute currentTemp : TemperatureValue;
        port pSensor;
        port pFan;
        port pPower;
        /* === Core behavior === */
        action regulatTemperature : RegulateTemperature;
        action def RegulateTemperature {
            action getReading accept reading : TemperatureReading via pSensor;
            action assignReading assign currentTemp := getReading.reading.value;
            action decideFanControl {
                if currentTemp > targetTemp {
                    action sendFanOn {
                        send new FanCommand(on = true) via pFan;
                    }
                } else {
                    action sendFanOff {
                        send new FanCommand(on = false) via pFan;
                    }
                }
            }
            /* action [$47] sendFanOn {
             * action [$48] send new FanCommand(on = true) via pFan;
             * }
             * action [$49] sendFanOff {
             * action [$50] send new FanCommand(on = false) via pFan;
             * } */
            action waitForShutdown {
                accept ShutdownSignal via pPower;
            }
            first start then getReading;
            first getReading then assignReading;
            first assignReading then decideFanControl;
            first decideFanControl then waitForShutdown;
            first waitForShutdown then done;
        }
    }
    action def doX {
        out result : Real;
        attribute x : Real default 0.0;
        assign x := x + 1;
        assign x := x * 10 + 2;
        assign result := x;
    }
    view 'CoolingController View' : DS_Views::SymbolicViews::gv;
    view CoolingControllerExample : DS_Views::SymbolicViews::afv;
}
