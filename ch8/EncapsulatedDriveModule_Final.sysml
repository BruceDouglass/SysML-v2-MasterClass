package EncapsulatedDriveModule_Final {
    public import ScalarValues::*;
    item def ElectricFlow {
        attribute current : Real;
        attribute voltage : Real;
    }
    item def Torque {
        attribute value : Real;
    }
    item def Enable;
    item def Disable;
    item def SetSpeed {
        attribute rpm : Real;
    }
    item def CurrentSpeed {
        attribute rpm : Real;
    }
    /* Ports */
    port def iPower {
        in item power : ElectricFlow;
    }
    port def iController_Motor {
        in item enable : Enable;
        in item disable : Disable;
        in item setSpeed : SetSpeed;
        out item currentSpeed : CurrentSpeed;
    }
    port def iCommandStatus {
        in item enable : Enable;
        in item disable : Disable;
        in item setSpeed : SetSpeed;
        out item setSpeed : CurrentSpeed;
    }
    port def iTorque {
        out item torque : Torque;
    }
    /* structural element definitions */
    part def PowerConverter {
        port pIn : iPower;
        port pOut : ~iPower;
    }
    part def Motor {
        port pPower : iPower;
        port pController : ~iController_Motor;
        port pTorque : iTorque;
    }
    part def Controller {
        port pExternal : iCommandStatus;
        port pMotor : iController_Motor;
    }
    part def DriveModule {
        port pPower : iPower;
        port pCommandStatus : iCommandStatus;
        port pTorque : iTorque;
        part conv : PowerConverter;
        part motor : Motor;
        part ctrl : Controller;
        /* for external connections */
        connect pPower to conv.pIn;
        connect pCommandStatus to ctrl.pExternal;
        connect pTorque to motor.pTorque;
        /* Internal wiring */
        connect conv.pOut to motor.pPower;
        connect ctrl.pMotor to motor.pController;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
