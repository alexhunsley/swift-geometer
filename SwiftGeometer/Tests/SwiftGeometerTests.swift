import Foundation
import SwiftGeometer
import SwiftUI

import Testing

//public struct Pair<T>: Sendable where T: Sendable {
//    public let a: T
//    public let b: T
//
//    public init(_ a: T, _ b: T) {
//        self.a = a
//        self.b = b
//    }
//}

public struct Pair<T, U>: Sendable where T: Sendable, U: Sendable {
//public struct Pair<T, U> {
    public let a: T
    public let b: U

    public init(_ a: T, _ b: U) {
        self.a = a
        self.b = b
    }
}

public struct Triple<T, U, V>: Sendable where T: Sendable, U: Sendable, V: Sendable {
//public struct Triple<T, U, V> {
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
//public struct Triple<T, U, V> {
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

extension Angle {
    func isAlmostEqual(_ other: Angle, accuracy: Double = 1e-5, message: String? = nil) {
        let isClose = abs(self.degrees - other.degrees) <= accuracy
        let failureMessage = Comment(rawValue: message ?? "Expected degrees \(self) to be close to degrees \(other) within \(accuracy)")
        #expect(isClose, failureMessage)
    }
}

extension CGPoint {
    func isAlmostEqual(_ other: CGPoint, accuracy: Double = 1e-4, message: String? = nil) {
        let isClose = abs(self.x - other.x) <= accuracy && abs(self.y - other.y) <= accuracy
//        print("Closeness: \(abs(self.x - other.x) <= accuracy), \(abs(self.y - other.y) <= accuracy)")
        let failureMessage = Comment(rawValue: message ?? "Expected \(self) to be close to \(other) within \(accuracy)")
        #expect(isClose, failureMessage)
    }
}

//extension CGPoint {
//    func isAlmostEqual(_ other: CGPoint, accuracy: Double = 1e-4, message: String? = nil) {
//        let isClose = abs(self.x - other.x) <= accuracy && abs(self.y - other.y) <= accuracy
////        print("Closeness: \(abs(self.x - other.x) <= accuracy), \(abs(self.y - other.y) <= accuracy)")
//        let failureMessage = Comment(rawValue: message ?? "Expected \(self) to be close to \(other) within \(accuracy)")
//        #expect(isClose, failureMessage)
//    }
//}

extension BinaryFloatingPoint {
    func isAlmostEqual(_ other: Self,
                       accuracy: Self = 1e-5,
                       message: String? = nil) {
        let isClose = abs(self - other) <= accuracy
        let failureMessage = Comment(rawValue: message ?? "Expected degrees \(self) to be close to degrees \(other) within \(accuracy)")
        #expect(isClose, failureMessage)
    }
}
//
////    func isAlmostEqual2(_ other: Self,
////                       accuracy: Self = 1e-5,
////                       message: String? = nil) {
////        let isClose = abs(self - other) <= accuracy
////        let failureMessage = Comment(rawValue: message ?? "Expected degrees \(self) to be close to degrees \(other) within \(accuracy)")
////        #expect(isClose, failureMessage)
////    }
//}

final class SwiftGeometerTests {
    /// #expect (with accuracy) helper usable withh any BinaryFloatingPoint type
//    func #expect<T: BinaryFloatingPoint>(_ a: T, _ b: T) {
//        assert(a == b)
//    }
//
//    func #expect(_ a: Angle, _ b: Angle) {
//        #expect(a.radians, b.radians)
//    }

//    func #expect(_ a: CGPoint, _ b: CGPoint) {
//        #expect(a.x, b.x)
//        #expect(a.y, b.y)
//    }

    func expectAlmostEqual(_ a: Double, _ b: Double, accuracy: Double = 1e-6, message: String? = nil) {
        let isClose = abs(a - b) <= accuracy
        let failureMessage = Comment(rawValue: message ?? "Expected \(a) to be close to \(b) within \(accuracy)")
        #expect(isClose, failureMessage)
    }

    // problematic!
//    @Test("constant values", arguments: [
//        (Double.pi, 3.141592653589793),
//        (Double.pi2, 1.5707963267948966),
//        (Double.pi4, 0.7853981633974483),
//        (Double.pi8, 0.39269908169872414),
//        (Double.tau, 6.283185307179586),
//        (Double.tau2, 3.141592653589793),
//        (Double.tau3, 2.0943951023931953),
//        (Double.tau4, 1.5707963267948966),
//        (Double.tau8, 0.7853981633974483),
////        // Float
////        (Float.pi, 3.1415926),
////        (Float.pi2, 1.5707963),
////        (Float.pi4, 0.78539815),
////        (Float.pi8, 0.392699075),
////        (Float.tau, 6.2831852),
////        (Float.tau2, 3.1415926),
////        (Float.tau3, 2.094395),
////        (Float.tau4, 1.5707963),
////        (Float.tau8, 0.78539815),
////        // CGFloat
////        (CGFloat.pi, 3.141592653589793),
////        (CGFloat.pi2, 1.5707963267948966),
////        (CGFloat.pi4, 0.7853981633974483),
////        (CGFloat.pi8, 0.39269908169872414),
////        (CGFloat.tau, 6.283185307179586),
////        (CGFloat.tau2, 3.141592653589793),
////        (CGFloat.tau3, 2.0943951023931953),
////        (CGFloat.tau4, 1.5707963267948966),
////        (CGFloat.tau8, 0.7853981633974483)
//    ])
//    func test_whenAccessingDoubleConstants_thenCorrectValuesFound(value: Double, expectedValue: Double) {
//        value.isAlmostEqual(expectedValue)
//    }

    //    func test_whenAccessingConstants_thenCorrectValuesFound(value: any BinaryFloatingPoint, expectedValue: any BinaryFloatingPoint) {
//        isAlmostEqual2(value, expectedValue)
//        ((Double)value).alm
//    }
//    func test_whenAccessingConstants_thenCorrectValuesFound<T: BinaryFloatingPoint>(value: T, expectedValue: T) {
//        value.isAlmostEqual(expectedValue)
//    }

    @Test("CGPoint artithmetic helpers", arguments: [
        Pair(CGPoint(x: 1.0, y: -2.0) / 2.0, CGPoint(x: 0.5, y: -1.0)),
        Pair(CGPoint(x: 1.0, y: -2.0) / -2.0, CGPoint(x: -0.5, y: 1.0)),

        Pair(CGPoint(x: -1.0, y: 2.0) * 2.0, CGPoint(x: -2.0, y: 4.0)),
        Pair(CGPoint(x: -1.0, y: 2.0) * -2.0, CGPoint(x: 2.0, y: -4.0)),

        Pair(CGPoint(x: -1.0, y: 2.0) + CGPoint(x: 0.2, y: 0.3), CGPoint(x: -0.8, y: 2.3)),
        Pair(CGPoint(x: -1.0, y: 2.0) - CGPoint(x: 0.2, y: 0.3), CGPoint(x: -1.2, y: 1.7)),
        Pair(-CGPoint(x: -1.0, y: 2.0) - CGPoint(x: 0.2, y: 0.3), CGPoint(x: 0.8, y: -2.3)),

        Pair(-CGPoint(x: 11.2, y: -15.9), CGPoint(x: -11.2, y: 15.9)),
        Pair(-(-CGPoint(x: 11.2, y: -15.9)), CGPoint(x: 11.2, y: -15.9)),
        // @Test args list doesn't like the amount of brackets below!
        // -- ah, this evaluates to same as a few lines above. and repeated values
        // are know to cause the issue. see forums.swift.org/t/fatal-error-internal-inconsistency-no-test-reporter-for-test-case-argumentids/75666/3
        //  -- now fixed by tweaking values so not identical
        Pair(-(-(-CGPoint(x: -11.2, y: -15.9))), CGPoint(x: 11.2, y: 15.9)),
        Pair(-(-(-(-CGPoint(x: -11.0, y: -15.9)))), CGPoint(x: -11.0, y: -15.9))
    ])
    func test_whenUsingCGPointArithmeticHelpers_thenCorrectValuesFound(pointPair points: Pair<CGPoint, CGPoint>) {
        points.a.isAlmostEqual(points.b)
    }

    // look at these later
//    @Test
//    func test_whenUsingTriangleHelpers_thenCorrectValuesFound() {
//        // Double
//        #expect(Triangle.HalfEquilateral.hypot == Double(2))
//        #expect(Triangle.HalfEquilateral.largerAngle == Double(60))
//        #expect(Triangle.HalfEquilateral.smallerAngle == Double(30))
//
//        // Float
//        #expect(Triangle.HalfEquilateral.hypot == Float(2))
//        #expect(Triangle.HalfEquilateral.largerAngle == Float(60))
//        #expect(Triangle.HalfEquilateral.smallerAngle == Float(30))
//
//        // CGFloat
//        #expect(Triangle.HalfEquilateral.hypot == CGFloat(2))
//        #expect(Triangle.HalfEquilateral.largerAngle == CGFloat(60))
//        #expect(Triangle.HalfEquilateral.smallerAngle == CGFloat(30))
//
//        #expect(Triangle.cos0 == 1)
//    }

// reconsider this - will change to CGVector later anyway
//    @Test
//    func test_whenUsingVec2Typealias_thenItIsInterchangableWithCGPoint() {
//        #expect(Vec2(x: 1.0, y: -2.0) / 2.0 == CGPoint(x: 0.5, y: -1.0))
//        #expect(Vec2(x: -1.0, y: 2.0) + CGPoint(x: 0.2, y: 0.3) == Vec2(x: -0.8, y: 2.3))
//    }

//    @Test("angle arithmetic helpers", arguments: [
//        (1.5 * Angle(degrees: -80), Angle(degrees: -120)),
////        (1.5 * -Angle(degrees: -80), Angle(degrees: 120)),
////        (-1.5 * -Angle(degrees: -80), Angle(degrees: -120)),
////        (Angle(degrees: -80) * 2, Angle(degrees: -160)),
////        (Angle(degrees: 80) / 2, Angle(degrees: 40)),
////        (Angle(degrees: 50) + Angle(degrees: 20), Angle(degrees: 70)),
//
////        #expect(Angle(degrees: 50) - Angle(degrees: 20) == Angle(degrees: 30))
//
////        (Angle(degrees: 50) - Angle(degrees: 20), Angle(degrees: 30)),
////        (Angle(degrees: 20) + Angle(degrees: 50), Angle(degrees: 70)),
////        (Angle(degrees: 20) - Angle(degrees: 50), Angle(degrees: -30))
//    ])
//    func test_whenUsingAngleArithmeticHelpers_thenCorrectValuesFound(angle: Angle, other: Angle) {
//        angle.isAlmostEqual(other)
//    }

    @Test("angle polar to cartesian with angle offset", arguments: [
        // plain angle and radius to coordinate
        Quad(0, 2.5, Angle.ninety, CGPoint(x: 0, y: 2.5)),
        Quad(90, 2.5, Angle.ninety, CGPoint(x: -2.5, y: 0)),
        Quad(180, 2.5, Angle.ninety, CGPoint(x: 0, y: -2.5)),
        Quad(270, 2.5, Angle.ninety, CGPoint(x: 2.5, y: 0)),
        Quad(90, 2.5, -Angle.ninety, CGPoint(x: 2.5, y: 0)),
        Quad(180, 2.5, -Angle.ninety, CGPoint(x: 0, y: 2.5)),
        Quad(270, 2.5, -Angle.ninety, CGPoint(x: -2.5, y: 0)),
        Quad(0, 2.5, -Angle.ninety, CGPoint(x: 0, y: -2.5))
    ])
    func test_anglePolarToCartesianWithAngleOffset(anglePointPair triple: Quad<Double, Double, Angle, CGPoint>) {
        Angle(degrees: triple.a).coordinate(withRadius: triple.b, angleOffset: triple.c).isAlmostEqual(triple.d)
    }

    @Test("angle polar to cartesian", arguments: [
        // plain angle and radius to coordinate
        Triple(0, 1.0, CGPoint(x: 1, y: 0)),
        Triple(90, 1.0, CGPoint(x: 0, y: 1)),
        Triple(180, 1.0, CGPoint(x: -1, y: 0)),
        Triple(270, 1.0, CGPoint(x: 0, y: -1)),
        Triple(0, 2.5, CGPoint(x: 2.5, y: 0)),
        Triple(90, 2.5, CGPoint(x: 0, y: 2.5)),
        Triple(180, 2.5, CGPoint(x: -2.5, y: 0)),
        Triple(270, 2.5, CGPoint(x: 0, y: -2.5))
    ])
    func test_anglePolarToCartesian(anglePointPair triple: Triple<Double, Double, CGPoint>) {
        //        print("Triple: \(triple)")
        //        print("Triple c: \(triple.c)")
        //        let coord = triple.a.coordinate(withRadius: triple.b)
        //        print(coord)
        //        coord.isAlmostEqual(triple.c)

        Angle(degrees: triple.a).coordinate(withRadius: triple.b).isAlmostEqual(triple.c)
    }

//
//        // "ambiguous use of .pi":
//        //        Found this candidate in module 'Swift' (Swift.Float16)
//        //        Found this candidate in module 'Swift' (Swift.Float)
//        //        Found this candidate in module 'Swift' (Swift.Double)
//        //        Found this candidate in module 'Foundation' (Foundation.Decimal)
//        //        Found this candidate in module 'CoreFoundation' (CoreFoundation.CGFloat)
//        //        let x = .pi/2 // bad
//        let _: Float16 = .pi/2 // ok
//
//        // so need to rethink what I've re-implemend or not!
//        // e.g. tau would be nice to offer as that's not offered.
//
//
//
//        // fromPoint
//        (Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(x: 1, y: -5)).isAlmostEqual(CGPoint(x: 3.5, y: -5)))
//
//        // angleOffset and fromPoint (rename to centrePoint?)
//        (Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(xy: 1), angleOffset: Angle(radians: Double.pi2)).isAlmostEqual(CGPoint(x: 1, y: 3.5)))
//        //TODO
////        Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(xy: 1), angleOffset: Angle(radians: Double.pi4)).isAlmostEqual(CGPoint(x: 2.76776, y: 2.76776))
//
//        // Angle operators
//        (1.5 * -Angle(degrees: -80)).isAlmostEqual(Angle(degrees: 120))
//        (-1.5 * -Angle(degrees: -80)).isAlmostEqual(Angle(degrees: -120))
//        (Angle(degrees: -80) * 2).isAlmostEqual(Angle(degrees: -160))
//        (Angle(degrees: 80) / 2).isAlmostEqual(Angle(degrees: 40))
//        (Angle(degrees: 50) + Angle(degrees: 20)).isAlmostEqual(Angle(degrees: 70))
//        (Angle(degrees: 50) - Angle(degrees: 20)).isAlmostEqual(Angle(degrees: 30))
//        (Angle(degrees: 20) + Angle(degrees: 50)).isAlmostEqual(Angle(degrees: 70))
//        (Angle(degrees: 20) - Angle(degrees: 50)).isAlmostEqual(Angle(degrees: -30))
//    }

//
//    @Test
//    func test_constants() {
//        expectAlmostEqual(Triangle.cos0, Angle(degrees: 0).cos)
//        expectAlmostEqual(Triangle.cos30, Angle(degrees: 30).cos)
//        expectAlmostEqual(Triangle.cos60, Angle(degrees: 60).cos)
//        expectAlmostEqual(Triangle.cos90, Angle(degrees: 90).cos)
//        expectAlmostEqual(Triangle.cos45, Angle(degrees: 45).cos)
//
//        expectAlmostEqual(Triangle.sin0, Angle(degrees: 0).sin)
//        expectAlmostEqual(Triangle.sin30, Angle(degrees: 30).sin)
//        expectAlmostEqual(Triangle.sin60, Angle(degrees: 60).sin)
//        expectAlmostEqual(Triangle.sin90, Angle(degrees: 90).sin)
//        expectAlmostEqual(Triangle.sin45, Angle(degrees: 45).sin)
//    }
//
//    @Test
//    func test_CGPointInitHelpers() {
//        #expect(CGPoint(x: 2.3) == CGPoint(x: 2.3, y: 0))
//        #expect(CGPoint(y: -7.12) == CGPoint(x: 0, y: -7.12))
//    }
//
//    @Test
//    func test_polarConversion() {
//        PolarCoord(angle: .zero, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint(x: 1))
//        PolarCoord(angle: .ninety, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint(y: 1))
//        PolarCoord(angle: .oneEighty, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint(x: -1))
//        PolarCoord(angle: .twoSeventy, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint(y: -1))
//
//        PolarCoord(angle: .fortyFive, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint.unitLine)
//        PolarCoord(angle: .fortyFive + .ninety, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint.unitLine.negatedX)
//        PolarCoord(angle: .fortyFive + 2 * .ninety, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint.unitLine.negatedX.negatedY)
//        PolarCoord(angle: .fortyFive + 3 * .ninety, radius: 1.0).cartesianCoord.isAlmostEqual(CGPoint.unitLine.negatedY)
//
//        let xyEdgeLenPoint = CGPoint(xy: Triangle<CGFloat>.Right.hypot)
//        PolarCoord(angle: .fortyFive, radius: 2.0).cartesianCoord.isAlmostEqual(xyEdgeLenPoint)
//        PolarCoord(angle: .fortyFive + .ninety, radius: 2.0).cartesianCoord.isAlmostEqual(xyEdgeLenPoint.negatedX)
//        PolarCoord(angle: .fortyFive + 2 * .ninety, radius: 2.0).cartesianCoord.isAlmostEqual(xyEdgeLenPoint.negatedX.negatedY)
//        PolarCoord(angle: .fortyFive + 3 * .ninety, radius: 2.0).cartesianCoord.isAlmostEqual(xyEdgeLenPoint.negatedY)
//
//        // NB there's a CGVector! It uses Doubles not CGFloat.
//        // note this in the readme. My Vec2 is CGFloat so maybe worth keeping? Or CGVector just as nice? - no can't directly use.
//        //        let x: CGVector = CGPoint.zero  // <-- no compile
//    }
//
//    @Test("angle between", arguments: [
//        (Vec2(x: 0, y: 1), Vec2(x: 0, y: 1), Angle.zero),
//        (Vec2(x: -1, y: 0), Vec2(x: -1, y: 0), Angle.zero),
//        (Vec2(x: -0.5, y: 58), Vec2(x: -0.5, y: 58), Angle.zero),
//        (Vec2(x: 0, y: 1), Vec2(x: 1, y: 0), Angle.ninety),
//        (Vec2(x: 0, y: 1), Vec2(x: -1, y: 0), Angle.ninety),
//        (Vec2(x: 1, y: -1), Vec2(x: -1, y: 1), Angle.oneEighty),
//        (Vec2(x: 0.5, y: 58), Vec2(x: -0.5, y: -58), Angle.oneEighty)
//    ])
//    func test_angleBetween(vectorA: Vec2, vectorB: Vec2, expectedAngle: Angle) {
//        Angle.between(vector: vectorA, andVector: vectorB).isAlmostEqual(expectedAngle)
//    }
//
//    @Test("rotate point", arguments: [
//        (CGPoint(x: 1, y: 0), Angle.ninety, CGPoint(x: 0, y: 1)),
//        (CGPoint(x: 1, y: 0), Angle.oneEighty, CGPoint(x: -1, y: 0)),
//        (CGPoint(x: 1, y: 0), Angle.twoSeventy, CGPoint(x: 0, y: -1)),
//        //        // -90 is same as +270
//        (CGPoint(x: 1, y: 0), -Angle.ninety, CGPoint(x: 0, y: -1)),
//        //        // two 45 rotations = 90 degree rotation
////        (CGPoint(x: 1, y: 0).rotate(byAngle: Angle.fortyFive).rotate(byAngle: Angle.fortyFive) == CGPoint(x: 0, y: 1))
//        //
//        //        // 45 then -45 rotation = 0 degree rotation overall
////                #expect(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.fortyFive).rotate(byAngle: -Angle.fortyFive) == CGPoint(x: 1, y: 0))
//    ])
//    func test_rotateCGPoint(pointA: CGPoint, angle: Angle, expectedPoint: CGPoint) {
//        pointA.rotate(byAngle: angle).isAlmostEqual(expectedPoint)
//    }
//
    @Test("two rotations of point", arguments: [
//        // two 45 rotations = 90 degree rotation
        (CGPoint(x: 1, y: 0), Angle.fortyFive, Angle.fortyFive, CGPoint(x: 0, y: 1)),
        // 45 then -45 rotation = 0 degree rotation overall
        (CGPoint(x: 1, y: 0), Angle.fortyFive, -Angle.fortyFive, CGPoint(x: 1, y: 0)),
        (CGPoint(x: 1, y: 0), Angle.thirty, Angle.sixty, CGPoint(x: 0, y: 1))

    ])
    func test_rotateCGPointTwice(pointA: CGPoint, firstAngle: Angle, secondAngle: Angle, expectedPoint: CGPoint) {
        pointA.rotate(byAngle: firstAngle).rotate(byAngle: secondAngle).isAlmostEqual(expectedPoint)
    }

    @Test("vector projection .zero onto B is undefined", arguments: [
        // A vecs projected on .zero result in undefined
        Vec2(x: 11, y: -4),
        Vec2(x: 11, y: 4),
        Vec2(x: -11, y: -4),
        Vec2(x: -11, y: 4)
    ])
    func test_vectorProjectionAOntoZeroIsUndefined(vectorA: Vec2) {
        #expect(vectorA.projection(ontoVector: CGPoint.zero).isUndefined)
    }

    @Test("vector projection", arguments: [
        // zero sized A vecs projected onto vectors result in .zero
        (Vec2.zero, Vec2(x: 11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: 4), Vec2.zero),
//        // orth vecs result in .zero
        (Vec2(x: 4, y: -11), Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2(x: 4, y: -11), Vec2(x: -11, y: -4), Vec2.zero),
        (Vec2(x: -4, y: 11), Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2(x: -4, y: 11), Vec2(x: -11, y: -4), Vec2.zero),
        // the projection has vec a's length projected when b is smaller
        (Vec2(x: 1, y: 1), Vec2(y: 0.1), Vec2(y: 1)),
        // the projection has vec a's length projected when b is larger
        (Vec2(x: 1, y: 1), Vec2(y: 2), Vec2(y: 1)),
        // the projected vector is a negative mulitple of B when angle between them > 90
        (Vec2(x: -1, y: -1), Vec2(y: 3), Vec2(y: -1)),
        (Vec2(x: 1, y: -1), Vec2(y: 3), Vec2(y: -1)),
//        // the projected vector is a positive multiple of B when angle between them < 90
        (Vec2(x: -1, y: 1), Vec2(y: 4), Vec2(y: 1)),
        (Vec2(x: 1, y: 1), Vec2(y: 4), Vec2(y: 1)),
        (Vec2(x: -2, y: -3), Vec2(y: 5), Vec2(y: -3))
    ])
    func test_vectorProjectionX(vectorA: Vec2, vectorB: Vec2, expectedVector: Vec2) {
        vectorA.projection(ontoVector: vectorB).isAlmostEqual(expectedVector)
//
    }
//
//    // TODO put back
////    @Test("vectorProjectionForward", arguments: [
////        // zero sized A vecs have zero sized projection
////        (CGPoint.zero.projectionForward(ontoVector: Vec2(x: 11, y: -4)), Vec2.zero),
////        (CGPoint.zero.projectionForward(ontoVector: Vec2(x: 11, y: 4)), Vec2.zero),
////        (CGPoint.zero.projectionForward(ontoVector: Vec2(x: -11, y: 4)), Vec2.zero),
////        (CGPoint.zero.projectionForward(ontoVector: Vec2(x: -11, y: -4)), Vec2.zero),
////        // zero sized B vecs have undefined projection
//////        (CGPoint(x: 4, y: -11).projectionForward(ontoVector: .zero), CGPoint.undefined),
//////        (CGPoint(x: -4, y: 11).projectionForward(ontoVector: .zero), CGPoint.undefined),
//////        (CGPoint(x: -4, y: -11).projectionForward(ontoVector: .zero), CGPoint.undefined),
//////        (CGPoint(x: 4, y: 11).projectionForward(ontoVector: .zero), CGPoint.undefined)
////
////    ])
////    func test_vectorProjectionForward(vectorA: Vec2, vectorB: Vec2) {
////        vectorA.isAlmostEqual(vectorB)
//////
//////        // zero sized A vecs have zero sized projection
//////        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: 11, y: -4)) == .zero)
//////        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: 11, y: 4)) == .zero)
//////        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: -11, y: 4)) == .zero)
//////        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: -11, y: -4)) == .zero)
////
//////
//////        // orthogonal vecs have zero sized projection
//////        #expect(CGPoint(x: 4, y: -11).projectionForward(ontoVector: Vec2(x: 11, y: 4)) == .zero)
//////        #expect(CGPoint(x: 4, y: -11).projectionForward(ontoVector: Vec2(x: -11, y: -4)) == .zero)
//////        #expect(CGPoint(x: -4, y: 11).projectionForward(ontoVector: Vec2(x: 11, y: 4)) == .zero)
//////        #expect(CGPoint(x: -4, y: 11).projectionForward(ontoVector: Vec2(x: -11, y: -4)) == .zero)
//////
//////        // the projection has vec a's length projected when b is smaller
//////        #expect(CGPoint(x: 1, y: 1).projectionForward(ontoVector: Vec2(y: 0.1)) == Vec2(y: 1))
//////        // the projection has vec a's length projected when b is larger
//////        #expect(CGPoint(x: 1, y: 1).projectionForward(ontoVector: Vec2(y: 2)) == Vec2(y: 1))
//////
//////        // the projected vector is a positive mulitple of B when angle between them > 90
//////        #expect(CGPoint(x: -1, y: -1).projectionForward(ontoVector: Vec2(y: 3)) == Vec2(y: 1))
//////        #expect(CGPoint(x: 1, y: -1).projectionForward(ontoVector: Vec2(y: 3)) == Vec2(y: 1))
//////
//////        // the projected vector is a positive multiple of B when angle between them < 90
//////        #expect(CGPoint(x: -1, y: 1).projectionForward(ontoVector: Vec2(y: 4)) == Vec2(y: 1))
//////        #expect(CGPoint(x: 1, y: 1).projectionForward(ontoVector: Vec2(y: 4)) == Vec2(y: 1))
//////
//////        #expect(CGPoint(x: -2, y: -3).projectionForward(ontoVector: Vec2(y: 5)) == Vec2(y: 3))
////    }
//
////    
////    @Test
////    func test_vectorRejection() {
////        // zero sized A vecs have zero sized projection
////        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: 11, y: -4)) == .zero)
////        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: 11, y: 4)) == .zero)
////        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: -11, y: 4)) == .zero)
////        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: -11, y: -4)) == .zero)
////
////        // zero sized B vecs have undefined projection
////        assert(CGPoint(x: 4, y: -11).rejection(ontoVector: .zero).isUndefined)
////        assert(CGPoint(x: -4, y: 11).rejection(ontoVector: .zero).isUndefined)
////        assert(CGPoint(x: -4, y: -11).rejection(ontoVector: .zero).isUndefined)
////        assert(CGPoint(x: 4, y: 11).rejection(ontoVector: .zero).isUndefined)
////
////        // colinear vecs have zero sized rejection
////        #expect(CGPoint(x: 4, y: -11).rejection(ontoVector: Vec2(x: 4, y: -11)) == .zero)
////        #expect(CGPoint(x: -4, y: -11).rejection(ontoVector: Vec2(x: -4, y: -11)) == .zero)
////        #expect(CGPoint(x: 0, y: 10).rejection(ontoVector: Vec2(x: 0, y: 20)) == .zero)
////        #expect(CGPoint(x: 0, y: 10).rejection(ontoVector: Vec2(x: 0, y: -20)) == .zero)
////
////        // the rejection of A left of B --> A left of B
////        #expect(CGPoint(x: 2, y: 7).rejection(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//////        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
////
////        // the rejection of A right of B --> A right of B
////        #expect(CGPoint(x: 2, y: -7).rejection(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: -7))
//////        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
////
////        // sum of projection and orth project equals the original B vector
////        #expect(CGPoint(x: 2, y: 7).projection(ontoVector: Vec2(x: 5, y: 0))
////            + CGPoint(x: 2, y: 7).rejection(ontoVector: Vec2(x: 5, y: 0))
////                == CGPoint(x: 2, y: 7))
////
////        // when colinear: sum of projection and orth project equals the original B vector
////        #expect(CGPoint(x: -2, y: -7).projection(ontoVector: Vec2(x: -2, y: -7))
////            + CGPoint(x: -2, y: -7).rejection(ontoVector: Vec2(x: -2, y: -7))
////                == CGPoint(x: -2, y: -7))
////
////        // when orth: sum of projection and orth project equals the original B vector
////        #expect(CGPoint(x: -2, y: -7).projection(ontoVector: Vec2(x: 7, y: -2))
////            + CGPoint(x: -2, y: -7).rejection(ontoVector: Vec2(x: 7, y: -2))
////                == CGPoint(x: -2, y: -7))
////    }
////
////    @Test
////    func test_vectorRejectionLeft() {
////        // the rejection of A left of B --> A right of B
////        #expect(CGPoint(x: 2, y: 7).rejectionLeft(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//////        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
////
////        // the rejection of A right of B --> A left of B
////        #expect(CGPoint(x: 2, y: -7).rejectionLeft(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//////        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
////
////    }
////
////    // don't think this make sense
//////    func test_vectorPositiveOrthogonalProjection() {
//////        // zero a sized A vecs have zero sized projection
//////        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: -4)), .zero)
//////        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: 4)), .zero)
//////        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: 4)), .zero)
//////        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: -4)), .zero)
//////
//////        // zero a sized B vecs have undefined projection
//////        assert(CGPoint(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////        assert(CGPoint(x: -4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////        assert(CGPoint(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////        assert(CGPoint(x: 4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////
//////        // colinear vecs have zero sized orth projection
//////        #expect(CGPoint(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: 4, y: -11)), .zero)
//////        #expect(CGPoint(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: -4, y: -11)), .zero)
//////        #expect(CGPoint(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: 20)), .zero)
//////        #expect(CGPoint(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: -20)), .zero)
//////
//////        // the projected orth vector is to right of B
//////        #expect(CGPoint(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: 7))
//////        #expect(CGPoint(x: 2, y: -2).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
//////
//////        // sum of projection and orth project equals the original B vector
//////        #expect(CGPoint(x: 2, y: 7).projected(ontoVector: Vec2(x: 5, y: 0))
//////            + CGPoint(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)),
//////                    CGPoint(x: 2, y: 7))
//////
//////        // when colinear: sum of projection and orth project equals the original B vector
//////        #expect(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: -2, y: -7))
//////            + CGPoint(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: -2, y: -7)),
//////                    CGPoint(x: -2, y: -7))
//////
//////        // when orth: sum of projection and orth project equals the original B vector
//////        #expect(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: 7, y: -2))
//////            + CGPoint(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 7, y: -2)),
//////                    CGPoint(x: -2, y: -7))
//////    }
////
////    @Test
////    func test_vectorRotate180() {
////        #expect(CGPoint.zero.rotated180 == .zero)
////
////        #expect(CGPoint(x: 3).rotated180 == CGPoint(x: -3))
////        #expect(CGPoint(x: -3).rotated180 == CGPoint(x: 3))
////
////        #expect(CGPoint(y: 3).rotated180 == CGPoint(y: -3))
////        #expect(CGPoint(y: -3).rotated180 == CGPoint(y: 3))
////
////        #expect(CGPoint(x: -2, y: 3).rotated180 == CGPoint(x: 2, y: -3))
////        #expect(CGPoint(x: 2, y: -3).rotated180 == CGPoint(x: -2, y: 3))
////    }
////
////    @Test
////    func test_vectorRotate90CW() {
////        #expect(CGPoint.zero.rotated90CW == .zero)
////
////        #expect(CGPoint(x: 3).rotated90CCW == CGPoint(y: 3))
////        #expect(CGPoint(y: 3.2).rotated90CCW == CGPoint(x: -3.2))
////        #expect(CGPoint(x: -3.2).rotated90CCW == CGPoint(y: -3.2))
////        #expect(CGPoint(y: -3.2).rotated90CCW == CGPoint(x: 3.2))
////    }
////
////    @Test
////    func test_vectorRotate90CCW() {
////        #expect(CGPoint.zero.rotated90CCW == .zero)
////
////        #expect(CGPoint(x: 3.2).rotated90CW == CGPoint(y: -3.2))
////        #expect(CGPoint(y: -3.2).rotated90CW == CGPoint(x: -3.2))
////        #expect(CGPoint(x: -3.2).rotated90CW == CGPoint(y: 3.2))
////        #expect(CGPoint(y: 3.2).rotated90CW == CGPoint(x: 3.2))
////    }
////
////    @Test
////    func test_isToSide_forZeroAndZero() {
////        // (zero, zero) calls give false left and false right
////        assert(!CGPoint.zero.isToLeft(ofVector: .zero))
////        assert(!CGPoint.zero.isToRight(ofVector: .zero))
////    }
////
////    @Test
////    func test_isToSide_forZeroAndVector() {
////        // (zero, <some vec>) calls give false left and false right
////        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(x: 1)))
////        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(x: -1)))
////        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(x: 1)))
////        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(x: -1)))
////
////        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(y: 2.2)))
////        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(y: -2.2)))
////        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(y: 1.9)))
////        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(y: -1.9)))
////    }
////
////    @Test
////    func test_isToSide_forVectorAndZero() {
////        // (<some vec>, zero) calls give false left and false right
////        #expect(!CGPoint(x: 1).isToLeft(ofVector: CGPoint.zero))
////        #expect(!CGPoint(x: -1).isToLeft(ofVector: CGPoint.zero))
////        #expect(!CGPoint(y: 1).isToLeft(ofVector: CGPoint.zero))
////        #expect(!CGPoint(y: -1).isToLeft(ofVector: CGPoint.zero))
////
////        #expect(!CGPoint(x: 1).isToRight(ofVector: CGPoint.zero))
////        #expect(!CGPoint(x: -1).isToRight(ofVector: CGPoint.zero))
////        #expect(!CGPoint(y: 1).isToRight(ofVector: CGPoint.zero))
////        #expect(!CGPoint(y: -1).isToRight(ofVector: CGPoint.zero))
////    }
////
////    @Test
////    func test_isToSide_forSameVector() {
////        // same value for both vecs always gives false left and false right
////        #expect(!CGPoint(x: 1).isToLeft(ofVector: CGPoint(x: 1)))
////        #expect(!CGPoint(x: -1).isToLeft(ofVector: CGPoint(x: -1)))
////        #expect(!CGPoint(y: 1).isToLeft(ofVector: CGPoint(y: 1)))
////        #expect(!CGPoint(y: -1).isToLeft(ofVector: CGPoint(y: -1)))
////
////        #expect(!CGPoint(x: 1).isToRight(ofVector: CGPoint(x: 1)))
////        #expect(!CGPoint(x: 1).isToRight(ofVector: CGPoint(x: 1)))
////        #expect(!CGPoint(y: -3).isToRight(ofVector: CGPoint(y: -3)))
////        #expect(!CGPoint(y: -3).isToRight(ofVector: CGPoint(y: -3)))
////    }
////
////    @Test
////    func test_isToLeft() {
////        #expect(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 1)))
////        #expect(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 0.001)))
////        #expect(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 100)))
////
////        #expect(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 1)))
////        #expect(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 0.001)))
////        #expect(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 100)))
////
////        #expect(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -1)))
////        #expect(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -0.001)))
////        #expect(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -100)))
////
////        #expect(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -1)))
////        #expect(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -0.001)))
////        #expect(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -100)))
////    }
////
////    @Test
////    func test_isToRight() {
////        #expect(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 1)))
////        #expect(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 0.001)))
////        #expect(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 100)))
////
////        #expect(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 1)))
////        #expect(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 0.001)))
////        #expect(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 100)))
////
////        #expect(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -1)))
////        #expect(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -0.001)))
////        #expect(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -100)))
////
////        #expect(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -1)))
////        #expect(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -0.001)))
////        #expect(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -100)))
////    }
////
////    @Test
////    func test_isSameDirection() {
////        #expect(!CGPoint.zero.isSameDirection(asVector: .zero))
////        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: .zero))
////        #expect(!CGPoint.zero.isSameDirection(asVector: CGPoint(x: 1, y: 1)))
////
////        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: -1, y: 1)))
////        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: 1, y: -1)))
////
////        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: -1.1, y: 1)))
////        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: 1, y: -1.1)))
////
////        #expect(CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: -0.95, y: 1)))
////        #expect(CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: 1, y: -0.95)))
////    }
////
////    @Test
////    func test_isOppositeDirection() {
////        #expect(!CGPoint.zero.isOppositeDirection(asVector: .zero))
////        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: .zero))
////        #expect(!CGPoint.zero.isOppositeDirection(asVector: CGPoint(x: 1, y: 1)))
////
////        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: -1, y: 1)))
////        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: 1, y: -1)))
////
////        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: -0.95, y: 1)))
////        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: 1, y: -0.95)))
////
////        #expect(CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: -1.1, y: 1)))
////        #expect(CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: 1, y: -1.1)))
////    }
////
////    @Test
////    func test_quadrant() {
////        #expect(Vec2(y: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
////        #expect(Vec2(x: 1, y: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
////        #expect(Vec2(x: 99, y: 0.1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
////
////        // what about the edge cases? that lie on two quadrants?
////        // this is neither NE or SE.
////        // make a strict quadrant?
////        // or just have default 'quadrant' impl pref north, and right?
////        // ^^ latter part is what happens now.
////        // this tests that:
////        #expect(Vec2(x: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
////        #expect(Vec2(y: -1).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
////        #expect(Vec2(x: -1).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
////
////        #expect(Vec2(x: 2, y: -0.01).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
////        #expect(Vec2(x: 0.001, y: -100).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
////
////        #expect(Vec2(x: -0.001, y: -100).quadrant(referenceVector: Vec2(y: 1)) == .southWest)
////        #expect(Vec2(x: -200, y: -0.01).quadrant(referenceVector: Vec2(y: 1)) == .southWest)
////
////        #expect(Vec2(x: -200, y: 0.01).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
////        #expect(Vec2(x: -0.01, y: 0.98).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
////    }
////
////    // use CGVector!
////    @Test
////    func test_rotate() {
////        #expect(Vec2(x: 1).rotate(byVector: Vec2(y: 1)) == CGPoint(x: 1))
////        #expect(Vec2(y: 1).rotate(byVector: Vec2(y: 1)) == CGPoint(y: 1))
////        #expect(Vec2(x: -1).rotate(byVector: Vec2(y: 1)) == CGPoint(x: -1))
////        #expect(Vec2(y: -1).rotate(byVector: Vec2(y: 1)) == CGPoint(y: -1))
////
////        #expect(Vec2(x: 1).rotate(byVector: Vec2(y: -1)) == CGPoint(x: -1))
////        #expect(Vec2(y: 1).rotate(byVector: Vec2(y: -1)) == CGPoint(y: -1))
////        #expect(Vec2(x: -1).rotate(byVector: Vec2(y: -1)) == CGPoint(x: 1))
////        #expect(Vec2(y: -1).rotate(byVector: Vec2(y: -1)) == CGPoint(y: 1))
////
////        #expect(Vec2(x: 1).rotate(byVector: Vec2(x: 1)) == CGPoint(y: -1))
////
//////        #expect(Vec2(x: 1).rotate(byVector: Vec2(x: 1)) == CGPoint(y: -1))
//////        #expect(CGPoint(x: 1) == Vec2(x: 0.5.squareRoot()).rotate(byVector: Vec2(x: 0.5.squareRoot())))
//////        #expect(CGPoint.zero == Vec2(x: 0.5.squareRoot()).rotate(byVector: Vec2(x: -0.5.squareRoot())))
//////        #expect(CGPoint(x: -1) == Vec2(x: 1).rotate(byVector: Vec2(y: 0.1)))
////    }
////
////    // TODO do lazy calc props so that things not calc mult times if used multiple times?
////    // TODO add generic or similar for notion of unit vector -- which can then
////    // have simpler calculations in specialisations (as we know it's a unit already)
}




// BUMPH

////        Int(1).magnitude // ok
////        //        Int(1).magnitudeSquared // not found
////        Double(4.0).magnitudeSquared
////        Float(4.0).magnitudeSquared


//
//        // M_PI_2 -- see def and comments around that!
//        //        M_PI_2
//        // e.g.:
//        //@available(swift, deprecated: 3.0, message: "Please use 'Double.pi' or '.pi' to get the value of correct type and avoid casting.")
//        //        public var M_PI: Double
//        //
//        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
//        //        @available(swift, deprecated: 3.0, message: "Please use 'Double.pi / 2' or '.pi / 2' to get the value of correct type and avoid casting.")
//        //        public var M_PI_2: Double
//        //
//        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
//        //        @available(swift, deprecated: 3.0, message: "Please use 'Double.pi / 4' or '.pi / 4' to get the value of correct type and avoid casting.")
//        //        public var M_PI_4: Double
//        //
//        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
//        //        @available(swift, deprecated: 3.0, message: "Please use '2.squareRoot()'.")
//        //        public var M_SQRT2: Double
//        //
//        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
//        //        @available(swift, deprecated: 3.0, message: "Please use '0.5.squareRoot()'.")
//        //        public var M_SQRT1_2: Double
//

