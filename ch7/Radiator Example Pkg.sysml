package 'Radiator Example Pkg' {
    public import ISQ::*;
    public import SI::*;
    public import USCU::*;
    private import MeasurementReferences::DerivedUnit;
    public import ScalarValues::*;
    /* structural elements */
    part def RadiatorPanel {
        attribute surfaceTemp :> thermodynamicTemperature = 75.0 ['°F'];
        attribute flowRate :> volumeFlowRate = 2.0 ['gal/min'];
        attribute efficiency : Real = 0.85;
    }
    /* define a new unit not in the SI library */
    attribute <'L/min'> LitresPerMin : VolumeFlowRateUnit;
    attribute def EnergyTransferEfficiencyUnit :> DerivedUnit;
    attribute <'W·min/L·K'> Watt_MinPerLitreDegreeK : EnergyTransferEfficiencyUnit;
    part radiatorA : RadiatorPanel {
        surfaceTemp default 295.15 [K];
        flowRate default 7.57 ['L/min'];
    }
    calc def HeatTransferPower {
        in t :> thermodynamicTemperature;
        in f :> volumeFlowRate;
        in e : Real;
        result : PowerValue;
        e * f * (t - 273.15 [K]) * 0.5
    }
    action def UpdateFlow {
        in p : RadiatorPanel;
        action {
            assign p.flowRate := 3.2 ['gal/min'];
        }
    }
    constraint def MaxSafeTemp {
        in t :> thermodynamicTemperature;
        constraint {
            t < 350.0 [K]
        }
    }
    part def CoolantControlSystem {
        attribute radiator : RadiatorPanel;
        constraint overheatProtects {
            MaxSafeTemp(radiator.surfaceTemp)
        }
    }
}
