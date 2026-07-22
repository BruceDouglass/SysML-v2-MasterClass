package Computing_TypeBased {
    public import ScalarValues::*;
    /* Basic component types */
    part def Computer;
    part def Display;
    part def Keyboard;
    part def Mouse;
    part def Terminal;
    /* Collaboration context using direct type connections */
    part def ComputingContext {
        part computer : Computer;
        part display : Display;
        part keyboard : Keyboard;
        part mouse : Mouse;
        part terminal : Terminal;
        /* Connections are between specific part types */
        connect computer to display;
        connect computer to keyboard;
        connect computer to mouse;
        connect computer to terminal;
    }
}
view unnamed : DS_Views::SymbolicViews::gv;
