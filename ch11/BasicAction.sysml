package BasicAction {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    item def DataPacket;
    action def AcquireData {
        in attribute filterFrequency : FrequencyValue;
        out item resultData : DataPacket;
        /* Decomposed subactions */
        action initialize;
        action collectSample {
            in attribute filterF : FrequencyValue = filterFrequency;
            out sampleData : DataPacket;
        }
        action processData {
            in unprocessedData : DataPacket;
            out processedData : DataPacket;
        }
        /* Sequence of steps  */
        bind filterFrequency = collectSample.filterF;
        first start then initialize;
        first initialize then collectSample;
        succession flow collectSample.sampleData to processData.unprocessedData;
        bind processData.processedData = resultData;
    }
    part def Sensor {
        item sensorMeasurement : DataPacket;
        attribute ff : FrequencyValue = 10 [Hz];
        bind ff = acquireData.filterFrequency;
        action acquireData : AcquireData;
        bind acquireData.resultData = sensorMeasurement;
    }
    view 'BasicAction View' : DS_Views::SymbolicViews::gv;
}
