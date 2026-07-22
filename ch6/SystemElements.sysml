package SystemElements {
    private import ScalarValues::*;
    part def Engine {
        attribute maxRPM : Integer;
        private attribute internalCode : String;
    }
    private part def FuelPump {
        attribute flowRate : Real;
    }
}
package ExternalUsage {
    public import SystemElements::*;
    part def Vehicle {
        part engine : Engine;
        constraint checkRPM {
            engine.maxRPM > 5000
        }
        constraint checkCode {}
    }
}
