package TransitionTriggerExample {
    public import ScalarValues::*;
    public import SI::*;
    item msgStart;
    part def ExampleController {
        attribute delay : Real = 3.0 [s];
        attribute wakeTime : Real = 10.0 [s];
        attribute temp : Real = 20.0 ['°C'];
        attribute threshold : Real = 50.0 ['°C'];
        state Controller {
            first start then Idle;
            state Idle;
            transition startOp first Idle accept msgStart then Active;
            state Active;
            transition relativeTimeout first Active accept after delay [s] then Wait;
            state Wait;
            transition absoluteWake first Wait accept at wakeTime then Monitor;
            state Monitor;
            transition tooHot first Monitor accept when temp > threshold then CoolDown;
            state CoolDown;
            transition coolDone first CoolDown then Idle;
        }
    }
}
view 'TransitionTriggers View' : DS_Views::SymbolicViews::gv;
