package TextualNoationGuideExamples {
    package LogicalModel {
        public import ScalarValues::*;
        public import ISQ::*;
        part def LogicalElement;
        part def TorqueGenerator :> LogicalElement;
        part torqueGenerator : TorqueGenerator;
        part def SpaceCraft_Logical {
            attribute powerBudget : PowerValue;
        }
        part scl : SpaceCraft_Logical;
    }
    package PhysicalModel {
        public import LogicalModel::*;
        part def PhysicalElement;
        part def PowerTrain :> PhysicalElement;
        part powerTrain : PowerTrain;
        allocation def LogicalToPhysical {
            end logical : LogicalElement;
            end physical : PhysicalElement;
        }
        allocation torqueGenAlloc : LogicalToPhysical allocate torqueGenerator to powerTrain;
        /* Spacecraft stuff */
        part def Spacecraft_Physical {
            part powerSystem;
        }
        part slp : Spacecraft_Physical;
        dependency Spacecraft_Physical to SpaceCraft_Logical;
        allocate scl to slp;
        allocate scl.powerBudget to slp.powerSystem;
    }
}
view 'Spacecrft Allocate Example View' : DS_Views::SymbolicViews::gv;
