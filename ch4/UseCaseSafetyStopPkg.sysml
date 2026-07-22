package UseCaseSafetyStopPkg {
    use case SafetyStop {
        subject Treadmill;
        dependency ucdep1 from SafetyStop to requirement10;
        dependency usdep2 from SafetyStop to requirement11;
    }
    requirement requirement10 {
        doc /* The treadmill shall provide an emergency stop function.*/
    }
    requirement requirement11 {
        doc /* The treadmill shall include a safety key that must be inserted to operate*/
        dependency dep1 from requirement11 to requirement10;
    }
    comment about requirement11::dep1 /* requirement 11 depends on requirement10, because the safety key is a mechanism that enables emergency stops*/
}
view 'Safety Stop VIew' : DS_Views::SymbolicViews::gv;
