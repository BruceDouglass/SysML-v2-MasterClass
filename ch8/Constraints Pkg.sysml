package 'Constraints Pkg' {
    private import ScalarValues::*;
    private import ISQ::*;
    private import SI::*;
    private import NumericalFunctions::*;
    constraint def IsFull {
        in tank : FuelTank;
        tank.fuelLevel == tank.maxFuelLevel
    }
    part def FuelTank {
        attribute fuelLevel : Real;
        attribute maxFuelLevel : Real;
    }
    part def Vehicle {
        part fuelTank : FuelTank;
        constraint isFull : IsFull {
            in tank = fuelTank;
        }
    }
    constraint def MassConstraint {
        in partMasses : MassValue [0..*];
        in massLimit : MassValue;
        sum(partMasses) <= massLimit
    }
    part def VehiclePart {
        mass : MassValue;
    }
    part def Engine :> VehiclePart;
    part def Transmission :> VehiclePart;
    part def Vehicle {
        assert constraint massConstraint : MassConstraint {
            in partMasses = (chassisMass, engine.mass, transmission.mass);
            in massLimit = 2500 [kg];
        }
        attribute chassisMass : MassValue;
        part engine : Engine;
        part transmission : Transmission;
    }
    public import QuantityCalculations::*;
    /* enables +,*,^ on quantities */
    /* Final velocity under constant acceleration: v_f = v_i + a·dt */
    calc def Velocity {
        in v_i : SpeedValue;
        in a : AccelerationValue;
        in dt : TimeValue;
        return v_f : SpeedValue;
        v_i + a * dt
    }
    /* Position update: x_f = x_i + v_i·dt + 1/2 a·dt^2 */
    calc def Position {
        in x_i : LengthValue;
        in v_i : SpeedValue;
        in a : AccelerationValue;
        in dt : TimeValue;
        return x_f : LengthValue;
        x_i + v_i * dt + 0.5 * a * dt ^ 2
    }
    /* (Optional) a = F / m, if you want force–mass linkage */
    calc def AccelerationFromForce {
        in F : ForceValue;
        in m : MassValue;
        return a : AccelerationValue;
        F / m
    }
}
