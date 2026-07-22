package MotorControl_SpecStyle {
    public import ScalarValues::*;
    public import ISQ::*;
    /* ------------------------------------------------------------------ *
     * Flow type for electrical energy transfer
     * ------------------------------------------------------------------ */
    item def ElectricFlow {
        attribute current : ElectricCurrentValue;
        attribute voltage : SourceVoltageValue;
        attribute frequency : FrequencyValue;
    }
    /* ------------------------------------------------------------------ *
     * Messages for command/feedback
     * ------------------------------------------------------------------ */
    flow Enable;
    flow Disable;
    flow SetSpeed {
        attribute speed : Real;
    }
    /* RPM */
    flow CurrentSpeed {
        attribute speed : Real;
    }
    /* RPM */
    /* ------------------------------------------------------------------ *
     * Interaction contracts (port definitions)
     * ------------------------------------------------------------------ */
    /* Power path: supply → motor (item flow) */
    port def iPower_Client {
        out item power : ElectricFlow;
        /* provided by the source */
    }
    /* Control path: controller → motor (commands), motor → controller (status) */
    port def iController_Motor {
        out flow Enable;
        out flow Disable;
        out flow SetSpeed;
        in flow CurrentSpeed;
    }
    /* ------------------------------------------------------------------ *
     * Parts
     * ------------------------------------------------------------------ */
    part def PowerSupply {
        port pPowerClient : iPower_Client;
        /* provides ElectricFlow */
    }
    part def Motor {
        port pPower : ~iPower_Client;
        /* consumes ElectricFlow */
        port pController : ~iController_Motor;
        /* receives commands, sends status */
        attribute speed : Real = 0.0;
        /* §7.17.8 accept ... via <port> */
        action serve {
            in part fromPart : Controller;
            /* enable */
            accept Enable via pController;
            assign speed := 1000.0;
            /* §7.17.7 send ... via <port> to <destination> */
            send new CurrentSpeed(CurrentSpeed::speed) via pController to fromPart;
            /* set speed */
            action speedCmd accept cmd : SetSpeed via pController;
            assign speed := speedCmd.cmd.speed;
            send new CurrentSpeed(CurrentSpeed::speed) via pController to fromPart;
            /* disable */
            accept Disable via pController;
            assign speed := 0.0;
            send new CurrentSpeed(CurrentSpeed::speed) via pController to fromPart;
        }
    }
    part def Controller {
        port pMotor : iController_Motor;
        /* sends commands, accepts status */
        /* §7.17.7 send ... via <port> to <destination>
         * §7.17.8 accept ... via <port> (named and unnamed forms) */
        action operate {
            in part motor : Motor;
            send Enable via pMotor to motor;
            send new SetSpeed(2500.0) via pMotor to motor;
            accept msg : CurrentSpeed via pMotor;
            /* Equivalent unnamed accept of the same payload type */
            accept CurrentSpeed via pMotor;
            send Disable via pMotor to motor;
        }
    }
    /* ------------------------------------------------------------------ *
     * System assembly
     * ------------------------------------------------------------------ */
    part def MotorSystem {
        part theSupply : PowerSupply;
        part theMotor : Motor;
        part theController : Controller;
        /* Power path: same contract, one side conjugated */
        connect theSupply.pPowerClient to theMotor.pPower;
        /* Control path: same contract, one side conjugated */
        connect theController.pMotor to theMotor.pController;
        action run {
            perform theController.operate {
                motor = theMotor;
            }
            perform theMotor.serve {
                ctrl = theController;
            }
        }
    }
}
package PortNamingExample_C4 {
    public import ScalarValues::*;
    /* ------------------------------------------------------------------*
     * Domain Items
     * ------------------------------------------------------------------*/
    item def TargetData;
    item def WeaponCommand;
    item def TargetingCommand;
    /* ------------------------------------------------------------------*
     * Port Definitions (interaction contracts)
     * ------------------------------------------------------------------*/
    /* Targeting (unconjugated) ↔ Weapon (conjugated) */
    port def iTargeting_Weapon {
        out item targetData : TargetData;
        /* Targeting → Weapon */
        in item command : WeaponCommand;
        /* Weapon → Targeting */
    }
    /* Command-and-Decision (unconjugated) → Targeting (conjugated) */
    port def iTargetingCmds {
        out item targetingCmd : TargetingCommand;
        /* C&D → Targeting */
    }
    /* ------------------------------------------------------------------*
     * Parts and Ports
     * ------------------------------------------------------------------*/
    part def CommandAndDecision {
        /* Semantically named port issuing commands to Targeting */
        port pTargetingCmd : iTargetingCmds;
    }
    part def Targeting {
        /* Port named for connected part definitions */
        port pWeapon : iTargeting_Weapon;
        /* connects to Weapon */
        port pTargetingCmd : ~iTargetingCmds;
        /* receives commands from C&D */
    }
    part def Weapon {
        /* Port named for the connected part (Targeting) */
        port pTargeting : ~iTargeting_Weapon;
        /* conjugated interface */
    }
    /* ------------------------------------------------------------------*
     * System Assembly
     * ------------------------------------------------------------------*/
    part def C4System {
        part cAndD : CommandAndDecision;
        part targeting : Targeting;
        part weapon : Weapon;
        /* Connections using same port defs; one side conjugated */
        connect targeting.pWeapon to weapon.pTargeting;
        /* iTargeting_Weapon ↔ ~iTargeting_Weapon */
        connect cAndD.pTargetingCmd to targeting.pTargetingCmd;
        /* iTargetingCmds ↔ ~iTargetingCmds */
        /* This port pair and port definition are named using the partipant rule of p<target participant> for the port usage and i<unconjugated participant>_<conjugated participant> using the participant naming rule for the port definition*/
        /* This port pair and port definition are named using the semantic information naming rule of p<info name> for the port name and i<info name> for the port definition. */
    }
}
package EncapsulatedDriveModule_Final {
    public import ScalarValues::*;
    /* ------------------------------------------------------------------*
     * Domain Items and Flows
     * ------------------------------------------------------------------*/
    item def ElectricFlow {
        attribute current : Real;
        attribute voltage : Real;
    }
    item def Torque {
        attribute value : Real;
        /* N·m */
    }
    flow Enable;
    flow Disable;
    flow SetSpeed {
        attribute rpm : Real;
    }
    flow CurrentSpeed {
        attribute rpm : Real;
    }
    /* ------------------------------------------------------------------*
     * Port Definitions
     * ------------------------------------------------------------------*/
    /* Power interface (source → consumer) */
    port def iPower {
        in item power : ElectricFlow;
    }
    /* Command/Status interface between Controller and Motor */
    port def iController_Motor {
        in flow Enable;
        in flow Disable;
        in flow SetSpeed;
        out flow CurrentSpeed;
    }
    /* Command/Status interface between external system and Controller */
    port def iCommandStatus {
        in flow Enable;
        in flow Disable;
        in flow SetSpeed;
        out flow CurrentSpeed;
    }
    /* Mechanical torque output interface */
    port def iTorque {
        out item torque : Torque;
    }
    /* ------------------------------------------------------------------*
     * Internal Parts
     * ------------------------------------------------------------------*/
    part def PowerConverter {
        port pIn : iPower;
        /* receives external power */
        port pOut : ~iPower;
        /* supplies conditioned power to Motor */
    }
    part def Motor {
        port pPower : iPower;
        /* receives electrical power */
        port pController : ~iController_Motor;
        /* receives commands, sends feedback */
        port pTorque : iTorque;
        /* produces torque output */
    }
    part def Controller {
        port pExternal : iCommandStatus;
        /* connects to DriveModule.pCommandStatus */
        port pMotor : iController_Motor;
        /* connects internally to Motor.pController */
    }
    /* ------------------------------------------------------------------*
     * Encapsulating Part Definition
     * ------------------------------------------------------------------*/
    part def DriveModule {
        /* External-facing ports */
        port pPower : iPower;
        /* electrical power input */
        port pCommandStatus : iCommandStatus;
        /* external command/control interface */
        port pTorque : iTorque;
        /* mechanical torque output */
        /* Internal subparts */
        part conv : PowerConverter;
        part motor : Motor;
        part ctrl : Controller;
        /* Delegations (owner port ↔ internal port; same perspective, no conjugation) */
        connect pPower to conv.pIn;
        /* delegate power input to converter */
        connect pCommandStatus to ctrl.pExternal;
        /* delegate external control to controller */
        connect pTorque to motor.pTorque;
        /* delegate torque output from motor */
        /* Internal wiring */
        connect conv.pOut to motor.pPower;
        /* conditioned power from converter to motor */
        connect ctrl.pMotor to motor.pController;
        /* controller ↔ motor command/status link */
    }
}
package MultiplicityExample {
    public import ScalarValues::*;
    part def Car {
        part engine : Engine;
        /* implicit multiplicity = 1  */
        part wheel : Wheel [4];
        /* exactly four wheels         */
        part seat : Seat [1..*];
        /* at least one, possibly many */
        part radio : Radio [0..1];
        /* optional radio             */
        part cupHolder : CupHolder [*];
        /* zero or more cupholders       */
    }
    part def Engine;
    part def Wheel;
    part def Seat;
    part def Radio {
        attribute presetChannel : Integer [*];
        part button [2..8];
        /* featuer w/o definition */
    }
    part def CupHolder;
}
view 'Port Example Diagram' : DS_Views::SymbolicViews::gv;
view 'Port Naming Example Diagram' : DS_Views::SymbolicViews::gv;
view 'Encapsulation Example Diagram' : DS_Views::SymbolicViews::gv;
