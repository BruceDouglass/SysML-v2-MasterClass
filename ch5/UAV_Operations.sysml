package UAV_Operations {
    public import ScalarValues::*;
    /* issues to be addressed */
    concern def 'Battery Safety Concern' {
        subject UAV;
        attribute minReserveLevel : Real = 0.15;
        attribute remainingBattery : Real;
        doc
        /* UAV operations shall maintain sufficient battery reserves 
         * to ensure a safe return-to-base or emergency landing. 
         * This concern captures energy safety margins that must 
         * be preserved across all mission profiles. */
        assume constraint {
            remainingBattery >= 0.0 and remainingBattery <= 1.0
        }
        require constraint {
            remainingBattery >= minReserveLevel
        }
    }
    /* structural things */
    occurrence def Weather;
    part def GroundOperator;
    part def MissionPlanner;
    part def UAV {
        attribute batteryLevel : Real;
        attribute payloadMass : Real;
    }
    /* use case */
    use case ConductSurveillanceUC {
        subject drone : UAV;
        actor weather : Weather;
        actor groundOperator;
        GroundOperator;
        actor planner : MissionPlanner;
        concern batterySafety : 'Battery Safety Concern';
        concern weatherRisk {
            doc
            /* Severe winds, icing, or turbulence may compromise 
             * mission success or threaten UAV integrity. */
        }
        doc
        /* The UAV performs a scheduled surveillance mission along 
         * a predefined route. The ground operator initiates the 
         * mission, and the UAV autonomously navigates, captures 
         * imagery, and maintains operational safety margins while 
         * monitoring energy reserves and environmental conditions. */
    }
}
