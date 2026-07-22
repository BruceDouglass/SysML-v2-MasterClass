package ItemVsPartPkg {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    item def WaterSample {
        attribute volume : VolumeValue;
        attribute turbidity : Real;
    }
    item def FiltrationCommand {
        attribute commandText : String;
    }
    part def FilterUnit {
        attribute filterHealth : Real;
        part sensor : TurbiditySensor;
    }
    part def TurbiditySensor {
        attribute lastReading : Real;
        action measure;
    }
    part def ControlModule {
        attribute status : String;
        in cmd : FiltrationCommand;
        out sample : WaterSample;
    }
    /* ------------------------------------------------------*
     *  A System Composed of Parts                          *
     * ------------------------------------------------------*/
    part def WaterFiltrationSystem {
        part controller : ControlModule;
        part waterFilter : FilterUnit;
        /* Items DO NOT appear as structural parts. 
         * Instead, they are exchanged over flows or messages. */
        connect controller.sample to waterFilter.sensor;
    }
}
