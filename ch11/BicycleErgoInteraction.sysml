package BicycleErgoInteraction {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* --- Payload --- */
    item def GearSetting {
        attribute gearIndex : Integer;
        attribute ratio : Real;
        /* e.g., 2.35 */
    }
    /* port defs */
    port def iRiderErgo {
        out attribute power : PowerValue;
        in attribute resistance : Real;
    }
    port def iErgoDisplay {
        in attribute power : PowerValue;
        in item currentGear : GearSetting;
        /* Ergo -> Display */
    }
    /* --- Structural participants --- */
    part def Rider {
        in attribute riderResistance : Real;
        out attribute riderPower : PowerValue;
        connect riderResistance to pErgometer.resistance;
        connect riderPower to pErgometer.power;
        event occurrence sendGearCmd;
        port pErgometer : iRiderErgo;
    }
    part def Ergometer {
        out attribute providedResistance : Real;
        in attribute receivedPower : PowerValue;
        out item currentGear : GearSetting;
        event occurrence recGearCmd;
        connect providedResistance to pRider.resistance;
        connect receivedPower to pRider.power;
        connect currentGear to pDisplay.currentGear;
        port pRider : ~iRiderErgo;
        port pDisplay : ~iErgoDisplay;
    }
    part def Display {
        in item currentGear : GearSetting;
        connect currentGear to pErgometer.currentGear;
        event occurrence updatedPower;
        port pErgometer : iErgoDisplay;
    }
    /* --- System context & connectors --- */
    part def BicycleErgometerSystem {
        part rider : Rider;
        part ergo : Ergometer;
        part display : Display;
        /* flows */
        flow powerFlow of riderPower : PowerValue from rider.pErgometer.power to ergo.pRider.power;
        flow resistanceFlow of resistanceBack : Real from ergo.pRider.resistance to rider.pErgometer.resistance;
        flow wattFlow of displayWatts : PowerValue from ergo.pDisplay.power to display.pErgometer.power;
        /* --- Messages  */
        message gearCmdMsg of cg : GearSetting from rider.sendGearCmd to ergo.recGearCmd;
        message gearNoticeMsg of GearSetting from ergo.recGearCmd to display.updatedPower;
        /* orchestration sketch */
        action def Session {
            in flow gearCommand;
            in flow gearNotice;
            first start then gearCommand;
            first gearCommand then gearNotice;
            first start then gearCommand;
            first gearCommand then gearNotice;
        }
        action session : Session {
            in flow gearCommand = gearCmdMsg;
            in flow gearNotice = gearNoticeMsg;
        }
    }
}
