package VehicleUsagePkg {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* System described entirely in context */
    part vehicle {
        part engine {
            attribute powerOutput : PowerValue;
            attribute fuelFlowRate : MassFlowRateValue;
        }
        part tank {
            attribute capacity : VolumeValue;
            attribute currentLevel : VolumeValue;
            assert constraint {
                currentLevel <= capacity
            }
        }
        connect tank to engine;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
