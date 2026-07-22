package Model;
private import ScalarValues::*;
view 'Harmony aMBSE Process View' : DS_Views::SymbolicViews::gv;
action def 'Harmony aMBSE Process Workflow' {
    attribute workCompleted : Boolean;
    action 'Initiate Project';
    first start then 'Initiate Project';
    fork __unnamed4;
    action 'Primary SE Iteration' {
        merge __unnamed2;
        action 'Define Stakeholder Requirements';
        action 'System Requirements Definition and analysis';
        action 'Architectural Analysis';
        action 'Architectural Design';
        action 'Perform Iteration Retrospective';
        action 'Handoff to Downstream Engineering';
        decide __unnamed3;
        if workCompleted then __unnamed1;
        else __unnamed2;
        first __unnamed2 then 'Define Stakeholder Requirements';
        first 'Define Stakeholder Requirements' then 'System Requirements Definition and analysis';
        first 'System Requirements Definition and analysis' then 'Architectural Analysis';
        first 'Architectural Analysis' then 'Architectural Design';
        first 'Architectural Design' then 'Perform Iteration Retrospective';
        first 'Perform Iteration Retrospective' then 'Handoff to Downstream Engineering';
        first 'Handoff to Downstream Engineering' then __unnamed3;
        first start then __unnamed2;
        first __unnamed3 if workCompleted then done;
    }
    action 'Contro Project';
    action 'Perform Quality Assurrance Activities';
    action 'Manage Change';
    action 'Manage Configuratons';
    join __unnamed1;
    first 'Initiate Project' then __unnamed4;
    first __unnamed4 then 'Primary SE Iteration';
    first __unnamed4 then 'Contro Project';
    first __unnamed4 then 'Perform Quality Assurrance Activities';
    first __unnamed4 then 'Manage Change';
    first __unnamed4 then 'Manage Configuratons';
    first 'Contro Project' then __unnamed1;
    first 'Perform Quality Assurrance Activities' then __unnamed1;
    first 'Manage Change' then __unnamed1;
    first 'Manage Configuratons' then __unnamed1;
    first __unnamed1 then done;
    first 'Primary SE Iteration' then __unnamed1;
}
