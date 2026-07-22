package MyCustomViews {
    public import StandardViewDefinitions::*;
    public import Views::*;
    view def RequirementsDiagramView :> GeneralView {
        filter @SysML::RequirementDefinition or @SysML::RequirementUsage or @SysML::ConcernDefinition or @SysML::ConcernUsage or @SysML::SatisfyRequirementUsage;
        render asTreeDiagram;
    }
}
package VehicleReqsModel {
    private import ISQ::*;
    private import SI::*;
    public import MyCustomViews::*;
    part def Vehicle {
        attribute dryMass :> mass;
        attribute cargoCapacity :> mass;
        attribute currentSpeed :> speed;
        attribute currentMass :> mass;
    }
    requirement def MassLimitationRequirement {
        doc /* The actual mass shall be less than or equal to the required mass.*/
        attribute massActual :> ISQ::mass;
        attribute massRequired :> ISQ::mass;
        require constraint {
            massActual <= massRequired
        }
    }
    requirement def MaxSpeedRequirement {
        doc /* The maximum speed shall not exceed the specified limit.*/
        attribute speedActual :> ISQ::speed;
        attribute speedLimit :> ISQ::speed;
        require constraint {
            speedActual <= speedLimit
        }
    }
    requirement VehicleSpecification {
        subject vehicle : Vehicle;
        requirement <'1.1'> MaximumGrossMass : MassLimitationRequirement {
            doc /* The total vehicle mass shall not exceed 2500 kg.*/
            attribute :>> massActual = vehicle.currentMass;
            attribute :>> massRequired = 2500 [kg];
            assume constraint {
                vehicle.currentMass == vehicle.dryMass + vehicle.cargoCapacity
            }
        }
        requirement <'1.2'> OperatingSpeedLimit : MaxSpeedRequirement {
            attribute :>> speedActual = vehicle.currentSpeed;
            attribute :>> speedLimit = 180 [km / h];
            assume constraint {
                doc /* Tested on flat, dry road surface. */
            }
        }
    }
    view vehicleRequirementsView : RequirementsDiagramView {
        expose VehicleReqsModel::**;
    }
}
