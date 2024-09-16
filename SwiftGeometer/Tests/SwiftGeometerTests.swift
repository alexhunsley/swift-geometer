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

        // Float
        assertEqual(Float.pi, 3.1415926)
        assertEqual(Float.pi2, 1.5707963)
        assertEqual(Float.pi4, 0.78539815)
        assertEqual(Float.pi8, 0.392699075)
        assertEqual(Float.tau, 6.2831852)

        // CGFloat
        assertEqual(CGFloat.pi, 3.1415926)
        assertEqual(CGFloat.pi2, 1.5707963)
        assertEqual(CGFloat.pi4, 0.78539815)
        assertEqual(CGFloat.pi8, 0.392699075)
        assertEqual(CGFloat.tau, 6.2831852)
    }

    func test_whenUsingCGPointHelpers_thenCorrectValuesFound() {
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
        assertEqual(PolarPoint(angle: .zero, radius: 1.0).cartesianPoint, CGPoint(x: 1))
        assertEqual(PolarPoint(angle: .ninety, radius: 1.0).cartesianPoint, CGPoint(y: 1))
        assertEqual(PolarPoint(angle: .oneEighty, radius: 1.0).cartesianPoint, CGPoint(x: -1))
        assertEqual(PolarPoint(angle: .twoSeventy, radius: 1.0).cartesianPoint, CGPoint(y: -1))

        assertEqual(PolarPoint(angle: .fortyFive, radius: 1.0).cartesianPoint, CGPoint.unitLine)
        assertEqual(PolarPoint(angle: .fortyFive + .ninety, radius: 1.0).cartesianPoint, CGPoint.unitLine.negatedX)
        assertEqual(PolarPoint(angle: .fortyFive + 2 * .ninety, radius: 1.0).cartesianPoint, CGPoint.unitLine.negatedX.negatedY)
        assertEqual(PolarPoint(angle: .fortyFive + 3 * .ninety, radius: 1.0).cartesianPoint, CGPoint.unitLine.negatedY)

        let xyEdgeLenPoint = CGPoint(xy: Triangle<CGFloat>.Right.hypot)
        assertEqual(PolarPoint(angle: .fortyFive, radius: 2.0).cartesianPoint, xyEdgeLenPoint)
        assertEqual(PolarPoint(angle: .fortyFive + .ninety, radius: 2.0).cartesianPoint, xyEdgeLenPoint.negatedX)
        assertEqual(PolarPoint(angle: .fortyFive + 2 * .ninety, radius: 2.0).cartesianPoint, xyEdgeLenPoint.negatedX.negatedY)
        assertEqual(PolarPoint(angle: .fortyFive + 3 * .ninety, radius: 2.0).cartesianPoint, xyEdgeLenPoint.negatedY)

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
}
