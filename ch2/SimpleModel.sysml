package SimpleModel {
    view Model : DS_Views::SymbolicViews::gv {
        doc /* this is the diagram documentation */
    }
    part def Vehicle {
        attribute speed : ScalarValues::Real;
    }
    part def Car :> Vehicle;
    part def Bike :> Vehicle;
    part car : Car;
    part bike : Bike;
    view 'Systems Taxonomy View' : DS_Views::SymbolicViews::gv {
        doc /* Mission: Show the specializatin taxonomy for system parts */
        public import Views::*;
        expose SimpleModel::*;
        filter @SysML::PartUsage or @SysML::PartDefinition;
        render Views::asTreeDiagram;
    }
    part car1 : Car;
}
