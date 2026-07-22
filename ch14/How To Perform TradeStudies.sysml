package 'How To Perform TradeStudies' {
    view 'How To Perform TradeStudies' : DS_Views::SymbolicViews::gv;
    action 'Identify Key System Functions to Optimize';
    action 'Define Candidate Solutions';
    action 'Define the Assessment Criteria';
    action 'Specify Weighting Factors for Each Criterion';
    action 'Define Utility Functions';
    action 'Perform Sensitivity Analysis';
    action 'Compute the Overall Effectiveness for Each Candidate Solution';
    action 'Select Solution';
    first Actions::Action::start then 'Identify Key System Functions to Optimize';
    first 'Identify Key System Functions to Optimize' then 'Define Candidate Solutions';
    first 'Define Candidate Solutions' then 'Define the Assessment Criteria';
    first 'Define the Assessment Criteria' then 'Specify Weighting Factors for Each Criterion';
    first 'Specify Weighting Factors for Each Criterion' then 'Define Utility Functions';
    first 'Define Utility Functions' then 'Perform Sensitivity Analysis';
    first 'Perform Sensitivity Analysis' then 'Compute the Overall Effectiveness for Each Candidate Solution';
    first 'Compute the Overall Effectiveness for Each Candidate Solution' then 'Select Solution';
    first 'Select Solution' then Actions::Action::done;
}
