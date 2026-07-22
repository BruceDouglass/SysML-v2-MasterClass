package DistanceCalculations {
    private import ISQ::*;
    private import SI::*;
    private import USCustomaryUnits::*;
    private import QuantityCalculations::*;
    calc def CalculateTotalDistance {
        in d_miles : LengthValue = 100.0 [mi];
        in d_meters : LengthValue = 5000.0 [m];
        return totalDistance : LengthValue;
        ConvertQuantity(d_miles, SI::m) + d_meters
    }
}
