import Foundation
import XCTest
import SwiftGeometer
import SwiftUI

final class SwiftGeometerTests: XCTestCase {

    /// assertEqual (with accuracy) helper usable withh any BinaryFloatingPoint type
    func assertEqual<T: BinaryFloatingPoint>(_ a: T, _ b: T) {
        XCTAssertEqual(a, b, accuracy: 0.0001)
    }

    func assertEqual(_ a: Angle, _ b: Angle) {
        assertEqual(a.radians, b.radians)
    }

    func assertEqual(_ a: CGPoint, _ b: CGPoint) {
        assertEqual(a.x, b.x)
        assertEqual(a.y, b.y)
    }

    func test_whenAccessingConstants_thenCorrectValuesFound() {
        assertEqual(Double.pi, 3.1415926)
        assertEqual(Double.pi2, 1.5707963)
        assertEqual(Double.pi4, 0.78539815)
        assertEqual(Double.pi8, 0.392699075)
        assertEqual(Double.tau, 6.2831852)
        assertEqual(Double.tau2, 3.1415926)
        assertEqual(Double.tau3, 2.09439506667)
        assertEqual(Double.tau4, 1.5707963)
        assertEqual(Double.tau8, 0.78539815)

        // Float
        assertEqual(Float.pi, 3.1415926)
        assertEqual(Float.pi2, 1.5707963)
        assertEqual(Float.pi4, 0.78539815)
        assertEqual(Float.pi8, 0.392699075)
        assertEqual(Float.tau, 6.2831852)
        assertEqual(Float.tau2, 3.1415926)
        assertEqual(Float.tau3, 2.09439506667)
        assertEqual(Float.tau4, 1.5707963)
        assertEqual(Float.tau8, 0.78539815)

        // CGFloat
        assertEqual(CGFloat.pi, 3.1415926)
        assertEqual(CGFloat.pi2, 1.5707963)
        assertEqual(CGFloat.pi4, 0.78539815)
        assertEqual(CGFloat.pi8, 0.392699075)
        assertEqual(CGFloat.tau, 6.2831852)
        assertEqual(CGFloat.tau2, 3.1415926)
        assertEqual(CGFloat.tau3, 2.09439506667)
        assertEqual(CGFloat.tau4, 1.5707963)
        assertEqual(CGFloat.tau8, 0.78539815)
    }

    func test_whenUsingCGPointArithmeticHelpers_thenCorrectValuesFound() {
        XCTAssertEqual(CGPoint(x: 1.0, y: -2.0) / 2.0, CGPoint(x: 0.5, y: -1.0))
        XCTAssertEqual(CGPoint(x: 1.0, y: -2.0) / -2.0, CGPoint(x: -0.5, y: 1.0))

        XCTAssertEqual(CGPoint(x: -1.0, y: 2.0) * 2.0, CGPoint(x: -2.0, y: 4.0))
        XCTAssertEqual(CGPoint(x: -1.0, y: 2.0) * -2.0, CGPoint(x: 2.0, y: -4.0))

        XCTAssertEqual(CGPoint(x: -1.0, y: 2.0) + CGPoint(x: 0.2, y: 0.3), CGPoint(x: -0.8, y: 2.3))
        XCTAssertEqual(CGPoint(x: -1.0, y: 2.0) - CGPoint(x: 0.2, y: 0.3), CGPoint(x: -1.2, y: 1.7))
        XCTAssertEqual(-CGPoint(x: -1.0, y: 2.0) - CGPoint(x: 0.2, y: 0.3), CGPoint(x: 0.8, y: -2.3))

        XCTAssertEqual(-CGPoint(x: 11.2, y: -15.9), CGPoint(x: -11.2, y: 15.9))
        XCTAssertEqual(-(-CGPoint(x: 11.2, y: -15.9)), CGPoint(x: 11.2, y: -15.9))
        XCTAssertEqual(-(-(-CGPoint(x: 11.2, y: -15.9))), CGPoint(x: -11.2, y: 15.9))
    }

    func test_whenUsingTriangleHelpers_thenCorrectValuesFound() {
        // Double
        assertEqual(Triangle.HalfEquilateral.hypot, Double(2))
        assertEqual(Triangle.HalfEquilateral.largerAngle, Double(60))
        assertEqual(Triangle.HalfEquilateral.smallerAngle, Double(30))

        // Float
        assertEqual(Triangle.HalfEquilateral.hypot, Float(2))
        assertEqual(Triangle.HalfEquilateral.largerAngle, Float(60))
        assertEqual(Triangle.HalfEquilateral.smallerAngle, Float(30))

        // CGFloat
        assertEqual(Triangle.HalfEquilateral.hypot, CGFloat(2))
        assertEqual(Triangle.HalfEquilateral.largerAngle, CGFloat(60))
        assertEqual(Triangle.HalfEquilateral.smallerAngle, CGFloat(30))

        assertEqual(Triangle.cos0, 1)
    }

    func test_whenUsingVec2Typealias_thenItIsInterchangableWithCGPoint() {
        XCTAssertEqual(Vec2(x: 1.0, y: -2.0) / 2.0, CGPoint(x: 0.5, y: -1.0))
        XCTAssertEqual(Vec2(x: -1.0, y: 2.0) + CGPoint(x: 0.2, y: 0.3), Vec2(x: -0.8, y: 2.3))
    }

    func test_whenUsingAngleArithmeticHelpers_thenCorrectValuesFound() {
        assertEqual(1.5 * Angle(degrees: -80), Angle(degrees: -120))
        assertEqual(1.5 * -Angle(degrees: -80), Angle(degrees: 120))
        assertEqual(-1.5 * -Angle(degrees: -80), Angle(degrees: -120))
        assertEqual(Angle(degrees: -80) * 2, Angle(degrees: -160))
        assertEqual(Angle(degrees: 80) / 2, Angle(degrees: 40))
        assertEqual(Angle(degrees: 50) + Angle(degrees: 20), Angle(degrees: 70))
        assertEqual(Angle(degrees: 50) - Angle(degrees: 20), Angle(degrees: 30))
        assertEqual(Angle(degrees: 20) + Angle(degrees: 50), Angle(degrees: 70))
        assertEqual(Angle(degrees: 20) - Angle(degrees: 50), Angle(degrees: -30))
    }

    func test_whenUsingAnglePolarToCartesian_thenCorrectValuesFound() {
        // plain angle and radius to coordinate
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 1.0), CGPoint(x: 1, y: 0))
        assertEqual(Angle(degrees: 90).coordinate(withRadius: 1.0), CGPoint(x: 0, y: 1))
        assertEqual(Angle(degrees: 180).coordinate(withRadius: 1.0), CGPoint(x: -1, y: 0))
        assertEqual(Angle(degrees: 270).coordinate(withRadius: 1.0), CGPoint(x: 0, y: -1))

        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5), CGPoint(x: 2.5, y: 0))
        assertEqual(Angle(degrees: 90).coordinate(withRadius: 2.5), CGPoint(x: 0, y: 2.5))
        assertEqual(Angle(degrees: 180).coordinate(withRadius: 2.5), CGPoint(x: -2.5, y: 0))
        assertEqual(Angle(degrees: 270).coordinate(withRadius: 2.5), CGPoint(x: 0, y: -2.5))

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
        let x: Float16 = .pi/2 // ok

        // so need to rethink what I've re-implemend or not!
        // e.g. tau would be nice to offer as that's not offered.

        // angleOffset
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: Angle(radians: Double.pi2)), CGPoint(x: 0, y: 2.5))
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: Angle(radians: Double.pi4)), CGPoint(x: 1.76776, y: 1.76776))

        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: Angle.ninety), CGPoint(x: 0, y: 2.5))
        assertEqual(Angle(degrees: 90).coordinate(withRadius: 2.5, angleOffset: Angle.ninety), CGPoint(x: -2.5, y: 0))
        assertEqual(Angle(degrees: 180).coordinate(withRadius: 2.5, angleOffset: Angle.ninety), CGPoint(x: 0, y: -2.5))
        assertEqual(Angle(degrees: 270).coordinate(withRadius: 2.5, angleOffset: Angle.ninety), CGPoint(x: 2.5, y: 0))

        assertEqual(Angle(degrees: 90).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety), CGPoint(x: 2.5, y: 0))
        assertEqual(Angle(degrees: 180).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety), CGPoint(x: 0, y: 2.5))
        assertEqual(Angle(degrees: 270).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety), CGPoint(x: -2.5, y: 0))
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, angleOffset: -Angle.ninety), CGPoint(x: 0, y: -2.5))

        // fromPoint
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(x: 1, y: -5)), CGPoint(x: 3.5, y: -5))

        // angleOffset and fromPoint (rename to centrePoint?)
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(xy: 1), angleOffset: Angle(radians: Double.pi2)), CGPoint(x: 1, y: 3.5))
        assertEqual(Angle(degrees: 0).coordinate(withRadius: 2.5, fromPoint: CGPoint(xy: 1), angleOffset: Angle(radians: Double.pi4)), CGPoint(x: 2.76776, y: 2.76776))

        // Angle operators
        assertEqual(1.5 * -Angle(degrees: -80), Angle(degrees: 120))
        assertEqual(-1.5 * -Angle(degrees: -80), Angle(degrees: -120))
        assertEqual(Angle(degrees: -80) * 2, Angle(degrees: -160))
        assertEqual(Angle(degrees: 80) / 2, Angle(degrees: 40))
        assertEqual(Angle(degrees: 50) + Angle(degrees: 20), Angle(degrees: 70))
        assertEqual(Angle(degrees: 50) - Angle(degrees: 20), Angle(degrees: 30))
        assertEqual(Angle(degrees: 20) + Angle(degrees: 50), Angle(degrees: 70))
        assertEqual(Angle(degrees: 20) - Angle(degrees: 50), Angle(degrees: -30))
    }

    func test_constants() {
        assertEqual(Triangle.cos0, Angle(degrees: 0).cos)
        assertEqual(Triangle.cos30, Angle(degrees: 30).cos)
        assertEqual(Triangle.cos60, Angle(degrees: 60).cos)
        assertEqual(Triangle.cos90, Angle(degrees: 90).cos)
        assertEqual(Triangle.cos45, Angle(degrees: 45).cos)

        assertEqual(Triangle.sin0, Angle(degrees: 0).sin)
        assertEqual(Triangle.sin30, Angle(degrees: 30).sin)
        assertEqual(Triangle.sin60, Angle(degrees: 60).sin)
        assertEqual(Triangle.sin90, Angle(degrees: 90).sin)
        assertEqual(Triangle.sin45, Angle(degrees: 45).sin)
    }

    func test_CGPointInitHelpers() {
        assertEqual(CGPoint(x: 2.3), CGPoint(x: 2.3, y: 0))
        assertEqual(CGPoint(y: -7.12), CGPoint(x: 0, y: -7.12))
    }

    func test_polarConversion() {
        assertEqual(PolarCoord(angle: .zero, radius: 1.0).cartesianCoord, CGPoint(x: 1))
        assertEqual(PolarCoord(angle: .ninety, radius: 1.0).cartesianCoord, CGPoint(y: 1))
        assertEqual(PolarCoord(angle: .oneEighty, radius: 1.0).cartesianCoord, CGPoint(x: -1))
        assertEqual(PolarCoord(angle: .twoSeventy, radius: 1.0).cartesianCoord, CGPoint(y: -1))

        assertEqual(PolarCoord(angle: .fortyFive, radius: 1.0).cartesianCoord, CGPoint.unitLine)
        assertEqual(PolarCoord(angle: .fortyFive + .ninety, radius: 1.0).cartesianCoord, CGPoint.unitLine.negatedX)
        assertEqual(PolarCoord(angle: .fortyFive + 2 * .ninety, radius: 1.0).cartesianCoord, CGPoint.unitLine.negatedX.negatedY)
        assertEqual(PolarCoord(angle: .fortyFive + 3 * .ninety, radius: 1.0).cartesianCoord, CGPoint.unitLine.negatedY)

        let xyEdgeLenPoint = CGPoint(xy: Triangle<CGFloat>.Right.hypot)
        assertEqual(PolarCoord(angle: .fortyFive, radius: 2.0).cartesianCoord, xyEdgeLenPoint)
        assertEqual(PolarCoord(angle: .fortyFive + .ninety, radius: 2.0).cartesianCoord, xyEdgeLenPoint.negatedX)
        assertEqual(PolarCoord(angle: .fortyFive + 2 * .ninety, radius: 2.0).cartesianCoord, xyEdgeLenPoint.negatedX.negatedY)
        assertEqual(PolarCoord(angle: .fortyFive + 3 * .ninety, radius: 2.0).cartesianCoord, xyEdgeLenPoint.negatedY)

        // NB there's a CGVector! It uses Doubles not CGFloat.
        // note this in the readme. My Vec2 is CGFloat so maybe worth keeping? Or CGVector just as nice? - no can't directly use.
        //        let x: CGVector = CGPoint.zero  // <-- no compile
    }

    func test_angleBetween() {
        assertEqual(Angle.between(vector: Vec2(x: 0, y: 1), andVector: Vec2(x: 0, y: 1)), Angle.zero)
        assertEqual(Angle.between(vector: Vec2(x: -1, y: 0), andVector: Vec2(x: -1, y: 0)), Angle.zero)
        assertEqual(Angle.between(vector: Vec2(x: -0.5, y: 58), andVector: Vec2(x: -0.5, y: 58)), Angle.zero)

        assertEqual(Angle.between(vector: Vec2(x: 0, y: 1), andVector: Vec2(x: 1, y: 0)), Angle.ninety)
        assertEqual(Angle.between(vector: Vec2(x: 0, y: 1), andVector: Vec2(x: -1, y: 0)), Angle.ninety)
        assertEqual(Angle.between(vector: Vec2(x: 1, y: -1), andVector: Vec2(x: -1, y: 1)), Angle.oneEighty)
        assertEqual(Angle.between(vector: Vec2(x: 0.5, y: 58), andVector: Vec2(x: -0.5, y: -58)), Angle.oneEighty)
    }

    func test_rotateCGPoint() {
        assertEqual(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.ninety), CGPoint(x: 0, y: 1))
        assertEqual(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.oneEighty), CGPoint(x: -1, y: 0))
        assertEqual(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.twoSeventy), CGPoint(x: 0, y: -1))
        // -90 is same as +270
        assertEqual(CGPoint(x: 1, y: 0).rotate(byAngle: -Angle.ninety), CGPoint(x: 0, y: -1))

        // two 45 rotations = 90 degree rotation
        assertEqual(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.fortyFive).rotate(byAngle: Angle.fortyFive), CGPoint(x: 0, y: 1))

        // 45 then -45 rotation = 0 degree rotation overall
        assertEqual(CGPoint(x: 1, y: 0).rotate(byAngle: Angle.fortyFive).rotate(byAngle: -Angle.fortyFive), CGPoint(x: 1, y: 0))

    }

    func test_vectorProjection() {
        // zero a sized A vecs have zero sized projection
        assertEqual(CGPoint.zero.projected(ontoVector: Vec2(x: 11, y: -4)), .zero)
        assertEqual(CGPoint.zero.projected(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint.zero.projected(ontoVector: Vec2(x: -11, y: 4)), .zero)
        assertEqual(CGPoint.zero.projected(ontoVector: Vec2(x: -11, y: -4)), .zero)

        // zero a sized B vecs have undefined projection
        assert(CGPoint(x: 4, y: -11).projected(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: 11).projected(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: -11).projected(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: 4, y: 11).projected(ontoVector: .zero).isUndefined)

        // orthogonal vecs have zero sized projection
        assertEqual(CGPoint(x: 4, y: -11).projected(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint(x: 4, y: -11).projected(ontoVector: Vec2(x: -11, y: -4)), .zero)
        assertEqual(CGPoint(x: -4, y: 11).projected(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint(x: -4, y: 11).projected(ontoVector: Vec2(x: -11, y: -4)), .zero)

        // the projection has vec a's length projected when b is smaller
        assertEqual(CGPoint(x: 1, y: 1).projected(ontoVector: Vec2(y: 0.1)), Vec2(y: 1))
        // the projection has vec a's length projected when b is larger
        assertEqual(CGPoint(x: 1, y: 1).projected(ontoVector: Vec2(y: 2)), Vec2(y: 1))

        // the projected vector is a negative mulitple of B when angle between them > 90
        assertEqual(CGPoint(x: -1, y: -1).projected(ontoVector: Vec2(y: 3)), Vec2(y: -1))
        assertEqual(CGPoint(x: 1, y: -1).projected(ontoVector: Vec2(y: 3)), Vec2(y: -1))

        // the projected vector is a positive multiple of B when angle between them < 90
        assertEqual(CGPoint(x: -1, y: 1).projected(ontoVector: Vec2(y: 4)), Vec2(y: 1))
        assertEqual(CGPoint(x: 1, y: 1).projected(ontoVector: Vec2(y: 4)), Vec2(y: 1))

        assertEqual(CGPoint(x: -2, y: -3).projected(ontoVector: Vec2(y: 5)), Vec2(y: -3))
    }

    func test_vectorPositiveProjection() {
        // zero a sized A vecs have zero sized projection
        assertEqual(CGPoint.zero.positiveProjected(ontoVector: Vec2(x: 11, y: -4)), .zero)
        assertEqual(CGPoint.zero.positiveProjected(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint.zero.positiveProjected(ontoVector: Vec2(x: -11, y: 4)), .zero)
        assertEqual(CGPoint.zero.positiveProjected(ontoVector: Vec2(x: -11, y: -4)), .zero)

        // zero a sized B vecs have undefined projection
        assert(CGPoint(x: 4, y: -11).positiveProjected(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: 11).positiveProjected(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: -11).positiveProjected(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: 4, y: 11).positiveProjected(ontoVector: .zero).isUndefined)

        // orthogonal vecs have zero sized projection
        assertEqual(CGPoint(x: 4, y: -11).positiveProjected(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint(x: 4, y: -11).positiveProjected(ontoVector: Vec2(x: -11, y: -4)), .zero)
        assertEqual(CGPoint(x: -4, y: 11).positiveProjected(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint(x: -4, y: 11).positiveProjected(ontoVector: Vec2(x: -11, y: -4)), .zero)

        // the projection has vec a's length projected when b is smaller
        assertEqual(CGPoint(x: 1, y: 1).positiveProjected(ontoVector: Vec2(y: 0.1)), Vec2(y: 1))
        // the projection has vec a's length projected when b is larger
        assertEqual(CGPoint(x: 1, y: 1).positiveProjected(ontoVector: Vec2(y: 2)), Vec2(y: 1))

        // the projected vector is a positive mulitple of B when angle between them > 90
        assertEqual(CGPoint(x: -1, y: -1).positiveProjected(ontoVector: Vec2(y: 3)), Vec2(y: 1))
        assertEqual(CGPoint(x: 1, y: -1).positiveProjected(ontoVector: Vec2(y: 3)), Vec2(y: 1))

        // the projected vector is a positive multiple of B when angle between them < 90
        assertEqual(CGPoint(x: -1, y: 1).positiveProjected(ontoVector: Vec2(y: 4)), Vec2(y: 1))
        assertEqual(CGPoint(x: 1, y: 1).positiveProjected(ontoVector: Vec2(y: 4)), Vec2(y: 1))

        assertEqual(CGPoint(x: -2, y: -3).positiveProjected(ontoVector: Vec2(y: 5)), Vec2(y: 3))
    }

    func test_vectorOrthogonalProjection() {
        // zero a sized A vecs have zero sized projection
        assertEqual(CGPoint.zero.projectedOrthogonally(ontoVector: Vec2(x: 11, y: -4)), .zero)
        assertEqual(CGPoint.zero.projectedOrthogonally(ontoVector: Vec2(x: 11, y: 4)), .zero)
        assertEqual(CGPoint.zero.projectedOrthogonally(ontoVector: Vec2(x: -11, y: 4)), .zero)
        assertEqual(CGPoint.zero.projectedOrthogonally(ontoVector: Vec2(x: -11, y: -4)), .zero)

        // zero a sized B vecs have undefined projection
        assert(CGPoint(x: 4, y: -11).projectedOrthogonally(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: 11).projectedOrthogonally(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: -4, y: -11).projectedOrthogonally(ontoVector: .zero).isUndefined)
        assert(CGPoint(x: 4, y: 11).projectedOrthogonally(ontoVector: .zero).isUndefined)

        // colinear vecs have zero sized orth projection
        assertEqual(CGPoint(x: 4, y: -11).projectedOrthogonally(ontoVector: Vec2(x: 4, y: -11)), .zero)
        assertEqual(CGPoint(x: -4, y: -11).projectedOrthogonally(ontoVector: Vec2(x: -4, y: -11)), .zero)
        assertEqual(CGPoint(x: 0, y: 10).projectedOrthogonally(ontoVector: Vec2(x: 0, y: 20)), .zero)
        assertEqual(CGPoint(x: 0, y: 10).projectedOrthogonally(ontoVector: Vec2(x: 0, y: -20)), .zero)

        // the projected orth vector is same orth dir as B
        assertEqual(CGPoint(x: 2, y: 7).projectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: 7))
        assertEqual(CGPoint(x: 2, y: -2).projectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))

        // sum of projection and orth project equals the original B vector
        assertEqual(CGPoint(x: 2, y: 7).projected(ontoVector: Vec2(x: 5, y: 0))
            + CGPoint(x: 2, y: 7).projectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)),
                    CGPoint(x: 2, y: 7))

        // when colinear: sum of projection and orth project equals the original B vector
        assertEqual(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: -2, y: -7))
            + CGPoint(x: -2, y: -7).projectedOrthogonally(ontoVector: Vec2(x: -2, y: -7)),
                    CGPoint(x: -2, y: -7))

        // when orth: sum of projection and orth project equals the original B vector
        assertEqual(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: 7, y: -2))
            + CGPoint(x: -2, y: -7).projectedOrthogonally(ontoVector: Vec2(x: 7, y: -2)),
                    CGPoint(x: -2, y: -7))
    }

    // don't think this make sense
//    func test_vectorPositiveOrthogonalProjection() {
//        // zero a sized A vecs have zero sized projection
//        assertEqual(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: -4)), .zero)
//        assertEqual(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: 4)), .zero)
//        assertEqual(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: 4)), .zero)
//        assertEqual(CGPoint.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: -4)), .zero)
//
//        // zero a sized B vecs have undefined projection
//        assert(CGPoint(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//        assert(CGPoint(x: -4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//        assert(CGPoint(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//        assert(CGPoint(x: 4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//
//        // colinear vecs have zero sized orth projection
//        assertEqual(CGPoint(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: 4, y: -11)), .zero)
//        assertEqual(CGPoint(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: -4, y: -11)), .zero)
//        assertEqual(CGPoint(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: 20)), .zero)
//        assertEqual(CGPoint(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: -20)), .zero)
//
//        // the projected orth vector is to right of B
//        assertEqual(CGPoint(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: 7))
//        assertEqual(CGPoint(x: 2, y: -2).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
//
//        // sum of projection and orth project equals the original B vector
//        assertEqual(CGPoint(x: 2, y: 7).projected(ontoVector: Vec2(x: 5, y: 0))
//            + CGPoint(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)),
//                    CGPoint(x: 2, y: 7))
//
//        // when colinear: sum of projection and orth project equals the original B vector
//        assertEqual(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: -2, y: -7))
//            + CGPoint(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: -2, y: -7)),
//                    CGPoint(x: -2, y: -7))
//
//        // when orth: sum of projection and orth project equals the original B vector
//        assertEqual(CGPoint(x: -2, y: -7).projected(ontoVector: Vec2(x: 7, y: -2))
//            + CGPoint(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 7, y: -2)),
//                    CGPoint(x: -2, y: -7))
//    }

    func test_vectorRotate180() {
        assertEqual(CGPoint.zero.rotated180, .zero)

        assertEqual(CGPoint(x: 3).rotated180, CGPoint(x: -3))
        assertEqual(CGPoint(x: -3).rotated180, CGPoint(x: 3))

        assertEqual(CGPoint(y: 3).rotated180, CGPoint(y: -3))
        assertEqual(CGPoint(y: -3).rotated180, CGPoint(y: 3))

        assertEqual(CGPoint(x: -2, y: 3).rotated180, CGPoint(x: 2, y: -3))
        assertEqual(CGPoint(x: 2, y: -3).rotated180, CGPoint(x: -2, y: 3))
    }

    func test_vectorRotate90CW() {
        assertEqual(CGPoint.zero.rotated90CW, .zero)

        assertEqual(CGPoint(x: 3).rotated90CCW, CGPoint(y: 3))
        assertEqual(CGPoint(y: 3.2).rotated90CCW, CGPoint(x: -3.2))
        assertEqual(CGPoint(x: -3.2).rotated90CCW, CGPoint(y: -3.2))
        assertEqual(CGPoint(y: -3.2).rotated90CCW, CGPoint(x: 3.2))
    }

    func test_vectorRotate90CCW() {
        assertEqual(CGPoint.zero.rotated90CCW, .zero)

        assertEqual(CGPoint(x: 3.2).rotated90CW, CGPoint(y: -3.2))
        assertEqual(CGPoint(y: -3.2).rotated90CW, CGPoint(x: -3.2))
        assertEqual(CGPoint(x: -3.2).rotated90CW, CGPoint(y: 3.2))
        assertEqual(CGPoint(y: 3.2).rotated90CW, CGPoint(x: 3.2))
    }

    func test_isToSide_forZeroAndZero() {
        // (zero, zero) calls give false left and false right
        assert(!CGPoint.zero.isToLeft(ofVector: .zero))
        assert(!CGPoint.zero.isToRight(ofVector: .zero))
    }

    func test_isToSide_forZeroAndVector() {
        // (zero, <some vec>) calls give false left and false right
        assert(!CGPoint.zero.isToLeft(ofVector: CGPoint(x: 1)))
        assert(!CGPoint.zero.isToLeft(ofVector: CGPoint(x: -1)))
        assert(!CGPoint.zero.isToRight(ofVector: CGPoint(x: 1)))
        assert(!CGPoint.zero.isToRight(ofVector: CGPoint(x: -1)))

        assert(!CGPoint.zero.isToLeft(ofVector: CGPoint(y: 2.2)))
        assert(!CGPoint.zero.isToLeft(ofVector: CGPoint(y: -2.2)))
        assert(!CGPoint.zero.isToRight(ofVector: CGPoint(y: 1.9)))
        assert(!CGPoint.zero.isToRight(ofVector: CGPoint(y: -1.9)))
    }

    func test_isToSide_forVectorAndZero() {
        // (<some vec>, zero) calls give false left and false right
        assert(!CGPoint(x: 1).isToLeft(ofVector: CGPoint.zero))
        assert(!CGPoint(x: -1).isToLeft(ofVector: CGPoint.zero))
        assert(!CGPoint(y: 1).isToLeft(ofVector: CGPoint.zero))
        assert(!CGPoint(y: -1).isToLeft(ofVector: CGPoint.zero))

        assert(!CGPoint(x: 1).isToRight(ofVector: CGPoint.zero))
        assert(!CGPoint(x: -1).isToRight(ofVector: CGPoint.zero))
        assert(!CGPoint(y: 1).isToRight(ofVector: CGPoint.zero))
        assert(!CGPoint(y: -1).isToRight(ofVector: CGPoint.zero))
    }

    func test_isToSide_forSameVector() {
        // same value for both vecs always gives false left and false right
        assert(!CGPoint(x: 1).isToLeft(ofVector: CGPoint(x: 1)))
        assert(!CGPoint(x: -1).isToLeft(ofVector: CGPoint(x: -1)))
        assert(!CGPoint(y: 1).isToLeft(ofVector: CGPoint(y: 1)))
        assert(!CGPoint(y: -1).isToLeft(ofVector: CGPoint(y: -1)))

        assert(!CGPoint(x: 1).isToRight(ofVector: CGPoint(x: 1)))
        assert(!CGPoint(x: 1).isToRight(ofVector: CGPoint(x: 1)))
        assert(!CGPoint(y: -3).isToRight(ofVector: CGPoint(y: -3)))
        assert(!CGPoint(y: -3).isToRight(ofVector: CGPoint(y: -3)))
    }

    func test_isToLeft() {
        assert(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 1)))
        assert(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 0.001)))
        assert(CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: 100)))

        assert(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 1)))
        assert(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 0.001)))
        assert(CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: 100)))

        assert(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -1)))
        assert(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -0.001)))
        assert(!CGPoint(x: -1, y: 1).isToLeft(ofVector: CGPoint(x: 0, y: -100)))

        assert(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -1)))
        assert(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -0.001)))
        assert(!CGPoint(x: -1, y: -1).isToLeft(ofVector: CGPoint(x: 0, y: -100)))
    }

    func test_isToRight() {
        assert(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 1)))
        assert(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 0.001)))
        assert(CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: 100)))

        assert(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 1)))
        assert(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 0.001)))
        assert(CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: 100)))

        assert(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -1)))
        assert(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -0.001)))
        assert(!CGPoint(x: 1, y: 1).isToRight(ofVector: CGPoint(x: 0, y: -100)))

        assert(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -1)))
        assert(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -0.001)))
        assert(!CGPoint(x: 1, y: -1).isToRight(ofVector: CGPoint(x: 0, y: -100)))
    }

    // TODO do lazy calc props so that things not calc mult times if used multiple times?
    // TODO add generic or similar for notion of unit vector -- which can then
    // have simpler calculations in specialisations (as we know it's a unit already)
}
