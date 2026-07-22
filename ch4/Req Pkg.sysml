package 'Req Pkg' {
    /* import relevant libraies */
    public import ScalarValues::*;
    public import USCU::*;
    public import SI::*;
    public import RealFunctions::*;
    /* declare diagrams */
    view 'Structural  Elements View' : DS_Views::SymbolicViews::gv;
    view 'Requirements View' : DS_Views::SymbolicViews::gv;
    /* Structural aspects */
    part def Treadmill {
        satisfy requirement 'Set Treadmill Speed' by self;
        satisfy $::'Req Pkg'::'Set Treadmill Speed'.'Stopping the Belt' by belt;
        satisfy $::'Req Pkg'::'Set Treadmill Speed'.'Speed Range' by Treadmill::belt;
        satisfy 'Treadmill Speed Stability';
        attribute totalWeight : Real;
        part deck : Deck;
        part belt : Belt;
        item tFrame : TFrame;
        part panel : 'Control Panel';
    }
    part def Deck;
    part def Belt {
        attribute measuredSpeed : Real = 0 ['mi/h'];
        attribute commandedSpeed : Real = 0 ['mi/h'];
        attribute width : Real = 24 ['in'];
    }
    part def TFrame;
    part def 'Control Panel' {
        attribute speedIncrement : Real;
    }
    concern def 'Long Workout Concern' {
        subject Treadmill;
        stakeholder Trainer;
        stakeholder Athlete;
        attribute maxWworkoutDuration : Real;
        assume constraint {
            doc /* Trainer is in charge of Athlete's workouts */
        }
        require constraint {
            doc /* long workouts need to be supported */
            maxWworkoutDuration >= 6 [h]
        }
    }
    /* part 2: requirements */
    requirement 'Treadmill Speed Stability' {
        doc /* The treadmill shall vary speed of the belt by less than 1% with each foot strike by an running athlete.*/
        subject belt : Belt;
        attribute speedPreStrike : Real;
        attribute speedPostStrike : Real;
        attribute athleteMass : Real;
        assume constraint {
            speedPreStrike > 0 ['mi/h'] and speedPostStrike > 0 ['mi/h'] and athleteMass > 50 [lb] and athleteMass < 400 [lb]
        }
        require constraint {
            speedPreStrike / speedPostStrike > 0.99 and speedPreStrike / speedPostStrike < 1.1
        }
    }
    requirement <req10> 'Set Treadmill Speed' {
        doc /* The Treadmill shall allow the user to set the speed of the treadmill belt in miles per hour.*/
        subject Treadmill;
        concern longWorkoutConcern : 'Long Workout Concern';
        require 'Treadmill Speed Stability';
        requirement <req10_1> 'Setting Speed' {
            subject 'Control Panel';
            doc /* The system shall provide surface-level control to set the speed of the treadmill. */
        }
        requirement 'Stopping the Belt' {
            doc /* The system shall provide the ability to stop the treadmill belt with a single gesture. */
            subject 'Control Panel';
            actor Athlete;
            stakeholder Trainer;
        }
        requirement <req10_3> 'Speed Range' {
            doc /* The system shall provide belt speeds of from 0.0 to 15.0 mph. */
            subject belt : Belt;
            require constraint {
                belt.commandedSpeed >= 0.0 ['mi/h'] and belt.commandedSpeed <= 15.0 ['mi/h']
            }
        }
        requirement 'Speed Accuracy' {
            doc /* The belt speed shall be within 0.25 mph of the set speed.*/
            subject belt : Belt;
            require constraint {
                abs(belt.commandedSpeed - belt.measuredSpeed) <= 0.25
            }
        }
        requirement 'Speed Fidelity' {
            doc /* The system shall provide the ability to set the commanded belt speed in units of 0.1 mph. */
            subject cp : 'Control Panel';
            require constraint name {
                cp.speedIncrement == 0.1 ['mi/h']
            }
        }
    }
    view 'Req Table' : DS_Views::TabularViews::rt {
        expose 'Req Pkg'::**;
        filter hastype SysML::RequirementUsage;
    }
}
