package GreenhouseOverviewExamplePkg {
    public import StandardViewDefinitions::*;
    public import Views::*;
    public import ScalarValues::*;
    part def GreenhouseController;
    package CapabilitiesPkg {
        /* What the system does for its users and environment (capabilities). */
        part def Grower;
        occurrence def Weather;
        use case MaintainClimate {
            subject controller : GreenhouseController;
            actor grower : Grower;
            actor weather : Weather;
            objective {
                doc /* Temperature and humidity maintained within configured limits. */
            }
        }
        use case ViewStatusAndAlarms {
            subject controller : GreenhouseController;
            actor grower : Grower;
            objective {
                doc /* Current conditions and alarms are visible to the grower. */
            }
        }
        view 'Capabilities View' : GeneralView;
        view 'Use Case Context View' : GeneralView;
    }
    package RequirementsPkg {
        /* Requirements that constrain what the greenhouse controller must do and how well it must do it. */
        requirement MaintainTemperatureReq {
            subject controller : GreenhouseController;
            doc /* The controller shall maintain greenhouse air temperature between 18°C and 30°C under nominal conditions. */
        }
        requirement MaintainHumidityReq {
            subject controller : GreenhouseController;
            doc /* The controller shall maintain greenhouse relative humidity between 40% and 70% under nominal conditions. */
        }
        requirement AlarmOnSensorFaultReq {
            subject controller : GreenhouseController;
            doc /* The controller shall raise an alarm when a sensor reading is implausible. */
        }
        view 'Requirements View' : GeneralView;
        view 'Requirements Trace View' : GeneralView;
    }
    package ArchitecturePkg {
        /* Structural decomposition and key interactions of the greenhouse controller. */
        part def TempSensor;
        part def HumiditySensor;
        part def Heater;
        part def VentFan;
        part def Display;
        part def GreenhouseController {
            part tempSensor : TempSensor;
            part humiditySensor : HumiditySensor;
            part heater : Heater;
            part fan : VentFan;
            part display : Display;
        }
        view 'Architecture Composition View' : GeneralView;
        view 'Architecture Interconnection View' : GeneralView;
    }
    package AnalysesPkg {
        /* Analyses used to evaluate whether requirements are achievable and to guide design choices. */
        analysis NominalHeatBalance {
            subject controller : GreenhouseController;
            objective {
                doc /* Assess steady-state heating capacity under nominal weather conditions. */
            }
        }
        analysis NominalHumidityBalance {
            subject controller : GreenhouseController;
            objective {
                doc /* Assess steady-state humidity control under nominal loads. */
            }
        }
        view 'Analyses View' : GeneralView;
    }
    package VerificationPkg {
        /* Verification cases and evidence expectations. */
        public import VerificationCases::*;
        verification def TestCase {
            subject controller : GreenhouseController;
        }
        verification TempControlTest : TestCase {
            doc /* Verify temperature regulation behavior under nominal conditions. */
            objective {
                verify RequirementsPkg::MaintainTemperatureReq;
            }
            return verdict : VerdictKind;
        }
        verification HumidityControlTest : TestCase {
            doc /* Verify humidity regulation behavior under nominal conditions. */
            objective {
                verify RequirementsPkg::MaintainHumidityReq;
            }
            return verdict : VerdictKind;
        }
        verification SensorFaultAlarmTest : TestCase {
            doc /* Verify alarm behavior on implausible sensor readings. */
            objective {
                verify RequirementsPkg::AlarmOnSensorFaultReq;
            }
            return verdict : VerdictKind;
        }
        view 'Verification View' : GeneralView;
        view 'Verification Trace View' : GeneralView;
    }
    package ModelOverviewPkg {
        /* Purpose:
         * Model a simple greenhouse monitoring and control system that maintains healthy growing conditions.
         *
         * Stakeholders:
         * - Grower: wants reliable, easy-to-use control of temperature and humidity.
         * - Facility Owner: wants safe operation and predictable operating cost.
         * - Maintenance Technician: wants diagnosable behavior and clear fault indication.
         *
         * Fit-for-purpose criteria:
         * - Maintains temperature and humidity within specified ranges under nominal conditions.
         * - Detects sensor faults and fails to a safe control posture.
         * - Provides operator-visible status and alarms.
         *
         * Means for verification:
         * - Verification cases for sensor plausibility checks, setpoint tracking, and alarm behavior.
         * - Analysis cases for steady-state heat/humidity balance under nominal loads.
         * - Traceability from use cases and requirements to architecture elements and verification artifacts. */
        view 'Model Overview Diagram' : DS_Views::SymbolicViews::gv;
    }
}
