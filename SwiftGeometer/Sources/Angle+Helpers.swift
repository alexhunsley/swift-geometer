//
//  Angle+Helpers.swift
//  SwiftGeometer
//
//  Created by Alex Hunsley on 15/09/2024.
//

import SwiftUI

// hypot? same as magnitude I take it.
public extension Angle {
    var sin: CGFloat { _sin(radians) }
    var cos: CGFloat { _cos(radians) }
    var tan: CGFloat { _tan(radians) }
    var sinh: CGFloat { _sinh(radians) }
    var cosh: CGFloat { _cosh(radians) }
    var tanh: CGFloat { _tanh(radians) }

    func asin(a: CGFloat) -> Angle { Angle(radians: _asin(a)) }
    func acos(a: CGFloat) -> Angle { Angle(radians: _acos(a)) }
    func atan(a: CGFloat) -> Angle { Angle(radians: _atan(a)) }
    func atan2(_ y: CGFloat, _ x: CGFloat) -> Angle { Angle(radians: _atan2(y, x)) }
    func asinh(a: CGFloat) -> Angle { Angle(radians: _asinh(a)) }
    func acosh(a: CGFloat) -> Angle { Angle(radians: _acosh(a)) }
    func atanh(a: CGFloat) -> Angle { Angle(radians: _atanh(a)) }

    /// polar -> cartesian conversion
    func coordinate<T: BinaryFloatingPoint>(withRadius radius: T, angleOffset: T = 0) -> CGPoint {

        CGPoint(x: cos, y: sin)
    }
}

public func + (left: Angle, right: Angle) -> Angle {
    Angle(radians: left.radians + right.radians)
}

public func - (left: Angle, right: Angle) -> Angle {
    Angle(radians: left.radians - right.radians)
}

public func *<T: BinaryFloatingPoint> (left: Angle, right: T) -> Angle {
    Angle(radians: left.radians * Double(right))
}

public func *<T: BinaryFloatingPoint> (left: T, right: Angle) -> Angle {
    Angle(radians: Double(left) * right.radians)
}

public func /<T: BinaryFloatingPoint> (left: Angle, right: T) -> Angle {
    Angle(radians: left.radians / Double(right))
}

public prefix func - (angle: Angle) -> Angle {
    Angle(radians: -angle.radians)
}
