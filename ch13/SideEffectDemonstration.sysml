package SideEffectDemonstration {
    public import ScalarValues::*;
    part def Counter {
        attribute count : Integer = 0;
    }
    calc def IncrementAndFetch {
        in part target : Counter;
        return newCount : Integer;
        target.count
    }
    part SystemTest {
        part myCounter : Counter;
        calc r1 : IncrementAndFetch { in target = myCounter; }
        calc r2 : IncrementAndFetch { in target = myCounter; }
        assert constraint {
            myCounter.count == 2
        }
    }
}
