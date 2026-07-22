package MultiplicityExample {
    public import ScalarValues::*;
    part def Car {
        part engine : Engine;
        /* implicit multiplicity = 1  */
        part wheel [4] : Wheel;
        /* exactly four */
        part seat [1..*] : Seat;
        /* one or more */
        part radio [0..1] : Radio;
        /* optional */
        part cupHolder [*] : CupHolder;
        /* zero or more */
    }
    part def Engine;
    part def Wheel;
    part def Seat;
    part def Radio {
        attribute presetChannel [*] : Integer;
        /* zero or more */
        part button [2..8];
        /* feature w/o definition */
    }
    part def CupHolder;
}
