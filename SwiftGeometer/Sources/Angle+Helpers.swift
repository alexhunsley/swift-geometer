//
//  Angle+Helpers.swift
//  SwiftGeometer
//
//  Created by Alex Hunsley on 15/09/2024.
//

import SwiftUI

//struct PolarPoint<T: BinaryFloatingPoint> {
public struct PolarPoint {
    let angle: Angle
    let radius: CGFloat

    public init(angle: Angle, radius: CGFloat) {
        self.angle = angle
        self.radius = radius
    }

    public var cartesianPoint: CGPoint { angle.coordinate(withRadius: radius) }
}

// hypot? same as magnitude I take it.
public extension Angle {
    var sin: CGFloat { _sin(radians) }
    var cos: CGFloat { _cos(radians) }
    var tan: CGFloat { _tan(radians) }
    var sinh: CGFloat { _sinh(radians) }
    var cosh: CGFloat { _cosh(radians) }
    var tanh: CGFloat { _tanh(radians) }

    func asin(a: CGFloat) -> Angle { Angle(radians: _asin(a)) }
    static func acos(a: CGFloat) -> Angle { Angle(radians: _acos(a)) }
    func atan(a: CGFloat) -> Angle { Angle(radians: _atan(a)) }
    func atan2(_ y: CGFloat, _ x: CGFloat) -> Angle { Angle(radians: _atan2(y, x)) }
    func asinh(a: CGFloat) -> Angle { Angle(radians: _asinh(a)) }
    func acosh(a: CGFloat) -> Angle { Angle(radians: _acosh(a)) }
    func atanh(a: CGFloat) -> Angle { Angle(radians: _atanh(a)) }

    /// polar -> cartesian conversion
    func coordinate<T: BinaryFloatingPoint>(withRadius radius: T,
                                            fromPoint centrePoint: CGPoint = .zero,
                                            angleOffset: Angle = .zero) -> CGPoint {
        let offsetAngle = self + angleOffset
        return centrePoint + T(radius) * CGPoint(x: offsetAngle.cos, y: offsetAngle.sin)
    }

    static let thirty = Angle(degrees: 30)
    static let sixty = Angle(degrees: 60)
    static let ninety = Angle(degrees: 90)
    static let fortyFive = Angle(degrees: 45)

    static let oneEighty = Angle(degrees: 180)
    static let twoSeventy = Angle(degrees: 270)

    static let quarterTurn = Angle.ninety
    static let halfTurn = Angle.oneEighty
    static let threeQuarterTurn = Angle.twoSeventy

    // also do an instance method for .angleTo(otherVector:)
    static func between(vector lhs: Vec2, andVector rhs: Vec2) -> Angle {
        // a.b = |a| |b| cos theta
        let cosTheta: CGFloat = lhs.dot(rhs) / (lhs.magnitude * rhs.magnitude)
        return acos(a: cosTheta)
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
