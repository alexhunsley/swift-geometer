//
//  TestSupport.swift
//  SwiftGeometerTests
//
//  Created by Alex Hunsley on 15/03/2025.
//

import Foundation
import SwiftUI
import Testing

public struct Single<T>: Sendable where T: Sendable {
    let uniqueID = UUID()
    public let a: T

    public init(_ a: T) {
        self.a = a
    }
}

public struct Pair<T, U>: Sendable where T: Sendable, U: Sendable {
    let uniqueID = UUID()
    public let a: T
    public let b: U

    public init(_ a: T, _ b: U) {
        self.a = a
        self.b = b
    }
}

public struct Triple<T, U, V>: Sendable where T: Sendable, U: Sendable, V: Sendable {
    let uniqueID = UUID()
    public let a: T
    public let b: U
    public let c: V

    public init(_ a: T, _ b: U, _ c: V) {
        self.a = a
        self.b = b
        self.c = c
    }
}

public struct Quad<T, U, V, W>: Sendable where T: Sendable, U: Sendable, V: Sendable, W: Sendable {
    let uniqueID = UUID()
    public let a: T
    public let b: U
    public let c: V
    public let d: W

    public init(_ a: T, _ b: U, _ c: V, _ d: W) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }
}

// can't extend a typealias from a different target, but can extend the underlying type
extension CGVector {
    func isAlmostEqual(_ other: CGVector, accuracy: Double = 1e-4, message: String? = nil, negateCheck: Bool = false) {
        let isClose = abs(self.x - other.x) <= accuracy && abs(self.y - other.y) <= accuracy
        //        print("Closeness: \(abs(self.x - other.x) <= accuracy), \(abs(self.y - other.y) <= accuracy)")
        let failureMessage = Comment(rawValue: message ?? "Expected \(self) to be close to \(other) within \(accuracy)")
        #expect(negateCheck ? !isClose : isClose, failureMessage)
    }
}

extension BinaryFloatingPoint {
    func isAlmostEqual(_ other: Self,
                       accuracy: Self = 1e-5,
                       message: String? = nil) {
        let isClose = abs(self - other) <= accuracy
        let failureMessage = Comment(rawValue: message ?? "Expected degrees \(self) to be close to degrees \(other) within \(accuracy)")
        #expect(isClose, failureMessage)
    }
}

// SwiftUI
extension Angle {
    func isAlmostEqual(_ other: Angle, accuracy: Double = 1e-5, message: String? = nil) {
        let isClose = abs(self.degrees - other.degrees) <= accuracy
        let failureMessage = Comment(rawValue: message ?? "Expected degrees \(self) to be close to degrees \(other) within \(accuracy)")
        #expect(isClose, failureMessage)
    }
}
