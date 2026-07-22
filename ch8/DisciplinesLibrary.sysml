package DisciplinesLibrary {
    /* ------------------------------------------------------------------ *
     * Enumeration of engineering disciplines
     * ------------------------------------------------------------------ */
    enum DisciplineKind {
        Multimodal;
        Software;
        Electronics;
        Mechanical;
        Chemical;
        Nuclear;
    }
    /* ------------------------------------------------------------------ *
     * Metadata definition for applying discipline facets
     * ------------------------------------------------------------------ */
    metadata def facet {
        attribute discipline : DisciplineKind;
    }
}
package DeploymentArchitecture {
    public import Allocations::*;
    public import DisciplinesLibrary::*;
    public import ScalarValues::*;
    public import ISQ::*;
    /* -------- Logical spacecraft: system (non-facet) properties -------- */
    part def Spacecraft_Logical {
        attribute powerBudget : PowerValue;
        attribute computeBudget : Real;
        attribute massBudget : MassValue;
        action navigate;
    }
    part def Processor {
        @facet { discipline = DisciplineKind::Electronics; }
        /* -------- Faceted physical parts -------- */
        part flightSoftware {
            @facet { discipline = DisciplineKind::Software; }
        }
    }
    part def PowerSupply {
        @facet { discipline = DisciplineKind::Electronics; }
    }
    part def AvionicsRack {
        @facet { discipline = DisciplineKind::Mechanical; }
        part cpuBoard : Processor {
            @facet { discipline = DisciplineKind::Electronics; }
        }
        part powerUnit : PowerSupply {
            @facet { discipline = DisciplineKind::Electronics; }
        }
    }
    /* -------- Physical spacecraft: owns assembly and the allocation usages -------- */
    part def Spacecraft_Physical {
        @facet { discipline = DisciplineKind::Multimodal; }
        part rack : AvionicsRack {
            @facet { discipline = DisciplineKind::Mechanical; }
        }
    }
    /* Allocation usages of the built-in Allocation, no custom defs needed */
    dependency Spacecraft_Physical to Spacecraft_Logical;
    part spacecraft_physical : Spacecraft_Physical {
        @facet { discipline = DisciplineKind::Multimodal; }
    }
    part spacecraft_logical : Spacecraft_Logical;
    allocate spacecraft_logical.powerBudget to spacecraft_physical.rack.powerUnit;
    allocate spacecraft_logical.massBudget to spacecraft_physical;
    allocate spacecraft_logical.computeBudget to spacecraft_physical.rack.cpuBoard;
    allocate spacecraft_logical.navigate to spacecraft_physical.rack.cpuBoard.flightSoftware;
}
view 'Spacecraft allocation view' : DS_Views::SymbolicViews::gv;
