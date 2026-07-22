package DimensionlessCalculations {
    private import Quantities::*;
    private import MeasurementReferences::*;
    private import ISQ::*;
    attribute def MassFractionValue :> ScalarQuantityValue {
        attribute :>> mRef : DimensionOneUnit;
    }
    calc def CalculateMassFraction {
        in partMass : MassValue;
        in totalMass : MassValue;
        return fraction : MassFractionValue;
        partMass / totalMass
    }
}
