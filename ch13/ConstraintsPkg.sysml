package ConstraintsPkg {
    public import ScalarValues::*;
    public import SI::*;
    requirement batteryThermalPerformance {
        subject;
        in ambientTemp : TemperatureValue;
        in dischargeRate : Real;
        in capacity : Real;
        in nominalCapacity : Real;
        assume constraint ambientInRange {
            ambientTemp >= -10 ['°C'] and ambientTemp <= 40 ['°C']
        }
        require constraint capacityPreserved {
            dischargeRate <= 0.5 and capacity >= 0.8 * nominalCapacity
        }
    }
    part def P {
        constraint NonNegativeMass {
            in mass : Real;
            mass >= 0
        }
    }
}
