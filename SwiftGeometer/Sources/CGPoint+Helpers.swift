//
//  CGPoint+Helpers.swift
//  SwiftGeometer
//

import Foundation
import SwiftUI

// an alias allows us some choice over the actual implementation
public typealias Vec2 = CGVector
//public typealias Vec2 = CGPoint

// we want to use plain x, y for convenience
extension CGVector {
    public init(x: Double, y: Double) {
        self.init(dx: x, dy: y)
    }

    public var x: Double { dx }
    public var y: Double { dy }
}

public extension Vec2 {
    static let unitSquare = Vec2(x: 1.0, y: 1.0)
    static let unitLine = Vec2(x: 1 / Triangle<CGFloat>.Right.hypot, // or just 1 / sqrt(2)
                               y: 1 / Triangle<CGFloat>.Right.hypot)
    static let undefined = Vec2(x: Double.nan, y: Double.nan)

    /// Init with given x (sets y = 0)
    @Sendable init(x: CGFloat) {
        self.init(x: x, y: 0)
    }

    /// Init with given y (sets x = 0)
    @Sendable init(y: CGFloat) {
        self.init(x: 0, y: y)
    }

    /// Init both x and y components with given value
    @Sendable init(xy: CGFloat) {
        self.init(x: xy, y: xy)
    }

    @Sendable func atan() -> Angle {
        Angle(radians: _atan(y / x))
    }

    @Sendable func atan2() -> Angle {
        Angle(radians: _atan2(y, x))
    }

    var polarCoord: PolarCoord {
        PolarCoord(angle: atan2(), radius: hypot(x, y))
    }

    var negatedX: Vec2 { Vec2(x: -x, y: y) }
    var negatedY: Vec2 { Vec2(x: x, y: -y) }
    var conjugate: Vec2 { negatedY }

    @Sendable func dot(_ otherPoint: Vec2) -> CGFloat {
        x * otherPoint.x + y * otherPoint.y
    }

    var magnitude: CGFloat { sqrt(magnitude2) }

    @Sendable static
    func magnitude(vec: Vec2) -> CGFloat {
        vec.magnitude
    }

    /// magnitude squared
    var magnitude2: CGFloat { x * x + y * y }

    @Sendable static
    func magnitude2(vec: Vec2) -> CGFloat {
        vec.magnitude2
    }

    var unitVector: Vec2 { self / magnitude }

    // rotate counter-clockwise by angle
    @Sendable func rotate(byAngle angle: Angle) -> Vec2 {
        Vec2(x: angle.cos * x - angle.sin * y,
             y: angle.sin * x + angle.cos * y)
    }

    var rotated180: Vec2 {
        -self
    }

    var rotated90CCW: Vec2 {
        Vec2(x: -y, y: x)
    }

    var rotated90CW: Vec2 {
        Vec2(x: y, y: -x)
    }

    // TODO prolly get rid of this! do something better
    var isUndefined: Bool {
        x.isNaN || y.isNaN
    }

    @Sendable func angle(toVector otherVector: Vec2) -> CGFloat {
        let unitVector = unitVector
        let unitOtherVector = otherVector.unitVector
        return acos(unitVector.dot(unitOtherVector))
    }

    @Sendable static
    func angle(a: Vec2, b: Vec2) -> CGFloat {
        let aUnitVector = a.unitVector
        let bUnitVector = b.unitVector
        return acos(aUnitVector.dot(bUnitVector))
    }

    /// Vec2 resulting from `self` vector projected onto otherVector
    @Sendable func projection(ontoVector otherVector: Vec2) -> Vec2 {
        // Derivation:
        //
        //  dot product:
        //       a.b = |a| |b| cos theta      (1)
        //
        //  projection of `a` onto `b`: (a = self, b = otherVector)
        //    p(a\b) = a / |a|  *  |b| cos theta
        //           = a / |a|  *  a.b / |a|     (by subst (1))
        //           = a.b  *  a / (|a| * |a|)
        //           = a.b  *  a / a.magnitude2

        // so we end up with this (which works):
        //        self.dot(otherVector) * otherVector / otherVector.magnitude2

        // ... but it's more pleasant and more memorable to use the unit vector of otherVector:
        let unitOtherVector = otherVector.unitVector
        return self.dot(unitOtherVector) * unitOtherVector
    }

    // these static ones are for reference impls in blog,
    // meant to be as simple as possible to read!
    @Sendable static
    func projection(a: Vec2, b: Vec2) -> Vec2 {
        let bUnit = b.unitVector
        return a.dot(bUnit) * bUnit
    }

    @Sendable func projectionLength(ontoVector otherVector: Vec2) -> CGFloat {
        let unitOtherVector = otherVector.unitVector
        return abs(self.dot(unitOtherVector))
    }

    @Sendable static
    func projectionLength(a: Vec2, b: Vec2) -> CGFloat {
        let bUnit = b.unitVector
        return abs(a.dot(bUnit))
    }

    ///  Vec2 resulting from `self` vector projected onto otherVector, fixed to +ve B dierection
    @Sendable func projectionForward(ontoVector otherVector: Vec2) -> Vec2 {
        // Derivation:
        //
        //  dot product:
        //       a.b = |a| |b| cos theta      (1)
        //
        //  projection of `a` onto `b`: (a = self, b = otherVector)
        //    p(a\b) = a / |a|  *  |b| cos theta
        //           = a / |a|  *  a.b / |a|     (by subst (1))
        //           = a.b  *  a / (|a| * |a|)
        //           = a.b  *  a / a.magnitude2

        // so we end up with this (which works):
        //        self.dot(otherVector) * otherVector / otherVector.magnitude2

        // ... but it's more pleasant and more memorable to use the unit vector of otherVector:
        let unitOtherVector = otherVector.unitVector
        return abs(self.dot(unitOtherVector)) * unitOtherVector
    }

    @Sendable static
    func projectionForward(a: Vec2, b: Vec2) -> Vec2 {
        let bUnit = b.unitVector
        return abs(a.dot(bUnit)) * bUnit
    }

    /// Vec2 resulting from `self` vector projected onto orthogonal of otherVector
    @Sendable func rejection(ontoVector otherVector: Vec2) -> Vec2 {
        // Derivation:
        //
        //  dot product:
        //       a.b = |a| |b| cos theta      (1)
        //
        //  projection of `a` onto `b`: (a = self, b = otherVector)
        //    p(a\b) = a / |a|  *  |b| cos theta
        //           = a / |a|  *  a.b / |a|     (by subst (1))
        //           = a.b  *  a / (|a| * |a|)
        //           = a.b  *  a / a.magnitude2

        // so we end up with this (which works):
        //        self.dot(otherVector) * otherVector / otherVector.magnitude2

        // ... but it's more pleasant and more memorable to use the unit vector of otherVector:
        let unitOtherVectorOrth = otherVector.unitVector.rotated90CCW
        return self.dot(unitOtherVectorOrth) * unitOtherVectorOrth
    }

    @Sendable static
    func rejection(a: Vec2, b: Vec2) -> Vec2 {
        let bUnitOrth = b.unitVector.rotated90CCW
        return a.dot(bUnitOrth) * bUnitOrth
    }

    @Sendable func rejectionLength(ontoVector otherVector: Vec2) -> CGFloat {
        let unitOtherVectorOrth = otherVector.unitVector.rotated90CCW
        return abs(self.dot(unitOtherVectorOrth))
    }

    // TODO add tests for new bits like rejectionLength
    @Sendable static
    func rejectionLength(a: Vec2, b: Vec2) -> CGFloat {
        let bUnitOrth = b.unitVector.rotated90CCW
        return abs(a.dot(bUnitOrth))
    }

    /// Vec2 resulting from `self` vector rejected onto orthogonal of otherVector (fixed to eft of B)
    @Sendable func rejectionLeft(ontoVector otherVector: Vec2) -> Vec2 {
        // Derivation:
        //
        //  dot product:
        //       a.b = |a| |b| cos theta      (1)
        //
        //  projection of `a` onto `b`: (a = self, b = otherVector)
        //    p(a\b) = a / |a|  *  |b| cos theta
        //           = a / |a|  *  a.b / |a|     (by subst (1))
        //           = a.b  *  a / (|a| * |a|)
        //           = a.b  *  a / a.magnitude2

        // so we end up with this (which works):
        //        self.dot(otherVector) * otherVector / otherVector.magnitude2

        // ... but it's more pleasant and more memorable to use the unit vector of otherVector:
        let unitOtherVectorOrth = otherVector.unitVector.rotated90CCW
        return abs(self.dot(unitOtherVectorOrth)) * unitOtherVectorOrth
    }

    @Sendable static
    func rejectionLeft(a: Vec2, b: Vec2) -> Vec2 {
        let bUnitOrth = b.unitVector.rotated90CCW
        return abs(a.dot(bUnitOrth)) * bUnitOrth
    }

    /// returns true if < 90 degrees between vectors
    @Sendable func isSameDirection(asVector other: Vec2) -> Bool {
        self.dot(other) > 0
    }

    @Sendable static
    func isSameDirection(a: Vec2, b: Vec2) -> Bool {
        a.dot(b) > 0
    }

    /// returns true if > 90 degrees between vectors
    @Sendable func isOppositeDirection(asVector other: Vec2) -> Bool {
        self.dot(other) < 0
    }

    @Sendable static
    func isOppositeDirection(a: Vec2, b: Vec2) -> Bool {
        a.dot(b) < 0
     }

    // don't think this below makes sennse!
    /// variant that has orth projection to right of self vector
//    @Sendable func positiveProjectedOrthogonally(ontoVector otherVector: Vec2) -> Vec2 {
//        // Derivation:
//        //
//        //  dot product:
//        //       a.b = |a| |b| cos theta      (1)
//        //
//        //  projection of `a` onto `b`: (a = self, b = otherVector)
//        //    p(a\b) = a / |a|  *  |b| cos theta
//        //           = a / |a|  *  a.b / |a|     (by subst (1))
//        //           = a.b  *  a / (|a| * |a|)
//        //           = a.b  *  a / a.magnitude2
//
//        // so we end up with this (which works):
//        //        self.dot(otherVector) * otherVector / otherVector.magnitude2
//
//        // ... but it's more pleasant and more memorable to use the unit vector of otherVector:
//        let unitOtherVectorOrth = otherVector.unitVector.rotated90CCW
//        return abs(self.dot(unitOtherVectorOrth)) * unitOtherVectorOrth
//    }

    @Sendable func isToLeft(ofVector other: Vec2) -> Bool {
        // to discriminate handedness (left/right), we want to the sine
        // of the angle (because it changes sign at 0 degrees), so rotate the
        // other vector by 90 degrees CW (so self effectively is rotated 90CCW)
        self.rotated90CCW.dot(other) < 0
    }

    @Sendable static
    func isToLeft(a: Vec2, b: Vec2) -> Bool {
        // to discriminate handedness (left/right), we want to the sine
        // of the angle (because it changes sign at 0 degrees), so rotate
        // `a` vector by 90 degrees CCW
        a.rotated90CCW.dot(b) < 0
    }

    @Sendable func isToRight(ofVector other: Vec2) -> Bool {
        // to discriminate handedness (left/right), we want to the sine
        // of the angle (because it changes sign at 0 degrees), so rotate
        // `a` vector by 90 degrees CCW
        self.rotated90CCW.dot(other) > 0
    }

    @Sendable static
    func isToRight(a: Vec2, b: Vec2) -> Bool {
        // to discriminate handedness (left/right), we want to the sine
        // of the angle (because it changes sign at 0 degrees), so rotate
        // `a` vector by 90 degrees CCW
        a.rotated90CCW.dot(b) > 0
    }

    func quadrant(referenceVector other: Vec2) -> Quadrant {
        if self.isOppositeDirection(asVector: other) {
            return self.isToLeft(ofVector: other) ? .southWest : .southEast
        }
        return self.isToLeft(ofVector: other) ? .northWest : .northEast
    }

    func rotate(byVector other: Vec2) -> Vec2 {
        // cos - sin
        // sin + cos
        let otherUnit = other.unitVector
        // NB this is a CW rotation: c + s, -s + c
        return Vec2(x: otherUnit.y * self.x + otherUnit.x * self.y,
                    y: -otherUnit.x * self.x + otherUnit.y * self.y)
    }

    // todo finish this
    /// vector A rebased so that first component in new basis is in direction of B
//    @Sendable static
//    func rebase(a: Vec2, b: Vec2) -> Vec2 {
//        Vec2(x: projection(a: a, b: b), y: rejection(a: a, b: b))
//    }

    // obv can just put a - in front of positiveProjected to make it the negativeProjected
}

public enum Quadrant: Sendable, Equatable {
    case northEast
    case southEast
    case southWest
    case northWest
}

// MARK: - Vec2 operators

@Sendable public func + (left: Vec2, right: Vec2) -> Vec2 {
    Vec2(x: left.x + right.x, y: left.y + right.y)
}

@Sendable public func - (left: Vec2, right: Vec2) -> Vec2 {
    Vec2(x: left.x - right.x, y: left.y - right.y)
}

@Sendable public func *<T: BinaryFloatingPoint> (left: Vec2, right: T) -> Vec2 {
    Vec2(x: left.x * CGFloat(right), y: left.y * CGFloat(right))
}

@Sendable public func *<T: BinaryFloatingPoint> (left: T, right: Vec2) -> Vec2 {
    Vec2(x: CGFloat(left) * right.x, y: CGFloat(left) * right.y)
}

@Sendable public func /<T: BinaryFloatingPoint> (left: Vec2, right: T) -> Vec2 {
    Vec2(x: left.x / CGFloat(right), y: left.y / CGFloat(right))
}

@Sendable public prefix func - (point: Vec2) -> Vec2 {
    Vec2(x: -point.x, y: -point.y)
}
