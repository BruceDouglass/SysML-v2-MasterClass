package MetadDataStuff {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    metadata def QuantifiedValue {
        :>> annotatedElement : SysML::Systems::Usage;
        attribute digitsOfPrecision : Natural [0..1];
        attribute accuracy : Real [0..1];
        attribute isMeasured : Boolean default false;
    }
    metadata def StandardQV :> QuantifiedValue {
        :>> digitsOfPrecision : Natural [1] = 6;
        :>> accuracy : Real [1] = 0.1;
    }
    /* metadata usages */
    attribute altitude :> height {
        @QuantifiedValue {
            digitsOfPrecision = 6;
            accuracy = 0.1;
        }
    }
    #StandardQV attribute altitude :> height;
    #StandardQV attribute altitude :> height {
        constraint {
            that >= -1000 [m] and that <= 100000 [m]
        }
    }
    enum def SecurityLevelEnum {
        Low;
        Medium;
        High;
    }
    metadata def ConfidentialityLevel {
        attribute isSensitive : Boolean;
        attribute securityLevel : SecurityLevelEnum [0..1];
    }
    attribute emailAddress : String {
        @ConfidentialityLevel {
            isSensitive = true;
            securityLevel = securityLevel::High;
        }
    }
}
