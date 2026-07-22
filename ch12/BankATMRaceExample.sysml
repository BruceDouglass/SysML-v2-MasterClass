package BankATMRaceExample {
    public import ScalarValues::*;
    part def Bank {
        part accounts : BankAccount [*];
    }
    part def BankAccount {
        attribute balance : Real = 100.0;
        attribute withdrawAmount : Real = 80.0;
        action withdrawAndDispense {
            in amount : Real;
            assign balance := balance - amount;
        }
        item atm1Identify;
        item atm1ReqBalance;
        item atm1Withdraw;
        item atm2Identify;
        item atm2ReqBalance;
        item atm2Withdraw;
        state ATMWithdrawSessions parallel {
            state ATM1Session {
                state IdentifyUser1;
                state RequestBalance1;
                state Withdraw1 {
                    entry withdrawAndDispense { in amount : withdrawAmount; }
                }
                transition States::StateAction::start then IdentifyUser1;
                transition id1_to_req1 first IdentifyUser1 accept atm1Identify then RequestBalance1;
                transition req1_to_withdraw1 first RequestBalance1 accept atm1Withdraw then Withdraw1;
            }
            state ATM2Session {
                state IdentifyUser2;
                state RequestBalance2;
                state Withdraw2 {
                    entry withdrawAndDispense { in amount : withdrawAmount; }
                }
                transition States::StateAction::start then IdentifyUser2;
                transition id2_to_req2 first IdentifyUser2 accept atm2Identify then RequestBalance2;
                transition req2_to_withdraw2 first RequestBalance2 accept atm2Withdraw then Withdraw2;
            }
        }
    }
}
view RaceConditionView : DS_Views::SymbolicViews::gv;
