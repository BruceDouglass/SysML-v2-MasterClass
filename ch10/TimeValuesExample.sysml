package TimeValuesExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    public import Time::*;
    /* Use ISQ and Time quantity kinds and SI units */
    attribute duration : DurationValue = 5 [min];
    attribute startTime : TimeInstantValue = 12.0 [h];
    attribute endTime : TimeInstantValue = startTime + duration;
    attribute missionDate : Date = "2025-11-02";
    attribute timestamp : Iso8601DateTime = "2025-11-02T12:05:00Z";
    assert constraint {
        DurationOf(endTime - startTime) == 300 [s]
    }
}
