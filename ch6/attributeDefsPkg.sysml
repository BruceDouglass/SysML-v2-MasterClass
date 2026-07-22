package attributeDefsPkg {
    public import ScalarValues::*;
    enum def FuelEnum {
        Gasoline;
        Diesel;
        Kerosene;
    }
    part def Engine {
        attribute maxRPM : Integer;
        attribute fuelTypeEnum;
    }
    enum def LocationSource {
        GPSSource;
        INSSource;
        MapSource;
    }
    attribute def Location {
        attribute latitude : Real;
        attribute longitude : Real;
        attribute altitude : Real;
        attribute source : LocationSource;
    }
    part def Drone {
        attribute currentLocation : Location;
        action initLocation {
            assign currentLocation.latitude := 0;
            assign currentLocation.longitude := 0;
            assign currentLocation.altitude := 0;
            assign currentLocation.source := LocationSource::GPSSource;
        }
    }
    attribute def Age :> Integer {
        assert constraint {
            this >= 0 and this <= 120
        }
    }
    part box {
        attribute h :> ISQ::height default := 0 [SI::m];
        attribute w :> ISQ::width default := 10 [SI::m];
        attribute t :> ISQ::celsiusTemperature = 50 [SI::'°C'];
    }
    public import ISQ::*;
    public import SI::*;
    attribute def constrainedPressure :> PressureValue {
        assert constraint {
            that >= 0 [Pa] and that <= 50000 [Pa]
        }
    }
}
