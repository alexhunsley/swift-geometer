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

    /// cartesian -> polar conversion?
    var polarPoint: PolarPoint {
        PolarPoint(angle: atan2(), radius: hypot(x, y))
    }

    var negatedX: CGPoint { CGPoint(x: -x, y: y) }
    var negatedY: CGPoint { CGPoint(x: x, y: -y) }
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
