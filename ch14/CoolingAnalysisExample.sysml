package CoolingAnalysisExample {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    attribute def HeatLoad :> PowerValue;
    part def CoolingSubsystem {
        attribute coolingCapacity : PowerValue = 750 [W];
    }
    calc def EstimateHeatLoad {
        in ambientTemp : TemperatureValue;
        in internalTemp : TemperatureValue;
        return load : HeatLoad;
        (ambientTemp - internalTemp) * 10 [W / '°C']
    }
    analysis def CoolingLoadAnalysis {
        subject cooler : CoolingSubsystem;
        return loadResult : HeatLoad = EstimateHeatLoad(ambientTemp = 35 ['°C'], internalTemp = 5 ['°C']);
        objective LoadWithinCapacity {
            require constraint NotOverloaded {
                loadResult <= cooler.coolingCapacity
            }
        }
    }
}
