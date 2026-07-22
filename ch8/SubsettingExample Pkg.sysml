package 'SubsettingExample Pkg' {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    /* --- Generic definitions --- */
    part def Engine {
        attribute powerOutput : PowerValue;
    }
    part def GasolineEngine :> Engine {
        attribute fuelType : String = "Gasoline";
    }
    part def ElectricEngine :> Engine {
        attribute voltage : SourceVoltageValue;
    }
    /* --- Reference architecture --- */
    part def Car {
        part engine [1..*] : Engine;
    }
    /* --- Specialized (specific) architecture --- */
    part def HybridCar :> Car {
        /* Redefine the base engine to allow two engines */
        part :>> engine [2] : Engine;
        /* Define subsets to identify the types of each engine */
        part electricEngine : ElectricEngine :> engine;
        part gasolineEngine : GasolineEngine :> engine;
        assert constraint {
            electricEngine.voltage > 0 [V] and gasolineEngine.fuelType == "Gasoline"
        }
        doc
        /* A HybridCar has two engines—a gasoline engine and an electric motor—
         * both of which subset the general engine collection inherited from Car. */
    }
    /* Example occurrence */
    occurrence MyHybrid : HybridCar;
    view 'SubsettingExample View' : DS_Views::SymbolicViews::gv;
}
