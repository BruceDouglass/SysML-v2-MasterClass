package MetaDataExample2Pkg {
    public import ScalarValues::*;
    enum def RiskLikelihood {
        improbable;
        remote;
        occasional;
        probable;
        frequent;
    }
    enum def RiskSeverity {
        negligible;
        marginal;
        critical;
        catastrophic;
    }
    /* ----- Structured metadata definition ----- */
    metadata def SafetyHazard {
        attribute hazardText : String;
        attribute likelihood : RiskLikelihood;
        attribute severity : RiskSeverity;
        attribute riskIndex : Integer;
        attribute mitigation : String;
        attribute vendorInfo : String;
    }
    metadata def VendorInfo {
        attribute vendorName : String;
    }
    /* ----- A motor driver part that owns a hazard record ----- */
    part def TractionInverter {
        @thermalRisk : SafetyHazard {
            hazardText = "Power MOSFET junction may exceed 175°C";
            likelihood = likelihood::probable;
            severity = severity::critical;
            riskIndex = 16;
            mitigation = "Derate output > 90°C; log thermal event";
        }
    }
    part orionInverter : TractionInverter {
        @vendor : VendorInfo { vendorName = "Acme"; }
        @safetyRisk : SafetyHazard { likelihood = likelihood::occasional; }
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
