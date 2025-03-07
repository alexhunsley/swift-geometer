import Foundation
import SwiftGeometer
import SwiftUI

import Testing

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

    @Test
    func test_whenAccessingConstants_thenCorrectValuesFound() {
        #expect(Double.pi == 3.141592653589793)
        #expect(Double.pi2 == 1.5707963267948966)
        #expect(Double.pi4 == 0.7853981633974483)
        #expect(Double.pi8 == 0.39269908169872414)
        #expect(Double.tau == 6.283185307179586)
        #expect(Double.tau2 == 3.141592653589793)
        #expect(Double.tau3 == 2.0943951023931953)
        #expect(Double.tau4 == 1.5707963267948966)
        #expect(Double.tau8 == 0.7853981633974483)

        // Float
        #expect(Float.pi == 3.1415926)
        #expect(Float.pi2 == 1.5707963)
        #expect(Float.pi4 == 0.78539815)
        #expect(Float.pi8 == 0.392699075)
        #expect(Float.tau == 6.2831852)
        #expect(Float.tau2 == 3.1415926)
        #expect(Float.tau3 == 2.094395)
        #expect(Float.tau4 == 1.5707963)
        #expect(Float.tau8 == 0.78539815)

        // CGFloat
        #expect(CGFloat.pi == 3.141592653589793)
        #expect(CGFloat.pi2 == 1.5707963267948966)
        #expect(CGFloat.pi4 == 0.7853981633974483)
        #expect(CGFloat.pi8 == 0.39269908169872414)
        #expect(CGFloat.tau == 6.283185307179586)
        #expect(CGFloat.tau2 == 3.141592653589793)
        #expect(CGFloat.tau3 == 2.0943951023931953)
        #expect(CGFloat.tau4 == 1.5707963267948966)
        #expect(CGFloat.tau8 == 0.7853981633974483)
    }

    @Test
    func test_whenUsingCGPointArithmeticHelpers_thenCorrectValuesFound() {
        assert(CGPoint(x: 1.0, y: -2.0) / 2.0 == CGPoint(x: 0.5, y: -1.0))
        assert(CGPoint(x: 1.0, y: -2.0) / -2.0 == CGPoint(x: -0.5, y: 1.0))

        assert(CGPoint(x: -1.0, y: 2.0) * 2.0 == CGPoint(x: -2.0, y: 4.0))
        assert(CGPoint(x: -1.0, y: 2.0) * -2.0 == CGPoint(x: 2.0, y: -4.0))

        assert(CGPoint(x: -1.0, y: 2.0) + CGPoint(x: 0.2, y: 0.3) == CGPoint(x: -0.8, y: 2.3))
        assert(CGPoint(x: -1.0, y: 2.0) - CGPoint(x: 0.2, y: 0.3) == CGPoint(x: -1.2, y: 1.7))
        assert(-CGPoint(x: -1.0, y: 2.0) - CGPoint(x: 0.2, y: 0.3) == CGPoint(x: 0.8, y: -2.3))

        assert(-CGPoint(x: 11.2, y: -15.9) == CGPoint(x: -11.2, y: 15.9))
        assert(-(-CGPoint(x: 11.2, y: -15.9)) == CGPoint(x: 11.2, y: -15.9))
        assert(-(-(-CGPoint(x: 11.2, y: -15.9))) == CGPoint(x: -11.2, y: 15.9))
    }

    @Test
    func test_whenUsingTriangleHelpers_thenCorrectValuesFound() {
        // Double
        #expect(Triangle.HalfEquilateral.hypot == Double(2))
        #expect(Triangle.HalfEquilateral.largerAngle == Double(60))
        #expect(Triangle.HalfEquilateral.smallerAngle == Double(30))

        // Float
        #expect(Triangle.HalfEquilateral.hypot == Float(2))
        #expect(Triangle.HalfEquilateral.largerAngle == Float(60))
        #expect(Triangle.HalfEquilateral.smallerAngle == Float(30))

        // CGFloat
        #expect(Triangle.HalfEquilateral.hypot == CGFloat(2))
        #expect(Triangle.HalfEquilateral.largerAngle == CGFloat(60))
        #expect(Triangle.HalfEquilateral.smallerAngle == CGFloat(30))

        #expect(Triangle.cos0 == 1)
    }

    @Test
    func test_whenUsingVec2Typealias_thenItIsInterchangableWithCGPoint() {
        assert(Vec2(x: 1.0, y: -2.0) / 2.0 == CGPoint(x: 0.5, y: -1.0))
        assert(Vec2(x: -1.0, y: 2.0) + CGPoint(x: 0.2, y: 0.3) == Vec2(x: -0.8, y: 2.3))
    }

    @Test
    func test_whenUsingAngleArithmeticHelpers_thenCorrectValuesFound() {
        #expect(1.5 * Angle(degrees: -80) == Angle(degrees: -120))
        #expect(1.5 * -Angle(degrees: -80) == Angle(degrees: 120))
        #expect(-1.5 * -Angle(degrees: -80) == Angle(degrees: -120))
        #expect(Angle(degrees: -80) * 2 == Angle(degrees: -160))
        #expect(Angle(degrees: 80) / 2 == Angle(degrees: 40))
        #expect(Angle(degrees: 50) + Angle(degrees: 20) == Angle(degrees: 70))
        #expect(Angle(degrees: 50) - Angle(degrees: 20) == Angle(degrees: 30))
        #expect(Angle(degrees: 20) + Angle(degrees: 50) == Angle(degrees: 70))
        #expect(Angle(degrees: 20) - Angle(degrees: 50) == Angle(degrees: -30))
    }

    @Test
    func test_whenUsingAnglePolarToCartesian_thenCorrectValuesFound() {
        // plain angle and radius to coordinate
        #expect(Angle(degrees: 0).coordinate(withRadius: 1.0) == CGPoint(x: 1, y: 0))
        #expect(Angle(degrees: 90).coordinate(withRadius: 1.0) == CGPoint(x: 0, y: 1))
        #expect(Angle(degrees: 180).coordinate(withRadius: 1.0) == CGPoint(x: -1, y: 0))
        #expect(Angle(degrees: 270).coordinate(withRadius: 1.0) == CGPoint(x: 0, y: -1))

        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5) == CGPoint(x: 2.5, y: 0))
        #expect(Angle(degrees: 90).coordinate(withRadius: 2.5) == CGPoint(x: 0, y: 2.5))
        #expect(Angle(degrees: 180).coordinate(withRadius: 2.5) == CGPoint(x: -2.5, y: 0))
        #expect(Angle(degrees: 270).coordinate(withRadius: 2.5) == CGPoint(x: 0, y: -2.5))

        // M_PI_2 -- see def and comments around that!
        //        M_PI_2
        // e.g.:
        //@available(swift, deprecated: 3.0, message: "Please use 'Double.pi' or '.pi' to get the value of correct type and avoid casting.")
        //        public var M_PI: Double
        //
        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
        //        @available(swift, deprecated: 3.0, message: "Please use 'Double.pi / 2' or '.pi / 2' to get the value of correct type and avoid casting.")
        //        public var M_PI_2: Double
        //
        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
        //        @available(swift, deprecated: 3.0, message: "Please use 'Double.pi / 4' or '.pi / 4' to get the value of correct type and avoid casting.")
        //        public var M_PI_4: Double
        //
        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
        //        @available(swift, deprecated: 3.0, message: "Please use '2.squareRoot()'.")
        //        public var M_SQRT2: Double
        //
        //        @available(macOS 10.9, iOS 7.0, watchOS 2.0, tvOS 9.0, bridgeOS 7.0, visionOS 1.0, *)
        //        @available(swift, deprecated: 3.0, message: "Please use '0.5.squareRoot()'.")
        //        public var M_SQRT1_2: Double

        Int(1).magnitude // ok
        //        Int(1).magnitudeSquared // not found
        Double(4.0).magnitudeSquared
        Float(4.0).magnitudeSquared

        // "ambiguous use of .pi":
        //        Found this candidate in module 'Swift' (Swift.Float16)
        //        Found this candidate in module 'Swift' (Swift.Float)
        //        Found this candidate in module 'Swift' (Swift.Double)
        //        Found this candidate in module 'Foundation' (Foundation.Decimal)
        //        Found this candidate in module 'CoreFoundation' (CoreFoundation.CGFloat)
        //        let x = .pi/2 // bad
        let _: Float16 = .pi/2 // ok

        // so need to rethink what I've re-implemend or not!
        // e.g. tau would be nice to offer as that's not offered.

        // angleOffset
        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: Angle(radians: Double.pi2)) == CGPoint(x: 0, y: 2.5))
        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: Angle(radians: Double.pi4)) == CGPoint(x: 1.76776, y: 1.76776))

        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: Angle.ninety) == CGPoint(x: 0, y: 2.5))
        #expect(Angle(degrees: 90).coordinate(withRadius: 2.5, angleOffset: Angle.ninety) == CGPoint(x: -2.5, y: 0))
        #expect(Angle(degrees: 180).coordinate(withRadius: 2.5, angleOffset: Angle.ninety) == CGPoint(x: 0, y: -2.5))
        #expect(Angle(degrees: 270).coordinate(withRadius: 2.5, angleOffset: Angle.ninety) == CGPoint(x: 2.5, y: 0))

        #expect(Angle(degrees: 90).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety) == CGPoint(x: 2.5, y: 0))
        #expect(Angle(degrees: 180).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety) == CGPoint(x: 0, y: 2.5))
        #expect(Angle(degrees: 270).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety) == CGPoint(x: -2.5, y: 0))
        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety) == CGPoint(x: 0, y: -2.5))

        // fromPoint
        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(x: 1, y: -5)) == CGPoint(x: 3.5, y: -5))

        // angleOffset and fromPoint (rename to centrePoint?)
        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(xy: 1), angleOffset: Angle(radians: Double.pi2)) == CGPoint(x: 1, y: 3.5))
        #expect(Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(xy: 1), angleOffset: Angle(radians: Double.pi4)) == CGPoint(x: 2.76776, y: 2.76776))

        // Angle operators
        #expect(1.5 * -Angle(degrees: -80) == Angle(degrees: 120))
        #expect(-1.5 * -Angle(degrees: -80) == Angle(degrees: -120))
        #expect(Angle(degrees: -80) * 2 == Angle(degrees: -160))
        #expect(Angle(degrees: 80) / 2 == Angle(degrees: 40))
        #expect(Angle(degrees: 50) + Angle(degrees: 20) == Angle(degrees: 70))
        #expect(Angle(degrees: 50) - Angle(degrees: 20) == Angle(degrees: 30))
        #expect(Angle(degrees: 20) + Angle(degrees: 50) == Angle(degrees: 70))
        #expect(Angle(degrees: 20) - Angle(degrees: 50) == Angle(degrees: -30))
    }

    @Test
    func test_constants() {
        #expect(Triangle.cos0 == Angle(degrees: 0).cos)
        #expect(Triangle.cos30 == Angle(degrees: 30).cos)
        #expect(Triangle.cos60 == Angle(degrees: 60).cos)
        #expect(Triangle.cos90 == Angle(degrees: 90).cos)
        #expect(Triangle.cos45 == Angle(degrees: 45).cos)

        #expect(Triangle.sin0 == Angle(degrees: 0).sin)
        #expect(Triangle.sin30 == Angle(degrees: 30).sin)
        #expect(Triangle.sin60 == Angle(degrees: 60).sin)
        #expect(Triangle.sin90 == Angle(degrees: 90).sin)
        #expect(Triangle.sin45 == Angle(degrees: 45).sin)
    }

    @Test
    func test_CGPointInitHelpers() {
        #expect(CGPoint(x: 2.3) == CGPoint(x: 2.3, y: 0))
        #expect(CGPoint(y: -7.12) == CGPoint(x: 0, y: -7.12))
    }

    @Test
    func test_polarConversion() {
        #expect(PolarCoord(angle: .zero, radius: 1.0).cartesianCoord == CGPoint(x: 1))
        #expect(PolarCoord(angle: .ninety, radius: 1.0).cartesianCoord == CGPoint(y: 1))
        #expect(PolarCoord(angle: .oneEighty, radius: 1.0).cartesianCoord == CGPoint(x: -1))
        #expect(PolarCoord(angle: .twoSeventy, radius: 1.0).cartesianCoord == CGPoint(y: -1))

        #expect(PolarCoord(angle: .fortyFive, radius: 1.0).cartesianCoord == CGPoint.unitLine)
        #expect(PolarCoord(angle: .fortyFive + .ninety, radius: 1.0).cartesianCoord == CGPoint.unitLine.negatedX)
        #expect(PolarCoord(angle: .fortyFive + 2 * .ninety, radius: 1.0).cartesianCoord == CGPoint.unitLine.negatedX.negatedY)
        #expect(PolarCoord(angle: .fortyFive + 3 * .ninety, radius: 1.0).cartesianCoord == CGPoint.unitLine.negatedY)

        let xyEdgeLenPoint = CGPoint(xy: Triangle<CGFloat>.Right.hypot)
        #expect(PolarCoord(angle: .fortyFive, radius: 2.0).cartesianCoord == xyEdgeLenPoint)
        #expect(PolarCoord(angle: .fortyFive + .ninety, radius: 2.0).cartesianCoord == xyEdgeLenPoint.negatedX)
        #expect(PolarCoord(angle: .fortyFive + 2 * .ninety, radius: 2.0).cartesianCoord == xyEdgeLenPoint.negatedX.negatedY)
        #expect(PolarCoord(angle: .fortyFive + 3 * .ninety, radius: 2.0).cartesianCoord == xyEdgeLenPoint.negatedY)

        // NB there's a CGVector! It uses Doubles not CGFloat.
        // note this in the readme. My Vec2 is CGFloat so maybe worth keeping? Or CGVector just as nice? - no can't directly use.
        //        let x: CGVector = CGPoint.zero  // <-- no compile
    }

    @Test
    func test_angleBetween() {
        #expect(Angle.between(vector: Vec2(x: 0, y: 1), andVector: Vec2(x: 0, y: 1)) == Angle.zero)
        #expect(Angle.between(vector: Vec2(x: -1, y: 0), andVector: Vec2(x: -1, y: 0)) == Angle.zero)
        #expect(Angle.between(vector: Vec2(x: -0.5, y: 58), andVector: Vec2(x: -0.5, y: 58)) == Angle.zero)

        #expect(Angle.between(vector: Vec2(x: 0, y: 1), andVector: Vec2(x: 1, y: 0)) == Angle.ninety)
        #expect(Angle.between(vector: Vec2(x: 0, y: 1), andVector: Vec2(x: -1, y: 0)) == Angle.ninety)
        #expect(Angle.between(vector: Vec2(x: 1, y: -1), andVector: Vec2(x: -1, y: 1)) == Angle.oneEighty)
        #expect(Angle.between(vector: Vec2(x: 0.5, y: 58), andVector: Vec2(x: -0.5, y: -58)) == Angle.oneEighty)
    }

    @Test
    func test_rotateCGPoint() {
        #expect(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.ninety) == CGPoint(x: 0, y: 1))
        #expect(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.oneEighty) == CGPoint(x: -1, y: 0))
        #expect(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.twoSeventy) == CGPoint(x: 0, y: -1))
        // -90 is same as +270
        #expect(CGPoint(x: 1, y: 0).rotate(byAngle: -Angle.ninety) == CGPoint(x: 0, y: -1))

        // two 45 rotations = 90 degree rotation
        #expect(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.fortyFive).rotate(byAngle: Angle.fortyFive) == CGPoint(x: 0, y: 1))

        // 45 then -45 rotation = 0 degree rotation overall
        #expect(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.fortyFive).rotate(byAngle: -Angle.fortyFive) == CGPoint(x: 1, y: 0))

    }

    @Test
    func test_vectorProjection() {
        // zero sized A vecs have zero sized projection
        #expect(CGPoint.zero.projection(ontoVector: Vec2(x: 11, y: -4)) == .zero)
        #expect(CGPoint.zero.projection(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint.zero.projection(ontoVector: Vec2(x: -11, y: 4)) == .zero)
        #expect(CGPoint.zero.projection(ontoVector: Vec2(x: -11, y: -4)) == .zero)

        // zero sized B vecs have undefined projection
        assert(CGPoint(x: 4, y: -11).projection(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: 11).projection(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: -11).projection(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: 4, y: 11).projection(ontoVector: .zero).isUndefined)

        // orthogonal vecs have zero sized projection
        #expect(CGPoint(x: 4, y: -11).projection(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint(x: 4, y: -11).projection(ontoVector: Vec2(x: -11, y: -4)) == .zero)
        #expect(CGPoint(x: -4, y: 11).projection(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint(x: -4, y: 11).projection(ontoVector: Vec2(x: -11, y: -4)) == .zero)

        // the projection has vec a's length projected when b is smaller
        #expect(CGPoint(x: 1, y: 1).projection(ontoVector: Vec2(y: 0.1)) == Vec2(y: 1))
        // the projection has vec a's length projected when b is larger
        #expect(CGPoint(x: 1, y: 1).projection(ontoVector: Vec2(y: 2)) == Vec2(y: 1))

        // the projected vector is a negative mulitple of B when angle between them > 90
        #expect(CGPoint(x: -1, y: -1).projection(ontoVector: Vec2(y: 3)) == Vec2(y: -1))
        #expect(CGPoint(x: 1, y: -1).projection(ontoVector: Vec2(y: 3)) == Vec2(y: -1))

        // the projected vector is a positive multiple of B when angle between them < 90
        #expect(CGPoint(x: -1, y: 1).projection(ontoVector: Vec2(y: 4)) == Vec2(y: 1))
        #expect(CGPoint(x: 1, y: 1).projection(ontoVector: Vec2(y: 4)) == Vec2(y: 1))

        #expect(CGPoint(x: -2, y: -3).projection(ontoVector: Vec2(y: 5)) == Vec2(y: -3))
    }

    @Test
    func test_vectorProjectionForward() {
        // zero sized A vecs have zero sized projection
        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: 11, y: -4)) == .zero)
        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: -11, y: 4)) == .zero)
        #expect(CGPoint.zero.projectionForward(ontoVector: Vec2(x: -11, y: -4)) == .zero)

        // zero sized B vecs have undefined projection
        assert(CGPoint(x: 4, y: -11).projectionForward(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: 11).projectionForward(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: -11).projectionForward(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: 4, y: 11).projectionForward(ontoVector: .zero).isUndefined)

        // orthogonal vecs have zero sized projection
        #expect(CGPoint(x: 4, y: -11).projectionForward(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint(x: 4, y: -11).projectionForward(ontoVector: Vec2(x: -11, y: -4)) == .zero)
        #expect(CGPoint(x: -4, y: 11).projectionForward(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint(x: -4, y: 11).projectionForward(ontoVector: Vec2(x: -11, y: -4)) == .zero)

        // the projection has vec a's length projected when b is smaller
        #expect(CGPoint(x: 1, y: 1).projectionForward(ontoVector: Vec2(y: 0.1)) == Vec2(y: 1))
        // the projection has vec a's length projected when b is larger
        #expect(CGPoint(x: 1, y: 1).projectionForward(ontoVector: Vec2(y: 2)) == Vec2(y: 1))

        // the projected vector is a positive mulitple of B when angle between them > 90
        #expect(CGPoint(x: -1, y: -1).projectionForward(ontoVector: Vec2(y: 3)) == Vec2(y: 1))
        #expect(CGPoint(x: 1, y: -1).projectionForward(ontoVector: Vec2(y: 3)) == Vec2(y: 1))

        // the projected vector is a positive multiple of B when angle between them < 90
        #expect(CGPoint(x: -1, y: 1).projectionForward(ontoVector: Vec2(y: 4)) == Vec2(y: 1))
        #expect(CGPoint(x: 1, y: 1).projectionForward(ontoVector: Vec2(y: 4)) == Vec2(y: 1))

        #expect(CGPoint(x: -2, y: -3).projectionForward(ontoVector: Vec2(y: 5)) == Vec2(y: 3))
    }

    @Test
    func test_vectorRejection() {
        // zero sized A vecs have zero sized projection
        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: 11, y: -4)) == .zero)
        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: 11, y: 4)) == .zero)
        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: -11, y: 4)) == .zero)
        #expect(CGPoint.zero.rejection(ontoVector: Vec2(x: -11, y: -4)) == .zero)

        // zero sized B vecs have undefined projection
        assert(CGPoint(x: 4, y: -11).rejection(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: 11).rejection(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: -11).rejection(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: 4, y: 11).rejection(ontoVector: .zero).isUndefined)

        // colinear vecs have zero sized rejection
        #expect(CGPoint(x: 4, y: -11).rejection(ontoVector: Vec2(x: 4, y: -11)) == .zero)
        #expect(CGPoint(x: -4, y: -11).rejection(ontoVector: Vec2(x: -4, y: -11)) == .zero)
        #expect(CGPoint(x: 0, y: 10).rejection(ontoVector: Vec2(x: 0, y: 20)) == .zero)
        #expect(CGPoint(x: 0, y: 10).rejection(ontoVector: Vec2(x: 0, y: -20)) == .zero)

        // the rejection of A left of B --> A left of B
        #expect(CGPoint(x: 2, y: 7).rejection(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))

        // the rejection of A right of B --> A right of B
        #expect(CGPoint(x: 2, y: -7).rejection(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: -7))
//        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))

        // sum of projection and orth project equals the original B vector
        #expect(CGPoint(x: 2, y: 7).projection(ontoVector: Vec2(x: 5, y: 0))
            + CGPoint(x: 2, y: 7).rejection(ontoVector: Vec2(x: 5, y: 0))
                == CGPoint(x: 2, y: 7))

        // when colinear: sum of projection and orth project equals the original B vector
        #expect(CGPoint(x: -2, y: -7).projection(ontoVector: Vec2(x: -2, y: -7))
            + CGPoint(x: -2, y: -7).rejection(ontoVector: Vec2(x: -2, y: -7))
                == CGPoint(x: -2, y: -7))

        // when orth: sum of projection and orth project equals the original B vector
        #expect(CGPoint(x: -2, y: -7).projection(ontoVector: Vec2(x: 7, y: -2))
            + CGPoint(x: -2, y: -7).rejection(ontoVector: Vec2(x: 7, y: -2))
                == CGPoint(x: -2, y: -7))
    }

    @Test
    func test_vectorRejectionLeft() {
        // the rejection of A left of B --> A right of B
        #expect(CGPoint(x: 2, y: 7).rejectionLeft(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))

        // the rejection of A right of B --> A left of B
        #expect(CGPoint(x: 2, y: -7).rejectionLeft(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//        #expect(CGPoint(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))

    }

    // don't think this make sense
//    func test_vectorPositiveOrthogonalProjection() {
//        // zero a sized A vecs have zero sized projection
//        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: -4)), .zero)
//        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: 4)), .zero)
//        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: 4)), .zero)
//        #expect(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: -4)), .zero)
//
//        // zero a sized B vecs have undefined projection
//        assert(CGPoint(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//        assert(CGPoint(x: -4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//        assert(CGPoint(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//        assert(CGPoint(x: 4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//
//        // colinear vecs have zero sized orth projection
//        #expect(CGPoint(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: 4, y: -11)), .zero)
//        #expect(CGPoint(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: -4, y: -11)), .zero)
//        #expect(CGPoint(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: 20)), .zero)
//        #expect(CGPoint(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: -20)), .zero)
//
//        // the projected orth vector is to right of B
//        #expect(CGPoint(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: 7))
//        #expect(CGPoint(x: 2, y: -2).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
//
//        // sum of projection and orth project equals the original B vector
//        #expect(CGPoint(x: 2, y: 7).projected(ontoVector: Vec2(x: 5, y: 0))
//            + CGPoint(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)),
//                    CGPoint(x: 2, y: 7))
//
//        // when colinear: sum of projection and orth project equals the original B vector
//        #expect(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: -2, y: -7))
//            + CGPoint(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: -2, y: -7)),
//                    CGPoint(x: -2, y: -7))
//
//        // when orth: sum of projection and orth project equals the original B vector
//        #expect(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: 7, y: -2))
//            + CGPoint(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 7, y: -2)),
//                    CGPoint(x: -2, y: -7))
//    }

    @Test
    func test_vectorRotate180() {
        #expect(CGPoint.zero.rotated180 == .zero)

        #expect(CGPoint(x: 3).rotated180 == CGPoint(x: -3))
        #expect(CGPoint(x: -3).rotated180 == CGPoint(x: 3))

        #expect(CGPoint(y: 3).rotated180 == CGPoint(y: -3))
        #expect(CGPoint(y: -3).rotated180 == CGPoint(y: 3))

        #expect(CGPoint(x: -2, y: 3).rotated180 == CGPoint(x: 2, y: -3))
        #expect(CGPoint(x: 2, y: -3).rotated180 == CGPoint(x: -2, y: 3))
    }

    @Test
    func test_vectorRotate90CW() {
        #expect(CGPoint.zero.rotated90CW == .zero)

        #expect(CGPoint(x: 3).rotated90CCW == CGPoint(y: 3))
        #expect(CGPoint(y: 3.2).rotated90CCW == CGPoint(x: -3.2))
        #expect(CGPoint(x: -3.2).rotated90CCW == CGPoint(y: -3.2))
        #expect(CGPoint(y: -3.2).rotated90CCW == CGPoint(x: 3.2))
    }

    @Test
    func test_vectorRotate90CCW() {
        #expect(CGPoint.zero.rotated90CCW == .zero)

        #expect(CGPoint(x: 3.2).rotated90CW == CGPoint(y: -3.2))
        #expect(CGPoint(y: -3.2).rotated90CW == CGPoint(x: -3.2))
        #expect(CGPoint(x: -3.2).rotated90CW == CGPoint(y: 3.2))
        #expect(CGPoint(y: 3.2).rotated90CW == CGPoint(x: 3.2))
    }

    @Test
    func test_isToSide_forZeroAndZero() {
        // (zero, zero) calls give false left and false right
        assert(!CGPoint.zero.isToLeft(ofVector: .zero))
        assert(!CGPoint.zero.isToRight(ofVector: .zero))
    }

    @Test
    func test_isToSide_forZeroAndVector() {
        // (zero, <some vec>) calls give false left and false right
        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(x: 1)))
        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(x: -1)))
        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(x: 1)))
        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(x: -1)))

        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(y: 2.2)))
        #expect(!CGPoint.zero.isToLeft(ofVector: CGPoint(y: -2.2)))
        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(y: 1.9)))
        #expect(!CGPoint.zero.isToRight(ofVector: CGPoint(y: -1.9)))
    }

    @Test
    func test_isToSide_forVectorAndZero() {
        // (<some vec>, zero) calls give false left and false right
        #expect(!CGPoint(x: 1).isToLeft(ofVector: CGPoint.zero))
        #expect(!CGPoint(x: -1).isToLeft(ofVector: CGPoint.zero))
        #expect(!CGPoint(y: 1).isToLeft(ofVector: CGPoint.zero))
        #expect(!CGPoint(y: -1).isToLeft(ofVector: CGPoint.zero))

        #expect(!CGPoint(x: 1).isToRight(ofVector: CGPoint.zero))
        #expect(!CGPoint(x: -1).isToRight(ofVector: CGPoint.zero))
        #expect(!CGPoint(y: 1).isToRight(ofVector: CGPoint.zero))
        #expect(!CGPoint(y: -1).isToRight(ofVector: CGPoint.zero))
    }

    @Test
    func test_isToSide_forSameVector() {
        // same value for both vecs always gives false left and false right
        #expect(!CGPoint(x: 1).isToLeft(ofVector: CGPoint(x: 1)))
        #expect(!CGPoint(x: -1).isToLeft(ofVector: CGPoint(x: -1)))
        #expect(!CGPoint(y: 1).isToLeft(ofVector: CGPoint(y: 1)))
        #expect(!CGPoint(y: -1).isToLeft(ofVector: CGPoint(y: -1)))

        #expect(!CGPoint(x: 1).isToRight(ofVector: CGPoint(x: 1)))
        #expect(!CGPoint(x: 1).isToRight(ofVector: CGPoint(x: 1)))
        #expect(!CGPoint(y: -3).isToRight(ofVector: CGPoint(y: -3)))
        #expect(!CGPoint(y: -3).isToRight(ofVector: CGPoint(y: -3)))
    }

    @Test
    func test_isToLeft() {
        #expect(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 1)))
        #expect(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 0.001)))
        #expect(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 100)))

        #expect(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 1)))
        #expect(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 0.001)))
        #expect(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 100)))

        #expect(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -1)))
        #expect(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -0.001)))
        #expect(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -100)))

        #expect(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -1)))
        #expect(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -0.001)))
        #expect(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -100)))
    }

    @Test
    func test_isToRight() {
        #expect(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 1)))
        #expect(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 0.001)))
        #expect(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 100)))

        #expect(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 1)))
        #expect(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 0.001)))
        #expect(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 100)))

        #expect(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -1)))
        #expect(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -0.001)))
        #expect(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -100)))

        #expect(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -1)))
        #expect(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -0.001)))
        #expect(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -100)))
    }

    @Test
    func test_isSameDirection() {
        #expect(!CGPoint.zero.isSameDirection(asVector: .zero))
        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: .zero))
        #expect(!CGPoint.zero.isSameDirection(asVector: CGPoint(x: 1, y: 1)))

        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: -1, y: 1)))
        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: 1, y: -1)))

        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: -1.1, y: 1)))
        #expect(!CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: 1, y: -1.1)))

        #expect(CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: -0.95, y: 1)))
        #expect(CGPoint(x: 1, y: 1).isSameDirection(asVector: CGPoint(x: 1, y: -0.95)))
    }

    @Test
    func test_isOppositeDirection() {
        #expect(!CGPoint.zero.isOppositeDirection(asVector: .zero))
        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: .zero))
        #expect(!CGPoint.zero.isOppositeDirection(asVector: CGPoint(x: 1, y: 1)))

        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: -1, y: 1)))
        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: 1, y: -1)))

        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: -0.95, y: 1)))
        #expect(!CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: 1, y: -0.95)))

        #expect(CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: -1.1, y: 1)))
        #expect(CGPoint(x: 1, y: 1).isOppositeDirection(asVector: CGPoint(x: 1, y: -1.1)))
    }

    @Test
    func test_quadrant() {
        #expect(Vec2(y: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
        #expect(Vec2(x: 1, y: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
        #expect(Vec2(x: 99, y: 0.1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)

        // what about the edge cases? that lie on two quadrants?
        // this is neither NE or SE.
        // make a strict quadrant?
        // or just have default 'quadrant' impl pref north, and right?
        // ^^ latter part is what happens now.
        // this tests that:
        #expect(Vec2(x: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
        #expect(Vec2(y: -1).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
        #expect(Vec2(x: -1).quadrant(referenceVector: Vec2(y: 1)) == .northWest)

        #expect(Vec2(x: 2, y: -0.01).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
        #expect(Vec2(x: 0.001, y: -100).quadrant(referenceVector: Vec2(y: 1)) == .southEast)

        #expect(Vec2(x: -0.001, y: -100).quadrant(referenceVector: Vec2(y: 1)) == .southWest)
        #expect(Vec2(x: -200, y: -0.01).quadrant(referenceVector: Vec2(y: 1)) == .southWest)

        #expect(Vec2(x: -200, y: 0.01).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
        #expect(Vec2(x: -0.01, y: 0.98).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
    }

    // use CGVector!
    @Test
    func test_rotate() {
        #expect(Vec2(x: 1).rotate(byVector: Vec2(y: 1)) == CGPoint(x: 1))
        #expect(Vec2(y: 1).rotate(byVector: Vec2(y: 1)) == CGPoint(y: 1))
        #expect(Vec2(x: -1).rotate(byVector: Vec2(y: 1)) == CGPoint(x: -1))
        #expect(Vec2(y: -1).rotate(byVector: Vec2(y: 1)) == CGPoint(y: -1))

        #expect(Vec2(x: 1).rotate(byVector: Vec2(y: -1)) == CGPoint(x: -1))
        #expect(Vec2(y: 1).rotate(byVector: Vec2(y: -1)) == CGPoint(y: -1))
        #expect(Vec2(x: -1).rotate(byVector: Vec2(y: -1)) == CGPoint(x: 1))
        #expect(Vec2(y: -1).rotate(byVector: Vec2(y: -1)) == CGPoint(y: 1))

        #expect(Vec2(x: 1).rotate(byVector: Vec2(x: 1)) == CGPoint(y: -1))

//        #expect(Vec2(x: 1).rotate(byVector: Vec2(x: 1)) == CGPoint(y: -1))
//        #expect(CGPoint(x: 1) == Vec2(x: 0.5.squareRoot()).rotate(byVector: Vec2(x: 0.5.squareRoot())))
//        #expect(CGPoint.zero == Vec2(x: 0.5.squareRoot()).rotate(byVector: Vec2(x: -0.5.squareRoot())))
//        #expect(CGPoint(x: -1) == Vec2(x: 1).rotate(byVector: Vec2(y: 0.1)))
    }

    // TODO do lazy calc props so that things not calc mult times if used multiple times?
    // TODO add generic or similar for notion of unit vector -- which can then
    // have simpler calculations in specialisations (as we know it's a unit already)
}
