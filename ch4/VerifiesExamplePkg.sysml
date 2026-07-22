package VerifiesExamplePkg {
    requirement requirement1;
    requirement requirement3;
    requirement requirement4;
    /* verification stuff */
    public import VerificationCases::*;
    verification def TestCase {
        /* verification definition for the system definition */
        subject system;
    }
    verification testCase1 : TestCase {
        doc /* verification test case  */
        subject systemStates;
        objective testcaseObjective {
            verify requirement3;
        }
        return verdict : VerdictKind;
    }
    verification testCase2 : TestCase {
        doc /* verification test case  */
        subject systemAction;
        objective testcaseObjective {
            verify requirement1;
            verify requirement4;
        }
        return verdict : VerdictKind;
    }
    verification testCase3 : TestCase;
    /* structural things */
    state def StateDef1;
    action def ActionDef1;
    state systemStates : StateDef1;
    action systemcAction : ActionDef1;
    part def 'System Specification' {
        exhibit state systemStates;
        perform action systemAction;
    }
    part <system> 'System Of Concern' : 'System Specification';
    comment about requirement1 /* An annotation of an requirement that is outside of the requirement itself*/
}
view 'Verification Stuff View' : DS_Views::SymbolicViews::gv;
