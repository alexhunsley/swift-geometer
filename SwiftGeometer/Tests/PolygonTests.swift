//
//  PolygonTests.swift
//  SwiftGeometerTests
//
//  Created by Alex Hunsley on 26/03/2025.
//

import Testing
import SwiftGeometer

struct PolygonTests {
    let triangle = [Vec2.zero, Vec2(y: 20.0), Vec2(x: 5, y: 0)]
    let square = [Vec2.zero, Vec2(y: 10.0), Vec2(x: 10, y: 10), Vec2(x: 10)]

    @Test("triangleContainsPoint", arguments: [
        // on boundary is inside
        (Vec2.zero, true),
        (Vec2(x: 5, y: 0), true),
        (Vec2(x: 0, y: 20), true),
        // centre inside
        (Vec2(x: 2.5, y: 10), true),
        // inside
        (Vec2(x: 2.499, y: 9.99), true),
        // outside
        (Vec2(x: -0.01, y: -0.1), false),
        (Vec2(x: 0.01, y: -0.1), false),
        (Vec2(x: -0.01, y: 0.1), false),
        (Vec2(x: 2.501, y: 10.01), false),
    ])
    func test_triangleContainsPoint(point: Vec2, expected: Bool) {
        #expect(polygon(vertices: triangle, containsPoint: point) == expected)
    }

    @Test("squareContainsPoint", arguments: [
        // on boundary is inside
        (Vec2.zero, true),
        (Vec2(x: 10, y: 10), true),
        // dead centre inside
        (Vec2(x: 5.0, y: 5.0), true),
        // 4 points near square corners (inside)
        (Vec2(x: 0.1, y: 0.1), true),
        (Vec2(x: 9.9, y: 0.1), true),
        (Vec2(x: 9.9, y: 9.9), true),
        (Vec2(x: 0.1, y: 9.9), true),
        // 4 points near square corners (outside)
        (Vec2(x: -0.1, y: 0.1), false),
        (Vec2(x: 10.1, y: 0.1), false),
        (Vec2(x: 10.1, y: 9.9), false),
        (Vec2(x: -0.1, y: 9.9), false),
        // 4 points near square corners (outside) B
        (Vec2(x: 0.1, y: -0.1), false),
        (Vec2(x: 0.9, y: -0.1), false),
        (Vec2(x: 0.9, y: 10.1), false),
        (Vec2(x: 0.1, y: 10.1), false),
    ])
    func test_squareContainsPoint(point: Vec2, expected: Bool) {
        #expect(polygon(vertices: square, containsPoint: point) == expected)
    }
}
