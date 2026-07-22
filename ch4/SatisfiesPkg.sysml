package SatisfiesPkg {
    requirement requirement10;
    requirement requirement11;
    part def Treadmill;
    part 'Speed Demon' : Treadmill {
        satisfy requirement10 by 'Speed Demon';
        part 'Emergency Stop Button' {
            satisfy requirement11 by 'Emergency Stop Button';
        }
    }
}
view 'Satisfies View' : DS_Views::SymbolicViews::gv;
