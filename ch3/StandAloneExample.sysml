package StandAloneExample {
    private import ScalarValues::*;
    metadata def DataValidationTag;
    metadata def ReviewStatus {
        attribute requiresReview : Boolean default false;
        attribute notes : String;
    }
    attribute def Reading {
        attribute value : Real;
        attribute isReliable : Boolean;
    }
    #DataValidationTag calc def EvaluateDataSeries {
        in readings : Reading [*] ordered;
        in threshold : Real;
        @ReviewStatus {
            requiresReview = true;
            notes = "Checked for critical anomalies using index and condition logic.";
        }
        attribute critical_anomaly : Boolean = readings#(1).isReliable and readings#(1).value > threshold or not readings#(2).isReliable and readings#(2).value < 10.0;
        return score : Real = if critical_anomaly ? 0.0 else 100.0;
    }
}
