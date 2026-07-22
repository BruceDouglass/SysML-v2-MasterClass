package VehicleRequirements {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    public import MeasurementReferences::*;
    /* --- Functional and performance requirements --- */
    attribute def CarEfficiencyUnit :> DerivedUnit;
    attribute <'km/L'> kilometrePerLiter : CarEfficiencyUnit;
    requirement <R1> MassLimit {
        subject;
        in vehicleMass : MassValue;
        require constraint {
            vehicleMass <= 2500 [kg]
        }
        doc /* The vehicle shall not exceed a total mass of 2500 kg. */
    }
    requirement <R2> FuelEfficiency {
        subject;
        in fuelEfficiency : Real;
        require constraint {
            fuelEfficiency >= 20 ['km/L']
        }
        doc /* The vehicle shall achieve at least 20 km per liter of fuel. */
    }
    requirement <R3> Range {
        subject;
        in range : LengthValue;
        require constraint {
            range >= 400 [km]
        }
        doc /* The vehicle shall have a driving range of at least 400 km. */
    }
    requirement <R4> Acceleration {
        subject;
        in timeTo100 : TimeValue;
        require constraint {
            timeTo100 <= 9 [s]
        }
        doc /* The vehicle shall accelerate from 0 to 100 km/h in 9 seconds or less. */
    }
    requirement <R5> BrakingDistance {
        subject;
        in brakingDistance : LengthValue;
        require constraint {
            brakingDistance <= 40 [m]
        }
        doc /* The vehicle shall stop from 100 km/h in 40 meters or less. */
    }
    requirement <R6> CargoCapacity {
        subject;
        in cargoVolume : VolumeValue;
        require constraint {
            cargoVolume >= 450 [L]
        }
        doc /* The vehicle shall provide at least 450 liters of cargo space. */
    }
}
package VehicleDesign {
    public import VehicleRequirements::*;
    attribute <'kW⋅h'> kilometrePerLiter : EnergyUnit;
    /* --- Base vehicle design --- */
    part def Vehicle {
        attribute vehicleMass : MassValue = 2300 [kg];
        attribute fuelEfficiency : ScalarValue = 22 ['km/L'];
        attribute range : LengthValue = 450 [km];
        attribute timeTo100 : TimeValue = 8.5 [s];
        attribute brakingDistance : LengthValue = 38 [m];
        attribute cargoVolume : VolumeValue = 470 [L];
        /* Declare satisfaction of requirements */
        satisfy MassLimit {
            subject;
        }
        satisfy FuelEfficiency {
            subject;
        }
        satisfy Range {
            subject;
        }
        satisfy Acceleration {
            subject;
        }
        satisfy BrakingDistance {
            subject;
        }
        satisfy CargoCapacity {
            subject;
        }
    }
    /* --- Specialized variant: Hybrid vehicle --- */
    part def HybridVehicle :> Vehicle {
        attribute batteryCapacity : EnergyValue = 12 ['kW⋅h'];
        attribute electricRange : LengthValue = 60 [km];
        assert constraint {
            range == 450 [km] + electricRange
        }
        /* Inherits satisfaction of base requirements */
        /* Optionally add new requirement satisfaction, e.g., emission or fuel-saving */
    }
    /* --- Example occurrence representing a specific design --- */
    occurrence def VehicleProject {
        part sedan : Vehicle;
        part hybrid : HybridVehicle;
    }
}
view 'Vechicle Requirements and Design View' : DS_Views::SymbolicViews::gv;
