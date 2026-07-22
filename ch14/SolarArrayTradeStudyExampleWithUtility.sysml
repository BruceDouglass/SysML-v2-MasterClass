package SolarArrayTradeStudyExampleWithUtility {
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
    calc def LinearUtilityCurve {
        doc
        /* LinearUtilityCurve(value, best, worst)
         * Utility = 10 * (value - worst) / (best - worst)
         * Produces a straight line in which
         * worst -> 0.0
         * best  -> 10.0 */
        in value : Real;
        in best : Real;
        in worst : Real;
        return u : Real;
        10.0 * (value - worst) / (best - worst)
    }
    calc def ComputeWeightedObjectiveScore {
        doc
        /* Computes the overall effectiveness score for a solar array alternative
         * by applying a weighted sum of its utility values. */
        in power : PowerValue;
        in mass : MassValue;
        in cost : Real;
        in bestPower : PowerValue;
        in worstPower : PowerValue;
        in bestMass : MassValue;
        in worstMass : MassValue;
        in bestCost : Real;
        in worstCost : Real;
        in powerWeight : Real;
        in massWeight : Real;
        in costWeight : Real;
        return score : Real;
        LinearUtilityCurve(power, bestPower, worstPower) * powerWeight + LinearUtilityCurve(mass, bestMass, worstMass) * massWeight +
                LinearUtilityCurve(cost, bestCost, worstCost) * costWeight
    }
    analysis arraySelectionStudy : TradeStudy {
        /* Alternatives under consideration */
        subject candidates :> solarArray = (arrayA, arrayB, arrayC);
        /* Explicit weighting factors (sum = 1.0) */
        attribute powerWeight : Real = 0.5;
        attribute massWeight : Real = 0.3;
        attribute costWeight : Real = 0.2;
        /* Best/worst values for each criterion (define the utility curves) */
        attribute bestPower : PowerValue = 180 [W];
        attribute worstPower : PowerValue = 120 [W];
        attribute bestMass : MassValue = 10 [kg];
        attribute worstMass : MassValue = 16 [kg];
        attribute bestCost : Real = 600.0;
        attribute worstCost : Real = 1100.0;
        /* Objective: select the alternative with maximum weighted score */
        objective : MaximizeObjective {}
        /* Evaluation function applied to each alternative */
        calc :> evaluationFunction {
            in sarray :> solarArray;
            return score : Real = ComputeWeightedObjectiveScore(power = sarray.powerOutput, mass = sarray.mass, cost = sarray.cost, bestPower = bestPower,
                                                                worstPower = worstPower, bestMass = bestMass, worstMass = worstMass, bestCost = bestCost,
                                                                worstCost = worstCost, powerWeight = powerWeight, massWeight = massWeight, costWeight = costWeight);
        }
        /* Returned selected alternative */
        return part selectedArray :>> selectedAlternative :> solarArray;
    }
    view 'Solar Array Trade Study View' : DS_Views::SymbolicViews::gv;
}
view unnamed : DS_Views::SymbolicViews::gv;
