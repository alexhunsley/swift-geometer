//
//  CGPoint+Helpers.swift
//  SwiftGeometer
//

import Foundation
import SwiftUI

/// Convenience
typealias Vec2 = CGPoint

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func *<T: BinaryFloatingPoint> (left: CGPoint, right: T) -> CGPoint {
    CGPoint(x: left.x * CGFloat(right), y: left.y * CGFloat(right))
}

public func /<T: BinaryFloatingPoint> (left: CGPoint, right: T) -> CGPoint {
    CGPoint(x: left.x / CGFloat(right), y: left.y / CGFloat(right))
}

public prefix func - (point: CGPoint) -> CGPoint {
    CGPoint(x: -point.x, y: -point.y)
}

public extension CGPoint {
    static let unitSquare = CGPoint(x: 1.0, y: 1.0)
    static let unitLine = CGPoint(x: sqrt(2), y: sqrt(2))

    func atan() -> Angle {
        Angle(radians: _atan(y / x))
    }

    func atan2() -> Angle {
        Angle(radians: _atan2(y, x))
    }
}
