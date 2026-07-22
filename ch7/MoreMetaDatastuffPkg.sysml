package MoreMetaDatastuffPkg {
    public import ScalarValues::*;
    public import ISQ::*;
    enum def AcquisitionMethodEnum {
        Simulated;
        Measured;
        Estimated;
        Manual;
    }
    metadata def DataProvenance {
        attribute source : String;
        attribute acquisitionMethod : AcquisitionMethodEnum [1];
    }
    attribute ambientTemperature :> thermodynamicTemperature {
        @DataProvenance {
            source = "Sensor_47A";
            acquisitionMethod = acquisitionMethod::Measured;
        }
    }
}
