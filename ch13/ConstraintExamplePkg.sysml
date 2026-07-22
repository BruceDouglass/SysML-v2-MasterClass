package ConstraintExamplePkg {
    public import ScalarValues::*;
    public import SI::*;
    part def Resistor {
        public import ScalarValues::*;
        in attribute resistance : Real;
        in attribute current : Real;
        attribute voltage : Real = resistance * current;
        attribute power : Real = voltage * current;
        constraint OhmsLawOK {
            voltage >= 0
        }
        assert constraint NotOverheated {
            power < 0.25 [W]
        }
    }
    analysis NominalConditions {
        attribute ambientTemp : Real;
        assert constraint AmbientSafe {
            ambientTemp < 60 ['°C']
        }
    }
    requirement VoltageLimitReq {
        subject;
        in voltage : Real;
        in temperature : Real;
        assume constraint AtLeastZero {
            voltage >= 0 [V] and temperature >= 0 ['°C']
        }
        require constraint voltageWithinLimit {
            voltage <= 12.0 [V]
        }
    }
}
