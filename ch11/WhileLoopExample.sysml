package WhileLoopExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    action def FillTank {
        attribute currentLevel : VolumeValue default 0.0 [L];
        attribute maxLevel : VolumeValue = 10.0 [L];
        action pumpIn;
        while currentLevel < maxLevel {
            perform pumpIn;
            assign currentLevel := currentLevel + 1.0 [L];
        }
    }
}
package LoopUntilExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    action def HeatFluid {
        attribute temperature : TemperatureValue default 20 ['°C'];
        attribute targetTemp : TemperatureValue = 80 ['°C'];
        loop {
            assign temperature := temperature + 5 ['°C'];
        } until temperature >= targetTemp;
    }
}
package ForCollectionExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    action def ComputeTotalPower {
        attribute powerProfile [*] :> power = (100, 120, 80);
        attribute totalPower : PowerValue = 0 [W];
        for p in powerProfile {
            assign totalPower := totalPower + p;
        }
    }
}
package ForRangeExample {
    public import ScalarValues::*;
    action def SumIntegers {
        attribute total : Integer default 0;
        for i in 1..10 {
            assign total := total + i;
        }
    }
}
package TestPkg {
    public import CollectionFunctions::*;
    public import ScalarValues::*;
    action def InitializeCluster {
        inout gears : Integer [*];
        /* Assign entire collection at once */
        assign gears := (11, 13, 15, 17, 19, 21, 23, 25, 27, 29);
    }
    action def IterativelySetGears {
        inout gears : Integer [*];
        attribute j : Integer default 0;
        for g in gears {
            assign g := 9 + j * 2;
            assign j := j + 2;
        }
    }
    part def BicycleDrivetrain {
        attribute rearGears : Integer [*];
        attribute frontGears : Integer [*] = (34, 54);
        action initializeCluster : InitializeCluster { inout gears : Integer [*] = rearGears; }
        action iteravtivelySetGears : IterativelySetGears { inout gears = rearGears; }
    }
}
