package pkg {
    public import ScalarValues::*;
    public import SI::*;
    public import USCU::*;
    attribute def DistancePerVolumeValue :> Quantities::ScalarQuantityValue;
    attribute <'mi/gal'> milesPerGallon : MeasurementReferences::DerivedUnit;
    part def Vehicle {
        attribute wheelDiameter : Real;
        attribute driveTrainEfficiency : Real;
    }
    analysis def FuelEconomyAnalysis {
        subject vehicle : Vehicle;
        objective fuelEconomyAnalysisObjective {
            doc
            /* The objective of this analysis is to determine whether the
             * subject vehicle can satisfy the fuel economy requirement.
             */
            assume constraint {
                vehicle.wheelDiameter == 33 ['in'] and vehicle.driveTrainEfficiency == 0.4
            }
            require constraint {
                fuelEconomyResult > 30 ['mi/gal']
            }
        }
        return fuelEconomyResult : DistancePerVolumeValue;
    }
}
