//
//  PolygonTests.swift
//  SwiftGeometerTests
//
//  Created by Alex Hunsley on 26/03/2025.
//

import Testing
import SwiftGeometer
import UIKit

struct PolygonTests {
    let triangle = [Vec2.zero, Vec2(y: 20.0), Vec2(x: 5, y: 0)]

    let square = [Vec2.zero, Vec2(y: 10.0), Vec2(x: 10, y: 10), Vec2(x: 10)]

    let kite = [Vec2.zero,
                Vec2(y: 10.0),
                Vec2(x: 4, y: 6),
                Vec2(x: 6, y: 6),
                Vec2(x: 10, y: 10),
                Vec2(x: 10)]

    let kiteTwoCavity = [Vec2.zero,
                         Vec2(y: 10.0),
                         Vec2(x: 4, y: 6),
                         Vec2(x: 6, y: 6),
                         Vec2(x: 10, y: 10),
                         Vec2(x: 10),
                         Vec2(x: 6),
                         Vec2(x: 5, y: 1),
                         Vec2(x: 4)]

//    let kiteLevelTwoCavity = [Vec2.zero,
//                              Vec2(y: 10.0),
//                              Vec2(x: 4, y: 6),
//                              // this little bump up gives us level 2 cavity
//                              // (it makes the cut-away concave)
////                              Vec2(x: 5, y: 7),
//                              Vec2(x: 6, y: 6),
//                              Vec2(x: 10, y: 10),
//                              Vec2(x: 10)]

    // this shows the issues with my attmept to make
    // my convex convavity only (level 1 shape) alg work wth concave concavity (level 2).
    //
    // that idea (for GLSL): try the left/right calc but add all values together (or similar),
    // check sign.
    let lCavity = [Vec2.zero,
                   Vec2(y: 30),
                   Vec2(x: 10, y: 30),
                   Vec2(x: 10, y: 10),
                   Vec2(x: 30, y: 10),
                   Vec2(x: 30, y: 20),
                   // commenting out this gives us a convex concavity so it works
                   Vec2(x: 20, y: 20),
                   Vec2(x: 20, y: 30),
                   Vec2(x: 40, y: 30),
                   Vec2(x: 40)]

    // all cavities are convex, should work
    let levelOneCavities = [Vec2.zero,
                            // start cavity 1:
                            Vec2(y: 10),
                            Vec2(x: 5, y: 15),
                            // end cavity 1:
                            Vec2(y: 20),
                            // start TL cavity:
                            Vec2(y: 25),
                            Vec2(x: 3, y: 25),
                            Vec2(x: 5, y: 27),
                            // end TL cavity:
                            Vec2(x: 5, y: 30),
                            // start cavity 2:
                            Vec2(x: 10, y: 30),
                            Vec2(x: 10, y: 18),
                            Vec2(x: 20, y: 15),
                            Vec2(x: 30, y: 18),
                            Vec2(x: 30, y: 20),
                            // end cavity 2:
                            Vec2(x: 20, y: 30),
                            Vec2(x: 40, y: 30),
                            // start BR cavity:
                            Vec2(x: 40, y: 6),
                            Vec2(x: 38, y: 5),
                            // end BR cavity:
                            Vec2(x: 36),
                            // start cavity 3:
                            Vec2(x: 35),
                            Vec2(x: 35, y: 10),
                            Vec2(x: 20, y: 10),
                            Vec2(x: 10, y: 7.5),
                            Vec2(x: 5, y: 2.5),
                            // end cavity 3:
                            Vec2(x: 5),
    ]

    @Test("lCavityContainsPoint", arguments: [
        // on boundary is inside
//        (Vec2.zero, true),
//        (Vec2(x: 5, y: 25), true),
//        (Vec2(x: 5, y: 15), true),
//        (Vec2(x: 5, y: 5), true),
//        (Vec2(x: 25, y: 25), true),
//        (Vec2(x: 35, y: 25), true),
//        (Vec2(x: 35, y: 15), true),
//        (Vec2(x: 35, y: 5), true),
//        (Vec2(x: 25, y: 5), true),
//        (Vec2(x: 15, y: 5), true),
        // outside
        (Vec2(x: 15, y: 25), false),
//        (Vec2(x: 15, y: 15), false),
//        (Vec2(x: 25, y: 15), false),
    ], 0...0)
    func test_lCavityContainsPoint(pointsToExpected: (Vec2, Bool), rotationAmount: Int) {
//        let poly = lCavity  // fails! as expected for my level 1 alg.
//        let poly = kiteLevelTwoCavity // fails! as expected (the little bump up doesn't appear)
        let poly = levelOneCavities

        for rots in 0...poly.count {
            print("--------- ROTS = \(rots)")
            test_bitmap(poly: poly.rotateLeft(rots), res: 1.0)
            //        print(">>>>>>>>>>>>>> verts after rot: \(poly.rotateLeft(rotationAmount))")
        }
        #expect(polygon(vertices: poly.rotateLeft(rotationAmount),
                    containsPoint: pointsToExpected.0) == pointsToExpected.1)
    }

    func boundingRect(for points: [Vec2], border: CGFloat = 0.0) -> CGRect {
        guard let first = points.first else {
            return .null
        }

        var minX = first.x
        var minY = first.y
        var maxX = first.x
        var maxY = first.y

        for point in points.dropFirst() {
            minX = min(minX, point.x)
            minY = min(minY, point.y)
            maxX = max(maxX, point.x)
            maxY = max(maxY, point.y)
        }

        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
//            .inset(by: UIEdgeInsets(top: border, left: border, bottom: border, right: border))
    }

    func loopThroughRect(_ rect: CGRect,
                         step res: Double,
                         border disableParam: CGFloat = 0.0,
                         handler: (Vec2, Bool) -> Void) {
        let border = res * 2
        let minX = rect.minX - border
        let maxX = rect.maxX + border
        let minY = rect.minY - border
        let maxY = rect.maxY + border
//        let minX = rect.minX - border
//        let maxX = rect.maxX + border
//        let minY = rect.minY - border
//        let maxY = rect.maxY + border

        var y = maxY
        while y >= minY {
            var x = minX
            while x <= maxX {
                handler(Vec2(x: x, y: y), x == maxX)
                x += res
            }
            y -= res
        }
    }

    func test_bitmap(poly: [Vec2], res: CGFloat = 5.0) {
        print("Bitmap:")
        let boundingRect = boundingRect(for: poly)
        loopThroughRect(boundingRect, step: res, border: 5.0) { (point, endOfLine) in
//            print("P: \(point)")
            let hit = polygon(vertices: poly, containsPoint: Vec2(x: point.x, y: point.y))
            print(hit ? "*" : ".", terminator: endOfLine ? "\n" : "")
        }
    }

//    @Test("kiteContainsPoint - all rots", arguments: [
//        // on boundary is inside
//        (Vec2.zero, true),
//        // in kite part, outside
//        (Vec2(x: 5.0, y: 7.5), false),
//
//        // to left of kite bit, inside. fails with convex only alg!
//        (Vec2(x: 1.0, y: 7.5), true),
//
//        (Vec2(x: 0.1, y: 7.5), true),
//        (Vec2(x: 0.1, y: 2.5), true),
//        (Vec2(x: 9.0, y: 7.5), true),
//
//        (Vec2(x: 4.01, y: 5.99), true),
//        (Vec2(x: 5.99, y: 5.99), true),
//        (Vec2(x: 5.0, y: 5.99), true),
//        (Vec2(x: 5.0, y: 5), true),
//        (Vec2(x: 5.0, y: 1), true),
//        (Vec2(x: 5.0, y: 0.01), true),
//
//        // outside
//        (Vec2(x: 5.0, y: 6.02), false),
//        (Vec2(x: 4.01, y: 6.02), false),
//        (Vec2(x: 5.99, y: 6.02), false),
//
//        // outside
//        (Vec2(x: -0.1, y: 0.1), false),
//        (Vec2(x: -0.01, y: -0.1), false),
//        (Vec2(x: 0.01, y: -0.1), false),
//        (Vec2(x: -0.01, y: 0.1), false),
//        (Vec2(x: 2.501, y: 10.01), false),
//
//        // very large offsets
//        (Vec2(x: .greatestFiniteMagnitude), false),
//        (Vec2(x: -.greatestFiniteMagnitude), false),
//        (Vec2(y: .greatestFiniteMagnitude), false),
//        (Vec2(y: -.greatestFiniteMagnitude), false),
//    ], 0...5)
//    func test_kiteContainsPointRot(pointsToExpected: (Vec2, Bool), rotationAmount: Int) {
//        print("Rotated: \(kite.rotateLeft(rotationAmount))")
//        #expect(polygon(vertices: kite.rotateLeft(rotationAmount), containsPoint: pointsToExpected.0) == pointsToExpected.1)
//    }
//
//    @Test("kiteTwoCavityContainsPoint - all rots", arguments: [
//        // on boundary is inside
//        (Vec2.zero, true),
//        // in kite part, outside
//        (Vec2(x: 5.0, y: 7.5), false),
//
//        // to left of kite bit, inside. fails with convex only alg!
//        (Vec2(x: 1.0, y: 7.5), true),
//
//        (Vec2(x: 0.1, y: 7.5), true),
//        (Vec2(x: 0.1, y: 2.5), true),
//        (Vec2(x: 9.0, y: 7.5), true),
//
//        (Vec2(x: 4.01, y: 5.99), true),
//        (Vec2(x: 5.99, y: 5.99), true),
//        (Vec2(x: 5.0, y: 5.99), true),
//        (Vec2(x: 5.0, y: 5), true),
//        (Vec2(x: 5.0, y: 1), true),
//        (Vec2(x: 5.0, y: 1.1), true),
//        // outside points in bottom notch
//        (Vec2(x: 4.9, y: 0.01), false),
//        (Vec2(x: 5.0, y: 0.01), false),
//        (Vec2(x: 5.1, y: 0.01), false),
//
//        // outside
//        (Vec2(x: 5.0, y: 6.02), false),
//        (Vec2(x: 4.01, y: 6.02), false),
//        (Vec2(x: 5.99, y: 6.02), false),
//
//        // outside
//        (Vec2(x: -0.1, y: 0.1), false),
//        (Vec2(x: -0.01, y: -0.1), false),
//        (Vec2(x: 0.01, y: -0.1), false),
//        (Vec2(x: -0.01, y: 0.1), false),
//        (Vec2(x: 2.501, y: 10.01), false),
//
//        // very large offsets
//        (Vec2(x: .greatestFiniteMagnitude), false),
//        (Vec2(x: -.greatestFiniteMagnitude), false),
//        (Vec2(y: .greatestFiniteMagnitude), false),
//        (Vec2(y: -.greatestFiniteMagnitude), false),
//    ], 0...5)
//    func test_kiteTwoCavityContainsPointRot(pointsToExpected: (Vec2, Bool), rotationAmount: Int) {
//        #expect(polygon(vertices: kiteTwoCavity.rotateLeft(rotationAmount),
//                        containsPoint: pointsToExpected.0) == pointsToExpected.1)
//    }
//
////    // we expect this to fail - the alg doesn't handle anything beyond first level cavities (i.e. convex cavities).
////    // this shape has a concave shape subtracted
////    @Test("kiteLevelTwoCavityContainsPoint - all rots", arguments: [
////        // THESE THREE FAIL (alg doesn't handle concave cutaways, some
////        // failure is expected)
////        // inside: the little inner bump
////        (Vec2(x: 5.0, y: 6.02), true),
////        (Vec2(x: 4.98, y: 6.02), true),
////        (Vec2(x: 5.02, y: 6.02), true),
////
////        // The remaing pass:
////
////        // on boundary is inside
////        (Vec2.zero, true),
////        // in kite part, outside
////        (Vec2(x: 5.0, y: 7.5), false),
////
////        // to left of kite bit, inside. fails with convex only alg!
////        (Vec2(x: 1.0, y: 7.5), true),
////
////        (Vec2(x: 0.1, y: 7.5), true),
////        (Vec2(x: 0.1, y: 2.5), true), 
////        (Vec2(x: 9.0, y: 7.5), true),
////
////        (Vec2(x: 4.01, y: 5.99), true),
////        (Vec2(x: 5.99, y: 5.99), true),
////        (Vec2(x: 5.0, y: 5.99), true),
////        (Vec2(x: 5.0, y: 5), true),
////        (Vec2(x: 5.0, y: 1), true),
////        (Vec2(x: 5.0, y: 0.01), true),
////
////        // outside: above the little inner bump
////        (Vec2(x: 5.0, y: 7.1), false),
////        (Vec2(x: 4.01, y: 7.1), false),
////        (Vec2(x: 5.99, y: 7.1), false),
////        (Vec2(x: 4.01, y: 9.9), false),
////        (Vec2(x: 5.99, y: 9.9), false),
////
////        // outside
////        (Vec2(x: -0.1, y: 0.1), false),
////        (Vec2(x: -0.01, y: -0.1), false),
////        (Vec2(x: 0.01, y: -0.1), false),
////        (Vec2(x: -0.01, y: 0.1), false),
////        (Vec2(x: 2.501, y: 10.01), false),
////
////        // very large offsets
////        (Vec2(x: .greatestFiniteMagnitude), false),
////        (Vec2(x: -.greatestFiniteMagnitude), false),
////        (Vec2(y: .greatestFiniteMagnitude), false),
////        (Vec2(y: -.greatestFiniteMagnitude), false),
////    ], 0...5)
////    func test_kiteLevelTwoCavityContainsPointRot(pointsToExpected: (Vec2, Bool), rotationAmount: Int) {
////        #expect(polygon(vertices: kiteLevelTwoCavity.rotateLeft(rotationAmount), containsPoint: pointsToExpected.0) == pointsToExpected.1)
////    }
//
//    @Test("triangleContainsPoint", arguments: [
//        // on boundary is inside
//        (Vec2.zero, true),
//        (Vec2(x: 5, y: 0), true),
//        (Vec2(x: 0, y: 20), true),
//        // centre inside
//        (Vec2(x: 2.5, y: 10), true),
//        // inside
//        (Vec2(x: 2.499, y: 9.99), true),
//        // outside
//        (Vec2(x: -0.01, y: -0.1), false),
//        (Vec2(x: 0.01, y: -0.1), false),
//        (Vec2(x: -0.01, y: 0.1), false),
//        (Vec2(x: 2.501, y: 10.01), false),
//        // very large offsets
//        (Vec2(x: .greatestFiniteMagnitude), false),
//        (Vec2(x: -.greatestFiniteMagnitude), false),
//        (Vec2(y: .greatestFiniteMagnitude), false),
//        (Vec2(y: -.greatestFiniteMagnitude), false),
//    ], 0...2)
//    func test_triangleContainsPointRot(pointsToExpected: (Vec2, Bool), rotationAmount: Int) {
//        #expect(polygon(vertices: triangle.rotateLeft(rotationAmount), containsPoint: pointsToExpected.0) == pointsToExpected.1)
//    }
//
//    @Test("squareContainsPoint", arguments: [
//        // on boundary is inside
//        (Vec2.zero, true),
//        (Vec2(x: 10, y: 10), true),
//        // dead centre inside
//        (Vec2(x: 5.0, y: 5.0), true),
//        // 4 points near square corners (inside)
//        (Vec2(x: 0.1, y: 0.1), true),
//        (Vec2(x: 9.9, y: 0.1), true),
//        (Vec2(x: 9.9, y: 9.9), true),
//        (Vec2(x: 0.1, y: 9.9), true),
//        // 4 points near square corners (outside)
//        (Vec2(x: -0.1, y: 0.1), false),
//        (Vec2(x: 10.1, y: 0.1), false),
//        (Vec2(x: 10.1, y: 9.9), false),
//        (Vec2(x: -0.1, y: 9.9), false),
//        // 4 points near square corners (outside) B
//        (Vec2(x: 0.1, y: -0.1), false),
//        (Vec2(x: 0.9, y: -0.1), false),
//        (Vec2(x: 0.9, y: 10.1), false),
//        (Vec2(x: 0.1, y: 10.1), false),
//        // very large offsets
//        (Vec2(x: .greatestFiniteMagnitude), false),
//        (Vec2(x: -.greatestFiniteMagnitude), false),
//        (Vec2(y: .greatestFiniteMagnitude), false),
//        (Vec2(y: -.greatestFiniteMagnitude), false),
//    ], 0...3)
//    func test_squareContainsPointRot(pointsToExpected: (Vec2, Bool), rotationAmount: Int) {
//        #expect(polygon(vertices: square.rotateLeft(rotationAmount), containsPoint: pointsToExpected.0) == pointsToExpected.1)
//    }
}
