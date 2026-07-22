package MotorControllPkg {
    public import ScalarValues::*;
    public import ISQ::*;
    item def ElectricFlow {
        attribute current : ElectricCurrentValue;
        attribute voltage : SourceVoltageValue;
        attribute frequency : FrequencyValue;
    }
    item enable;
    item disable;
    item def SetSpeed {
        attribute sSpeed : Real;
    }
    item def CurrentSpeed {
        attribute cSpeed : Real;
    }
    port def iPower_Client {
        out item power : ElectricFlow;
    }
    port def iController_Motor {
        out item enable;
        out item disable;
        out item setSpeed : SetSpeed;
        in item currentSpeed : CurrentSpeed;
    }
    /* structure */
    part def PowerSupply {
        port pPowerClient : iPower_Client;
    }
    part def Motor {
        port pPower : ~iPower_Client;
        port pController : ~iController_Motor;
        attribute speed : Real = 0.0;
        action serve {
            action readyGo {
                accept enable via pController;
            }
            action init {
                accept sCmd : SetSpeed via pController;
            }
            action sendIt {
                send new CurrentSpeed(cSpeed = speed);
            }
            first start then readyGo;
            first readyGo then init;
            first init then sendIt;
        }
    }
    part def Controller {
        port pMotor : iController_Motor;
        action operate {
            action startIt {
                send enable via pMotor;
            }
            action initializeIt {
                send new SetSpeed(2500.0) to pMotor;
            }
            action waitForIt {
                accept csm : CurrentSpeed via pMotor;
            }
            first start then startIt;
            first startIt then initializeIt;
            first initializeIt then waitForIt;
        }
    }
    /* system assembly */
    part def MotorSystem {
        part theSupply : PowerSupply;
        part theMotor : Motor;
        part theController : Controller;
        connect theSupply.pPowerClient to theMotor.pPower;
        connect theController.pMotor to theMotor.pController;
        action run {
            perform action op :> theController.operate {
                motor = theMotor;
            }
            perform action se :> theMotor.serve {
                ctrl = theController;
            }
            first start then op;
            first op then se;
        }
    }
}
