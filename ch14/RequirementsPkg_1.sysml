package RequirementsPkg {
    public import ScalarValues::*;
    requirement req_SomeProperty;
}
package SystemPkg {
    public import RequirementsPkg::*;
    part def SystemUnderTest {
        satisfy req_SomeProperty;
    }
}
package VerificationPkg {
    public import ScalarValues::*;
    public import RequirementsPkg::*;
    public import SystemPkg::*;
    public import VerificationCases::*;
    verification def Verify_Req_SomeProperty :> VerificationCase {
        @VerificationMethod { kind = VerificationMethodKind::test; }
        subject sut : SystemUnderTest;
        in testInput : Real;
        /* Verification verdict returned by this case */
        return verdict : VerdictKind = PassIf(evaluateData);
        action evaluateData { out evaluationResult : Boolean; }
        objective Req_SomeProperty_Verified {
            /* List of requirements to verify */
            verify req_SomeProperty;
        }
    }
}
