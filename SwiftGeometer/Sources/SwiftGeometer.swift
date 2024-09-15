import SwiftUI

public struct SwiftGeometer {
    public static func hello() -> String {
        "Hello from SwiftGeometer"
    }
}

// Pi for Double, Float, CGFloat, etc.
extension BinaryFloatingPoint {
    public static var pi: Self { Self(Double.pi) }
    public static var pi2: Self { pi / 2 }
    public static var pi4: Self { pi / 4 }
    public static var pi8: Self { pi / 8 }
    public static var tau: Self { pi * 2 }
}
