package MissionThreadExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* Domain participants (structural types) */
    part def Ship {
        port pCommander;
        port pRadar : ~iTrack;
        port pMissile : iMissileComms;
    }
    part def Radar {
        port pTrackClient : iTrack;
    }
    part def Missile;
    item def MissileMessage;
    part def Commander {
        port pSystem;
    }
    /* Operational information entity */
    item def Position;
    item def Track {
        attribute trackID : Integer;
        item pos : Position;
        attribute confidence : Real;
    }
    /* Interfaces */
    port def iTrack {
        out item trackOut : Track;
    }
    port def iMissileComms {
        out item msg : MissileMessage;
    }
    /* Mission thread as an occurrence definition */
    occurrence def DefendMissionThread {
        part commander : Commander;
        part ship : Ship;
        part radar : Radar;
        part enemyMissile : Missile;
        part interceptorMissile : Missile {
            port pMaster : ~iMissileComms;
        }
        /* Connections between system participants */
        connect radar.pTrackClient to ship.pRadar;
        connect interceptorMissile.pMaster to ship.pMissile;
        connect commander.pSystem to ship.pCommander;
        flow track : Track from radar.pTrackClient.trackOut to ship.pRadar.trackOut;
        flow of Position from enemyMissile to radar;
        flow of MissileMessage from ship.pMissile to interceptorMissile.pMaster;
    }
}
view 'TrackOccurrences View' : DS_Views::SymbolicViews::gv;
