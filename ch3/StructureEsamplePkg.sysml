package StructureEsamplePkg {
    public import ScalarValues::*;
    calc def ReportChargeLevel {
        in pack : BatteryPack;
        return soc : Real;
        soc := pack.energy / pack.energyMax;
    }
    action def chargeBattery {
        inout pack : BatteryPack;
        in kilowattH : Real;
        attribute newEnergy : Real := RealFunctions::min(pack.energy + kilowattH, pack.energyMax);
    }
    item def BatteryPack {
        attribute mass : Real;
        attribute energyMax : Real;
        attribute energy : Real;
        /* expose reusable behavior */
        calc reportChargeLevel : ReportChargeLevel;
        action charge : chargeBattery;
    }
    part def EV {
        part mainBattery : BatteryPack {
            perform charge;
        }
        attribute curbMass : Real;
        /* EV level action that queries the battery and reacts */
        action def checkBattery {
            in ev : EV;
            out warningIssued : Boolean;
            attribute soc : Real := ev.mainBattery.reportChargeLevel(ev.mainBattery);
            if soc < 0.2 {
                warningIssued := true;
            } else {
                warningIssued := false;
            }
        }
    }
}
