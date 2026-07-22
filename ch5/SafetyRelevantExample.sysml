package SafetyRelevantExample {
    private import ScalarValues::*;
    private import SI::*;
    /* safety use cases */
    enum def HazardType {
        ENERGY;
        TOXIN;
        PATHOGEN;
        LIFE_SUPPORT;
        RADIATION;
    }
    use case def 'Safety Use Case' {
        doc /* usage of this definition are safety-critical capabilities */
        attribute hazard : HazardType;
        attribute safetyIntegrityLevel : Integer;
    }
    use case ventilation : 'Safety Use Case' {
        hazard = HazardType::LIFE_SUPPORT;
        safetyIntegrityLevel = 2;
    }
    /* Performance use cases */
    use case def 'Performance-Oriented Use Case' {
        doc /* usages of this definition are assessed via key performance indicators */
        attribute kpiName : String;
        attribute <kpiValue> keyPerformanceIndicatorValue : Real;
        attribute <kpiTarget> keyPerformanceTargetValue : Real;
    }
    use case performBuiltInTest : 'Performance-Oriented Use Case' {
        kpiName = "Time to perform BIT";
        kpiValue = 10 [s];
        kpiTarget = 5 [s];
    }
}
