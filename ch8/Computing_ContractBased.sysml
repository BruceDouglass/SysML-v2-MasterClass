package Computing_ContractBased {
    /* Port definitions act as the interaction contracts */
    port def iComputer_Display;
    port def iComputer_Keyboard;
    port def iComputer_Mouse;
    port def iComputer_Terminal;
    /* Each participant exposes the contract it uses/offers */
    part def Computer_WithPorts {
        port pDisplay : iComputer_Display;
        port pKeyboard : iComputer_Keyboard;
        port pMouse : iComputer_Mouse;
        port pTerminal : iComputer_Terminal;
    }
    part def Display_WithPort {
        port pComputer : ~iComputer_Display;
    }
    part def Keyboard_WithPort {
        port pComputer : ~iComputer_Keyboard;
    }
    part def Mouse_WithPort {
        port pComputer : ~iComputer_Mouse;
    }
    part def Terminal_WithPort {
        port pComputer : ~iComputer_Terminal;
    }
    /* Context connects by contract conformance (matching port defs) */
    part def ComputingContext {
        part computer : Computer_WithPorts;
        part display : Display_WithPort;
        part keyboard : Keyboard_WithPort;
        part mouse : Mouse_WithPort;
        part terminal : Terminal_WithPort;
        /* Connections are between ports typed by the same contract */
        connect computer.pDisplay to display.pComputer;
        connect computer.pKeyboard to keyboard.pComputer;
        connect computer.pMouse to mouse.pComputer;
        connect computer.pTerminal to terminal.pComputer;
    }
}
