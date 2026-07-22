package 'Actions and Control Flow' {
    action def RunMotor {
        action Engage {
            action 'Measure Spin' { out spin; }
            action 'Adjust Spin' { in spin; }
            first start then m1;
            succession flow 'Measure Spin'.spin.'Measure Spin'::spin to 'Adjust Spin'.spin.'Adjust Spin'::spin;
            merge m1;
            first 'Adjust Spin' then m1;
            first m1 then 'Measure Spin';
        }
        action 'Spin Up';
        action initialize;
        first start then initialize;
        first initialize then 'Spin Up';
        first 'Spin Up' then Engage;
    }
    view 'Actions and Control Flow' : DS_Views::SymbolicViews::gv;
}
