package CarsAndDrivers {
    public import ScalarValues::*;
    public import ISQ::*;
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
    individual part dadsAudi : 'Dads Car';
    occurrence def CommuteToWork {
        part driver_occur : driver;
        part vehicle_occur : Car;
        event occurrence startEngine;
        event occurrence driveToWork;
        event occurrence parkVehicle;
        message start : startEngine from driver_occur to vehicle_occur;
        message drive : driveToWork from driver_occur to vehicle_occur;
        message park : parkVehicle from driver_occur to vehicle_occur;
    }
    occurrence mondayCommute : CommuteToWork {
        :>> vehicle_occur = dadsAudi;
        :>> driver_occur = vehicle_occur.carDriver;
    }
}
