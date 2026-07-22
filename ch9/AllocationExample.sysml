package AllocationExample {
    public import ScalarValues::*;
    public import SI::*;
    /* Behavior definition (type) and usage (feature) */
    action faultMonitor {
        in period : TimeValue;
        action logFault;
        action scheduleNextTest;
    }
    /* Structure */
    part def DataLogger {
        attribute capacity : Real;
    }
    part def FlightComputer {
        attribute cores : Integer;
    }
    part def AvionicsSystem {
        part logger : DataLogger;
        part computer : FlightComputer;
    }
    part avionics : AvionicsSystem;
    /* Quick generic allocation (host): OK */
    /* Explicit kinds: specialize Allocation with typed ends */
    allocation def HostAllocation {
        end behavior : Actions::Action;
        end host : Parts::Part;
    }
    allocation def ResourceAllocation {
        end behavior : Actions::Action;
        end resource : Parts::Part;
    }
    /* Use the single-statement style for allocation usages */
    allocate faultMonitor.scheduleNextTest to avionics.computer;
    allocation FaultMonExecOnCPU : AllocationExample::HostAllocation allocate AllocationExample::faultMonitor to AllocationExample::avionics.computer;
    allocation FaultMonUsesLogger : AllocationExample::ResourceAllocation allocate AllocationExample::faultMonitor.logFault to AllocationExample::avionics.logger;
}
