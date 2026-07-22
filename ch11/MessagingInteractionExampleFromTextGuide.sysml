package MessagingInteractionExampleFromTextGuide {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    item def SetSpeed;
    item def SensedSpeed;
    item def FuelCommand;
    part driver {
        item setSpeedSent : SetSpeed;
    }
    part vehicle {
        part cruiseController {
            item setSpeedReceived : SetSpeed;
            item sensedSpeedReceived : SensedSpeed;
            fuelCommandSent : FuelCommand;
        }
        part speedometer {
            item sensedSpeedSent : SensedSpeed;
        }
        part engine {
            item fuelCommandReceived : FuelCommand;
        }
    }
    occurrence def CruiseControlInteraction {
        ref part :>> driver;
        ref part :>> vehicle;
        message setSpeedMessage of SetSpeed from driver.setSpeedSent to vehicle.cruiseController.setSpeedReceived;
        message sensedSpeedMessage of SensedSpeed from vehicle.speedometer.sensedSpeedSent to vehicle.cruiseController.sensedSpeedReceived;
        message fuelCommandMessage of FuelCommand from vehicle.cruiseController.fuelCommandSent to vehicle.engine.fuelCommandReceived;
        first setSpeedMessage then sensedSpeedMessage;
    }
    view 'MessagingInteractionExample View' : DS_Views::SymbolicViews::gv;
}
