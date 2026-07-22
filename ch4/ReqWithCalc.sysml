package ReqWithCalc {
    public import ScalarValues::*;
    public import RealFunctions::*;
    public import 'Req Pkg'::*;
    calc isInteger {
        in attribute x : Real;
        return result : Boolean;
        /* Use the standard floor() function from library QuantityCalculations.
         * If x equals its own floor, it has no fractional part. */
        x == floor(x)
    }
    requirement BeltSpeedRange {
        subject treadmill : Treadmill;
        in minSpeed : SpeedValue = 0 ['mi/h'];
        in maxSpeed : SpeedValue = 15 ['mi/h'];
        in resolution : SpeedValue = 0.1 ['mi/h'];
        require constraint {
            treadmill.belt.commandedSpeed >= minSpeed and treadmill.belt.commandedSpeed <= maxSpeed and isInteger(treadmill.belt.commandedSpeed - minSpeed) / resolution
        }
        assume constraint {
            minSpeed >= 0 and maxSpeed >= 0 and maxSpeed > minSpeed
        }
        doc
        /* The treadmill shall allow the user to set any belt speed between
         * minSpeed and maxSpeed in increments of specified resolution. */
    }
}
