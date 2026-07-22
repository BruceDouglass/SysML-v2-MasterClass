package GreenhouseExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    public import Time::*;
    /* --- Reusable actions --- */
    action def RegulateTemperature {
        in attribute targetTemp : TemperatureValue;
        action measureTemp;
        action adjustHeater;
        first start;
        then measureTemp;
        first measureTemp then adjustHeater;
    }
    action def IrrigatePlants {
        action openValve;
        action closeValve;
        first start then openValve;
        first openValve then closeValve;
    }
    action def ReportStatus {
        action gatherData;
        action sendReport;
        first start then gatherData;
        first gatherData then sendReport;
    }
    /* --- Structural parts --- */
    part def ClimateController {
        action regulate : RegulateTemperature { in targetTemp = 22 ['°C']; }
    }
    part def WateringUnit {
        action irrigationCycle : IrrigatePlants;
    }
    part def GreenhouseSystem {
        part climate : ClimateController;
        part watering : WateringUnit;
        /* --- 1. Perform Action WITH Reference --- */
        perform action maintainClimate ::> climate.regulate;
        /* --- 2. Perform Action WITHOUT Reference --- */
        perform action generateStatusReport;
        /* This declares a perform action that has no explicit reference yet.
         * It means: “The GreenhouseSystem performs a ReportStatus-like behavior,”
         * even if we haven’t connected it to a specific definition or usage yet.
         * Later, we could redefine this to reference ReportStatus. */
        /* --- 3. Anonymous Perform --- */
        perform watering.irrigationCycle;
        /* --- 4. Simple Action (no perform) --- */
        action internalDiagnostics : ReportStatus;
        /* --- Orchestration (Sequencing) --- */
        action dailyRoutine {
            first Parts::Part::start;
            then maintainClimate;
            then generateStatusReport;
            then watering.irrigationCycle;
            then internalDiagnostics;
        }
    }
    view 'GreenhouseExample View' : DS_Views::SymbolicViews::gv;
}
