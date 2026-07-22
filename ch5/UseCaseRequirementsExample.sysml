package UseCaseRequirementsExample {
    public import ScalarValues::*;
    public import SI::*;
    private import ModelingMetadata::refinement;
    /* Provides the refinement metadata */
    /* System subject */
    part def SmartDoorSystem;
    /* Use case describing a system behavior */
    use case UnlockDoorUC {
        subject doorSystem : SmartDoorSystem;
        actor Resident;
        actor MaintenanceTechnician;
        doc /* A resident or technician initiates a door unlock operation. The system authenticates the user, verifies door status, and commands the door actuator to unlock. */
    }
    /* Requirements for the Smart Door System */
    requirement 'User Authentication' {
        subject SmartDoorSystem;
        doc /* The system shall authenticate all users before unlocking the door. */
    }
    requirement 'Door Status Check' {
        subject SmartDoorSystem;
        doc /* The system shall verify that the door is closed before initiating unlock operations. */
    }
    requirement 'Unlock Response Time' {
        subject SmartDoorSystem;
        attribute maxDelay : Real = 1.0 [s];
        doc /* The system shall command the door to unlock within 1 second of user authentication. */
        require constraint {
            maxDelay <= 1.0 [s]
        }
    }
    requirement 'Logging Requirement' {
        subject SmartDoorSystem;
        doc /* The system shall record each unlock event to secure audit logs. */
    }
    requirement 'Unauthorized Access Lockout' {
        subject SmartDoorSystem;
        doc /* The system shall lock out access after three failed authentication attempts. */
    }
    /* Refinement relations from the use case to the requirements */
    #refinement dependency refineAuth from UnlockDoorUC to 'User Authentication';
    #refinement dependency refineStatus from UnlockDoorUC to 'Door Status Check';
    #refinement dependency refineTiming from UnlockDoorUC to 'Unlock Response Time';
    #refinement dependency refineAudit from UnlockDoorUC to 'Logging Requirement';
    #refinement dependency refineSecurity from UnlockDoorUC to 'Unauthorized Access Lockout';
}
view 'Use Case Req Example View' : DS_Views::SymbolicViews::gv;
