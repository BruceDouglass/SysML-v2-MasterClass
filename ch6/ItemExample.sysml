package ItemExample {
    private import ScalarValues::*;
    public import ISQ::*;
    private import SI::*;
    private import Time::*;
    item def TemperatureReading {
        attribute value : TemperatureValue;
        attribute whenMeasured : DateTime;
    }
    item def Fuel {
        attribute flowRate : Real;
    }
    part furnace {
        in item fuel : Fuel;
        out t : TemperatureReading;
        attribute currentTemp : TemperatureValue;
        action {
            assign t.value := currentTemp;
        }
    }
}
