package 'Car and Driver' {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* information */
    item def DriverLicense {
        attribute licenseNumber : String;
        attribute stateIssued : String;
        attribute isValid : Boolean;
    }
    /* Cars and drivers */
    part def Driver {
        attribute age : Positive;
        ref item license : DriverLicense;
    }
    part driver : Driver;
    part def Engine {
        attribute maxRPM : AngularVelocityValue;
        attribute rpm : AngularVelocityValue;
    }
    part def Car {
        attribute milesDriven : Real default 0;
        attribute brand : String;
        attribute engineRPM : AngularVelocityValue = engine.rpm;
        part engine : Engine;
        ref part carDriver : Driver = driver;
        assert constraint canBeDriven {
            carDriver.license.isValid
        }
    }
    individual item def LicenseForDad :> DriverLicense {
        :>> licenseNumber = "D123456789";
        :>> stateIssued = "VA";
        :>> isValid = true;
    }
    individual part def Dad :> Driver {
        :>> age = 58;
        individual item :>> license : LicenseForDad;
    }
    individual part def 'Dads Car' :> Car {
        :>> milesDriven = 100000;
        ref part dad :>> carDriver : Dad;
        :>> brand = "Audi";
    }
    /* Commute occurrences */
    occurrence def CommuteToWork {
        part driver : Driver;
        part vehicle : Car;
        connect driver to vehicle;
        event occurrence startEngine;
        event occurrence driveToWork;
        event occurrence parkVehicle;
        message start : startEngine from driver to vehicle;
        message drive : driveToWork from driver to vehicle;
        message park : parkVehicle from driver to vehicle;
    }
    occurrence mondayCommute : CommuteToWork {
        :>> driver : Dad;
        :>> vehicle : 'Dads Car';
    }
    part def Widget {
        attribute weight : MassValue default 90 [kg];
        attribute brand : String;
    }
    part def Controller {
        in targetSpeed :> speed;
        out throttleCommand : Real;
        attribute currentSpeed :> speed;
        action controlSpeed {
            in tSpeed :> speed = targetSpeed;
            out cmd : Real = throttleCommand;
            perform action readSpeed : getSpeed;
            assign currentSpeed := readSpeed.value;
            assign cmd := tSpeed - currentSpeed;
        }
        action getSpeed { out value :> speed; }
    }
    view 'Car and Driver Diagram' : DS_Views::SymbolicViews::gv;
    view 'Car and Driver Occurrences' : DS_Views::SymbolicViews::gv;
}
