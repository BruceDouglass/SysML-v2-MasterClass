package LogisticsExample {
    public import ScalarValues::*;
    public import SI::*;
    item def PlannedRoute {
        attribute requiredDistance : LengthValue;
        attribute requiredDrivers : Natural;
    }
    part def LogisticsPlanner {
        attribute isOptimized : Boolean = true;
    }
    part def DeliveryFleet {
        attribute maxRange : LengthValue = 1000 [km];
        attribute availableDrivers : Natural = 50;
    }
    calc def CalculateRouteFeasibility {
        in startLocation : String;
        in endLocation : String;
        return route : PlannedRoute = (450 [km], 5);
    }
    case def DeliveryCapacityCase {
        subject planner : LogisticsPlanner;
        actor fleet : DeliveryFleet;
        return plannedRoute : PlannedRoute;
        plannedRoute = CalculateRouteFeasibility(startLocation = "A", endLocation = "B");
        objective FeasibilityCheck {
            subject fleet : DeliveryFleet;
            require constraint ResourceAvailability {
                fleet.maxRange >= plannedRoute.requiredDistance and fleet.availableDrivers >= plannedRoute.requiredDrivers
            }
        }
    }
}
