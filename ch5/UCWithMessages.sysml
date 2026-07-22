package UCWithMessages {
    private import ScalarValues::*;
    part def Aircraft {
        attribute airspeed : Real;
        attribute weightOnWheels : Boolean;
    }
    part def Pilot;
    item def Wind;
    item def SpeedCmdMsg {
        attribute cmdSpeed : Real;
    }
    item def SpeedMsg {
        attribute timeStamp;
        attribute speed : Real;
    }
    use case maintainAirSpeed {
        subject aircraft : Aircraft;
        actor pilot : Pilot;
        actor wind : Wind;
        message enable from pilot to aircraft;
        then message systemIsOn from aircraft to pilot;
        then message setAirspeed : SpeedCmdMsg from pilot to aircraft;
        if not aircraft.weightOnWheels {
            then message speedm : SpeedMsg from aircraft to pilot;
        } else {
            message notAirborne from aircraft to pilot;
        }
    }
}
