package PartConstraint {
    public import SI::*;
    public import RealFunctions::*;
    constraint def MassConstraint {
        in attribute partMasses : MassValue [0..*];
        in attribute massLimit : MassValue;
        sum(partMasses) <= massLimit
    }
    part def VehiclePart {
        attribute vpmass : MassValue;
    }
    part def Engine :> VehiclePart;
    part def Transmission :> VehiclePart;
    part def Vehicle {
        assert constraint massConstraint : MassConstraint {
            in attribute partMasses = (chassisMass, engine.vpmass, transmission.vpmass);
            in attribute massLimit = 2500 [kg];
        }
        attribute chassisMass : MassValue;
        part engine : Engine;
        part transmission : Transmission;
    }
}
