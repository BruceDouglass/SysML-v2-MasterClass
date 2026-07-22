package PortNamingExample_C4 {
    public import ScalarValues::*;
    item def TargetData;
    item def WeaponCommand;
    item def TargetingCommand;
    port def iTargeting_Weapon {
        out item targetData : TargetData;
        in item command : WeaponCommand;
    }
    port def iTargetingCmds {
        out item targetingCmd : TargetingCommand;
        /* C&D → Targeting */
    }
    /* parts using ports */
    part def CommandAndDecision {
        port pTargetingCmd : iTargetingCmds;
    }
    part def Targeting {
        port pWeapon : iTargeting_Weapon;
        port pTargetingCmd : ~iTargetingCmds;
    }
    part def Weapon {
        port pTargeting : ~iTargeting_Weapon;
    }
    /* ------------------------------------------------------------------*
     * System Assembly
     * ------------------------------------------------------------------*/
    part def C4System {
        part cAndD : CommandAndDecision;
        part targeting : Targeting;
        part weapon : Weapon;
        connect cAndD.pTargetingCmd to targeting.pTargetingCmd;
        connect targeting.pWeapon to weapon.pTargeting;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
