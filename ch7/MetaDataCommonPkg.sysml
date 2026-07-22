package MetaDataCommonPkg {
    public import ScalarValues::*;
    public import ISQ::*;
    public import SI::*;
    metadata def QuantifiedValue {
        :>> annotatedElement : SysML::Systems::Usage;
        attribute digitsOfPrecision : Natural [0..1];
        attribute accuracy : Real [0..1];
        attribute isMeasured : Boolean default false;
    }
    metadata def StandardQV :> QuantifiedValue {
        :>> digitsOfPrecision : Natural [1] = 6;
        :>> accuracy : Real [1] = 0.1;
    }
}
package FlightDataPkg {
    public import MetaDataCommonPkg::*;
    item def FlightPlan {
        item commandedFlightPath : FlightPropertySet [*];
        item actualFlightPath : FlightPropertySet [*];
    }
    item def FlightPropertySet {
        attribute isWaypoint : Boolean default false;
        attribute whenMeasured : Time::DateTime;
        item attitude : Attitude;
        item attitudinalVelocity : AttitudialVelocity;
        item position : Position;
        item velocity : Velocity;
        item acceleration : Acceleration;
    }
    constraint def AttitudeAngleExtent {
        in angle : AngularMeasureValue;
        angle >= -180 and angle <= 180
    }
    item def Attitude {
        #StandardQV attribute roll : AngularMeasureValue {
            assert constraint extent : AttitudeAngleExtent {
                in angle = that;
            }
        }
        #StandardQV attribute pitch : AngularMeasureValue {
            assert constraint extent : AttitudeAngleExtent {
                in angle = that;
            }
        }
        #StandardQV attribute yaw : AngularMeasureValue {
            assert constraint extent : AttitudeAngleExtent {
                in angle = that;
            }
        }
    }
    item def AttitudialVelocity {
        attribute dRoll : AngularVelocityValue;
        attribute dPitch : AngularVelocityValue;
        attribute dYaw : AngularVelocityValue;
    }
    item def Position {
        attribute lattitude : AngularMeasureUnit {
            @QuantifiedValue {
                digitsOfPrecision = 8;
                accuracy = 0.001;
            }
            assert constraint {
                that >= -90 and that <= 90
            }
        }
        attribute longitude : AngularMeasureUnit {
            @QuantifiedValue {
                digitsOfPrecision = 8;
                accuracy = 0.001;
            }
            assert constraint {
                that >= -180 and that <= 180
            }
        }
        #StandardQV attribute altitude : height {
            assert constraint {
                that >= -1000 [m] and that <= 100000 [m]
            }
        }
    }
    item def Velocity {
        attribute dLatitude : AngularVelocityUnit;
        attribute dLongitude : AngularVelocityUnit;
        attribute dAltitude : speed;
    }
    item def Acceleration {
        attribute d2Latitude : AngularAccelerationUnit;
        attribute d2Longitude : AngularAccelerationUnit;
        attribute d2Altitude : acceleration;
    }
}
package AircraftPkg {
    public import FlightDataPkg::*;
    part def AirVehicle {
        attribute flightplan : FlightPlan;
    }
}
view 'Metadata view' : DS_Views::SymbolicViews::gv {
    doc /* this diagrgram shows the metadata applied to numerically quantifiable values */
}
view 'DataSchame View' : DS_Views::SymbolicViews::gv {
    doc /* This diagram view shows the data schema for the Flight Plan. */
}
view 'Data Schema Table View' : DS_Views::TabularViews::gt {
    expose FlightDataPkg::*;
    filter istype SysML::Systems::ItemDefinition or istype SysML::Systems::ItemUsage or istype SysML::Systems::AttributeDefinition or istype
            SysML::Systems::AttributeUsage;
}
