package FlowVsMessageEndPoints {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* --- Data and Item Definitions (Payloads) --- */
    item def PacingPulse;
    /* --- Component Definitions (Prototypes) --- */
    part def SensorUnit {
        out attribute sensedVoltage : SourceVoltageValue;
    }
    part def Controller {
        in attribute dataIn : SourceVoltageValue;
        event occurrence commandReady;
        event occurrence ackReceived;
    }
    part def Engine {
        event occurrence pulseReceived;
    }
    /* --- System Context (Where Usages and Connections Live) --- */
    part def SystemContext {
        part sensorUnit : SensorUnit;
        part controller : Controller;
        part engine : Engine;
        /* --- 2. STREAMING FLOW: Continuous, Structural Transfer --- */
        /* Flows connect features of PART USAGES (occurrences), bound to structural 
         * features (attributes/ports). The transfer is continuous over time.
         */
        flow continuousData of SourceVoltageValue from sensorUnit.sensedVoltage to controller.dataIn;
        /* --- 3. MESSAGE: Discrete, Event-Based Transfer --- */
        /* Messages connect Event Occurrence Usages (temporal markers) 
         * of occurrences. The transfer is instantaneous.
         */
        action a1 {
            message paceCommand of pp : PacingPulse from controller.commandReady to engine.pulseReceived;
            message paceAck of ok : Boolean from engine.pulseReceived to controller.ackReceived;
            succession sendPace first start then paceCommand;
            succession thenAck first paceAck then paceAck;
        }
        succession paceThatGuy first controller.commandReady then engine.pulseReceived;
    }
    view 'FlowVsMessageEndPoints VIew' : DS_Views::SymbolicViews::gv;
}
