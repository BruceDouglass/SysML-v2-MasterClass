package SendAcceptExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    item def SensorMeasurement {
        attribute value : Real;
        attribute units : String;
    }
    part def Sensor {
        port pDataOut;
        action senseAndSend {
            item reading : SensorMeasurement = new SensorMeasurement(value = 42.0, units = "°C");
            send reading via pDataOut;
        }
    }
    part def Controller {
        port pSensorIn;
        action waitAndProcess {
            item processed : SensorMeasurement;
            action getMeasurement accept received : SensorMeasurement via pSensorIn;
            action update {
                assign processed.value := getMeasurement.received.value * 1.8 + 32.0;
                /* Convert to °F */
                assign processed.units := "°F";
            }
            first getMeasurement then update;
        }
    }
    part def SensorSystem {
        part sensor : Sensor;
        part controller : Controller;
        connect sensor.pDataOut to controller.pSensorIn;
        action run [1] {
            first Parts::Part::start;
            then sensor.senseAndSend;
            then controller.waitAndProcess;
        }
    }
}
