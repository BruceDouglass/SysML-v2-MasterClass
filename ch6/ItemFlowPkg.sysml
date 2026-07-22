package ItemFlowPkg {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    /* -------------------------------*
     * Items (things that flow)       *
     * -------------------------------*/
    item def ControlSignal {
        attribute value : Real;
        attribute sourceId : String;
    }
    item def PowerFeed {
        attribute current : ElectricCurrentValue;
        attribute voltage : ElectricPotentialValue;
    }
    item def ActuatorOutput {
        attribute displacement : LengthValue;
        attribute force : ForceValue;
    }
    item def ActuatorStatus {
        attribute isOperational : Boolean;
        attribute temperature : ThermodynamicTemperatureValue;
    }
    /* -------------------------------*
     * Parts (structural elements)    *
     * -------------------------------*/
    part def Controller {
        out item signalOut : ControlSignal;
        in item statusIn : ActuatorStatus;
    }
    part def PowerSupply {
        out item powerOut : PowerFeed;
    }
    part def Actuator {
        in item signalIn : ControlSignal;
        in item powerIn : PowerFeed;
        out item mechOut : ActuatorOutput;
        out item statusOut : ActuatorStatus;
    }
    part def MechanicalLoad {
        in item input : ActuatorOutput;
    }
    /* -------------------------------*
     * System composed of parts       *
     * -------------------------------*/
    part def ActuatedSystem {
        part controller : Controller;
        part supply : PowerSupply;
        part actuator : Actuator;
        part load : MechanicalLoad;
        /* Explicit item flows on the connectors */
        flow controlFlow : ControlSignal from controller.signalOut to actuator.signalIn;
        flow powerFlow : PowerFeed from supply.powerOut to actuator.powerIn;
        flow statusFlow : ActuatorStatus from actuator.statusOut to controller.statusIn;
        flow mechanicalFlow : ActuatorOutput from actuator.mechOut to load.input;
    }
}
view 'ItemFlow Example View' : DS_Views::SymbolicViews::gv;
