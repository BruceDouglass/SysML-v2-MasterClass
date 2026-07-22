package UCParametersExample {
    private import ScalarValues::*;
    private import RealFunctions::*;
    /* --- type declarations used by the scenario ----------------------- */
    part def Aircraft {
        attribute currentAirSpeed : Real;
    }
    part def Pilot;
    item def WindSpeedReading {
        attribute value : Real;
    }
    /* --- use-case definition ------------------------------------------ */
    use case maintainAirSpeed {
        subject aircraft : Aircraft;
        actor pilot : Pilot;
        /* parameters that cross the subject boundary */
        in item wind : WindSpeedReading;
        in attribute commandedSpeed : Real;
        objective {
            doc /* Maintain the aircraft’s true air speed within ±2 knots of the commanded value.*/
            assume constraint pre_validCommand {
                in cmdSpeed : Real = commandedSpeed;
                cmdSpeed > 0.0
            }
            require constraint post_speedMaintained {
                in cmdSpeed : Real = commandedSpeed;
                in part aircraft : Aircraft;
                abs(aircraft.currentAirSpeed - cmdSpeed) <= 2.0
            }
        }
    }
}
