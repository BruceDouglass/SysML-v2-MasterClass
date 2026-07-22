package SolarArrayTradeStudyExample {
    public import ScalarValues::*;
    public import TradeStudies::*;
    public import ISQ::*;
    public import SI::*;
    part def SolarArray {
        attribute powerOutput : PowerValue;
        attribute mass : MassValue;
        attribute cost : Real;
    }
    part solarArray : SolarArray;
    part arrayA :> solarArray {
        :>> powerOutput = 150 [W];
        :>> mass = 12 [kg];
        :>> cost = 800;
    }
    part arrayB :> solarArray {
        :>> powerOutput = 120 [W];
        :>> mass = 10 [kg];
        :>> cost = 600;
    }
    part arrayC :> solarArray {
        :>> powerOutput = 180 [W];
        :>> mass = 16 [kg];
        :>> cost = 1100;
    }
    calc def ComputeArrayScore {
        in power : PowerValue;
        in mass : MassValue;
        in cost : Real;
        return score : Real;
        power / 100 [W] - mass / 10 [kg] - cost / 1000
    }
    analysis arraySelectionStudy : TradeStudy {
        subject candidates :> solarArray = (arrayA, arrayB, arrayC);
        objective : MaximizeObjective {}
        calc :> evaluationFunction {
            in sarray :> solarArray = (arrayA, arrayB, arrayC);
            return score = ComputeArrayScore(sarray.powerOutput, sarray.mass, sarray.cost);
        }
        return part selectedArray :>> selectedAlternative :> solarArray;
    }
}
view 'Solar Array Trade Study View' : DS_Views::SymbolicViews::gv;
