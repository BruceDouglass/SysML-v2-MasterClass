package SampleUnitsPkg {
    public import ScalarValues::*;
    public import SI::*;
    public import USCU::*;
    public import QuantityCalculations::*;
    calc def dimensionalIssue {
        return : TemperatureValue;
        attribute x : TemperatureValue = 10;
        attribute y : LengthValue = 20;
        x + y
    }
    calc def unitsIssue {
        return : LengthValue;
        attribute x : LengthValue = 10 [mi];
        attribute y : LengthValue = 20 [km];
        x + y
    }
    calc def resovledUnits {
        return : LengthValue;
        attribute x : LengthValue = 10 [mi];
        attribute y : LengthValue = 20 [km];
        x + ConvertQuantity(y, mi)
    }
    calc def LengthSum {
        return : LengthValue;
        attribute x : LengthValue = 10 [mi];
        attribute y : LengthValue = 20 [km];
        x + y
    }
    calc def MassSum {
        return : MassValue;
        attribute m1 : MassValue;
        attribute m2 : MassValue;
        attribute m3 : MassValue;
        m1 + m2
    }
}
view 'Units Taxonomy VIew' : DS_Views::SymbolicViews::gv;
