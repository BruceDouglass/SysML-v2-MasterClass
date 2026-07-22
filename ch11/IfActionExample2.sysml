package IfActionExample2 {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    action def CheckTemperature {
        in attribute temp : TemperatureValue;
        in attribute limit : TemperatureValue = 40 ['°C'];
        action startFan;
        if temp > limit then startFan;
    }
    action def ManageTemperature {
        in attribute temp : TemperatureValue;
        in attribute lowerLimit : TemperatureValue = 18 ['°C'];
        in attribute upperLimit : TemperatureValue = 26 ['°C'];
        action startHeater;
        action startCooler;
        action maintain;
        if temp < lowerLimit {
            startHeater;
        } else {
            if temp > upperLimit {
                startCooler;
            } else {
                maintain;
            }
        }
    }
}
