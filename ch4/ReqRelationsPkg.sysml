package ReqRelationsPkg {
    /* imports */
    private import VerificationCases::*;
    private import RequirementDerivation::*;
    /* derivation metadata */
    private import ModelingMetadata::refinement;
    /* refinement metadata */
    public import ScalarValues::*;
    public import USCU::*;
    public import SI::*;
    public import RealFunctions::*;
    /* views */
    view 'Requirements Relations Diagram' : DS_Views::SymbolicViews::gv;
    /* metadata for special relations */
    metadata def <trace> Trace {
        doc /* trace is a user-redefined dependency */
        :>> annotatedElement : KerML::Root::Dependency;
    }
    /* requirements */
    concern concern1;
    requirement requirement1 {
        requirement requirement2;
    }
    requirement requirement3;
    requirement requirement4 {
        dependency requirement4 to concern1;
    }
    requirement requirement5;
    requirement requirement6 {
        attribute maxWeight : Real;
        attribute height : Real;
    }
    requirement requirement7;
    requirement requirement8;
    requirement requirement9;
    comment about req1_derivation /* n-way connection. */
    use case useCase1;
    /* part 2 */
    /* relations */
    #trace dependency trace1 from requirement3 to requirement4;
    #refinement dependency ref1 from requirement9 to requirement7;
    #trace dependency trace2 from requirement1 to requirement8;
    #trace dependency trace3 from requirement1 to requirement4;
    #trace dependency trace4 from useCase1 to requirement1;
    /* derivation is  from RequirementsDerivation library */
    /* binary derivation */
    #derivation connection {
        end #original requirement ::> requirement3;
        end #derive requirement ::> requirement1.requirement2;
    }
    /* n-way derivation */
    #derivation connection req1_derivation {
        end #original requirement ::> requirement1;
        end #derive requirement ::> requirement5;
        end #derive requirement ::> requirement6;
        end #derive requirement ::> requirement7;
    }
    part System {
        satisfy requirement6 {
            :>> maxWeight = 100 [kg];
            :>> height = 2 [m];
        }
    }
}
