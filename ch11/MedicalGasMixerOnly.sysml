package MedicalGasMixerOnly {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* --- Domain items --- */
    item def Gas;
    attribute <'L/min'> litrePerMin : VolumeFlowRateUnit;
    item evComputeFlows;
    /* --- Ports --- */
    /* Supply publishes gas at its configured rate */
    port def iGasOut {
        out item gas : Gas;
    }
    /* Mixer sends each supply a target flow rate */
    port def iSetpoint {
        in attribute rate : VolumeFlowRateValue;
    }
    port def iSetpointOut {
        out attribute rate : VolumeFlowRateValue;
    }
    /* Mixer receives gas from each supply (for completeness) */
    port def iGasIn {
        in item gas : Gas;
    }
    /* --- Supplies --- */
    part def GasSupply {
        /* Control input (setpoint from mixer) and gas output */
        port pSet : iSetpoint;
        port pOut : iGasOut;
        /* Local state: current setpoint & simple “production” stub */
        attribute setpoint : VolumeFlowRateValue = 0 ['L/min'];
        /* Track incoming setpoint; clamp to ≥ 0 */
        action def TrackSetpoint {
            in attribute target : VolumeFlowRateValue;
            assert constraint {
                target >= 0 ['L/min']
            }
            assign setpoint := target;
        }
        /* Publish gas (details elided; this just marks the flow path) */
        action def ProduceGas {
            out item g : Gas;
            /* The “amount” is abstract here; physical balance is out of scope */
            flow g to pOut.gas;
        }
        /* Wire behaviors */
        action track : TrackSetpoint { in target = pSet.rate; }
        action publish : ProduceGas;
    }
    part def O2Supply :> GasSupply;
    part def N2Supply :> GasSupply;
    part def AirSupply :> GasSupply;
    part def HeSupply :> GasSupply;
    /* --- Mixer --- */
    part def GasMixer {
        /* Desired total output and fractions (0.0 .. 1.0) */
        attribute desiredTotal : VolumeFlowRateValue = 10 ['L/min'];
        attribute o2Frac : Real = 0.5;
        attribute n2Frac : Real = 0.2;
        attribute airFrac : Real = 0.2;
        attribute heFrac : Real = 0.1;
        /* Setpoint outputs to supplies */
        port pO2Set : iSetpointOut;
        port pN2Set : iSetpointOut;
        port pAirSet : iSetpointOut;
        port pHeSet : iSetpointOut;
        /* Gas inflows from supplies (separate physical path) */
        port pO2In : iGasIn;
        port pN2In : iGasIn;
        port pAirIn : iGasIn;
        port pHeIn : iGasIn;
        /* Compute per-supply rates from desiredTotal & fractions */
        calc def ComputeSetpoints {
            in attribute total : VolumeFlowRateValue;
            in attribute fO2 : Real;
            in attribute fN2 : Real;
            in attribute fAir : Real;
            in attribute fHe : Real;
            out attribute o2Rate : VolumeFlowRateValue;
            out attribute n2Rate : VolumeFlowRateValue;
            out attribute airRate : VolumeFlowRateValue;
            out attribute heRate : VolumeFlowRateValue;
            /* Fraction sanity & sum constraint (≤ 1.0) */
            assert constraint {
                0.0 <= fO2 and 0.0 <= fN2 and 0.0 <= fAir and 0.0 <= fHe
            }
            assert constraint {
                fO2 + fN2 + fAir + fHe <= 1.0
            }
            /* Basic split */
            assign o2Rate := total * fO2;
            assign n2Rate := total * fN2;
            assign airRate := total * fAir;
            assign heRate := total * fHe;
            /* Non-negativity on outputs */
            assert constraint {
                o2Rate >= 0 ['L/min'] and n2Rate >= 0 ['L/min'] and airRate >= 0 ['L/min'] and heRate >= 0 ['L/min']
            }
        }
        /* Whenever inputs change, recompute and drive setpoint ports */
        action def UpdateSetpoints {
            /* Bind current inputs */
            in attribute total = desiredTotal;
            in attribute fO2 = o2Frac;
            in attribute fN2 = n2Frac;
            in attribute fAir = airFrac;
            in attribute fHe = heFrac;
            /* Local calc usage */
            calc compute : ComputeSetpoints {
                in total = total;
                in fO2 = fO2;
                in fN2 = fN2;
                in fAir = fAir;
                in fHe = fHe;
            }
            /* Drive out the rates to the setpoint ports */
            bind compute.o2Rate = pO2Set.rate;
            bind compute.n2Rate = pN2Set.rate;
            bind compute.airRate = pAirSet.rate;
            bind compute.heRate = pHeSet.rate;
        }
        /* Simple trigger pattern: recompute on any change to inputs */
        /* (Tools typically support change triggers; here we show intent.) */
        state mixerControl {
            first start then Recompute;
            state Recompute {
                action run : UpdateSetpoints;
            }
            /* Retrigger whenever any input attribute changes */
            transition Recompute accept evComputeFlows then Recompute;
        }
        /* --- System wiring: mixer + supplies --- */
        part def MedicalGasDeliverySystem {
            part mixer : GasMixer;
            part o2 : O2Supply;
            part n2 : N2Supply;
            part air : AirSupply;
            part he : HeSupply;
            /* Control (setpoints) from mixer → supplies */
            connect mixer.pO2Set.rate to o2.pSet.rate;
            connect mixer.pN2Set.rate to n2.pSet.rate;
            connect mixer.pAirSet.rate to air.pSet.rate;
            connect mixer.pHeSet.rate to he.pSet.rate;
            /* Physical gas flows from supplies → mixer */
            connect o2.pOut.gas to mixer.pO2In.gas;
            connect n2.pOut.gas to mixer.pN2In.gas;
            connect air.pOut.gas to mixer.pAirIn.gas;
            connect he.pOut.gas to mixer.pHeIn.gas;
            /* Optional: make control flows order the producers (succession flows) */
            succession flow o2Set from mixer.pO2Set.rate to o2.pSet.rate;
            succession flow n2Set from mixer.pN2Set.rate to n2.pSet.rate;
            succession flow airSet from mixer.pAirSet.rate to air.pSet.rate;
            succession flow heSet from mixer.pHeSet.rate to he.pSet.rate;
        }
        view 'Gas Mixer Focus' : DS_Views::SymbolicViews::gv;
    }
    view 'MedicalGasMixerOnly Behevaior View' : DS_Views::SymbolicViews::gv;
}
