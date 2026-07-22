package UCWithActionsPkg {
    public import ScalarValues::*;
    part def MedicalVaporizer;
    use case MaintainDrugConcentration {
        subject vap : MedicalVaporizer;
        actor clinician;
        in attribute procedureDone : Boolean;
        in attribute targetConcentration : Real;
        in attribute gasFlowRate : Real;
        out attribute deliveredConcentration : Real;
        objective {
            doc /* Maintain delivered drug concentration within ±0.5 % of the commanded value. */
        }
        /* action declarations */
        action measure { out attribute measuredDrugConc : Real; }
        action adjust {
            in attribute measuredConc : Real;
            out attribute commandedConc : Real;
        }
        action deliver { in commandedConc : Real; }
        action 'set drug concentration value';
        action shutDown;
        /* sequencing */
        first start then 'set drug concentration value';
        first 'set drug concentration value' then mergePt;
        merge mergePt;
        first mergePt then measure;
        first deliver then 'done Yet?';
        decide 'done Yet?';
        if not procedureDone then mergePt;
        if procedureDone then shutDown;
        first shutDown then done;
        succession flow measure.measuredDrugConc to adjust.measuredConc;
        succession flow adjust.commandedConc to deliver.commandedConc;
    }
}
view 'UC with actions view' : DS_Views::SymbolicViews::gv;
