package ChemicalMixingSequence {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    item def Chemical;
    item def Mixture;
    action def MixChemicals {
        /* Define key actions */
        attribute shouldIRun : Boolean;
        action evaluateStability { out isExplosive : Boolean; }
        action dispenseA { out output : Chemical; }
        action dispenseB { out output : Chemical; }
        action combine {
            in chem1 : Chemical;
            in chem2 : Chemical;
            out mix : Mixture;
        }
        action heat { in mixIn : Mixture; }
        action runForIt;
        /* 1. Simple succession — order without data flow */
        first start;
        then dispenseA;
        first dispenseA then dispenseB;
        /* 2. Flow plus separate succession */
        flow chemA from dispenseA.output to combine.chem1;
        flow chemB from dispenseB.output to combine.chem2;
        first dispenseB then combine;
        /* 3. Successive flow — data transfer implies sequencing */
        succession flow mixtureFlow from combine.mix to heat.mixIn;
        first heat then evaluateStability;
        first evaluateStability if evaluateStability.isExplosive then runForIt;
    }
    view ChemicalMixingSequence : DS_Views::SymbolicViews::gv;
}
