package 'Work Done pkg' {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    calc def WorkDone {
        in m : MassValue;
        in h0 : height;
        in h1 : height;
        attribute g : Real = 9.81;
        return Real;
        m * g * (h1 - h0)
    }
    constraint def totalMassConstraint {
        in structureMass : MassValue;
        in passengerMass : MassValue;
        in nPassengers : Integer;
        in massLimit : MassValue;
        structureMass + passengerMass * nPassengers <= massLimit
    }
    part def elevator {
        attribute elevatorMass : MassValue = 900 [kg];
        attribute floorHeight : height = 5 [m];
        attribute numberOfFloors : Integer = 8 [m];
        attribute upperMassLimit : MassValue = 2500 [kg];
        totalWork : Real = totalWorkDone;
        calc totalWorkDone {
            return Real;
            WorkDone(elevatorMass, 0, floorHeight * numberOfFloors)
        }
        constraint tmConstraint : totalMassConstraint {
            structureMass = elevatorMass;
            passengerMass = 100 [kg];
            nPassemgers = 10;
            massLimit = upperMassLimit;
        }
    }
}
