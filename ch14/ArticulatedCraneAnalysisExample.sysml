package ArticulatedCraneAnalysisExample {
    public import ScalarValues::*;
    public import SI::*;
    public import ISQ::*;
    public import TrigFunctions::*;
    /* --- SUBJECT: TWO-SEGMENT ARTICULATED CRANE --- */
    part def ArticulatedCrane {
        attribute proximalLength : LengthValue = 8 [m];
        attribute distalLength : LengthValue = 6 [m];
        /* Maximum permissible overturning moment (N·m) before tipping. */
        attribute tippingLimit : MomentOfForceValue = 300000 [N * m];
    }
    /* --- PURE CALCULATIONS --- */
    /* Horizontal reach from base to tip for a 2-segment articulated arm:
     * dx = L1 * cos(theta1) + L2 * cos(theta1 + theta2) */
    calc def ComputeHorizontalReach {
        in L1 : LengthValue;
        in L2 : LengthValue;
        in theta1 : AngularMeasureValue;
        in theta2 : AngularMeasureValue;
        return reach : LengthValue;
        L1 * cos(theta1) + L2 * cos(theta1 + theta2)
    }
    /* Overturning moment = load * horizontalReach */
    calc def ComputeMoment {
        in load : ForceValue;
        in horizontalReach : LengthValue;
        return moment : MomentOfForceValue;
        load * horizontalReach
    }
    /* --- ACTION: INCREMENTAL SEARCH FOR MAX SAFE θ1 --- */
    action def FindMaxSafeTheta1 {
        in L1 : LengthValue;
        in L2 : LengthValue;
        in load : ForceValue;
        in theta2 : AngularMeasureValue;
        in tippingLimit : MomentOfForceValue;
        maxTheta1 : AngularMeasureValue;
        doc
        /* Purpose: Numerically determine the maximum proximal-arm angle θ1
         * (0–90°) for a given load and fixed distal angle θ2, such that the
         * overturning moment does not exceed tippingLimit.
         *
         * Intent: Iterate θ1 in small increments, compute the resulting
         * horizontal reach and moment at each step, and record the largest
         * θ1 that satisfies the stability constraint.
         *
         * Usage: Called from analyses that need a conservative maximum
         * allowable elevation for the proximal segment under a specific load
         * and distal configuration.
         */
        /* Local variables */
        attribute step : AngularMeasureValue = 1 ['°'];
        attribute theta1 : AngularMeasureValue = 0 ['°'];
        attribute best : AngularMeasureValue = 0 ['°'];
        attribute reach : LengthValue;
        attribute moment : MomentOfForceValue;
        while theta1 <= 90 ['°'] {
            reach := ComputeHorizontalReach(L1 = L1, L2 = L2, theta1 = theta1, theta2 = theta2);
            moment := ComputeMoment(load = load, horizontalReach = reach);
            if moment <= tippingLimit {
                best := theta1;
            }
            theta1 := theta1 + step;
        }
        maxTheta1 := best;
    }
    /* --- ANALYSIS CASE --- */
    analysis def CraneLoadBalanceAnalysis {
        doc
        /* Purpose: Determine the maximum proximal-arm elevation angle θ1 for
         * a two-segment articulated crane, under a specified tip load and
         * fixed distal angle θ2, that does not cause the crane to exceed its
         * allowable overturning moment.
         *
         * Intent: Use the crane geometry (proximal and distal lengths), the
         * tip load, and θ2 to compute a maximum safe θ1 via an action that
         * searches the admissible range. The analysis result is the largest
         * angle at which the crane remains stable.
         *
         * Usage: Bind a specific ArticulatedCrane, tipLoad, and distalAngle.
         * Run the analysis to obtain maxSafeTheta1 and then confirm that the
         * stability condition is met at that configuration.
         */
        /* The crane being evaluated. */
        subject crane : ArticulatedCrane;
        /* Inputs: applied tip load and distal-joint angle θ2. */
        in tipLoad : ForceValue;
        in distalAngle : AngularMeasureValue;
        /* Result of the analysis: maximum safe proximal angle θ1. */
        return maxSafeTheta1 : AngularMeasureValue = FindMaxSafeTheta1(L1 = crane.proximalLength, L2 = crane.distalLength, load = tipLoad, theta2 = distalAngle,
                                                                       tippingLimit = crane.tippingLimit);

        /* Perform the iterative search in an action (side-effect-free w.r.t. model). */
        action FindMaxSafeTheta1 {
            L1 = crane.proximalLength;
            L2 = crane.distalLength;
            load = tipLoad;
            theta2 = distalAngle;
            tippingLimit = crane.tippingLimit;
            maxTheta1 = maxSafeTheta1;
        }
        objective StableAtMaxAngle {
            subject maxSafeTheta1 : AngularMeasureValue;
            require constraint WithinTippingLimit {
                doc
                /* Purpose: Assert that at the computed maximum safe angle θ1,
                 * with the given distalAngle and tipLoad, the overturning
                 * moment does not exceed the crane’s tippingLimit.
                 *
                 * Intent: Express the stability condition as a pure constraint
                 * over the analysis result (maxSafeTheta1) and inputs, using
                 * only pure calculations (no iteration).
                 *
                 * Usage: This constraint is used to determine whether the
                 * analysis result is consistent with the crane’s stability
                 * requirement. If violated, the configuration is unsafe.
                 */
                ComputeMoment(load = tipLoad, horizontalReach = ComputeHorizontalReach(L1 = crane.proximalLength, L2 = crane.distalLength, theta1 = maxSafeTheta1,
                                                                                       theta2 = distalAngle)) <= crane.tippingLimit
            }
        }
    }
}
