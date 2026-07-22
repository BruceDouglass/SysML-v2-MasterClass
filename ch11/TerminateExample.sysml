package TerminateExample {
    public import ScalarValues::*;
    action def SupervisoryControl {
        attribute minorFault : Boolean;
        attribute majorFault : Boolean;
        attribute internalError : Boolean;
        loop action monitorLoop {
            action monitorSystem;
            then if minorFault {
                terminate monitorSystem;
            } else if majorFault {
                terminate this;
            } else if internalError {
                terminate;
            }
        } until false;
    }
}
