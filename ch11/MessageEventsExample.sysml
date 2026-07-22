package MessageEventsExample {
    public import ScalarValues::*;
    public import Time::*;
    item def Request;
    item def Response;
    part def Client;
    part def Server;
    part def Network {
        part client : Client;
        part server : Server;
        /* Define abstract messages */
        message req of Request from client to server;
        message rsp of Response from server to client;
        /* Temporal constraint: response follows request */
        assert constraint {
            TimeOf(rsp.sourceEvent) > TimeOf(req.targetEvent)
        }
    }
    view 'MessageEventsExample View' : DS_Views::SymbolicViews::gv;
}
