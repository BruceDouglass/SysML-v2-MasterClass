package SampleRequirements {
    public import ScalarValues::*;
    requirement <r1> req_TemperatureAccuracy {
        doc
        /* The system shall report temperature within a bounded
         * deviation from true ambient temperature.
         */
        attribute maxError : Real = 1.0;
        /* degrees Celsius */
    }
    requirement <r2> req_ResponseTime {
        doc
        /* The system shall update its reported state within a
         * maximum allowable time after the true value changes.
         */
        attribute maxResponseTime : Real = 0.5;
        /* seconds */
    }
    requirement <r3> req_PowerConsumption {
        doc
        /* The system shall not exceed the maximum allowed
         * continuous power consumption during nominal operation.
         */
        attribute maxPower : Real = 25.0;
        /* watts */
    }
    requirement <r4> req_DataThroughput {
        doc
        /* The system shall sustain a minimum data throughput
         * sufficient for continuous operation without buffering
         * overflow or data loss.
         */
        attribute minThroughput : Real = 2.0;
        /* MB/s */
    }
    requirement <r5> req_OperationalLifetime {
        doc
        /* The system shall operate for a minimum lifetime under
         * continuous nominal load before required replacement.
         */
        attribute minLifetimeHours : Real = 20000.0;
        /* hours */
    }
    view def RequirementsDiagram;
    view myReqsView : RequirementsDiagram {
        public import Views::*;
        expose SampleRequirements::*;
        filter @SysML::RequirementUsage;
        render Views::asTreeDiagram;
    }
}
view 'Requirements Table' : DS_Views::TabularViews::rt {
    expose SampleRequirements::*;
}
