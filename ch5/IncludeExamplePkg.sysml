package IncludeExamplePkg {
    private import ScalarValues::*;
    private import RealFunctions::*;
    /* ── supporting type declarations ── */
    part def Aircraft;
    part def Pilot;
    /* ── included use-case definitions ── */
    use case preFlightCheck {
        subject aircraft : Aircraft;
        actor pilot : Pilot;
        objective {
            doc /* Verify flight controls, fuel, and navigation systems. */
        }
    }
    use case maintainAirSpeed {
        subject aircraft : Aircraft;
        actor pilot : Pilot;
        in commandedSpeed : Real;
        objective {
            doc /* Hold true air speed within ±2 kt of the commanded value. */
        }
    }
    /* parent use-case definition that includes the two above */
    use case executeFlightMission {
        subject aircraft : Aircraft;
        actor pilot : Pilot;
        /* Include relationships */
        include preFlightCheck {
            objective {}
        }
        include maintainAirSpeed {
            objective {}
        }
        objective {
            doc /* Complete the flight mission from take-off to landing. */
        }
    }
}
view 'Include Example View' : DS_Views::SymbolicViews::gv;
