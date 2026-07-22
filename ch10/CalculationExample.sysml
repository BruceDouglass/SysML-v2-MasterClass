package CalculationExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* === Structural context (performs the calculation) === */
    part def EngineController {
        attribute airDensity : DensityValue;
        attribute speed : SpeedValue;
        attribute thrustCmd : ForceValue;
        /* Executes a side-effect-free calculation */
        action computeThrust : CalculateThrust;
    }
    /* === Specialized calculation action === */
    calc def CalculateThrust {
        in attribute rho : DensityValue;
        in attribute v : SpeedValue;
        return attribute t : ForceValue;
        /* Local constraint verifying result range */
        assert constraint {
            t <= 20000 [N]
        }
        /* Pure computation — no side effects */
        0.5 * rho * v ^ 2 * 1.2 ['m²']
    }
}
