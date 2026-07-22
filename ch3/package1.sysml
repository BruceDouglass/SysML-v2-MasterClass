package package1 {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    part def User;
    part def WallPower;
    part def 'Microwave Oven' {
        action cook;
        action setCountDownTimer { in time : DurationValue; }
        action setPowerLevel { in pw : PowerValue; }
        satisfy SetPowerReq by SetPowerReq::'Microwave Oven';
        satisfy DoorClosedReq by DoorClosedReq::'Microwave Oven';
    }
    requirement SetPowerReq {
        subject 'Microwave Oven';
        doc /* The system shall radiate microwaves at a commanded power level between 0 and 2000W. */
        attribute powerLevel : PowerValue [W];
        constraint powerConstraint {
            powerLevel >= 0 [W] and powerLevel <= 2000 [W]
        }
    }
    requirement DoorClosedReq {
        subject 'Microwave Oven';
        doc /* The oven shall only emit microwaves when the door is latched closed. */
    }
    use case CookFood {
        subject 'Microwave Oven';
        objective {
            doc /* The microwave should cook food  */
        }
        actor microwaveCook : User;
        actor powerSupply : WallPower;
        dependency R1 from CookFood to SetPowerReq;
    }
    analysis RadiationSafety {
        subject 'Microwave Oven';
        objective {
            doc /* Ensure the user isn't subjected to high levels of radiation */
        }
        attribute emittedRadiation : PowerValue [W];
        constraint {
            emittedRadiation < 0.005 [W]
        }
    }
    verification 'Door Closed Test' {
        subject 'Microwave Oven';
        objective {
            doc /* microwave should not emit when the door is open */
            verify DoorClosedReq {
                subject 'Microwave Oven';
            }
        }
    }
}
