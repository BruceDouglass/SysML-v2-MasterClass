package EqualsOperatorsPkg {
    public import ScalarValues::*;
    public import RealFunctions::abs;
    calc def ComputeFlowError {
        /* 1. “=” as a default/initial value */
        attribute tolerance : Real = 0.5;
        /* parameters */
        in commanded : Real;
        in measured : Real;
        out error : Real;
        /* 2. “:=” writes a new value (imperative assignment) */
        error := measured - commanded;
        /* 3. constraint uses both “==” (equality test) and “=” (local Boolean) */
        constraint checkResults {
            in error : Real;
            in tolerance : Real;
            in commanded : Real;
            in measured : Real;
            return inTol : Boolean;
            return exact : Boolean;
            assign inTol := abs(error) <= tolerance;
            assign exact := commanded == measured;
        }
    }
}
