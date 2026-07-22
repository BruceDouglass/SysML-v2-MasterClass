package VehicleTaxonomy {
    public import ScalarValues::*;
    public import ISQ::*;
    /* Base vehicle type */
    part def Vehicle {
        attribute name : String;
        attribute distanceTraveled : Real;
        attribute dateOfPurchase : Time::DateTime;
    }
    /* First-level specializations */
    part def GroundVehicle :> Vehicle;
    part def AirVehicle :> Vehicle {
        attribute ceiling :> height;
    }
    part def SeaVehicle :> Vehicle;
    /* Ground vehicles */
    part def Car :> GroundVehicle;
    part def Truck :> GroundVehicle;
    part def Bicycle :> GroundVehicle;
    /* Air vehicles */
    part def FixedWing :> AirVehicle;
    part def RotaryWing :> AirVehicle;
    part def Dirigible :> AirVehicle;
    /* Sea vehicles */
    part def Boat :> SeaVehicle;
    part def Submarine :> SeaVehicle {
        attribute crushDepth :> height;
    }
    part def Canoe :> SeaVehicle;
    part def Trawler :> SeaVehicle;
}
view unnamed : DS_Views::SymbolicViews::gv {
    doc /* This view shows the Vehicle taxonomy */
}
