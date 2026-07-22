package DerivePkg {
    private import RequirementDerivation::*;
    requirement 'Source Req1' {
        doc /* The treadmill shall support users ranging from beginner walkers to advanced runners.*/
    }
    requirement 'Derived Requirement' {
        doc /* The treadmill shall have a speed range of 0.5 mph to 15 mph to accommodate different fitness levels.*/
    }
    #derivation connection {
        end #original requirement ::> 'Source Req1';
        end #derive requirement ::> 'Derived Requirement';
    }
}
