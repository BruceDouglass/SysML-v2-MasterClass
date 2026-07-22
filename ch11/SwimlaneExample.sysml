package SwimlaneExample {
    part def Part0;
    part def Part1;
    part def Part2;
    part part0 : Part0 {
        perform action0;
        part part1 : Part1 {
            perform action0.action1;
            perform action0.action4;
        }
        part part2 : Part2 {
            perform action0.action2;
            perform action0.action3;
        }
    }
    action action0 {
        action action1;
        action action2;
        action action3;
        action action4;
        first start then action1;
        first action1 then action2;
        first action2 then action3;
        first action3 then action4;
        first action4 then done;
    }
    view 'SwimlaneExample View' : DS_Views::SymbolicViews::gv;
}
