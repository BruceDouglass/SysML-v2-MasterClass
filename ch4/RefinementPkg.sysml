package RefinementPkg {
    public import ModelingMetadata::*;
    requirement 'Source Req2' {
        doc /* The treadmill shall provide variable speed control.*/
    }
    requirement 'Refined Req1' {
        doc /* The treadmill shall allow speed adjustment in increments of 0.1 mph.*/
    }
    requirement 'Refined Req2' {
        doc /* The treadmill shall support a minimum speed of 0.5 mph and a maximum speed of 12 mph.*/
    }
    #refinement dependency 'Refined Req1' to 'Source Req2';
    #refinement dependency 'Refined Req2' to 'Source Req2';
}
view 'Refinement View' : DS_Views::SymbolicViews::gv;
