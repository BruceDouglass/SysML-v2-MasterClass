package InfusionPumpExample {
    public import ScalarValues::*;
    public import SI::*;
    /* -------------------------*
     * System subject & types  *
     * -------------------------*/
    part def InfusionPump {
        attribute availablePower : Real;
        attribute minOperationalPower : Real;
        attribute reservoirVolume : Real;
        attribute infusedVolume : Real;
    }
    part def Patient;
    part def Clinician;
    item evStartInfusion;
    item evLowPower;
    item evInfusionComplete;
    item evPowerRestored;
    /* -------------------------*
     * Use case with invariant *
     * -------------------------*/
    use case InfuseMedicationUC {
        doc
        /* The infusion pump delivers medication at a controlled rate.
         * The use case assumes adequate power margin for its validity.
         * The exhibited state machine handles a low-power condition
         * by switching to backup power and alerting the clinician. */
        subject pump : InfusionPump;
        actor patient : Patient;
        actor clinician : Clinician;
        /* Input parameter: ordered dose to administer */
        in orderedDose : Real;
        /* Invariant: must hold throughout the use case */
        assert constraint inv_stablePower {
            in pump : InfusionPump;
            pump.availablePower >= pump.minOperationalPower
        }
        /* Preconditions / Postconditions in the objective */
        objective {
            assume constraint pre_medAvailable {
                in pump : InfusionPump;
                pump.reservoirVolume > 0.0
            }
            require constraint post_infusionComplete {
                in pump : InfusionPump;
                pump.infusedVolume >= orderedDose
            }
        }
        state infusionBehavior {
            state Infusing {
                entry action startInfusion;
            }
            state LowPowerHandling {
                entry action switchToBackupPower;
                entry action alertClinician;
            }
            state Completed {
                entry action stopInfusion;
            }
            /* Initial transition: begin infusion */
            transition Infusing accept evStartInfusion then Infusing;
            /* Nominal completion path */
            transition Infusing accept evInfusionComplete then Completed;
            /* Rainy-day: low power detected during infusion */
            transition Infusing accept evLowPower then LowPowerHandling;
            /* Power restored: return to Infusing */
            transition LowPowerHandling accept evPowerRestored then Infusing;
            transition Actions::Action::start then Infusing;
        }
    }
}
view 'Infusion Pump UC View' : DS_Views::SymbolicViews::gv;
