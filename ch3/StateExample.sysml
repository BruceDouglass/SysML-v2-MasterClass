package StateExample {
    public import ScalarValues::*;
    public import SI::*;
    item evOff;
    item evOn;
    state def LightStateMachine {
        attribute goodStatus : Boolean;
        first start then LightOff;
        transition LightOff accept evOn then LightOn;
        transition LightOn accept evOff if goodStatus then LightOff;
        transition LightOn accept evOff if not goodStatus then Actions::Action::done;
        state LightOff;
        state LightOn {
            first start then ToggleOff;
            state ToggleOff {
                entry action turnLightOff;
            }
            state ToggleOn {
                entry action turnLightOff;
            }
            transition ToggleOff accept after 2 [s] then ToggleOn;
            transition ToggleOn accept after 1 [s] then ToggleOff;
            transition Actions::Action::start then ToggleOff;
        }
        transition Actions::Action::start then LightOff;
    }
    part def Light {
        exhibit state LightStateMachine;
    }
}
