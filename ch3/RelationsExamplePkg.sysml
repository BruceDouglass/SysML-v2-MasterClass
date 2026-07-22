package RelationsExamplePkg {
    public import ScalarValues::*;
    requirement powerTheCar {
        subject Vehicle;
        doc /* The car shall be able to move itself. */
    }
    allocation powerAlloc allocate powerTheCar to Vehicle::engine;
    part def Wheel {
        attribute diameter : Real = 18;
    }
    part def Cylinder;
    part def Engine {
        attribute mass : Real = 2000;
        part cylinder : Cylinder [8];
    }
    part def SmallEngine :> Engine {
        smallMass :>> mass = 1500;
        part :>> cylinder [6];
    }
    part def Vehicle {
        part wheel [4] : Wheel;
        part engine : Engine;
        ref part driver : Driver;
        attribute cost : Real;
        attribute maxSpeed : Real;
        attribute owner : String;
        attribute speed : Real;
        satisfy requirement powerTheCar;
    }
    part def smallVehicle :> Vehicle {
        part smallEngine :>> engine;
    }
    part def Driver;
}
view 'Relations Example View' : DS_Views::SymbolicViews::gv;
