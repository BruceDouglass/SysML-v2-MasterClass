package RealTimeSystemExample {
    public import Time::*;
    public import SI::*;
    public import ScalarValues::*;
    part def DeviceBase {
        part :>> localClock = new Time::Clock();
        state def DelayedStart {
            state pause;
            first start then pause;
            transition pause accept after 30 [s] then operating;
            state operating;
        }
        state delayedStart : DelayedStart;
    }
    part def SensorHub :> DeviceBase {
        /* Specialize the inherited usage */
        state calibration :>> delayedStart {
            /* Redefine the substate 'operating' */
            state :>> operating {
                action calibrate;
            }
        }
    }
    part def ActuatorUnit :> DeviceBase {
        state selfCheck :>> delayedStart {
            state performinBIT :>> operating {
                action builtInTest;
            }
        }
    }
    part def RealTimeSystem {
        attribute today : String;
        part hub : SensorHub;
        part actuator : ActuatorUnit;
        action def SystemStartup {
            attribute wakeTime : TimeInstantValue = new Time::Iso8601DateTime(today + "T06:00:00Z");
            action waitForWakeTime {
                accept at wakeTime;
            }
            first waitForWakeTime then hub.calibration;
            first start then actuator.selfCheck;
        }
        action startUp : SystemStartup;
    }
    individual part def RealTimeSystem_2026 :> RealTimeSystem {
        attribute :>> today = "2026-10-27";
    }
}
view 'ClocksExample View' : DS_Views::SymbolicViews::gv;
