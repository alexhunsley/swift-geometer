//
//  Angle+Helpers.swift
//  SwiftGeometer
//
//  Created by Alex Hunsley on 15/09/2024.
//

import SwiftUI

public struct PolarCoord: Sendable {
    let angle: Angle
    let radius: CGFloat

    @Sendable public init(angle: Angle, radius: CGFloat) {
        self.angle = angle
        self.radius = radius
    }

    public var cartesianCoord: Vec2 { angle.coordinate(withRadius: radius) }
}

// "'@Sendable' attribute cannot be applied to this declaration"
// 'public' modifier cannot be used with extensions that declare protocol conformances
//@Sendable
public extension Angle {
    // MARK: - Static functionality
    static let thirty = Angle(degrees: 30)
    static let sixty = Angle(degrees: 60)
    static let ninety = Angle(degrees: 90)
    static let fortyFive = Angle(degrees: 45)

    static let oneEighty = Angle(degrees: 180)
    static let twoSeventy = Angle(degrees: 270)

    static let quarterTurn = Angle.ninety
    static let halfTurn = Angle.oneEighty
    static let threeQuarterTurn = Angle.twoSeventy

    @Sendable static func asin(a: CGFloat) -> Angle { Angle(radians: _asin(a)) }
    @Sendable static func acos(a: CGFloat) -> Angle { Angle(radians: _acos(a)) }
    @Sendable static func atan(a: CGFloat) -> Angle { Angle(radians: _atan(a)) }
    @Sendable static func atan2(_ y: CGFloat, _ x: CGFloat) -> Angle { Angle(radians: _atan2(y, x)) }
    @Sendable static func asinh(a: CGFloat) -> Angle { Angle(radians: _asinh(a)) }
    @Sendable static func acosh(a: CGFloat) -> Angle { Angle(radians: _acosh(a)) }
    @Sendable static func atanh(a: CGFloat) -> Angle { Angle(radians: _atanh(a)) }

    @Sendable static func between(vector lhs: Vec2, andVector rhs: Vec2) -> Angle {
        // Reminder: a.b = |a| |b| cos theta
        Angle.acos(a: Angle.cosineBetween(vector: lhs, andVector: rhs))
    }

    @Sendable static func cosineBetween(vector lhs: Vec2, andVector rhs: Vec2) -> CGFloat {
        lhs.dot(rhs) / (lhs.magnitude * rhs.magnitude)
    }

    // MARK: - Instance functionality

    var sin: CGFloat { _sin(radians) }
    var cos: CGFloat { _cos(radians) }
    var tan: CGFloat { _tan(radians) }
    var sinh: CGFloat { _sinh(radians) }
    var cosh: CGFloat { _cosh(radians) }
    var tanh: CGFloat { _tanh(radians) }

    /// polar -> cartesian conversion
    @Sendable func coordinate<T: BinaryFloatingPoint>(withRadius radius: T,
                                                      fromPoint centrePoint: Vec2 = .zero,
                                                      angleOffset: Angle = .zero) -> Vec2 {
        let offsetAngle = self + angleOffset
        return centrePoint + T(radius) * Vec2(x: offsetAngle.cos, y: offsetAngle.sin)
    }
}

// MARK: - Angle operators

@Sendable public func + (left: Angle, right: Angle) -> Angle {
    Angle(radians: left.radians + right.radians)
}

@Sendable public func - (left: Angle, right: Angle) -> Angle {
    Angle(radians: left.radians - right.radians)
}

@Sendable public func *<T: BinaryFloatingPoint> (left: Angle, right: T) -> Angle {
    Angle(radians: left.radians * Double(right))
}

@Sendable public func *<T: BinaryFloatingPoint> (left: T, right: Angle) -> Angle {
    Angle(radians: Double(left) * right.radians)
}

@Sendable public func /<T: BinaryFloatingPoint> (left: Angle, right: T) -> Angle {
    Angle(radians: left.radians / Double(right))
}

@Sendable public prefix func - (angle: Angle) -> Angle {
    Angle(radians: -angle.radians)
}
