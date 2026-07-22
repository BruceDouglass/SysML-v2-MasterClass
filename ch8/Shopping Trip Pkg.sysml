package 'Shopping Trip Pkg' {
    public import ScalarValues::*;
    /* Type-level structure */
    part def Person {
        attribute name : String;
        attribute hasLicense : Boolean;
    }
    part def Car {
        attribute vin : String;
    }
    occurrence def ShoppingTrip {
        part driver : Person;
        part shopper : Person;
        part car : Car;
    }
    /* Unique individuals (real-world entities) */
    individual part def Joyce :> Person {
        :>> name = "Joyce";
        :>> hasLicense = true;
    }
    individual part def JoycesCar :> Car {
        :>> vin = "VIN-9Z123";
    }
    /* A context where individuals occupy roles */
    individual JoyceShoppingTrip : ShoppingTrip {
        /* Same Joyce in two contextual roles */
        individual part :>> driver : Joyce;
        individual part :>> shopper : Joyce;
        /* A specific car */
        individual part :>> car : JoycesCar;
        assert constraint {
            driver.hasLicense == true
        }
    }
}
