package AnesthesiaInformationModel {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* Informational items */
    item def GasMixture {
        attribute o2Percent : Real;
        attribute airPercent : Real;
        attribute n2Percent : Real;
        attribute totalFlow : VolumeFlowRateValue;
    }
    item def PatientStatus {
        attribute heartRate : FrequencyValue;
        attribute breathingRate : FrequencyValue;
        attribute spo2 : Real;
        attribute tidalVolume : VolumeValue;
    }
    /* Port interface contracts */
    port def iGas {
        out item gas : GasMixture;
        /* producer publishes a GasMixture */
    }
    port def iStatus {
        out item status : PatientStatus;
    }
    /* Structural parts */
    part def GasSupply {
        port pOut : iGas;
        /* produces unmixed gas */
    }
    part def Ventilator {
        port pSupply : ~iGas;
        /* consumes unmixed gas from 1..* supplies */
        port pPatient : iGas;
        /* produces mixed gas toward circuit */
        action mixGasses {
            in unmixed : GasMixture;
            out mixed : GasMixture;
        }
    }
    part def BreathingCircuit {
        port pIn : ~iGas;
        /* consumes mixed gas from ventilator */
    }
    part def PatientMonitor {
        port pOut : iStatus;
        /* publishes patient status (not wired here) */
        item status : PatientStatus;
        action displayPatientStatus { in s : PatientStatus; }
    }
    /* System composition with connectors and flows */
    part def AnesthesiaSystem {
        part supplies : GasSupply [1..*];
        part ventilator : Ventilator;
        part circuit : BreathingCircuit;
        part monitor : PatientMonitor;
        /* Connectors among elements (structure) */
        connect supplies.pOut to ventilator.pSupply;
        /* N→1 gas feed */
        connect ventilator.pPatient to circuit.pIn;
        /* mixed gas path */
        /* Named flows over those connectors (informational) */
        flow unmixedGas : GasMixture from supplies.pOut.gas to ventilator.pSupply.gas;
        flow mixedGas : GasMixture from ventilator.pPatient.gas to circuit.pIn.gas;
    }
    view 'AnesthesiaInformationModel view' : DS_Views::SymbolicViews::gv;
}
