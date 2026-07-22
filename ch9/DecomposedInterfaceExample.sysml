package DecomposedInterfaceExample {
    public import ScalarValues::*;
    public import SI::*;
    attribute <'L/s'> litersPerSec :> volumeFlowRate;
    /* -----------------------------------------
     * 1. Domain-specific subports and interfaces
     * -----------------------------------------*/
    port def FluidPort {
        out attribute flowRate : VolumeFlowRateValue;
        in attribute pressure : PressureValue;
    }
    interface def FluidInterface {
        end source : FluidPort;
        end sink : ~FluidPort;
        bind source.flowRate = sink.flowRate;
        bind source.pressure = sink.pressure;
    }
    port def PowerPort {
        out attribute voltage : SourceVoltageValue;
        out attribute current : ElectricCurrentValue;
    }
    interface def ElectricalInterface {
        end source : PowerPort;
        end sink : ~PowerPort;
        bind source.voltage = sink.voltage;
        bind source.current = sink.current;
    }
    /* -----------------------------------------
     * 2. Composite port and decomposed interface
     * -----------------------------------------*/
    port def ElectroHydraulicPort {
        port fluid : FluidPort;
        port power : PowerPort;
    }
    interface def ElectroHydraulicInterface {
        end source : ElectroHydraulicPort;
        end sink : ~ElectroHydraulicPort;
        /* Decompose into subinterfaces */
        interface fluidLink : FluidInterface;
        interface powerLink : ElectricalInterface;
        connect source.fluid to sink.fluid;
        connect source.power to sink.power;
        /* Coordinate the subinterfaces */
        bind source.fluid = fluidLink.source;
        bind sink.fluid = fluidLink.sink;
        bind source.power = powerLink.source;
        bind sink.power = powerLink.sink;
        /* Optional cross-domain constraint */
        assert constraint {
            powerLink.source.voltage > 0 [V] implies fluidLink.source.flowRate > 0 ['L/s']
        }
    }
    /* -----------------------------------------
     * 3. Parts using the composite port
     * -----------------------------------------*/
    part def Actuator {
        port supply : ~ElectroHydraulicPort;
    }
    part def ControlModule {
        port output : ElectroHydraulicPort;
    }
    part def System {
        part controller : ControlModule;
        part actuator : Actuator;
        connection electrohydraulic connect actuator.supply to controller.output;
    }
}
view 'Usages View' : DS_Views::SymbolicViews::gv;
view 'Defs  View' : DS_Views::SymbolicViews::gv;
