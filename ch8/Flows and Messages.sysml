package 'Flows and Messages' {
    event occurrence startFlow;
    event occurrence stopFlow;
    item def Fuel;
    port def FuelIF {
        out fuel : Fuel;
        in event startFlow;
        out event stopFlow;
    }
    part def Tank {
        port pEngine : FuelIF;
    }
    part def Engine {
        port pTank : ~FuelIF;
    }
    part fuelSys {
        part t : Tank;
        part e : Engine;
        connect t.pEngine to e.pTank;
        flow t.pEngine.fuel to e.pTank.fuel;
        message startFlow from e.pTank to t.pEngine;
        message stopFlow from e.pTank to t.pEngine;
    }
    view 'Flows and Messages' : DS_Views::SymbolicViews::gv;
}
