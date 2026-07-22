package 'Logical Model' {
    part communicationDevice {
        perform sendAlert;
    }
    action sendAlert;
}
package 'Physical Model' {
    public import 'Logical Model'::*;
    part cellPhone {
        part transmitter {
            perform sendAlert;
        }
    }
    allocate communicationDevice to cellPhone {
        allocate communicationDevice.sendAlert to cellPhone.transmitter.sendAlert;
    }
}
view 'Alloication View' : DS_Views::SymbolicViews::gv;
