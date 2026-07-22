package RedefinitionExample {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    /* --- Base (reference) architecture --- */
    part def Aircraft {
        part wing : Wing;
        part rudder : Rudder;
        action controlSurfaceAdjustment {
            /* Abstract behavior */
            doc /* Placeholder for flight control logic */
        }
    }
    /* Generic components */
    part def Wing {
        attribute span : LengthValue;
    }
    part def Rudder {
        attribute deflection : AngularMeasureValue;
    }
    /* Specialized subtypes */
    part def TwelveControlSurfaceWing :> Wing {
        attribute controlSurfaceCount : Integer default 12;
    }
    part def TwinRudder :> Rudder {
        attribute count : Integer default 2;
    }
    /* --- Specialized (specific) architecture --- */
    part def HighPerformanceAircraft :> Aircraft {
        /* (1) Redefine part type to a specialized subtype */
        part :>> wing : TwelveControlSurfaceWing;
        /* (2) Redefine behavior with a specific implementation */
        action :>> controlSurfaceAdjustment {
            doc /* Implements advanced control laws for multiple surfaces */
            assert constraint {
                wing.controlSurfaceCount >= 12
            }
        }
        /* (3) Redefine multiplicity to represent two rudders */
        part :>> rudder [2] : TwinRudder;
    }
    /* Example occurrence of the specialized aircraft */
    occurrence FalconX : HighPerformanceAircraft;
}
