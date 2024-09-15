import SwiftUI

public struct SwiftGeometer {
    public static func hello() -> String {
        "Hello from SwiftGeometer"
    }
}

/// Triangle constants for literate programming.
/// In other words, rather than inserting e.g. `sqrt(3)` directly
/// into your geometrical  code, `Triangle.HalfEquilateral.largerSideLength` might
/// be used to give more context about the intention/concept.
public enum Triangle<FloatingPoint: BinaryFloatingPoint> {
    /// half of an equilateral triangle with side lengths 1, 2, sqrt(3)
    public enum HalfEquilateral {
        static public var hypot: FloatingPoint { 2 }
        static public var largerSideLength: FloatingPoint { sqrt(3) }
        static public var smallerSideLength: FloatingPoint { 1 }
        static public var largerAngle: FloatingPoint { 60 }
        static public var smallerAngle: FloatingPoint { 30 }
    }

    public enum Right {
        static public var hypot: FloatingPoint { sqrt(2) }
        /// both non-hypot sides are length 1
        static public var side: FloatingPoint { 1 }
        /// both non-hypot angles are 45
        static public var angle: FloatingPoint { 45 }
    }
}

// TODO
// [ ] put the test harness app into a project inside this project

// will trigger swift 6 concurrency warning if strict is enabled
//class DataManager {
//    var data: [String] = []
//
//    // Non-isolated function that accesses shared mutable state
//    func addData(_ value: String) {
//        data.append(value)  // This will trigger a warning under strict concurrency
//    }
//
//    // "Instance method of non-Sendable type 'DataManager' cannot be marked as '@Sendable'; this is an error in the Swift 6 language mode"
//    @Sendable
//    func processDataConcurrently() {
//        addData("Test")  // This will trigger a warning due to concurrency violation
//    }
//}
