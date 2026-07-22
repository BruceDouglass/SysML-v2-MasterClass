package ConjugatedBidirectionalPorts {
    public import ScalarValues::*;
    item def CommandResult {
        attribute status : String;
        attribute msg : String;
    }
    item def TelemetryConfig {
        attribute sampleRateHz : Integer;
        attribute mode : String;
    }
    port def CommandInterface {
        in attribute commandText : String;
        out item result : CommandResult;
    }
    port def TelemetryInterface {
        out attribute telemetryCode : String;
        in item configUpdate : TelemetryConfig;
    }
    part def DeviceController {
        port cmdPort : CommandInterface;
        port telemPort : ~TelemetryInterface;
    }
    part def CommandClient {
        port cmdClient : ~CommandInterface;
    }
    part def TelemetrySensor {
        port telemPort : TelemetryInterface;
    }
    occurrence def SystemContext {
        part controller : DeviceController;
        part commandClient : CommandClient;
        part telemetrySensor : TelemetrySensor;
        connect commandClient.cmdClient to controller.cmdPort;
        connect telemetrySensor.telemPort to controller.telemPort;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
