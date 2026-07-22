package BatteryCaseExample {
    public import ScalarValues::*;
    public import SI::*;
    public import RealFunctions::*;
    part def Battery {
        attribute capacity : Real;
        attribute voltage : Real;
        attribute internalResistance : Real;
    }
    part def MissionLoad {
        attribute avgCurrentDraw : Real;
        attribute duration : TimeValue;
    }
    calc def EstimateDrop {
        in I : Real;
        in R : Real;
        return : Real;
        I * R
    }
    case def BatteryDischargeCase {
        subject batt : Battery;
        actor load : MissionLoad;
        attribute drop : Real = EstimateDrop(I = load.avgCurrentDraw, R = batt.internalResistance);
        attribute ampHoursConsumed : Real = load.avgCurrentDraw * (load.duration / 1 [h]);
        return remainingCapacity : Real = batt.capacity - ampHoursConsumed;
        objective MissionSuccess {
            require constraint preservedCap {
                remainingCapacity >= 0.2 * batt.capacity
            }
        }
    }
}
