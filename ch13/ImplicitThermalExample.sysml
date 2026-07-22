package ImplicitThermalExample {
    public import ScalarValues::*;
    part def AvionicsCoolingModel {
        attribute internalTemp : Real = 45.0;
        attribute ambientTemp : Real = 25.0;
        attribute heatCapacity : Real = 120.0;
        attribute coolingPower : Real = 15.0;
        attribute estimatedDrop : Real = coolingPower / heatCapacity - ambientTemp;
    }
}
package ExplicitDimensionExample {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    public import Quantities::*;
    attribute def TemperatureRateValue :> ScalarQuantityValue;
    part def AvionicsCoolingModel {
        /* Explicit quantity kinds instead of bare Real */
        attribute internalTemp : TemperatureValue = 45.0 ['°C'];
        attribute ambientTemp : TemperatureValue = 25.0 ['°C'];
        attribute heatCapacity : HeatCapacityValue;
        attribute coolingPower : PowerValue;
        attribute estimatedDrop : TemperatureRateValue = coolingPower / heatCapacity - ambientTemp;
    }
}
