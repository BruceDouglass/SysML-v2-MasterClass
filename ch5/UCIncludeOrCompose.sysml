package UCIncludeOrCompose {
    public import UseCases::*;
    part def SecuritySystem;
    /* Reusable use case */
    use case authenticateUser {
        subject system : SecuritySystem;
        actor user;
    }
    /* Including use case */
    use case accessSecureArea {
        subject system : SecuritySystem;
        actor user;
        include use case authenticateUser;
    }
    /* Sub-use case defined as a nested composite usage */
    use case ProcessEntryRequest {
        subject system : SecuritySystem;
        actor user;
        use case validateBadge;
        use case checkAccessRights;
        use case authenticateDuringEntry :> authenticateUser;
    }
}
view 'UCIncludeotCompose View' : DS_Views::SymbolicViews::gv;
