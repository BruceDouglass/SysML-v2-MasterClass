package SimpleCalcs {
    public import ScalarValues::*;
    public import RealFunctions::*;
    calc def SumOfSquares {
        in x : Real;
        in y : Real;
        return : Real;
        x * x + y * y
    }
    calc def RMS_TwoValues {
        in x : Real;
        in y : Real;
        attribute x2 : Real = x * x;
        attribute y2 : Real = y * y;
        attribute meanOfSquares : Real = (x2 + y2) / 2;
        return : Real;
        sqrt(meanOfSquares)
    }
    calc def ComputeArea {
        in width : Real;
        in height : Real;
        return : Real;
        width * height
    }
    calc computeArea : ComputeArea;
    action ComputeDoorArea {
        in w : Real;
        in h : Real;
        out area : Real;
        out areaX2 : Real;
        assign area := ComputeArea(width = w, height = h);
        assign areaX2 := computeArea {
            in width = w * 2;
            in height = h * 2;
        }
    }
    calc def WeightedAverage {
        in x : Real;
        in y : Real;
        out result : Real;
        attribute sum : Real;
        sum := x + y;
        result := sum / 2;
    }
    calc def Foo {
        in b : Boolean;
        in x : Real;
        return : Real;
        if b ? x else 0
    }
    item brakeCommand;
    calc def ComputeBrakingForce { in speed : Real; }
    state def BigState {
        attribute currentSpeed : Real;
        attribute brakeForce;
        state Moving;
        state Braking;
        transition computeBrakeForce first Moving accept brakeCommand do action {
            attribute force := ComputeBrakingForce(speed = currentSpeed);
            assign brakeForce := force;
        }
        then Braking;
    }
}
package ParameterExample {
    public import ScalarValues::*;
    public import ISQ::*;
    calc def ComputePower {
        in voltage : Real;
        in current : Real;
        return : Real;
        voltage * current
    }
    calc electricalPower : ComputePower {
        :> voltage : SourceVoltageValue;
        :> current : ElectricCurrentValue;
    }
    calc nominalPower : ComputePower { in :>> voltage : Real default := 28.0; }
    action EvaluatePower {
        in measuredVoltage : SourceVoltageValue;
        in measuredCurrent : ElectricCurrentValue;
        out p1 : Real;
        out p2 : Real;
        out p3 : Real;
        assign p1 := electricalPower(voltage = measuredVoltage, current = measuredCurrent);
        assign p2 := nominalPower(voltage = 30.0, current = measuredCurrent);
        assign p3 := nominalPower(current = measuredCurrent);
    }
    calc def EvaluateCoolingStatus {
        in temp : Real;
        in humidity : Real;
        in maxTemp : Real;
        in maxHumidity : Real;
        return : Boolean;
        attribute tempRatio : Real = temp / maxTemp;
        attribute humidityRatio : Real = humidity / maxHumidity;
        if temp >= 0 and humidity >= 0 ? tempRatio > 1.0 or tempRatio > 0.8 and humidityRatio > 0.9 else false
    }
    public import SI::*;
    public import USCU::*;
    public import QuantityCalculations::*;
    calc def OpiateOfTheMasses {
        attribute a : MassValue = 10 [kg];
        attribute b : MassValue = 10 [lb];
        return : MassValue;
        a + b
    }
    part def MyPart {
        in attribute b;
        attribute x : MassValue = 7;
        attribute y : MassValue = 6 * (1 + x);
        attribute z : MassValue = ootm();
        attribute z1 : SourceVoltageUnit = OpiateOfTheMasses();
    }
    calc ootm : OpiateOfTheMasses;
    view ParameterExample : DS_Views::SymbolicViews::gv;
}
