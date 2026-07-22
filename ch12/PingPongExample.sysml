package PingPongExample {
    public import ScalarValues::*;
    public import SI::*;
    /* Shared events */
    item evPing;
    item evPong;
    part def Pinger {
        /* Reference to the Ponger participant (defined later) */
        ref part ponger : Ponger;
        /* Number of pings sent so far (default 0, not bound to 0) */
        attribute numberOfPings : Integer default := 0;
        /* Ping period: 0.5 seconds (500 ms) */
        attribute pingPeriod : Real default := 0.5 [s];
        /* Action: send a ping and increment the counter */
        action sendPingAndIncrement {
            action sendPing send evPing to ponger;
            action updatePings assign numberOfPings := numberOfPings + 1;
            first sendPing then updatePings;
        }
        /* Pinger state machine */
        state PingerSM {
            first start then WaitingToPing;
            /* Wait until it is time to ping again */
            state WaitingToPing;
            transition timeToPing first WaitingToPing accept after pingPeriod [s] then SendPing;
            /* Send the ping and bump the counter */
            state SendPing {
                entry sendPingAndIncrement;
            }
            /* Immediately move to waiting for the response */
            /* Wait for the pong from Ponger */
            transition pongReceived first SendPing accept evPong then WaitingToPing;
        }
    }
    part def Ponger {
        /* Reference back to the Pinger (defined above) */
        ref part pinger : Pinger;
        /* Composed action: handle a ping (log + send pong) */
        action handlePing {
            /* Do whatever reporting/logging is appropriate */
            action reportPingReceived;
            action sendPing send evPong to pinger;
            first reportPingReceived then sendPing;
        }
        state PongerSM {
            first start then WaitingForPing;
            /* Wait for a ping */
            state WaitingForPing;
            transition pingArrived first WaitingForPing accept evPing then HandlePingState;
            /* Handle the ping and send a pong */
            state HandlePingState {
                entry handlePing;
            }
            /* Immediately go back to waiting for the next ping */
            transition handled first HandlePingState then WaitingForPing;
        }
    }
    part def PingPongContext {
        part pinger : Pinger;
        part ponger : Ponger;
        /* Bind the ref parts so they actually point at each other */
        bind pinger.ponger = ponger;
        bind ponger.pinger = pinger;
    }
}
view PingPongView : DS_Views::SymbolicViews::gv;
