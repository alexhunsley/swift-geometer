import Foundation
import XCTest
import SwiftGeometer

final class SwiftGeometerTests: XCTestCase {

    //    func assertEqualEpsilon<T: FloatingPoint>(a: T, b: T) {
    //    func assertEqualEpsilon(a: FloatingPoint, b: FloatingPoint) {
    //        XCTAssertEqual(a, b, accuracy: T(0.00001))
    //    }

    func test_whenAccessingConstants_thenCorrectValuesFound() {
        XCTAssertEqual(Double.pi, 3.1415926, accuracy: 0.00001)
        XCTAssertEqual(Double.pi2, 1.5707963, accuracy: 0.00001)
        XCTAssertEqual(Double.pi4, 0.78539815, accuracy: 0.00001)
        XCTAssertEqual(Double.pi8, 0.392699075, accuracy: 0.00001)
        XCTAssertEqual(Double.tau, 6.2831852, accuracy: 0.00001)

        XCTAssertEqual(Float.pi, 3.1415926, accuracy: 0.00001)
        XCTAssertEqual(Float.pi2, 1.5707963, accuracy: 0.00001)
        XCTAssertEqual(Float.pi4, 0.78539815, accuracy: 0.00001)
        XCTAssertEqual(Float.pi8, 0.392699075, accuracy: 0.00001)
        XCTAssertEqual(Float.tau, 6.2831852, accuracy: 0.00001)

        XCTAssertEqual(CGFloat.pi, 3.1415926, accuracy: 0.00001)
        XCTAssertEqual(CGFloat.pi2, 1.5707963, accuracy: 0.00001)
        XCTAssertEqual(CGFloat.pi4, 0.78539815, accuracy: 0.00001)
        XCTAssertEqual(CGFloat.pi8, 0.392699075, accuracy: 0.00001)
        XCTAssertEqual(CGFloat.tau, 6.2831852, accuracy: 0.00001)
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
}
