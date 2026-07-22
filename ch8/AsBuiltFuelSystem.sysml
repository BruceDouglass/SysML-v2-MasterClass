package AsBuiltFuelSystem {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* Type-level structure */
    part def FuelSystem {
        part tank : Tank;
        part engine : Engine;
    }
    part def Tank {
        attribute capacity : Real;
        attribute level : Real;
    }
    part def Engine {
        attribute fuelRate : Real;
    }
    /* Unique individuals (actual installed equipment) */
    individual part def Tank_A :> Tank {
        :>> capacity = 60 [L];
        :>> level = 25 [L];
    }
    individual part def Engine_0042 :> Engine {
        :>> fuelRate = 120 [L / h];
    }
    /* As-built configuration (unique system entity) */
    individual part def FuelInstallation_20251030 :> FuelSystem {
        /* Same real tank and engine play roles in structure */
        individual part :>> tank : Tank_A;
        individual part :>> engine : Engine_0042;
        /* Realized operational constraint */
        assert constraint {
            tank.level <= tank.capacity
        }
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
