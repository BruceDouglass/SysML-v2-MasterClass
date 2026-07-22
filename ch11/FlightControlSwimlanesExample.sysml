package FlightControlSwimlanesExample {
    /* Performer types */
    part def Aircraft;
    part def NavSuite;
    part def FlightComputer;
    part def ActuatorController;
    /* System composition + swimlane performer mapping */
    part aircraft : Aircraft {
        perform mainControl;
        part nav : NavSuite {
            perform mainControl.acquireIMU;
            perform mainControl.fuseNavigation;
        }
        part fcu : FlightComputer {
            perform mainControl.computeCommands;
        }
        part actuators : ActuatorController {
            perform mainControl.sendCommands;
        }
    }
    /* Orchestrating action (with nested actions and successions) */
    action mainControl {
        action acquireIMU;
        action fuseNavigation;
        action computeCommands;
        action sendCommands;
        first start then acquireIMU;
        first acquireIMU then fuseNavigation;
        first fuseNavigation then computeCommands;
        first computeCommands then sendCommands;
        first sendCommands then done;
    }
    view 'FlightControl Swimlanes View' : DS_Views::SymbolicViews::gv;
}
