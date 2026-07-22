package InterfaceExample {
    public import ScalarValues::*;
    public import SI::*;
    /* The flowing medium */
    item def Fluid {
        attribute density : Real;
        attribute temperature : TemperatureValue;
    }
    /* Ports keep quantitative features and add a directed carrier feature */
    port def FluidPort {
        out item fluid : Fluid;
        out attribute flowRate : VolumeFlowRateValue;
        in attribute pressure : PressureValue;
    }
    /* Interface: ports only; define how the carrier and quantities relate */
    interface def FluidInterface {
        end source : FluidPort;
        end sink : ~FluidPort;
        /* Carrier and quantity relations across the interface */
        flow source.fluid to sink.fluid;
        bind source.flowRate = sink.flowRate;
        bind source.pressure = sink.pressure;
    }
    part def Pump {
        attribute outletPressure : PressureValue;
        attribute outletFlowRate : VolumeFlowRateValue;
        port outlet : FluidPort;
        bind outletPressure = outlet.pressure;
        bind outletFlowRate = outlet.flowRate;
    }
    part def Valve {
        attribute inletPressure : PressureValue;
        attribute inletFlowRate : VolumeFlowRateValue;
        port inlet : ~FluidPort;
        bind inletPressure = inlet.pressure;
        bind inletFlowRate = inlet.flowRate;
    }
    part def HydraulicSystem {
        part pump : Pump;
        part valve : Valve;
        connection mainFlow : FluidInterface connect pump.outlet to valve.inlet;
    }
}
view Simplified : DS_Views::SymbolicViews::gv;
view Elaborated : DS_Views::SymbolicViews::gv;
