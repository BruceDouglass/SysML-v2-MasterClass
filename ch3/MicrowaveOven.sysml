part def MicrowaveOven;
package StakeholderPkg {
    requirement skR1 {
        subject MicrowaveOven;
        doc /* The oven shall be able cook dinner quickly */
    }
}
package SystemRequirementsPkg {
    requirement sysR1 {
        subject MicrowaveOven;
        doc /* The oven shall provide an output of 0 to 800 watts of power settable with increments of 200 Watts*/
        attribute powerLevel :> ISQMechanics::power;
        require constraint {
            powerLevel == 0 or powerLevel == 200 or powerLevel == 400 or powerLevel == 600 or powerLevel == 800
        }
    }
    requirement sysR2 {
        subject MicrowaveOven;
        doc /* The system shall be able to cook food for 0 to 60 minutes settable with increment +/- 1 second. */
        attribute timeIncrementinSeconds :> ISQBase::duration;
        attribute cookingTime :> ISQBase::duration;
        require constraint timeIncrementConstraint {
            timeIncrementinSeconds == 1
        }
        require constraint maxCookingTimeConstraint {
            cookingTime >= 0 and cookingTime <= 60
        }
    }
    dependency sys2stk from sysR1 to StakeholderPkg::skR1;
    dependency sys2stk from sysR2 to StakeholderPkg::skR1;
}
