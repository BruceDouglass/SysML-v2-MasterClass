package UCContextualPatterPkg {
    public import ScalarValues::*;
    occurrence def Weather;
    part def Aircraft {
        flightPlan : String [*];
        planSubmitted : Boolean;
    }
    part def Person {
        isLoggedIn : Boolean;
    }
    part def AirTrafficControl {
        calc hasFiledPlan {
            in aircraft : Aircraft;
            return Boolean;
            aircraft.flightPlan != null & aircraft.planSubmitted
        }
    }
    use case fileFlightPlan {
        subject aircraft : Aircraft;
        actor pilot [1] : Person;
        actor atc : AirTrafficControl;
        actor weather : Weather;
        objective {
            doc /* Flight plan filed and acknowledged */
            assume constraint loggedin {
                pilot.isLoggedIn
            }
            require constraint {
                atc.hasFiledPlan(aircraft)
            }
        }
    }
}
