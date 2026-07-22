package VehicleDefPkg {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    part def Engine {
        attribute powerOutput : PowerValue;
        attribute fuelFlowRate : MassFlowRateValue;
    }
    part def FuelTank {
        attribute capacity : VolumeValue;
        attribute currentLevel : VolumeValue;
        assert constraint {
            currentLevel <= capacity
        }
    }
    part def Vehicle {
        part engine : Engine;
        part tank : FuelTank;
    }
}
