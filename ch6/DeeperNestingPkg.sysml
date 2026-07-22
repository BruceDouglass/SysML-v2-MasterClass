package DeeperNestingPkg {
    public import ScalarValues::*;
    /* structured attributes */
    attribute def A2 {
        attribute z : Real default 0.0;
    }
    attribute def A1 {
        attribute y : A2;
        attribute y1 : Real;
    }
    attribute def A0 {
        attribute x : A1;
        attribute x1 : Real;
    }
    /* Structured Item */
    item def It2 {
        attribute k : Real default 10.0;
    }
    item def It1 {
        item j : It2;
    }
    item def It0 {
        item i : It1;
    }
    /* using the structured items and attributes */
    part def MyPart {
        attribute a : A0;
        item b : It0;
        action {
            assign a.x.y.z := 1.0;
            assign a := new A0((2.0, 3.0), 4.0);
            assign b.i.j.k := 11.0;
            assign b := new It0(12.0);
        }
        constraint lessThan100 {
            a.x.y.z < 100
        }
        constraint moreThanMinus10 {
            b.i.j.k > -10
        }
    }
}
