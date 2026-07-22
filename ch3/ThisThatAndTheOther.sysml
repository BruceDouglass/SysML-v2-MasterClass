package ThisThatAndTheOther {
    public import Time::*;
    public import ScalarValues::*;
    public import SI::*;
    /*  Demonstrates the use of self, that, and this inside a
     *  three level nesting:  Part  →  Action  →  Constraint
     */
    part Treadmill {
        attribute maxAllowedTime : TimeValue = 10 [s];
        action runCycle {
            attribute elapsedTime : TimeValue;
            constraint checkTime {
                return ok : Boolean;
                attribute withinLimit : Boolean = runCycle.elapsedTime <= Treadmill.maxAllowedTime;
                ok := checkTime.withinLimit;
            }
        }
    }
}
