package RequirementsPkg {
    public import Real;
    public import RealFunctions::*;
    /* ------------------------------------------------------------
     * Requirement: Temperature Accuracy
     * ------------------------------------------------------------ */
    requirement req_tempAccuracy {
        doc
        /* The monitor shall report ambient temperature within ±1.0 °C
         * of the true ambient temperature under normal operating conditions.
         * The requirement includes a parameter (maxError) that defines
         * the bound used by the verification case.
         */
        attribute tempError : Real;
        attribute maxError : Real = 1.0;
        /* This constraint expresses the formal requirement that any
         * allowable absolute temperature error must not exceed maxError. */
        require constraint TempAccuracyBound {
            abs(tempError) <= maxError
        }
    }
    /* ------------------------------------------------------------
     * Requirement: Response Time
     * ------------------------------------------------------------ */
    requirement req_responseTime {
        doc
        /* The monitor shall update its reported temperature within
         * 0.5 seconds of a change in the true ambient temperature.
         * The requirement includes a parameter (maxResponseTime).
         */
        attribute responseTime : Real;
        attribute maxResponseTime : Real = 0.5;
        /* This constraint expresses the formal requirement that the
         * system's response time must not exceed the specified limit. */
        require constraint ResponseTimeBound {
            responseTime <= maxResponseTime
        }
    }
}
package DesignPkg {
    public import ScalarValues::*;
    public import RequirementsPkg::*;
    part def EnvMonitor {
        doc
        /* Simple environmental monitor that reports ambient temperature
         * and has a measurable response time. This part is modeled as
         * satisfying both the temperature accuracy and response time
         * requirements.
         */
        attribute trueTemperature : Real;
        /* ground truth from fixture */
        attribute reportedTemperature : Real;
        /* what the monitor outputs */
        attribute responseTime : Real;
        /* time to update after change */
        action doStuff [1] {
            doc /* this is where the system magic happens */
        }
        satisfy req_tempAccuracy;
        satisfy req_responseTime;
    }
}
package VerificationPkg {
    public import ScalarValues::*;
    public import RequirementsPkg::*;
    public import DesignPkg::*;
    public import VerificationCases::*;
    public import RealFunctions::*;
    /* ============================================================
     * Top-level verification case for EnvMonitor
     * ============================================================ */
    verification def VerifyEnvMonitor :> VerificationCase {
        doc
        /* Verification case definition that aggregates two simpler
         * verification cases: one for temperature accuracy and one
         * for response time. The overall verdict is pass only if both
         * subordinate verification cases pass.
         */
        subject sut : EnvMonitor;
        /* Top-level verdict is derived from the subordinate cases */
        return verdict : VerdictKind = tempAccuracyCase.verdict == VerdictKind::pass and responseTimeCase.verdict == VerdictKind::pass;
        /* --------------------------------------------------------
         * Verification case for temperature accuracy
         * -------------------------------------------------------- */
        verification tempAccuracyCase : VerificationCase {
            doc
            /* Verifies req_tempAccuracy by applying a known test
             * temperature, allowing the EnvMonitor to produce a
             * reported temperature, and computing the resulting error.
             */
            @VerificationMethod { kind = VerificationMethodKind::test; }
            subject sut : EnvMonitor;
            in testTemperature : Real;
            /* The error value bound to the requirement's constraint variable */
            calc measureTempError {
                return error : Real;
                /* In a real model, testTemperature would be produced
                 * by EnvMonitor behavior or a connected test harness. */
                abs(testTemperature - sut.trueTemperature)
            }
            return verdict : VerdictKind = PassIf(measureTempError.error <= req_tempAccuracy.maxError);
            objective verify_tempAccuracy {
                verify req_tempAccuracy;
            }
        }
        /* --------------------------------------------------------
         * Verification case for response time
         * -------------------------------------------------------- */
        verification responseTimeCase : VerificationCase {
            doc
            /* Verifies req_responseTime by measuring the time required
             * for EnvMonitor to update its reported temperature after
             * a change in the true ambient temperature.
             */
            @VerificationMethod { kind = VerificationMethodKind::test; }
            subject sut : EnvMonitor;
            /* The responseTime value bound to the requirement's
             * ResponseTimeBound constraint variable. */
            calc measureResponseTime {
                return responseTime : Real;
                /* In a real model, this action would stimulate a step
                 * change in trueTemperature and measure the elapsed time
                 * until reportedTemperature settles; here we simply
                 * read sut.responseTime as the measured value. */
                responseTime := sut.responseTime;
            }
            /* Verdict based on applying the requirement's response time
             * constraint to the measured value via PassIf. */
            return verdict : VerdictKind = PassIf(measureResponseTime <= req_responseTime.maxResponseTime);
            objective verify_responseTime {
                verify req_responseTime;
            }
        }
    }
}
