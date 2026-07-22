package DroneExhibitExample {
    public import ScalarValues::*;
    public import SI::*;
    public import Time::*;
    /* External events */
    item evStart;
    item evClimb;
    item evLand;
    /* ---------------------------------------------
     * Flight Controller (referenced by Drone)
     * ---------------------------------------------*/
    part def FlightController {
        action beginAscent;
        action processWaypointUpdate;
        action prepareForDescent;
    }
    /* ---------------------------------------------
     * Reusable Flight Modes State Machine Definition
     * (DEFINED ELSEWHERE — not owned by Drone)
     * ---------------------------------------------*/
    state def FlightModes {
        in controller : FlightController;
        first start then Idle;
        state Idle;
        transition startTakeoff first Idle accept evStart then TakeoffMode;
        state TakeoffMode {
            entry controller.beginAscent;
        }
        transition climb first TakeoffMode accept evClimb then ClimbMode;
        state ClimbMode {
            entry controller.processWaypointUpdate;
        }
        /* Relative-time trigger INSIDE the exhibited (referential) behavior */
        transition navTicked first ClimbMode accept after 5 [s] then ClimbMode;
        transition land first ClimbMode accept evLand then LandingMode;
        state LandingMode {
            entry controller.prepareForDescent;
        }
    }
    /* State *usage* to be exhibited */
    state flightModes : FlightModes;
    /* ---------------------------------------------
     * Drone PART (owns localClock, references controller,
     * and exhibits flightModes)
     * ---------------------------------------------*/
    part def Drone {
        /* Drone's local clock */
        part localClock : Time::Clock;
        /* Owned timing parameter that uses Drone.localClock */
        attribute healthCheckPeriod : Real = 10.0 [s];
        /* REF part: controller does NOT inherit Drone.localClock */
        ref part flightController : FlightController;
        /* Composite behavior: uses Drone.localClock */
        state HealthMonitoring {
            first start then Monitoring;
            state Monitoring;
            transition periodicCheck first Monitoring accept after healthCheckPeriod [s] then Monitoring;
            /* driven by Drone.localClock */
        }
        /* Exhibited behavior: referential, does NOT use Drone.localClock */
        exhibit flightModes : FlightModes {
            in controller = flightController;
        }
    }
}
view DroveStateView : DS_Views::SymbolicViews::gv;
