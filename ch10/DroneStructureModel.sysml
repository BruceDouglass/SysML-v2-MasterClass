package DroneStructureModel {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* Interface contracts (directionality declared inside) */
    item def EphemerisData;
    port def iPayload {
        out attribute payloadDoorStatus : Boolean;
        in attribute payloadPosition : Real;
    }
    port def iComms {
        out attribute telemetry : String;
        out attribute position : String;
        in cmdSpeed : Real;
        in attribute speed : SpeedValue;
        in attribute orientation : AngularMeasureValue;
    }
    port def iPropulsion {
        in attribute throttleCmd : Real;
    }
    port def iGPS {
        in item ephemerisData : EphemerisData;
    }
    port def iPosition {
        in attribute position : String;
    }
    port def iExternalComm {
        inout item msg : ProtocolMsg;
    }
    item def ProtocolMsg;
    /* Structural participants */
    part def Propulsion {
        attribute maxThrust : ForceValue;
        attribute rpm : FrequencyValue;
        port pAvionics : iPropulsion;
        /* connects to Avionics */
    }
    part def Avionics {
        attribute swVersion : String;
        port pPropulsion : ~iPropulsion;
        /* connects to Propulsion */
        port pPayload : ~iPayload;
        /* connects to PayloadBay */
        port pComms : iComms;
        /* connects to CommsLink */
        port pGnss : iPosition;
        /* connects to GNSS */
        attribute speed : SpeedValue;
        attribute rotationalAngle : AngularMeasureValue;
    }
    part def GPSReceiver {
        attribute fixQuality : Integer;
        port pAvionics : ~iPosition;
        port pGPS : iGPS;
        /* connects to Avionics */
    }
    part def CommsLink {
        port pAvionics : ~iComms;
        /* connects to Avionics */
        port pExtComms : iExternalComm;
    }
    part def PayloadBay {
        attribute capacity : MassValue;
        attribute doorOpen : Boolean;
        port pAvionics : iPayload;
        /* connects to Avionics */
    }
    /* System composition */
    part def Drone {
        part propulsion : Propulsion;
        part avionics : Avionics;
        part gpsReceiver : GPSReceiver;
        part comms : CommsLink;
        part payload : PayloadBay;
        port pGPS : iGPS;
        port pExtComms : iExternalComm;
        /* Behavioral-invocation links via ports (named by peer) */
        connect avionics.pPropulsion to propulsion.pAvionics;
        connect avionics.pPayload to payload.pAvionics;
        connect gpsReceiver.pAvionics to avionics.pGnss;
        connect comms.pAvionics to avionics.pComms;
        connect gpsReceiver.pGPS to pGPS;
        connect comms.pExtComms to pExtComms;
    }
    view 'DroneStructureModel view' : DS_Views::SymbolicViews::gv;
}
