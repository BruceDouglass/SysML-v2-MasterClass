package DefaultBindingExample {
    public import ScalarValues::*;
    public import RealFunctions::*;
    public import TrigFunctions::*;
    /* Calculation definition: compute a simple weighted combination */
    calc def WeightedCombination {
        in a : Real;
        in b : Real;
        return : Real;
        2.0 * a + 3.0 * b
    }
    /* Calculation definition used to compute an adaptive bias value */
    calc def ComputeBias {
        in a : Real;
        in b : Real;
        return : Real;
        sin(a) + cos(b) / 2.0
    }
    part signalCombiner {
        in attribute x : Real default 2;
        attribute y : Real = 3;
        attribute z : Real = 2.0 * sin(x) ^ 2 + 3.0 * cos(y);
        attribute combined : Real = WeightedCombination(a = x, b = y);
        attribute gain : Real default 1.0 + abs(x - y);
        attribute bias : Real default := ComputeBias(a = x, b = y);
    }
}
view 'Signal Stuff View' : DS_Views::SymbolicViews::gv;
