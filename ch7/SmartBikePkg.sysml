package SmartBikePkg {
    private import Quantities::*;
    private import ScalarValues::*;
    private import SI::*;
    private import MeasurementReferences::DerivedUnit;
    /* user-define quantites */
    attribute def ScaledPowerByWeightValue :> ScalarQuantityValue;
    attribute def OxygenUptakeRateValue :> ScalarQuantityValue;
    /* user defined units */
    attribute def WattPerKg :> DerivedUnit;
    attribute def CCPerMinPerKg :> DerivedUnit;
    attribute w_per_kg : WattPerKg;
    attribute ccO2_per_min_kg : CCPerMinPerKg;
    /* usage of quantities and units */
    part def Cyclist {
        attribute ftp :> power default 250.0 [W];
        attribute riderWeight : MassValue := 90 [kg];
        attribute powerToWeight : ScaledPowerByWeightValue default := ftp / riderWeight;
        attribute vo2Max : OxygenUptakeRateValue default := 61.5 [ccO2_per_min_kg];
    }
}
