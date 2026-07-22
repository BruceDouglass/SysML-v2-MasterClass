package TwoLensTelescopeAnalysis {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    item def TwoLensOptic {
        attribute focalLength1 : LengthValue;
        /* objective lens */
        attribute focalLength2 : LengthValue;
        /* eyepiece or secondary */
        attribute separation : LengthValue;
        /* distance between lenses */
    }
    part def Telescope {
        doc
        /* A simple two-lens telescope with a fixed separation between the
         * lenses and a limited range over which the image plane (sensor or
         * eyepiece) can be moved for focusing. The optical design also
         * includes a requirement on how close the telescope must be able
         * to focus on nearby objects.
         */
        item optics : TwoLensOptic {
            :>> focalLength1 = 0.5 [m];
            :>> focalLength2 = 0.1 [m];
            :>> separation = 0.6 [m];
        }
        attribute maxImagePlaneTravel : LengthValue = 0.02 [m];
        attribute requiredMinFocus : LengthValue = 5.0 [m];
    }
    calc def ComputeEffectiveFocalLength {
        in optics : TwoLensOptic;
        return f_eff : LengthValue;
        1 / (1 / optics.focalLength1 + 1 / optics.focalLength2 - optics.separation / (optics.focalLength1 * optics.focalLength2))
    }
    calc def ComputeMinFocusDistance {
        in f_eff : LengthValue;
        in focusTravel : LengthValue;
        return minObjectDistance : LengthValue;
        1 / (1 / f_eff - 1 / (f_eff + focusTravel))
    }
    analysis def TelescopeMinFocusAnalysis {
        doc
        /* Purpose: Determine the minimum object distance that a two-lens
         * telescope can bring into focus, given the effective focal length
         * of its optics and the available image-plane travel.
         *
         * Intent: Compute the effective focal length of the two-lens
         * combination, then use the thin-lens equation to derive the
         * closest distance at which an object can be focused when the
         * image plane is moved to its maximum extension.
         *
         * Usage: Bind a specific Telescope instance and evaluate whether
         * the resulting minimum focusing distance meets the telescope's
         * design requirement for nearby objects.
         */
        subject scope : Telescope;
        return minFocusDistance : LengthValue = ComputeMinFocusDistance(f_eff = ComputeEffectiveFocalLength(optics = scope.optics),
                                                                                                            focusTravel = scope.maxImagePlaneTravel);

        objective MeetsCloseFocusRequirement {
            subject minFocusDistance : LengthValue;
            require constraint WithinRequiredDistance {
                doc
                /* Purpose: Ensure that the computed minimum focusing distance
                 * is no greater than the telescope's requiredMinFocus value.
                 *
                 * Intent: Treat the analysis result (minFocusDistance) as the
                 * subject of evaluation and compare it against the design
                 * requirement captured on the Telescope.
                 *
                 * Usage: If this constraint holds, the optical and mechanical
                 * design provides sufficient close-focus capability; if not,
                 * adjustments to focal lengths or focus travel are required.
                 */
                minFocusDistance <= scope.requiredMinFocus
            }
        }
    }
}
