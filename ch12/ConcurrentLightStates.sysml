package ConcurrentLightStates {
    public import ScalarValues::*;
    public import SI::*;
    enum def ColorType {
        RED;
        YELLOW;
        GREEN;
    }
    item evRed;
    item evGreen;
    item evYellow;
    item evSteady;
    item evSlow;
    item evFast;
    item evOn;
    item evOff;
    part def LEDLight {
        action setColor { in color : ColorType; }
        action toggleOnOff;
        action turnOn;
        action turnOff;
        attribute slowTick : Real = 10 [s];
        attribute fastTick : Real = 2 [s];
        state LightStates {
            first start then Off;
            state Off {
                entry turnOff;
            }
            accept evOn then On;
            transition On accept evOff then Off;
            state On parallel {
                state ColorStates {
                    state Red {
                        entry setColor { in color : ColorType::RED; }
                    }
                    state Yellow {
                        entry setColor { in color : ColorType::YELLOW; }
                    }
                    state Green {
                        entry setColor { in color : ColorType::GREEN; }
                    }
                    transition States::StateAction::start then Red;
                    transition Red accept evYellow then Yellow;
                    transition Yellow accept evRed then Red;
                    transition Red accept evGreen then Green;
                    transition Green accept evRed then Red;
                    transition Yellow accept evGreen then Green;
                    transition Green accept evYellow then Yellow;
                }
                state FlashingStates {
                    state Steady {
                        entry turnOn;
                    }
                    state FlashingQuickly {
                        entry toggleOnOff;
                    }
                    state FlashingSlowly {
                        entry toggleOnOff;
                    }
                    transition States::StateAction::start then Steady;
                    transition FlashingSlowly accept after slowTick [s] then FlashingSlowly;
                    transition FlashingQuickly accept after fastTick [s] then FlashingQuickly;
                    transition Steady accept evFast then FlashingQuickly;
                    transition FlashingQuickly accept evSteady then Steady;
                    transition FlashingQuickly accept evSlow then FlashingSlowly;
                    transition FlashingSlowly accept evFast then FlashingQuickly;
                    transition Steady accept evSlow then FlashingSlowly;
                    transition FlashingSlowly accept evFast then Steady;
                }
            }
        }
    }
}
view 'Light States View' : DS_Views::SymbolicViews::gv;
