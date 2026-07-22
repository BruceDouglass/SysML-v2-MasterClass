package 'Requirements Pkg' {
    part def System;
    requirement def Req1 {
        subject System;
    }
}
package 'Capabilities Pkg' {
    public import 'Requirements Pkg'::*;
    package 'Operational Capabilities' {
        use case MannedFlight {
            subject System;
        }
        /* define alternative names */
        alias pilotFlight for MannedFlight;
        alias SpaceAndTimeQuantities for ISQSpaceTime;
    }
    package 'Maintenance Capabilities';
}
package VisibilityExample {
    part def Car;
    private part myCar : Car;
    protected attribute def a;
    part def Wheel;
}
package KitchenApplicancesPkg {
    public import ScalarValues::*;
    public import ISQElectromagnetism::*;
    part def MicrowaveOven {
        doc /* the system of concern */
        attribute maxPower : Real;
        attribute currentSettings : CookingConfiguration;
        /* homeOven part is typed by MicrowaveOven – see the alias below */
        part homeOven : Oven;
        /* reference to a usage */
        ref part food : Food;
        ref part cook : Cook;
    }
    alias Oven for MicrowaveOven;
    part def Cook;
    part def Food;
    attribute def CookingConfiguration {
        attribute cooktime : ISQBase::duration;
        attribute powerLevel : ISQElectromagnetism::activePower;
    }
}
view SampleView : DS_Views::SymbolicViews::gv;
