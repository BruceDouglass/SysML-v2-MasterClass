package PacemakerExamplePkg {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* occurrences */
    item def HeartSenseSignal;
    item def PacerSenseNotification;
    item def PacingPulse;
    /* structural members */
    part def AVI_Pacemaker {
        attribute pacingRate : Integer default 60;
        part aPaceEngine : AtrialPacer_AVI;
        part vPaceEngine : VentricularPacer_AVI {
            in part atrialPacer = aPacer;
        }
        part vSensor : SenseElectronics;
        part aPacer : PaceElectronics;
        connect aPacer to vPaceEngine;
        flow HeartSenseSignal from vSensor to vPaceEngine;
        flow PacingPulse from aPaceEngine to aPacer;
    }
    part def SenseElectronics;
    part def PaceElectronics;
    part def AtrialPacer_AVI {
        attribute refactoryTime : TimeValue default 0.15 [s];
        attribute vTimeout : TimeValue default 1 [s];
        attribute pulseAmplitude : SourceVoltageValue default 3.5 [V];
        attribute pulseWidth : TimeValue default 0.005 [s];
        in part pe : PaceElectronics;
        ref part monitor;
        state AtrialPacingStates : APacingStateMachine;
        state def APacingStateMachine {
            state Refactory {
                action stopAtrialPulse;
            }
            accept after refactoryTime [s] then WaitingForVSense;
            state WaitingForVSense;
            accept PacerSenseNotification then WaitingForVSense;
            accept after vTimeout then aPacing;
            state aPacing {
                entry action startAtrialPulse {
                    in attribute pAmp = pulseAmplitude;
                    flow PacingPulse from self to pe;
                }
                event occurrence pacing ::> startAtrialPulse;
                action {
                    send pacing to monitor;
                }
            }
            accept after pulseWidth [s] then Refactory;
            ref view APacingStates : DS_Views::SymbolicViews::stv;
            transition Actions::Action::start then Refactory;
        }
    }
    part def VentricularPacer_AVI {
        in part atrialPacer : AtrialPacer_AVI;
        attribute refactoryTime : TimeValue default 0.05 [s];
        attribute senseTimeout : TimeValue default 0.85 [s];
        state VentricularPacingStates : VPacingStateMachne;
        state def VPacingStateMachne {
            transition Actions::Action::start then Refactory;
            state Refactory;
            accept after refactoryTime [s] then WaitingForSense;
            state WaitingForSense;
            accept HeartSenseSignal then WaitingForSense;
            accept after senseTimeout do send new PacerSenseNotification() to atrialPacer then Refactory;
        }
    }
}
view 'PacemakerExample view' : DS_Views::SymbolicViews::gv;
