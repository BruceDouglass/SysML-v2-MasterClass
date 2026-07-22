package ConstraintPkg {
    enum def MedicalGasType;
    part def GasTank {
        attribute gasType : MedicalGasType;
        attribute fillLevel : ScalarValues::Real;
        attribute capacity : ScalarValues::Real;
    }
    constraint def IsFull {
        in aTank : GasTank;
        aTank.fillLevel == aTank.capacity
    }
    part def Ventilator {
        part gasTank : GasTank;
        constraint isNotFull : IsFull {
            in aTank = gasTank;
        }
    }
}
