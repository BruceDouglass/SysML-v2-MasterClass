package ConstraintKindsExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import Quantities::*;
    public import MeasurementReferences::*;
    public import SI::*;
    public import Time::*;
    /* --- define constants --- */
    attribute maxSpeed : SpeedValue = 30 ['m/s'];
    attribute maxLiftCapacity : MassValue = 500 [kg];
    attribute safeTemp : TemperatureValue = 80 ['°C'];
    /* define quantity kind and unit for  */
    attribute def DistancePerVolumeValue :> ScalarQuantityValue;
    attribute def KilometrePerLiterUnit :> DerivedUnit;
    attribute <'km/L'> KilometrePerLiter : KilometrePerLiterUnit;
    /* --- Boolean calculation used by multiple constraints --- */
    calc def CheckSpeedWithinLimit {
        in attribute current : SpeedValue;
        in attribute limit : SpeedValue;
        return ok : Boolean;
        current <= limit
    }
    requirement <r1> efficiencyRequirement {
        subject vehicle : Vehicle;
        doc /* the vehicle fuel efficiency shall be greater than or equal to 25 km per liter.  */
        /* Required condition — performance target */
        require constraint {
            vehicle.fuelEfficiency >= 25 ['km/L']
        }
        /* assumed precondition — environmental bound */
        assume constraint {
            vehicle.ambientTemp < safeTemp
        }
    }
    /* --- Structural context --- */
    part def Vehicle {
        attribute ambientTemp : TemperatureValue;
        attribute velocity : SpeedValue;
        attribute fuelEfficiency : DistancePerVolumeValue;
        attribute temperature : TemperatureValue;
        attribute mass : MassValue;
        /* Supporting calculation */
        calc check : CheckSpeedWithinLimit;
        /* Generic constraint — postcondition or physical truth */
        constraint {
            mass < maxLiftCapacity
        }
        /* Asserted invariant — must remain true during operation */
        assert constraint {
            check.ok
        }
        /* Generic constraint as a postcondition of a behavior */
        constraint {
            temperature <= safeTemp
        }
    }
}
