package DampedSpringExample {
    public import ScalarValues::*;
    public import RealFunctions::*;
    public import TrigFunctions::*;
    public import SI::*;
    /* Exponential function: exp(x) = e^x, implemented in Groovy */
    calc def exp {
        in x : Real;
        return : Real;
        language "Groovy" /* Math.exp(x) */
    }
    /* Underdamped spring–mass system:
     * x(t) = A * exp(-ζ * ω0 * t) * cos(ωd * t)
     * where ωd = ω0 * sqrt(1 - ζ^2) */
    calc def DampedDisplacement {
        in t : Real;
        in amplitude : Real;
        in zeta : Real;
        in omega0 : Real;
        return : Real;
        attribute omegaD : Real = omega0 * sqrt(1.0 - zeta * zeta);
        attribute decay : Real = exp(x = -zeta * omega0 * t);
        amplitude * decay * cos(omegaD * t)
    }
    /* Groovy-backed printing action: delegate to println */
    action def PrintValue {
        in t : Real;
        in displacement : Real;
        language "Groovy" /* println(String.format("t = %.3f s, x(t) = %.4f", t, displacement));
         */
    }
    /* Pure-SysML action: iterate over time and sample the damped response */
    action def SimulateDampedSpring {
        in amplitude : Real;
        in zeta : Real;
        in omega0 : Real;
        in timeDurationToRun : Real default := 20.0 [s];
        /* Fixed time step: 0.5 s */
        attribute dt : Real = 0.5 [s];
        /* Local variables for time and displacement */
        attribute t : Real = 0.0 [s];
        attribute x : Real;
        /* Loop from t = 0 to t <= timeDurationToRun in steps of dt */
        while t <= timeDurationToRun {
            action a1 assign x := DampedDisplacement(t = t, amplitude = amplitude, zeta = zeta, omega0 = omega0);
            action printIt : PrintValue {
                in t = t;
                in displacement = x;
            }
            action update assign t := t + dt;
            first a1 then printIt;
            first printIt then update;
        }
    }
    action Sim : SimulateDampedSpring {
        in amplitude = 20;
        in zeta = 0.5;
        in omega0 = 0.5;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
