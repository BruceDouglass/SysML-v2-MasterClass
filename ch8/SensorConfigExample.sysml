package SensorConfigExample {
    public import ScalarValues::*;
    /* Reusable item definition for configuration data */
    item def SensorConfig {
        attribute sampleRateHz : Integer;
        attribute gain : Real;
    }
    /* Part def that owns the actual config item */
    part def SensorModule {
        item config : SensorConfig := {
            sampleRateHz default := 100;
            gain default := 1.0;
        };
    }
    /* Part def that refers to the config held by a contained SensorModule */
    part def ControlUnit {
        part sensor : SensorModule;
        /* ref item points to the same SensorConfig item inside sensor */
        ref item sensorConfig : SensorConfig = sensor.config;
        assert constraint {
            sensorConfig.sampleRateHz > 0
        }
    }
}
