package TemporalSlicesAndShots {
    public import ScalarValues::*;
    public import SI::*;
    public import Time::*;
    /* One occurrence partitioned into slices, with named snapshots */
    occurrence def PowerCycle {
        attribute t : DateTime;
        /* --- Time slices (sub-intervals of this occurrence’s lifetime) --- */
        timeslice rampUp;
        timeslice steady;
        timeslice coolDown;
        /* --- Snapshots (zero-duration instants) --- */
        snapshot t0 {
            /* explicit timestamp */
            :>> time = 0 [s];
        }
        snapshot tMid;
        /* constrained to lie within steady */
        snapshot tEnd {
            /* explicit timestamp */
            :>> time = 120 [s];
        }
        /* --- Sequencing (readable, declarative order) --- */
        first rampUp then steady;
        first steady then coolDown;
        /* --- Well-formedness & non-overlap via startShot/endShot --- */
        assert constraint {
            TimeOf(rampUp.startShot) < TimeOf(rampUp.endShot) and TimeOf(steady.startShot) < TimeOf(steady.endShot) and
                    TimeOf(coolDown.startShot) < TimeOf(coolDown.endShot) and TimeOf(rampUp.endShot) <= TimeOf(steady.startShot) and
                            TimeOf(steady.endShot) <= TimeOf(coolDown.startShot)
        }
        /* --- Anchor snapshots to lifetime boundaries --- */
        assert constraint {
            TimeOf(t0) == TimeOf(rampUp.startShot) and TimeOf(tEnd) == TimeOf(coolDown.endShot)
        }
        /* --- Constrain tMid within the steady slice (§9.7.2.2.4 pattern) --- */
        assert constraint {
            TimeOf(steady.startShot) <= TimeOf(tMid) and TimeOf(tMid) <= TimeOf(steady.endShot)
        }
        /* --- Duration reasoning using slices & snapshots --- */
        assert constraint {
            DurationOf(steady) >= 30 [s]
        }
        assert constraint {
            DurationOf(rampUp) + DurationOf(steady) + DurationOf(coolDown) == TimeOf(tEnd) - TimeOf(t0)
        }
    }
    view 'Temporal Slices & Shots' : DS_Views::SymbolicViews::gv;
}
