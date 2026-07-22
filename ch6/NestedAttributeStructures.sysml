package NestedAttributeStructures {
    public import ScalarValues::*;
    attribute def Gearing {
        front : Positive;
        rear : Positive;
    }
    part def Bicycle {
        attribute g : Gearing;
        attribute gearRatio : Real;
        action setUp {
            assignGears {
                f = 54;
                r = 18;
            }
        }
        action assignGears {
            in attribute f : Positive;
            in attribute r : Positive;
            assign g := new Gearing(f, r);
            assign gearRatio := f / r;
        }
        assert constraint {
            g.front > 0 and g.rear > 0
        }
    }
}
