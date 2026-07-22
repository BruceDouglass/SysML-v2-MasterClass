package GearingPkg {
    public import SequenceFunctions::*;
    public import ScalarValues::*;
    action def InitializeCluster {
        inout gears : Integer [*];
        /* Assign entire sequence at once */
        assign gears := (11, 13, 15, 17, 19, 21, 23, 25, 27, 29);
    }
    action def IterativelySetGears {
        inout gears : Integer [*];
        attribute firstGear : Integer;
        assign firstGear := gears#(1);
        attribute n : Integer = 10;
        for j in 1..n {
            assign gears := gears->includingAt(9 + j * 2, j);
        }
    }
    part def BicycleDrivetrain {
        attribute rearGears : Integer [*];
        attribute frontGears : Integer [*] = (34, 54);
        action initializeCluster : InitializeCluster { inout gears : Integer [*] = rearGears; }
        action iteravtivelySetGears : IterativelySetGears { inout gears = rearGears; }
    }
}
