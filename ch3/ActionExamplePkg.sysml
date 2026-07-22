package ActionExamplePkg {
    public import ScalarValues::*;
    part def PersonOfInterest {
        attribute name : String;
        attribute number : Integer;
    }
    part def AddressBook {
        part person : PersonOfInterest [*];
        action lookup {
            in attribute name : String;
            out attribute n : Integer;
        }
    }
    action def EstablishCall { in attribute n : Integer; }
    part def Operator {
        part addressBook : AddressBook;
        action MakeCall {
            in attribute callee : String;
            in part addressBook : AddressBook;
            action call : EstablishCall;
            action talk;
            action closeCall;
            bind callee = addressBook.lookup.name;
            succession flow callee to addressBook.lookup.name;
            succession flow addressBook.lookup.n.addressBook::lookup::n to call.n.call::n;
            first call then talk;
            first talk then closeCall;
            first closeCall then done;
        }
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
