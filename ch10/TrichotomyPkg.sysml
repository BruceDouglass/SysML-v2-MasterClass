package TrichotomyPkg {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    /* Type-level structure */
    part def Vehicle {
        attribute passengerCapacity : Integer;
        attribute loadCapacity : MassValue;
        ref part driver : Employee;
    }
    enum EmployeeRole {
        Overlord;
        Minion;
    }
    part def Employee {
        attribute role : EmployeeRole;
        attribute employeeID : String;
        attribute name : String;
        ref part assignedVehicle : Vehicle;
    }
    part def Fleet {
        part passengerVehicle : Vehicle [*];
        part cargoVehicle : Vehicle [*];
        part tankerVehicle : Vehicle [*];
    }
    /* Unique real-world individuals */
    individual part def CEO_Car :> Vehicle {
        attribute :>> passengerCapacity = 6;
        :>> driver : CEO;
    }
    individual part def CEO :> Employee {
        :>> role = EmployeeRole::Overlord;
        :>> name = "Melon Husk";
        :>> employeeID = "Number 1";
        :>> assignedVehicle : CEO_Car;
    }
    individual part def Sam_Smith :> Employee {
        :>> name = "Sam Smith";
        :>> employeeID = "17001";
        :>> role = EmployeeRole::Minion;
    }
    individual part def EmployeeBus1 :> Vehicle {
        attribute :>> passengerCapacity = 60;
        :>> driver : Sam_Smith;
    }
    /* Context using the same unique individuals */
    individual part def Fleet_20251030 :> Fleet {
        individual part :>> passengerVehicle : CEO_Car;
        individual part :>> passengerVehicle : EmployeeBus1;
        /* cargoVehicle and tankerVehicle intentionally left empty in this snapshot */
    }
}
view 'Fleet Diagram' : DS_Views::SymbolicViews::gv;
