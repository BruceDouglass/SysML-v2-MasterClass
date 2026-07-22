package SequenceManipulation {
    public import ScalarValues::*;
    public import SequenceFunctions::*;
    attribute mySequenceA : Integer [*] = (10, 20, 30, 40);
    attribute mySequenceB : Integer [*] = (10, 20, 30, 40);
    action insertValueIntoSequences {
        assign mySequenceA := mySequenceA->SequenceFunctions::includingAt(100, 3);
        action : addAt {
            seq = mySequenceB;
            values = 100;
            index = 3;
        }
        action setit {
            calc {
                mySequenceA->addAt(11, 3)
            }
            calc {
                addAt(seq = mySequenceA, values = 100, index = 3)
            }
        }
        action doStuff {
            attribute mySequenceA : Integer [*] = (10, 20, 30, 40);
        }
    }
}
