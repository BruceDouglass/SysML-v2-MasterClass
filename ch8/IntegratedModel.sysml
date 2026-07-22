package IntegratedModel {
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
    connection def FuelLine {
        end sink : Engine;
    }
    part def Vehicle {
        part engine : Engine;
        part tank : FuelTank;
        /* Connection usage */
        connection engineFuelLine : FuelLine connect tank to engine {
            source = tank;
            sink = engine;
        }
    }
    /* Actual physical assets */
    individual part def Tank_A :> FuelTank {
        :>> capacity = 60 [L];
        :>> currentLevel = 25 [L];
    }
    individual part def Engine_0042 :> Engine {
        :>> powerOutput = 120 [kW];
        :>> fuelFlowRate = 9.5 [kg / h];
    }
    individual connection def Connection101 :> FuelLine {
        end source : FuelTank;
    }
    /* Real-world vehicle instance */
    individual part def Vehicle_101 :> Vehicle {
        /* Same unique assets fill the Vehicle’s roles */
        individual part :>> tank : Tank_A;
        individual part :>> engine : Engine_0042;
        /* Individual connection usage for this specific vehicle */
        individual connection :>> engineFuelLine : Connection101 connect tank to engine;
        /* Instance-level operational check */
        assert constraint {
            tank.currentLevel <= tank.capacity
        }
    }
}
