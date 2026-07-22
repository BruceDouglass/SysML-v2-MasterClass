package ConcurrentStates {
    item VehicleStartSignal;
    item VehicleOnSignal;
    item VehicleOffSignal;
    state def VehicleStates;
    state vehicleStates : VehicleStates parallel {
        state operationalStates {
            entry;
            then off;
            state off;
            accept VehicleStartSignal then starting;
            state starting;
            accept VehicleOnSignal then on;
            state on;
            accept VehicleOffSignal then off;
        }
        state healthStates;
    }
    view 'ConcurrentStates view' : DS_Views::SymbolicViews::gv;
}
