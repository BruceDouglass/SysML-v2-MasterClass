package interfaceExamplePkg {
    public import ScalarValues::*;
    part tv;
    part tvRemote;
    connection tv_tvRemote connect tv to tvRemote;
    /* 1.  Interface that defines +12 V power */
    interface def IF_12VPower {
        attribute voltage : Real = 12.0;
        attribute maxCurrent : Real = 5.0;
        attribute isIsolated : Boolean;
    }
    /* 2.  Parts that own ports typed by the interface */
    part def PowerSupply {
        /* provider port – delivers 12 V */
        port out12V : IF_12VPower;
    }
    part def Gadget {
        /* consumer port – expects 12 V */
        port inPower : IF_12VPower;
    }
    /* 3.  Reusable connection definition (cable or trace) */
    connection def PowerCable {
        end source : IF_12VPower;
        end sink : IF_12VPower;
        attribute length : Real;
    }
    part ps : PowerSupply;
    part ga : Gadget;
    /* 4.  Concrete usage that hooks the supply to the gadget */
    connection : PowerCable connect ps.out12V to ga.inPower {
        length = 0.25;
    }
    part def Tub {
        port pFaucet : ~pdFaucetTub;
        in item flowin : FluidFlow;
    }
    part def Faucet {
        port pTub : pdFaucetTub;
        out item WaterFlow : FluidFlow;
    }
    part def PrivateBath {
        part tub : Tub;
        part faucet : Faucet;
        interface ift : iWaterSource2Target connect faucet.pTub to tub.pFaucet {
            flow of FluidFlow from source.fluidFlow to target.fluidFlow;
        }
        view PrivateBath;
    }
    dependency PrivateBath to iWaterSource2Target;
    port def pdFaucetTub {
        out attribute fluidFlow : Real;
    }
    item def FluidFlow {
        attribute fFlow : Real;
        attribute isActive : Boolean;
    }
    interface def iWaterSource2Target {
        port pWaterSource;
        port pWaterTarget;
        connection cFT connect pWaterSource to pWaterTarget;
    }
}
