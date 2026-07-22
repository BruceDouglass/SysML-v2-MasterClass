package ConnectionFlowExample {
    public import ScalarValues::*;
    public import SI::*;
    /* Port definition with flow-related features */
    port def FluidPort {
        out attribute flowRate : VolumeFlowRateValue;
        in attribute pressure : PressureValue;
    }
    /* Connection type representing a hydraulic line */
    connection def HydraulicLine {
        end source : FluidPort;
        end sink : ~FluidPort;
        /* Define flow direction and continuity */
        flow source.flowRate to sink.flowRate;
        bind source.pressure = sink.pressure;
    }
    /* Components using the ports */
    part def Pump {
        port outlet : FluidPort;
    }
    part def Valve {
        port inlet : ~FluidPort;
    }
    /* System connecting pump to valve */
    part def HydraulicSystem {
        part pump : Pump;
        part valve : Valve;
        connection mainLine : HydraulicLine connect pump.outlet to valve.inlet;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
