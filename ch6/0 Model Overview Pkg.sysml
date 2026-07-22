package '0 Model Overview Pkg' {
    doc
    /* Purpose:
     * This model models the High Energy Laser System, its requirements, capabilities, and architectural design.
     *
     * Specific Objectives:
     * 1. Enumerate the requirements for the HELS
     * 2. Enumerate the capabilities, modeled as use cases for the HELS
     * 3. Relate the capabilities and the requirements
     * 4. Specify the architecture of the HELS and its subsystems
     * 5. Relate requirements to HELS design elements
     * 6. Define the means for HELS system verification against the requirements
     *
     * Stakeholders:
     * - System Engineers
     * - Software Developers
     * - Electronic Engineers
     * - Mechanical Engineers
     * - Verification Engineers
     * - Safety Engineers
     *
     * Fit-for-Purpose Criteria:
     * - Drive engineering discipline specific design (electronics, software, mechanical, etc)
     * - Drive the development of test equipment, procedures, plans, and verification cases
     * - Provide a basis for review with stakeholders
     *
     * Means for Verification and Validation:
     * - All parts of the model shall be subject to inspection and review
     * - Use cases must simulate to demonstrate the adequacy of the requirements
     * - Architecture must simulate to demonstrate its adequacy against the requirements
     * - Monte Carlo simulation must be supported for stochastic test cases
     */
    view ModelOverviewDiagram : DS_Views::SymbolicViews::gv;
}
package '1 Capabilities Pkg' {
    package 'Requirements Pkg' {
        view 'Laser Requirements Table' : DS_Views::TabularViews::rt;
    }
    package 'Use Case Pkg' {
        doc /* This package models the capabilities of the system as use cases. This package contains the use cases, and external parts used as actors.
         */
        view 'Laser Use Cases View' : DS_Views::SymbolicViews::gv;
    }
    package 'Use Case Analysis Pkg' {
        doc /* This package is where the use cases are analyzed by construction of simulatable models. One nested package per use case.
         */
    }
}
package '2 Architecture Pkg' {
    package 'Architectural Design Pkg' {
        doc /* This and its nested packages contain all the information about the  structural elements of the architecture, including their data schema and behavior.
         */
        view 'HELS Composition Architecture View' : DS_Views::SymbolicViews::gv;
        view 'HELS Context View' : DS_Views::SymbolicViews::gv;
        package 'Simulation Pkg' {
            doc /* This package contains elements and views related to architectural simulation.
             */
            view 'Simulation View' : DS_Views::SymbolicViews::gv;
        }
    }
    package 'Architectural Analysis Pkg' {
        doc /* This package contains all architectural analyses – each analysis in its own nested package.
         */
        package 'Target Accuracy Pkg';
        package 'Cooling Analysis Pkg';
        package 'Power Source Trade Study Pkg';
    }
}
package '3 Verification Pkg' {
    doc /* This package contains the verification cases, plans and procedures for the system.
     */
}
