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

    func test_whenAccessingConstants_thenCorrectValuesFound() {
        // Double
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
}
