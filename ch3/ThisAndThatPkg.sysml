package ThisAndThatPkg {
    public import ScalarValues::*;
    part def Structural {
        attribute maxAllowedTime : Real = 100;
        action behavioral {
            attribute elapsedTime : Real;
            constraint check {
                elapsedTime <= maxAllowedTime
            }
        }
    }
}
