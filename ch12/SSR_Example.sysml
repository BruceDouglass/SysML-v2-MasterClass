package SSR_Example {
    public import ScalarValues::*;
    public import SI::*;
    item evInterrogation;
    item evReply {
        attribute beaconCode : Integer;
        attribute altitudeHundredsFeet : Integer;
    }
    part def Interrogator {
        ref part transponder : Transponder;
        attribute interrogationPeriod : Real default := 4.0 [s];
        action sendInterrogation {
            action sendPulse send evInterrogation to transponder;
            first sendPulse;
        }
        state InterrogatorSM {
            first start then WaitingToInterrogate;
            state WaitingToInterrogate;
            transition timeToInterrogate first WaitingToInterrogate accept after interrogationPeriod [s] then SendInterrogation;
            state SendInterrogation {
                entry sendInterrogation;
            }
            transition replyReceived first SendInterrogation accept evReply do action processReply then WaitingToInterrogate;
        }
    }
    part def Transponder {
        ref part interrogator : Interrogator;
        attribute assignedBeaconCode : Integer default := 1200;
        attribute altitudeHundredsFeet : Integer default := 300;
        action respondToInterrogation {
            action sendReply send evReply to interrogator;
            first sendReply;
        }
        state TransponderSM {
            first start then WaitingForInterrogation;
            state WaitingForInterrogation;
            transition interrogationArrived first WaitingForInterrogation accept evInterrogation then Replying;
            state Replying {
                entry respondToInterrogation;
            }
            transition '.' first Replying then WaitingForInterrogation;
        }
    }
    part def SSRContext {
        part interrogator : Interrogator;
        part transponder : Transponder;
        bind interrogator.transponder = transponder;
        bind transponder.interrogator = interrogator;
    }
    view SSRView : DS_Views::SymbolicViews::gv;
}
