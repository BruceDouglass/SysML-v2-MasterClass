package UCInclusionExample {
    public import ScalarValues::*;
    part def Client;
    part def SecuritySystem;
    use case authenticate;
    use case verifyAccessPrivileges {
        subject system;
        out attribute granted : Boolean;
    }
    use case AccessSecureArea {
        subject secSys : SecuritySystem;
        actor client : Client;
        in user : String;
        in pw : String;
        in securityLevel : Integer;
        in areaID : String;
        include use case auth :> authenticate;
        include use case vcCheck :> verifyAccessPrivileges;
        action openDoor {
            in areaID : String;
            in preauthorized : Boolean;
            out doorUnlocked : Boolean;
            action check {
                first auth then vcCheck;
                first vcCheck then wasGranted;
                decide wasGranted;
                if vcCheck.granted then open;
                else lock;
            }
            action open;
            action lock;
            first start then isOK;
            decide isOK;
            if preauthorized then open;
            else check;
        }
    }
}
view 'Inclusionexample view' : DS_Views::SymbolicViews::gv;
