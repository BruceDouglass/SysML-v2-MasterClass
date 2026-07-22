package 'Connection Example Pkg' {
    public import Parts::*;
    public import Ports::*;
    public import Connections::*;
    public import ScalarValues::*;
    public import SI::*;
    /* Define a simple pressure port */
    port def PressurePort {
        out attribute pressure : PressureValue;
    }
    /* Component parts */
    part def Pump {
        attribute outletPressure : PressureValue;
        port outlet : PressurePort;
        port backupOutlet : PressurePort;
    }
    part def Valve {
        attribute inletPressure : PressureValue;
        port inlet : ~PressurePort;
        port backupInlet : ~PressurePort;
    }
    part def Sensor {
        attribute measuredPressure : PressureValue;
    }
    /* Regular connection type: fluid link between parts */
    connection def FluidConnection {
        end source : Port;
        end sink : Port;
    }
    /* Regular connection type: link between ports */
    /* System assembly */
    part def HydraulicSystem {
        part pump : Pump;
        part valve : Valve;
        part sensor : Sensor;
        /* 1) Regular connection (parts): pump → valve */
        connect pump to sensor;
        /* 2) Binding connection (values): valve.inletPressure == sensor.measuredPressure */
        bind valve.inletPressure = sensor.measuredPressure;
        /* 3) Regular connection (ports): pump.outlet ↔ valve.inlet */
        connect pump.outlet to valve.inlet;
        connection pl : FluidConnection connect pump.backupOutlet to valve.backupInlet;
    }
}
