package 'Authenticator Pkg' {
    private import ScalarValues::*;
    item def bioScanImage;
    part def Client {
        attribute name : String;
    }
    part def SecuritySystem;
    use case def Authenticate {
        subject system : SecuritySystem;
        actor client : Client;
        in attribute user : String;
        in attribute pw : String;
        in attribute securityLevel : Integer;
        attribute authenticated : Boolean;
        action def ValidateUser {
            in userID : String;
            in pw : String;
            out isValid : Boolean;
        }
        action validateUser : ValidateUser;
    }
    use case def AuthenticateBiometric :> Authenticate {
        subject system : SecuritySystem;
        in bioScan : bioScanImage;
        attribute correlationMethod : Integer;
        action def BioValidateUser :> ValidateUser {
            in bio : bioScanImage :>> userID;
            in pw : String;
            out isValid : Boolean;
        }
        action bioValidateUser : BioValidateUser;
    }
    use case def BasicStartupUC;
    use case basicStartupUC;
    use case def AdvancedStartupUC :> BasicStartupUC;
    use case def QuickStartUp :> BasicStartupUC;
    use case emergencyStartupUC :> basicStartupUC;
    use case highPriorityStartupUC :> basicStartupUC;
}
view 'Authenticator View' : DS_Views::SymbolicViews::gv;
