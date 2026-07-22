package RealTimeMetadataExample {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    metadata def RealTimeAction {
        doc
        /* Metadata applied to actions to record real-time properties
         * that are not directly expressible as part of the action’s
         * functional behavior. These properties support schedulability
         * and timing analysis.
         */
        attribute maximumLagTime : TimeValue;
        attribute deadline : TimeValue;
        attribute averageExecutionTime : TimeValue;
    }
    metadata def software {
        doc
        /* Marks a model element as belonging primarily to the software
         * engineering facet of the design.
         */
    }
    metadata def electronics {
        doc
        /* Marks a model element as belonging primarily to the electronics
         * facet of the design.
         */
    }
    metadata def mechanical {
        doc
        /* Marks a model element as belonging primarily to the mechanical
         * facet of the design.
         */
    }
    /* -----------------------------
     * Structural and behavioral model
     * ----------------------------- */
    #software part def ValveController {
        doc
        /* Controller that computes the desired valve position and
         * commands the actuator accordingly.
         */
        action setValvePosition : SetValvePosition;
        ref part valve : Valve;
    }
    #mechanical part def Valve {
        doc /* The mechanical valve whose position regulates flow.
         */
    }
    #electronics part def Actuator {
        doc
        /* Electro-mechanical actuator that moves the valve according
         * to commands from the controller.
         */
    }
    action def SetValvePosition {
        doc
        /* Invokable behavior that drives the actuator to a commanded
         * valve position. Its functional behavior does not itself
         * express any timing properties such as deadlines or lag
         * times; those are captured as metadata.
         */
        @RealTimeAction {
            maximumLagTime = 0.02 [s];
            averageExecutionTime = 0.1 [s];
            deadline = 0.5 [s];
        }
    }
}
view 'Metadata Example View' : DS_Views::SymbolicViews::gv;
