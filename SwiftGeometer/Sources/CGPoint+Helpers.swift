//
//  CGPoint+Helpers.swift
//  SwiftGeometer
//

import Foundation
import SwiftUI

/// Convenience
public typealias Vec2 = CGPoint

public extension CGPoint {
    static let unitSquare = CGPoint(x: 1.0, y: 1.0)
    static let unitLine = CGPoint(x: 1 / Triangle<CGFloat>.Right.hypot, // or just 1 / sqrt(2)
                                  y: 1 / Triangle<CGFloat>.Right.hypot)

    /// Init with given x (sets y = 0)
    init(x: CGFloat) {
        self.init(x: x, y: 0)
    }

    /// Init with given y (sets x = 0)
    init(y: CGFloat) {
        self.init(x: 0, y: y)
    }

    /// Init both x and y components with given value
    init(xy: CGFloat) {
        self.init(x: xy, y: xy)
    }

    func atan() -> Angle {
        Angle(radians: _atan(y / x))
    }

    func atan2() -> Angle {
        Angle(radians: _atan2(y, x))
    }

    var polarPoint: PolarPoint {
        PolarPoint(angle: atan2(), radius: hypot(x, y))
    }

    var negatedX: CGPoint { CGPoint(x: -x, y: y) }
    var negatedY: CGPoint { CGPoint(x: x, y: -y) }
    var conjugate: CGPoint { negatedY }

    func dot(_ otherPoint: CGPoint) -> CGFloat {
        x * otherPoint.x + y * otherPoint.y
    }

    var magnitude: CGFloat { sqrt(magnitude2) }

    /// magnitude squared
    var magnitude2: CGFloat { x * x + y * y }

    var unitVector: Vec2 { self / magnitude }

    // rotate counter-clockwise by angle
    func rotate(byAngle angle: Angle) -> CGPoint {
        CGPoint(x: angle.cos * x - angle.sin * y,
                y: angle.sin * x + angle.cos * y)
    }

    /// Vec2 resulting from `self` vector projected onto otherVector
    func projected(ontoVector otherVector:Vec2) -> Vec2 {
        // Derivation:
        //
        //  dot product:
        //       a.b = |a| |b| cos theta
        //
        //  projection of `a` onto `b`: (a = self, b = otherVector)
        //    p(a\b) = a / |a|  *  |b| cos theta
        //           = a / |a|  *  a.b / |a|
        //           = a.b  *  a / (|a| * |a|)
        //           = a.b  *  a / a.magnitude2

        // so we end up with this (which works):
        //        self.dot(otherVector) * otherVector / otherVector.magnitude2

        // ... but it's more pleasant and more memorable to use the unit vector of otherVector:
        let unitOtherVector = otherVector.unitVector
        return self.dot(unitOtherVector) * unitOtherVector
    }
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func *<T: BinaryFloatingPoint> (left: CGPoint, right: T) -> CGPoint {
    CGPoint(x: left.x * CGFloat(right), y: left.y * CGFloat(right))
}

public func *<T: BinaryFloatingPoint> (left: T, right: CGPoint) -> CGPoint {
    CGPoint(x: CGFloat(left) * right.x, y: CGFloat(left) * right.y)
}

public func /<T: BinaryFloatingPoint> (left: CGPoint, right: T) -> CGPoint {
    CGPoint(x: left.x / CGFloat(right), y: left.y / CGFloat(right))
}

public prefix func - (point: CGPoint) -> CGPoint {
    CGPoint(x: -point.x, y: -point.y)
}
