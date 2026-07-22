package package1 {
    public import ScalarValues::*;
    part def Wheel;
    part def Car {
        part wheel [4] : Wheel;
    }
    item it;
    part def SensorArray {
        /* Inner part definition exists only for this SensorArray type */
        part def CalibrationModule {
            attribute offsetBias : Real = 0.0;
            attribute noiseLevel : Real = 0.01;
            attribute temperatureCompensation : Boolean = true;
        }
        /* Usages of the inner definition */
        part cal : CalibrationModule;
        part sensor1;
        part sensor2;
        ref item it;
    }
}
