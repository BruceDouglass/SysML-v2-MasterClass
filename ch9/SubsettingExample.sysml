package SubsettingExample {
    part def Bumper;
    part def Trailer;
    connection def GeneralLink;
    connection def HitchLink :> GeneralLink;
    part def Vehicle {
        connection allConnections [*] : GeneralLink;
    }
    part def HeavyDutyTruck :> Vehicle {
        part trailerPlate : Bumper;
        part towedUnit : Trailer;
        connection heavyDutyLinks [*] : HitchLink :> allConnections;
        connection trailerHitch : HitchLink connect (trailerPlate, towedUnit);
        :> heavyDutyLinks;
    }
}
