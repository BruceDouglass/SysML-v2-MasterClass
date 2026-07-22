package illegalStuff {
    public import ScalarValues::*;
    attribute def A;
    item def I;
    part def PBase {
        attribute x2 : Real = 6;
    }
    part def P :> PBase {
        x : Real;
        attribute x1 : Real default 6;
        attribute y : Integer = 4;
        attribute q : I;
        attribute p : A;
        /* items */
        item z : String;
        item z1 : A;
        item z2 {
            attribute s : String;
        }
        action myAction {
            assign x := 5.0;
            assign y := 6;
            assign z := "Bruce";
            assign z2.s := "Bruce";
        }
    }
}
