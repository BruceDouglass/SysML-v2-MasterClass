package ControlNodes {
    public import ScalarValues::*;
    item def Position3D;
    action def GetPosition {
        merge m;
        action getGPSEphemericData;
        action computeGPSPosition;
        action updateINS;
        action getINSPosition;
        action publishPosition;
        action resolvePosition;
        first start then m;
        first m then getGPSEphemericData;
        first m then updateINS;
        first getGPSEphemericData then computeGPSPosition;
        first updateINS then getINSPosition;
        first computeGPSPosition then resolvePosition;
        first getINSPosition then resolvePosition;
        first resolvePosition then publishPosition;
        first publishPosition then m;
    }
    action def DecideExample {
        attribute temp : Real;
        action coolDown;
        action heatUp;
        decide tempControl;
        first start then tempControl;
        first tempControl if temp > 25 then coolDown;
        first tempControl if temp < 15 then heatUp;
    }
}
package OrderRoutingWithDecide {
    public import ScalarValues::*;
    action def RouteOrder {
        /* Inputs and state */
        attribute riskScore : Real;
        attribute totalValue : Real;
        attribute isPreferred : Boolean;
        attribute isApproved : Boolean = false;
        attribute requiresReview : Boolean = false;
        /* Actions */
        action evaluateOrder;
        /* Control node */
        decide routeGate;
        /* 1) First evaluate the order */
        first start then evaluateOrder;
        /* 2) Then reach the decision point */
        first evaluateOrder then routeGate;
        /* 3) Branch based on conditions at the decision node */
        /* Low-risk and small orders: auto-approve */
        first routeGate if riskScore < 0.3 and totalValue < 1000.0 then autoApprove;
        /* Medium risk OR high-value orders: escalate to human review */
        first routeGate if riskScore >= 0.3 and riskScore < 0.7 or totalValue >= 1000.0 then sendToHumanReview;
        /* High-risk orders: reject */
        first routeGate if riskScore >= 0.7 then rejectOrder;
        /* 4) Simple effects in each branch */
        action autoApprove {
            assign isApproved := true;
            assign requiresReview := false;
        }
        action sendToHumanReview {
            assign isApproved := false;
            assign requiresReview := true;
        }
        action rejectOrder {
            assign isApproved := false;
            assign requiresReview := false;
        }
    }
    action def RouteOrderAction {
        /* Inputs and state */
        attribute riskScore : Real;
        attribute totalValue : Real;
        attribute isPreferred : Boolean;
        attribute isApproved : Boolean = false;
        attribute requiresReview : Boolean = false;
        /* Actions */
        action evaluateOrder;
        action autoApprove;
        action sendToHumanReview;
        action rejectOrder;
        action callFraudDept;
        /* Control node */
        decide routeGate;
        if riskScore < 0.3 and totalValue < 1000.0 then autoApprove;
        if riskScore >= 0.3 and riskScore < 0.7 or totalValue >= 1000.0 then sendToHumanReview;
        if riskScore >= 0.7 and riskScore < 0.9 then rejectOrder;
        else callFraudDept;
        first start then evaluateOrder;
        first evaluateOrder then routeGate;
    }
    action withoutDecideNode {
        /* Inputs and state */
        attribute riskScore : Real;
        attribute totalValue : Real;
        attribute isPreferred : Boolean;
        action evaluateRisk;
        action autoApprove;
        action sendToHumanReview;
        action rejectOrder;
        first start then evaluateRisk;
        first evaluateRisk;
        if riskScore < 0.3 then autoApprove;
        if riskScore >= 0.3 and riskScore < 0.7 then sendToHumanReview;
        if riskScore >= 0.7 then rejectOrder;
    }
    view 'Order Routing With Decide View' : DS_Views::SymbolicViews::gv;
}
view 'Control Nodes View' : DS_Views::SymbolicViews::gv;
package ForkExampleWithNode {
    public import ScalarValues::*;
    action def PrepareCoffee {
        attribute brewTime : Real = 120;
        action fillReservoir;
        action heatWater;
        action grindBeans;
        action brew {
            accept after brewTime;
        }
        action pourCup;
        /* Explicit fork for clarity */
        fork fPrep;
        /* Control flow */
        first start then fillReservoir;
        first fillReservoir then fPrep;
        /* Forked actions start concurrently */
        first fPrep then heatWater;
        first fPrep then grindBeans;
        /* After both complete, brewing may start */
        first heatWater then brew;
        first grindBeans then brew;
        first brew then pourCup;
    }
    view 'ForkExampleWithNode View' : DS_Views::SymbolicViews::gv;
}
package ForkExampleWithoutNode {
    public import ScalarValues::*;
    action def PrepareCoffee {
        action fillReservoir;
        action heatWater;
        action grindBeans;
        action brew;
        action pourCup;
        /* Same semantics, no explicit fork */
        first start then fillReservoir;
        first fillReservoir then heatWater;
        first fillReservoir then grindBeans;
        first heatWater then brew;
        first grindBeans then brew;
        first brew then pourCup;
    }
    view 'ForkExampleWithoutNode View' : DS_Views::SymbolicViews::gv;
}
package JoinExampleWithNode {
    public import ScalarValues::*;
    action def AssembleProduct {
        action pickComponents;
        action weldFrame;
        action tightenBolts;
        action applyLabel;
        action performQualityCheck;
        action packageItem;
        fork fAssembly;
        join jReadyForInspection;
        /* Parallel fabrication steps */
        first start then pickComponents;
        first pickComponents then fAssembly;
        first fAssembly then weldFrame;
        first fAssembly then tightenBolts;
        first fAssembly then applyLabel;
        /* Synchronize before inspection */
        first weldFrame then jReadyForInspection;
        first tightenBolts then jReadyForInspection;
        first applyLabel then jReadyForInspection;
        first jReadyForInspection then performQualityCheck;
        /* Final packaging */
        first performQualityCheck then packageItem;
    }
    view 'JoinExampleWithNode View' : DS_Views::SymbolicViews::gv;
}
package JoinExampleWithoutNode {
    public import ScalarValues::*;
    action def AssembleProduct {
        action pickComponents;
        action weldFrame;
        action tightenBolts;
        action applyLabel;
        action performQualityCheck;
        action packageItem;
        /* Same semantics, no explicit join */
        first start then pickComponents;
        first pickComponents then weldFrame;
        first pickComponents then tightenBolts;
        first pickComponents then applyLabel;
        /* All must complete before inspection */
        first weldFrame then performQualityCheck;
        first tightenBolts then performQualityCheck;
        first applyLabel then performQualityCheck;
        first performQualityCheck then packageItem;
    }
    view 'JoinExampleWithoutNode View' : DS_Views::SymbolicViews::gv;
}
