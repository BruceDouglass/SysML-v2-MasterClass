package FlightSystemDependencies {
    public import ScalarValues::*;
    public import SI::*;
    part def NavigationProcessor {
        attribute positionAccuracy : Real;
        /* meters */
        doc /* Provides navigation and position data to other subsystems. */
    }
    part def FlightControlComputer {
        attribute updateRate : FrequencyValue;
        doc /* Executes flight-control laws based on navigation data. */
    }
    /* Binary dependency */
    dependency FlightControlComputer to NavigationProcessor {
        doc /* FlightControlComputer depends on NavigationProcessor for position updates. */
    }
}
package MissionSystemDependencies {
    public import ScalarValues::*;
    public import SI::*;
    part def MissionComputer {
        attribute computationalLoad : Real;
        doc /* Central computing unit performing mission management and sensor fusion. */
    }
    part def PowerSubsystem {
        attribute outputVoltage : SourceVoltageValue;
    }
    part def FlightSoftware {
        attribute versionID : String;
    }
    part def SensorNetwork {
        attribute dataRate : Real;
    }
    /* N-ary dependency: one client, multiple suppliers */
    dependency MissionComputerDependencies from MissionComputer to PowerSubsystem, FlightSoftware, SensorNetwork {
        doc /* MissionComputer depends on power, software, and sensor data availability. */
    }
}
