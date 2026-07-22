package package1 {
    package CarModelPkg {
        public import ScalarValues::*;
        /* ============================================================
         * Component-based decomposition
         * ============================================================ */
        part def Engine;
        part def Drivetrain;
        part def Wheel;
        part def GasTank;
        part def Car {
            part engine : Engine;
            part drivetrain : Drivetrain;
            part wheel [4] : Wheel;
            part gasTank : GasTank;
            item aluminum : AluminumMass;
            item steel : SteelMass;
            item plastic : PlasticMass;
            item glass : GlassMass;
            attribute color : Color;
            attribute make : Make;
            attribute model : Model;
            attribute year : Positive;
            attribute styling : Styling;
        }
        /* ============================================================
         * Material-based decomposition
         * ============================================================ */
        item def AluminumMass;
        item def SteelMass;
        item def PlasticMass;
        item def GlassMass;
        /* ============================================================
         * Descriptive / property-based decomposition
         * ============================================================ */
        attribute def Color;
        attribute def Make;
        attribute def Model;
        attribute def Styling;
    }
    view 'Different Views of a Car' : DS_Views::SymbolicViews::gv;
    comment about CarModelPkg::Car /* A Car as a set of parts*/
    comment about CarModelPkg::Car /* A Car as a set of materials*/
    comment about CarModelPkg::Car /* A Car as a set of values*/
}
