package StateExample {
    item keyTurned;
    item throttlePressed;
    item throttleReleased;
    item keyRemoved;
    part def EngineController {
        state def EngineStates {
            entry;
            then Off;
            state Off;
            accept keyTurned then Idle;
            state Idle;
            accept throttlePressed then Running;
            state Running;
            accept throttleReleased then Idle;
            accept keyRemoved then Off;
        }
        state currentState [1] : EngineStates;
    }
}
