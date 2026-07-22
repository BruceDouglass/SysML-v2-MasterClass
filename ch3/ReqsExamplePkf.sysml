package ReqsExamplePkf {
    public import ScalarValues::*;
    part def MedicalGasSupply {
        satisfy O2CapacityRequirement by capacity;
        attribute capacity : Real;
        attribute fullness : Real;
        attribute gasType : MedicalGasType;
    }
    part O2Supply : MedicalGasSupply;
    enum def MedicalGasType {
        <o2> Oxygen;
        <he> Helium;
        <ne> Nitrogen;
        Air;
    }
    requirement O2CapacityRequirement {
        doc
        /* Assuming that the gas is oxygen, 
         * the medical gas supply shall 
         * have enough gas when full to provide 10L/min gas 
         * flow for 120 minutes  */
        subject MedicalGasSupply;
        in gasType : MedicalGasType;
        in fullness : Real;
        assume constraint nonEmpty {
            gasType == MedicalGasType::o2
        }
        require constraint name {
            fullness >= 1200
        }
    }
}
