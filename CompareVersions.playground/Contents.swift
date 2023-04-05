import UIKit

var greeting = "Hello, playground"

/**
 # SemVer (30 min)
 Semantic Versioning (SemVer) is a three-part versioning system of Major.Minor.Patch.
 Create a function that compares versions
 - function name: compare(version1:, version2:)
 - input: `String` for both parameters
 - output: `Int`
    - if version1 is less than version2, return -1
    - if version1 is more than version2, return 1
    - otherwise, return 0
 The following conventions may be helpful
 - Ignore any leading zeroes in number parts
    i.e.
    1.03.2 == 1.3.2
    1.2.7 == 1.2.007
 - Assume zero in number parts if not specified
    i.e.
    1.2 == 1.2.0
    5.0.0 == 5
 Test Cases
 --------------------
 input:    compare(version1: "1.01", version2: "1.001")
 output:    0 (since both are 1.1)
 input:    compare(version1: "1.0", version2: "1.0.0")
 output:    0 (since both are 1.0.0)
 input:    compare(version1: "0.1", version2: "1.1")
 output:    -1 (since version1 is less than version2)
 input:    compare(version1: "1.1", version2: "1.1.2")
 output:    -1 (since version1 is less than version2)
 input:    compare(version1: "0.75", version2: "0.7.5")
 output:    1 (since version1 is more than version2)
 Bonus Steps
 - Expand the function for enhanced SemVer (Major.Minor.Patch.Build.Revision.Maintenance)
 - Modify results to `ComparisonResult` enum instead of `Int`
 */

enum CompareResult {
    case isLesser
    case bothEqual
    case isGreater
}

func getNumArray(_ version: String) -> [Int]{
    var num = version.components(separatedBy: ".").map { item in
        Int(item) ?? 0
    }
    if let first = num.first {
        num.removeAll(where: {
            $0 == 0
        })
        num.insert(first, at: 0)
        return num
    } else {
        return num
    }
}

func getComparision(_ version1: Double, _ version2: Double) -> CompareResult {
    switch(version1, version2) {
        case let (x, y) where x == y:
        return .bothEqual
        case let (x, y) where x < y:
        return .isLesser
        case let (x, y) where x > y:
        return .isGreater
        default :
            return .bothEqual
    }
}

func compareVersion(_ version1: String,_ version2: String) -> CompareResult {
    let v1 = getNumArray(version1)
    let v2 = getNumArray(version2)
    
    //case for 1st digit greater 1st digit of version 2
    if let num1 = v1.first, let num2 = v2.first {
        let retValue = getComparision(Double(num1), Double(num2))
        if retValue != .bothEqual {
            return retValue
        }
    }
    
    //case for 1 decimals
//    if v1.count == 2 , v2.count == 2, let num1 = Double(version1), let num2 = Double(version2) {
//        return getComparision(num1, num2)
//    }
        
    for (index, item1) in v1.enumerated() {
        if v2.indices.contains(index) {
            let retValue = getComparision(Double(item1), Double(v2[index]))
            if retValue == .bothEqual {
                continue
            } else {
                return retValue
            }
        }
    }
    
    if v1.count < v2.count, let lastnum = v2.last, lastnum > 0 {
        return .isLesser
    } else if v1.count > v2.count, let lastnum = v1.last, lastnum > 0 {
        return .isGreater
    } else {
        return .bothEqual
    }
    
    
}


compareVersion("1.01", "1.001") //pass
compareVersion("1.0", "1.0.0") //pass
compareVersion("0.1", "1.0") //pass
compareVersion("1.1", "1.1.2") //pass
compareVersion("0.75", "0.7.5") //pass
compareVersion("1.1.0", "1.1.2") //pass
