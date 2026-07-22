package FlattenedLightStates {
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
            transition Actions::Action::start then Off;
            state Off {
                entry turnOff;
            }
            accept evOn then Red_Steady;
            state Red_Steady {
                entry assign setColor := ColorType::RED;
                entry turnOn;
            }
            state Red_FlashingQuickly {
                entry assign setColor := ColorType::RED;
                entry toggleOnOff;
            }
            state Red_FlashingSlowly {
                entry assign setColor := ColorType::RED;
                entry toggleOnOff;
            }
            state Yellow_Steady {
                entry assign setColor := ColorType::YELLOW;
                entry turnOn;
            }
            state Yellow_FlashingQuickly {
                entry assign setColor := ColorType::YELLOW;
                entry toggleOnOff;
            }
            state Yellow_FlashingSlowly {
                entry assign setColor := ColorType::YELLOW;
                entry toggleOnOff;
            }
            state Green_Steady {
                entry assign setColor := ColorType::GREEN;
                entry turnOn;
            }
            state Green_FlashingQuickly {
                entry assign setColor := ColorType::GREEN;
                entry toggleOnOff;
            }
            state Green_FlashingSlowly {
                entry assign setColor := ColorType::GREEN;
                entry toggleOnOff;
            }
            transition Red_Steady accept evOff then Off;
            transition Red_FlashingQuickly accept evOff then Off;
            transition Red_FlashingSlowly accept evOff then Off;
            transition Yellow_Steady accept evOff then Off;
            transition Yellow_FlashingQuickly accept evOff then Off;
            transition Yellow_FlashingSlowly accept evOff then Off;
            transition Green_Steady accept evOff then Off;
            transition Green_FlashingQuickly accept evOff then Off;
            transition Green_FlashingSlowly accept evOff then Off;
            transition Red_FlashingQuickly accept after fastTick [s] then Red_FlashingQuickly;
            transition Yellow_FlashingQuickly accept after fastTick [s] then Yellow_FlashingQuickly;
            transition Green_FlashingQuickly accept after fastTick [s] then Green_FlashingQuickly;
            transition Red_FlashingSlowly accept after slowTick [s] then Red_FlashingSlowly;
            transition Yellow_FlashingSlowly accept after slowTick [s] then Yellow_FlashingSlowly;
            transition Green_FlashingSlowly accept after slowTick [s] then Green_FlashingSlowly;
            transition Red_Steady accept evYellow then Yellow_Steady;
            transition Red_FlashingQuickly accept evYellow then Yellow_FlashingQuickly;
            transition Red_FlashingSlowly accept evYellow then Yellow_FlashingSlowly;
            transition Yellow_Steady accept evRed then Red_Steady;
            transition Yellow_FlashingQuickly accept evRed then Red_FlashingQuickly;
            transition Yellow_FlashingSlowly accept evRed then Red_FlashingSlowly;
            transition Red_Steady accept evGreen then Green_Steady;
            transition Red_FlashingQuickly accept evGreen then Green_FlashingQuickly;
            transition Red_FlashingSlowly accept evGreen then Green_FlashingSlowly;
            transition Green_Steady accept evRed then Red_Steady;
            transition Green_FlashingQuickly accept evRed then Red_FlashingQuickly;
            transition Green_FlashingSlowly accept evRed then Red_FlashingSlowly;
            transition Yellow_Steady accept evGreen then Green_Steady;
            transition Yellow_FlashingQuickly accept evGreen then Green_FlashingQuickly;
            transition Yellow_FlashingSlowly accept evGreen then Green_FlashingSlowly;
            transition Green_Steady accept evYellow then Yellow_Steady;
            transition Green_FlashingQuickly accept evYellow then Yellow_FlashingQuickly;
            transition Green_FlashingSlowly accept evYellow then Yellow_FlashingSlowly;
            transition Red_Steady accept evFast then Red_FlashingQuickly;
            transition Yellow_Steady accept evFast then Yellow_FlashingQuickly;
            transition Green_Steady accept evFast then Green_FlashingQuickly;
            transition Red_FlashingQuickly accept evSteady then Red_Steady;
            transition Yellow_FlashingQuickly accept evSteady then Yellow_Steady;
            transition Green_FlashingQuickly accept evSteady then Green_Steady;
            transition Red_FlashingQuickly accept evSlow then Red_FlashingSlowly;
            transition Yellow_FlashingQuickly accept evSlow then Yellow_FlashingSlowly;
            transition Green_FlashingQuickly accept evSlow then Green_FlashingSlowly;
            transition Red_FlashingSlowly accept evFast then Red_FlashingQuickly;
            transition Yellow_FlashingSlowly accept evFast then Yellow_FlashingQuickly;
            transition Green_FlashingSlowly accept evFast then Green_FlashingQuickly;
            transition Red_Steady accept evSlow then Red_FlashingSlowly;
            transition Yellow_Steady accept evSlow then Yellow_FlashingSlowly;
            transition Green_Steady accept evSlow then Green_FlashingSlowly;
            transition Red_FlashingSlowly accept evFast then Red_Steady;
            transition Yellow_FlashingSlowly accept evFast then Yellow_Steady;
            transition Green_FlashingSlowly accept evFast then Green_Steady;
        }
    }
}
view 'Flasttend States View' : DS_Views::SymbolicViews::gv;
