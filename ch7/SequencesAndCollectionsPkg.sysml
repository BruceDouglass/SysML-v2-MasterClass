package SequencesAndCollectionsPkg {
    private import ScalarValues::*;
    private import Collections::*;
    private import SequenceFunctions::*;
    private import BaseFunctions::*;
    attribute def IntegerArray1D :> Array {
        attribute :>> dimensions : Positive = 1;
    }
    action testAssign {
        attribute a : IntegerArray1D;
        assign a := a->includingAt(14, 3);
    }
    calc def StructureAccessDemo {
        attribute my_array : IntegerArray1D = new IntegerArray1D(elements = (100, 200, 300));
        attribute my_array_in_line : Array = new Array(dimensions = 1, elements = (10, 11, 14, 15, 18, 20, 22, 24, 26, 28));
        attribute my_sequence [*] : Integer default := (1, 2, 3);
        attribute seq_value : Integer = my_sequence#(3);
        assign my_array := my_array->includingAt(14, 3);
        attribute array_value : Integer = my_array#(1);
        return total_value : Integer = seq_value + array_value;
    }
    public import CollectionFunctions::*;
    action doStuff {
        attribute rearGears : Integer [*] = (10, 11, 14, 15, 18, 20, 22, 24, 26, 28);
        attribute cassette : Array = new Array(dimensions = 1, elements = (10, 11, 14, 15, 18, 20, 22, 24, 26, 28));
        assign rearGears := rearGears->SequenceFunctions::includingAt(14, 3);
        assign cassette := cassette->includingAt(14, 3);
    }
    part def RearWheel {
        attribute gear [4] : ScalarValues::Integer default := (0, 0, 0, 0);
        action setGears {
            assign gear := gear->SequenceFunctions::includingAt(11, 3);
        }
        action setGears {
            calc {
                gear->addAt(11, 3)
            }
        }
    }
}
package UsingAddAtPkg {
    private import ScalarValues::*;
    private import SequenceFunctions::*;
    part def RearWheel {
        attribute gear [4] : ScalarValues::Integer default := (0, 0, 0, 0);
        action setGears {
            calc {
                addAt(gear, 11, 3)
            }
        }
        action setGears2 {
            action : addAt {
                inout seq = gear;
                in values = 11;
                in index = 3;
            }
        }
    }
}
package UsingIndexingAndSelfPkg {
    private import ScalarValues::*;
    private import SequenceFunctions::*;
    part def RearWheel {
        attribute gear [4] : ScalarValues::Integer default := (0, 0, 0, 0);
        action setGears {
            // "Feature Membership -> Assign" is incompatible with textual.
        }
    }
    private import ScalarValues::*;
    private import VectorFunctions::*;
    calc def VelocityNorm {
        in v : NumericalVectorValue [1];
        return Real;
        norm(v)
    }
}
