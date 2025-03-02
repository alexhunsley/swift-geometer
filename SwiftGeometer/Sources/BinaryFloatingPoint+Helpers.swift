//
//  BinaryFloatingPoint+Helpers.swift
//  SwiftGeometer
//

import Foundation

/// Tau, pi, common Pi divisors for double, Float, CGFloat, etc.
extension BinaryFloatingPoint {
    public static var pi2: Self { pi / 2 }
    public static var pi3: Self { pi / 3 }
    public static var pi4: Self { pi / 4 }
    public static var pi8: Self { pi / 8 }
    public static var tau: Self { pi * 2 }

    // to test: divisors of tau
    public static var tau2: Self { tau / 2 }
    public static var tau3: Self { tau / 3 }
    public static var tau4: Self { tau / 4 }
    public static var tau8: Self { tau / 8 }

    public static var one: CGFloat { 1.0 }
}
