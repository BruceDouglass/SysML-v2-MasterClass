package UCRefinementExample {
    public import ModelingMetadata::refinement;
    /* Requirements */
    requirement 'Maintain Flow Rate' {
        doc /* The system shall maintain gas flow within ±2%. */
    }
    requirement 'Detect Occlusion' {
        doc /* The system shall detect and report flow-line occlusions. */
    }
    part def GasController;
    /* Use case */
    use case ControlGasDeliveryUC {
        subject gasController : GasController;
        actor clinician;
        doc
        /* The clinician initiates gas delivery and the controller
         * regulates flow and monitors for occlusions. */
    }
    /* Refinement relations */
    #refinement dependency ref1 from ControlGasDeliveryUC to 'Maintain Flow Rate';
    #refinement dependency ref2 from ControlGasDeliveryUC to 'Detect Occlusion';
}
