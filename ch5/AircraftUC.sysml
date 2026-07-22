package AircraftUC {
    private import ModelingMetadata::refinement;
    part def Aircraft;
    part def Pilot;
    item def 'Wind Condition';
    requirement MaintainAttitude_Stability;
    requirement MaintainAttitude_LossDetection;
    requirement MaintainAttitude_SensorRedundancy;
    requirement MaintainAttitude_ResponseTime;
    requirement MaintainAttitude_PowerAvailability;
    use case MaintainAircraftAttitude {
        doc
        /* Purpose: See Objective
         * Description: Using on board sensors and control surfaces, 
         * the system maintains roll, pitch and yaw.
         * Preconditions:
         * Post-Conditions:
         * Invariants:  */
        subject vehicle : Aircraft;
        actor driver : Pilot;
        actor wind : 'Wind Condition';
        objective maintainAttitudeObjective {
            doc /* maintain aircraft stability to support flight operations */
            subject vehicle : Aircraft;
            /* pre- and post-conditional constraints go in the Objective */
            assume constraint inAir : Precondition {
                doc /* Aircraft is in flight */
            }
            require constraint stableAttitude : Postcondition {
                doc /* Aircraft stability is maintained */
            }
        }
        /* invariants and generic constraints go here */
        assert constraint sensorAvailability : Invariant {
            doc /* rotational sensors for roll, pitch, and yaw are continuously available */
        }
        #refinement dependency MaintainAircraftAttitude to MaintainAttitude_Stability;
        #refinement dependency MaintainAircraftAttitude to MaintainAttitude_LossDetection;
        #refinement dependency MaintainAircraftAttitude to MaintainAttitude_SensorRedundancy;
        #refinement dependency MaintainAircraftAttitude to MaintainAttitude_ResponseTime;
        #refinement dependency MaintainAircraftAttitude to MaintainAttitude_PowerAvailability;
    }
    constraint def Precondition;
    constraint def Postcondition;
    constraint def Invariant;
}
view 'Aircraft UC View' : DS_Views::SymbolicViews::gv;
