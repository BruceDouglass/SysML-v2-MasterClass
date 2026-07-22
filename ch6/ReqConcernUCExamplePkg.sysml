package ReqConcernUCExamplePkg {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    public import RealFunctions::*;
    part def Clinician;
    part def Patient;
    part def Hospital;
    part def Ventilator {
        attribute tidalVolumeCmd : VolumeValue;
        attribute tidalVolumeMeas : VolumeValue;
        attribute airwayPressure : PressureValue;
    }
    requirement 'Maintain Tidal Volume' {
        subject vent : Ventilator;
        actor Clinician;
        attribute targetTidalVolume : VolumeValue;
        attribute measuredTidalVolume : VolumeValue;
        doc
        /* The ventilator shall maintain tidal volume within
         * ±5% of the commanded target for the connected patient. */
        require constraint {
            abs(measuredTidalVolume - targetTidalVolume) <= 0.05 * targetTidalVolume
        }
    }
    concern def 'Ventilation Safety Concern' {
        subject Ventilator;
        stakeholder Hospital;
        actor Clinician;
        attribute maxSafePressure : PressureValue;
        attribute currentPressure : PressureValue;
        doc
        /* Ventilation safety requires that airway pressure
         * remain below a configured maximum to avoid barotrauma. */
        assume constraint {
            currentPressure >= 0 [Pa]
        }
        require constraint {
            currentPressure <= maxSafePressure
        }
    }
    use case AdjustVentilationUC {
        subject vent : Ventilator;
        actor Clinician;
        actor Patient;
        in attribute targetTidalVolume : VolumeValue;
        in attribute targetRespRate : FrequencyValue;
        doc
        /* The clinician adjusts ventilator settings to achieve
         * the desired tidal volume and respiration rate for
         * the connected patient. */
    }
    calc def ComputeTidalVolumeError {
        in attribute target : VolumeValue;
        in attribute measured : VolumeValue;
        doc
        /* Compute the tidal-volume tracking error as a percentage
         * of the target tidal volume. */
        return errorPercent : Real = (measured - target) / target * 100.0;
    }
}
