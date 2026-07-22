package MorePartConstraints {
    public import ISQ::*;
    public import SI::*;
    /* enables +, *, /, ^ on quantities */
    public import QuantityCalculations::*;
    /* Motion segment under constant acceleration */
    part def MotionSegment {
        /* “Given” / independent quantities */
        attribute v_i : SpeedValue;
        /* initial velocity */
        attribute a : AccelerationValue;
        /* constant acceleration */
        attribute dt : TimeValue;
        /* time step */
        attribute x_i : LengthValue;
        /* initial position */
        attribute m : MassValue;
        /* mass */
        attribute f : ForceValue;
        /* applied force */
        /* “Derived” quantities we want to relate analytically */
        attribute v_f : SpeedValue;
        /* final velocity */
        attribute x_f : LengthValue;
        /* final position */
        /* Final velocity under constant acceleration: v_f = v_i + a·dt */
        assert constraint finalVelocity {
            v_f == v_i + a * dt
        }
        /* Position update: x_f = x_i + v_i·dt + 1/2 a·dt^2 */
        assert constraint positionUpdate {
            x_f == x_i + v_i * dt + 0.5 * a * dt ^ 2
        }
        /* Force–mass–acceleration relation: a = F / m */
        assert constraint accelerationFromForce {
            a == f / m
        }
    }
}
