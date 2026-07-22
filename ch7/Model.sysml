package Model {
    public import ScalarValues::*;
    public import ISQ::*;
    part def Payload1 {
        attribute weight : Real;
    }
    part def Payload2 {
        attribute weight : MassValue;
    }
    part def Payload3 {
        attribute weight :> mass;
    }
}
view 'AttributesPkg View' : DS_Views::SymbolicViews::gv;
