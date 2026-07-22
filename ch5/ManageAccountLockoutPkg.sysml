package ManageAccountLockoutPkg {
    public import ScalarValues::*;
    part def Account;
    part def User;
    part def AccountManager;
    item evLogIn;
    item evLogOut;
    item evReset;
    use case ManageAccountLockout {
        subject acct : Account;
        actor user : User;
        actor manager : AccountManager;
        state lockoutStates [1] : LockoutStateMachine;
        state def LockoutStateMachine {
            attribute logInAttempts : Integer;
            attribute passwordOk : Boolean;
            state active {
                action def ZeroLogInAttempts {
                    assign logInAttempts := 0;
                }
                entry action zeroLogInAttempts : ZeroLogInAttempts;
                state LoggedOut;
                state LoggedIn;
                state LoggingIn {
                    entry action evaluatePassword {
                        assign passwordOk := evaluatePassword();
                        assign logInAttempts := logInAttempts + 1;
                    }
                }
                action def AugmentLogInAttempts {
                    assign logInAttempts := logInAttempts + 1;
                }
                transition Actions::Action::start then LoggedOut;
                transition LoggedOut accept evLogIn then LoggingIn;
                transition LoggingIn if not passwordOk and logInAttempts < 5 then LoggedOut;
                transition LoggingIn if passwordOk then LoggedIn;
                transition LoggedIn accept evLogOut then active;
            }
            state Locked;
            transition t1 first active.LoggingIn if not passwordOk and logInAttempts >= 5 then Locked;
            transition t3 first Locked accept evReset then active;
            transition Actions::Action::start then active;
        }
    }
}
view 'ManageAccountLockOut View' : DS_Views::SymbolicViews::gv;
