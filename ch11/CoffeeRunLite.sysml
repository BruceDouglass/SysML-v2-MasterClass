package CoffeeRunLite {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* Payloads */
    item def Grounds;
    item def HotWater;
    item def Slurry;
    item def Brew;
    /* Parts (who performs) */
    part def Grinder {
        action grindBeans { out grounds : Grounds; }
    }
    part def Kettle {
        action heatWater { out water : HotWater; }
        action doseWater {
            in water : HotWater;
            out metered : HotWater;
        }
    }
    part def Brewer {
        action combine {
            in g : Grounds;
            in w : HotWater;
            out slurry : Slurry;
        }
    }
    part def FilterUnit {
        action filterBrew {
            in slurry : Slurry;
            out brew : Brew;
        }
    }
    part def Dispenser {
        action pourCup { in brew : Brew; }
    }
    /* System context + orchestration */
    part def CoffeeMaker {
        part grinder : Grinder;
        part kettle : Kettle;
        part brewer : Brewer;
        part filterUnit : FilterUnit;
        part dispenser : Dispenser;
        action def MakeCoffee {
            /* reference who does what */
            ref action grind = grinder.grindBeans;
            ref action heat = kettle.heatWater;
            ref action dose = kettle.doseWater;
            ref action mix = brewer.combine;
            ref action strain = filterUnit.filterBrew;
            ref action pour = dispenser.pourCup;
            /* 1) Plain succession (order only) */
            first start then grind;
            /* 2) Plain flows (data handoff without implying order) */
            flow grind.grounds to mix.g;
            flow heat.water to dose.water;
            flow dose.metered to mix.w;
            /* We still need execution order around these flows: */
            first grind then heat;
            first heat then dose;
            first dose then mix;
            /* 3) Succession flow (transfer + order in one) */
            succession flow mix.slurry to strain.slurry;
            /* Finish: succession flow from filter to pour */
            succession flow coffee from strain.brew to pour.brew;
        }
        action run : MakeCoffee {
            first pour then done;
        }
    }
    view 'CoffeeRunLite view' : DS_Views::SymbolicViews::gv;
}
