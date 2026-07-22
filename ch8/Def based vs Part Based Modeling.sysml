package 'Def based vs Part Based Modeling' {
    private import ScalarValues::*;
    private import ISQ::*;
    private import SI::*;
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
    connection def FuelLine {
        end source : FuelTank;
        end sink : Engine;
    }
    part def Vehicle {
        part engine : Engine;
        part tank : FuelTank;
        connection fuelLine : FuelLine {
            source = tank;
            sink = engine;
        }
    }
    part systemContext {
        part vehicle : Vehicle;
    }
    occurrence Vehicle_101 : Vehicle {
        occurrence Engine_0042 : Engine {
            powerOutput = 120 [kW];
            fuelFlowRate = 9.5 [kg / h];
        }
        occurrence Tank_A : FuelTank {
            capacity = 60 [L];
            currentLevel = 25 [L];
        }
        occurrence fuelLine_1 : FuelLine {
            source = Tank_A;
            sink = Engine_0042;
        }
    }
}
