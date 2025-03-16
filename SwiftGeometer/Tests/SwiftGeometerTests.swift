import Foundation
import SwiftGeometer
import SwiftUI

import Testing

final class SwiftGeometerTests {
    @Test("Vec2 artithmetic helpers", arguments: [
        (Vec2(x: 1.0, y: -2.0) / 2.0, Vec2(x: 0.5, y: -1.0)),
        (Vec2(x: 1.0, y: -2.0) / -2.0, Vec2(x: -0.5, y: 1.0)),

        (Vec2(x: -1.0, y: 2.0) * 2.0, Vec2(x: -2.0, y: 4.0)),
        (Vec2(x: -1.0, y: 2.0) * -2.0, Vec2(x: 2.0, y: -4.0)),

        (Vec2(x: -1.0, y: 2.0) + Vec2(x: 0.2, y: 0.3), Vec2(x: -0.8, y: 2.3)),
        (Vec2(x: -1.0, y: 2.0) - Vec2(x: 0.2, y: 0.3), Vec2(x: -1.2, y: 1.7)),
        (-Vec2(x: -1.0, y: 2.0) - Vec2(x: 0.2, y: 0.3), Vec2(x: 0.8, y: -2.3)),

        (-Vec2(x: 11.2, y: -15.9), Vec2(x: -11.2, y: 15.9)),
        (-(-Vec2(x: 11.2, y: -15.9)), Vec2(x: 11.2, y: -15.9)),
        // @Test args list doesn't like the amount of brackets below!
        // -- ah, this evaluates to same as a few lines above. and repeated values
        // are know to cause the issue. see forums.swift.org/t/fatal-error-internal-inconsistency-no-test-reporter-for-test-case-argumentids/75666/3
        //  -- now fixed by tweaking values so not identical
        (-(-(-Vec2(x: -11.2, y: -15.9))), Vec2(x: 11.2, y: 15.9)),
        (-(-(-(-Vec2(x: -11.0, y: -15.9)))), Vec2(x: -11.0, y: -15.9))
    ].map(Pair.init))
    func test_whenUsingVec2ArithmeticHelpers_thenCorrectValuesFound(pointPair points: Pair<Vec2, Vec2>) {
        points.a.isAlmostEqual(points.b)
    }

    // TODO fix this
    @Test("angle polar to cartesian YYYYY with angle offset X1", arguments: [
        // plain angle and radius to coordinate
        (0.0, 2.5, Angle.ninety, Vec2(x: 0, y: 2.5)),
        (0.0, 2.6, Angle.ninety, Vec2(x: 0, y: 2.6))
    ].map(Quad.init))
    func test_anglePolarToCartesianWithAngleOffsetXYZ(quad: Quad<Double, Double, Angle, Vec2>) {
        Angle(degrees: quad.a).coordinate(withRadius: quad.b, angleOffset: quad.c).isAlmostEqual(quad.d)
    }

    @Test("angle polar to cartesian", arguments: [
        // plain angle and radius to coordinate2
        (0.0, 1.0, Vec2(x: 1, y: 0)),
        (90, 1.0, Vec2(x: 0, y: 1)),
        (180, 1.0, Vec2(x: -1, y: 0)),
        (270, 1.0, Vec2(x: 0, y: -1)),
        (0, 2.5, Vec2(x: 2.5, y: 0)),
        (90, 2.5, Vec2(x: 0, y: 2.5)),
        (180, 2.5, Vec2(x: -2.5, y: 0)),
        (270, 2.5, Vec2(x: 0, y: -2.5))
    ].map(Triple.init))
    func test_anglePolarToCartesian(triple: Triple<Double, Double, Vec2>) {
        Angle(degrees: triple.a).coordinate(withRadius: triple.b).isAlmostEqual(triple.c)
    }

    @Test("angle operators", arguments: [
        (Angle(degrees: 50) - Angle(degrees: 20), Angle(degrees: 30)),
        (-1.5 * -Angle(degrees: -80), Angle(degrees: -120)),
        (Angle(degrees: -80) * 2, Angle(degrees: -160)),
        (Angle(degrees: 80) / 2, Angle(degrees: 40)),
        (Angle(degrees: 50) + Angle(degrees: 20), Angle(degrees: 70)),
        (Angle(degrees: 50) - Angle(degrees: 20), Angle(degrees: 30)),
        (Angle(degrees: 20) + Angle(degrees: 50), Angle(degrees: 70)),
        (Angle(degrees: 20) - Angle(degrees: 50), Angle(degrees: -30))
    ].map(Pair.init))
    func test_angleOperators(pair: Pair<Angle, Angle>) {
        pair.a.isAlmostEqual(pair.b)
    }

    @Test("Vec2 init helpers", arguments: [
        (Vec2(x: 2.3), Vec2(x: 2.3, y: 0)),
        (Vec2(y: -7.12), Vec2(x: 0, y: -7.12)),
        (Vec2(x: 0), Vec2.zero),
        (Vec2(y: 0), Vec2.zero),
        (Vec2(xy: 0), Vec2.zero)
    ].map(Pair.init))
    func test_Vec2InitHelpers(pointPair: Pair<Vec2, Vec2>) {
        pointPair.a.isAlmostEqual(pointPair.b)
    }

    @Test("Vec2 init helpers -- not equal", arguments: [
        (Vec2.undefined, Vec2.undefined)
    ].map(Pair.init))
    func test_Vec2InitHelpers_notEqual(pointPair: Pair<Vec2, Vec2>) {
        pointPair.a.isAlmostEqual(pointPair.b, negateCheck: true)
    }

    private static let xyEdgeLenPoint: Vec2 = .init(xy: Triangle<CGFloat>.Right.hypot)

    @Test("polarConversion", arguments: [
        (Angle.zero, 1.0, Vec2(x: 1)),
        (Angle.ninety, 1.0, Vec2(y: 1)),
        (Angle.oneEighty, 1.0, Vec2(x: -1)),
        (Angle.twoSeventy, 1.0, Vec2(y: -1)),
        (Angle.fortyFive, 1.0, Vec2.unitLine),
        (Angle.fortyFive + Angle.ninety, 1.0, Vec2.unitLine.negatedX),
        (Angle.fortyFive + 2 * Angle.ninety, 1.0, Vec2.unitLine.negatedX.negatedY),
        (Angle.fortyFive + 3 * Angle.ninety, 1.0, Vec2.unitLine.negatedY),

        (Angle.fortyFive, 2.0, xyEdgeLenPoint),

        (Angle.fortyFive + Angle.ninety, 2.0, xyEdgeLenPoint.negatedX),
        (Angle.fortyFive + 2 * Angle.ninety, 2.0, xyEdgeLenPoint.negatedX.negatedY),
        (Angle.fortyFive + 3 * Angle.ninety, 2.0, xyEdgeLenPoint.negatedY)
    ].map(Triple.init))
    func test_polarConversion(pair: Triple<Angle, Double, Vec2>) {
        // interesting! We can use this var in the test params above.
        // I guess because above test params macro puts code into the body of func.
        PolarCoord(angle: pair.a, radius: pair.b).cartesianCoord.isAlmostEqual(pair.c)

        // NB there's a CGVector! It uses Doubles not CGFloat.
        // note this in the readme. My Vec2 is CGFloat so maybe worth keeping? Or CGVector just as nice? - no can't directly use.
        //        let x: CGVector = Vec2.zero  // <-- no compile
    }

    @Test("angle between", arguments: [
        (Vec2(x: 0, y: 1), Vec2(x: 0, y: 1), Angle.zero),
        (Vec2(x: -1, y: 0), Vec2(x: -1, y: 0), Angle.zero),
        (Vec2(x: -0.5, y: 58), Vec2(x: -0.5, y: 58), Angle.zero),
        (Vec2(x: 0, y: 1), Vec2(x: 1, y: 0), Angle.ninety),
        (Vec2(x: 0, y: 1), Vec2(x: -1, y: 0), Angle.ninety),
        (Vec2(x: 1, y: -1), Vec2(x: -1, y: 1), Angle.oneEighty),
        (Vec2(x: 0.5, y: 58), Vec2(x: -0.5, y: -58), Angle.oneEighty)
    ])
    func test_angleBetween(vectorA: Vec2, vectorB: Vec2, expectedAngle: Angle) {
        Angle.between(vector: vectorA, andVector: vectorB).isAlmostEqual(expectedAngle)
    }

    @Test("rotate point", arguments: [
        (Vec2(x: 1, y: 0), Angle.ninety, Vec2(x: 0, y: 1)),
        (Vec2(x: 1, y: 0), Angle.oneEighty, Vec2(x: -1, y: 0)),
        (Vec2(x: 1, y: 0), Angle.twoSeventy, Vec2(x: 0, y: -1)),
        // -90 is same as +270
        (Vec2(x: 1, y: 0), -Angle.ninety, Vec2(x: 0, y: -1)),
    ])
    func test_rotateVec2(pointA: Vec2, angle: Angle, expectedPoint: Vec2) {
        pointA.rotate(byAngle: angle).isAlmostEqual(expectedPoint)
    }

    @Test("two rotations of point", arguments: [
        // two 45 rotations = 90 degree rotation
        (Vec2(x: 1, y: 0), Angle.fortyFive, Angle.fortyFive, Vec2(x: 0, y: 1)),
        // 45 then -45 rotation = 0 degree rotation overall
        (Vec2(x: 1, y: 0), Angle.fortyFive, -Angle.fortyFive, Vec2(x: 1, y: 0)),
        (Vec2(x: 1, y: 0), Angle.thirty, Angle.sixty, Vec2(x: 0, y: 1))

    ])
    func test_rotateVec2Twice(pointA: Vec2, firstAngle: Angle, secondAngle: Angle, expectedPoint: Vec2) {
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
        #expect(vectorA.projection(ontoVector: Vec2.zero).isUndefined)
    }

    @Test("vector projection", arguments: [
        // zero sized A vecs projected onto vectors result in .zero
        (Vec2.zero, Vec2(x: 11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: 4), Vec2.zero),
        // orth vecs result in .zero
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
        // the projected vector is a positive multiple of B when angle between them < 90
        (Vec2(x: -1, y: 1), Vec2(y: 4), Vec2(y: 1)),
        (Vec2(x: 1, y: 1), Vec2(y: 4), Vec2(y: 1)),
        (Vec2(x: -2, y: -3), Vec2(y: 5), Vec2(y: -3))
    ])
    func test_vectorProjection(vectorA: Vec2, vectorB: Vec2, expectedVector: Vec2) {
        vectorA.projection(ontoVector: vectorB).isAlmostEqual(expectedVector)
    }

    @Test("vectorProjectionForward", arguments: [
        // zero sized A vecs (onto non-zero B vecs) result in zero sized projection
        (Vec2.zero, Vec2(x: 11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: 4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: -4), Vec2.zero),
        // orthogonal vecs have zero sized projection
        (Vec2(x: 3, y: -19), Vec2(x: 19, y: 3), Vec2.zero),
        (Vec2(x: 3, y: -19), Vec2(x: -19, y: -3), Vec2.zero),
        (Vec2(x: -3, y: 19), Vec2(x: -19, y: -3), Vec2.zero),
        (Vec2(x: -3, y: 19), Vec2(x: 19, y: 3), Vec2.zero),
        // orthogonal vecs multipled up have zero sized projection
        (Vec2(x: 1, y: -4), Vec2(x: 8, y: 2), Vec2.zero),
        (Vec2(x: 1, y: -4), Vec2(x: -8, y: -2), Vec2.zero),
        (Vec2(x: -0.1, y: 0.4), Vec2(x: -8, y: -2), Vec2.zero),
        (Vec2(x: -0.1, y: 0.4), Vec2(x: 8, y: 2), Vec2.zero),
        // the projection has vec a's length projected when b is smaller
        (Vec2(x: 1, y: 1), Vec2(y: 0.1), Vec2(y: 1)),
        // the projection has vec a's length projected when b is larger
        (Vec2(x: 1, y: 1), Vec2(y: 2), Vec2(y: 1)),
        // the projected vector is a positive mulitple of B when angle between them > 90
        (Vec2(x: -1, y: -1), Vec2(y: 3), Vec2(y: 1)),
        (Vec2(x: 1, y: -1), Vec2(y: 3), Vec2(y: 1)),
        // the projected vector is a positive multiple of B when angle between them < 90
        (Vec2(x: -1, y: 1), Vec2(y: 4), Vec2(y: 1)),
        (Vec2(x: 1, y: 1), Vec2(y: 4), Vec2(y: 1)),
        (Vec2(x: -2, y: -3), Vec2(y: 5), Vec2(y: 3))
    ].map(Triple.init))
    func test_vectorProjectionForward(triple: Triple<Vec2, Vec2, Vec2>) {
        triple.a.projectionForward(ontoVector: triple.b).isAlmostEqual(triple.c)
    }

    @Test("vectorProjectionForward_undefinedResult", arguments: [
        // zero sized B vecs result in undefined projection
        (Vec2.zero, Vec2.zero, Vec2.undefined),
        (Vec2(x: 4, y: -11), Vec2.zero, Vec2.undefined),
        (Vec2(x: -4, y: 11), Vec2.zero, Vec2.undefined),
        (Vec2(x: -4, y: -11), Vec2.zero, Vec2.undefined),
        (Vec2(x: 4, y: 11), Vec2.zero, Vec2.undefined)
    ].map(Triple.init))
    func test_vectorProjectionForward_isUndefined(triple: Triple<Vec2, Vec2, Vec2>) {
        #expect(triple.a.projectionForward(ontoVector: triple.b).isUndefined)
    }

    @Test("vectorRejection", arguments: [
        // zero sized A vecs rejected onto vectors result in .zero
        (Vec2.zero, Vec2(x: 11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: -4), Vec2.zero),
        (Vec2.zero, Vec2(x: -11, y: 4), Vec2.zero),
        // colinear vecs result in .zero
        (Vec2(x: -11, y: -4), Vec2(x: -11, y: -4), Vec2.zero),
        (Vec2(x: -11, y: -4), Vec2(x: 11, y: 4), Vec2.zero),
        (Vec2(x: -11, y: -4), Vec2(x: -22, y: -8), Vec2.zero),
        (Vec2(x: -11, y: -4), Vec2(x: 22, y: 8), Vec2.zero),
        // the rejection has vec a's length projected when b is smaller
        (Vec2(x: 1, y: 1), Vec2(y: 0.1), Vec2(x: 1)),
        // the rejection has vec a's length projected when b is larger
        (Vec2(x: 1, y: 1), Vec2(y: 2), Vec2(x: 1)),
        // the rejected vector is a negative mulitple of B when angle between them > 90
        (Vec2(x: -1, y: -1), Vec2(y: 3), Vec2(x: -1)),
        (Vec2(x: 1, y: -1), Vec2(y: 3), Vec2(x: 1)),
        // the rejected vector is a positive multiple of B when angle between them < 90
        (Vec2(x: -1, y: 1), Vec2(y: 4), Vec2(x: -1)),
        (Vec2(x: 1, y: 1), Vec2(y: 4), Vec2(x: 1)),
        (Vec2(x: -2, y: -3), Vec2(y: 5), Vec2(x: -2)),
        // the rejection of A left of B --> A left of B
        (Vec2(x: 2, y: 7), Vec2(x: 5, y: 0), Vec2(y: 7)),
        (Vec2(x: 2, y: 3), Vec2(x: 5, y: 0), Vec2(y: 3)),
        // the rejection of A right of B --> A right of B
        (Vec2(x: 10, y: -7), Vec2(x: 5, y: 0), Vec2(y: -7)),
        (Vec2(x: 12, y: -2), Vec2(x: 5, y: 0), Vec2(y: -2)),
    ].map(Triple.init))
    func test_vectorRejection(triple: Triple<Vec2, Vec2, Vec2>) {
        triple.a.rejection(ontoVector: triple.b).isAlmostEqual(triple.c)
    }

    @Test("sum of projection and rejection of (A->B) equals the B vector", arguments: [
        (Vec2.zero, Vec2(x: -5, y: 2)),
        (Vec2(x: 2, y: 7), Vec2(x: -5, y: 2)),
        (Vec2(x: -8.2, y: 2025), Vec2(x: 5, y: -99)),
        // orth pair
        (Vec2(x: 2.5, y: -1.7), Vec2(x: 1.7, y: 2.5)),
        (Vec2(x: 2.5, y: -1.7), Vec2(x: -1.7, y: -2.5)),
        // colinear pair
        (Vec2(x: 2.5, y: -1.7), Vec2(x: 2.5, y: -1.7)),
        (Vec2(x: 2.5, y: -1.7), Vec2(x: -2.5, y: 1.7)),
    ].map(Pair.init))
    func test_sumOfProjectionAndRejectionIsVectorA(pair: Pair<Vec2, Vec2>) {
        let proj = pair.a.projection(ontoVector: pair.b)
        let rej = pair.a.rejection(ontoVector: pair.b)
        (proj + rej).isAlmostEqual(pair.a)
    }

    @Test("vector rotate 180", arguments: [
        (Vec2.zero, .zero),
        (Vec2(x: 3), Vec2(x: -3)),
        (Vec2(x: -3), Vec2(x: 3)),
        (Vec2(y: 3), Vec2(y: -3)),
        (Vec2(y: -3), Vec2(y: 3)),
        (Vec2(x: -2, y: 3), Vec2(x: 2, y: -3)),
        (Vec2(x: 2, y: -3), Vec2(x: -2, y: 3))
    ].map(Pair.init))
    func test_vectorRotate180(pair: Pair<Vec2, Vec2>) {
        pair.a.rotated180.isAlmostEqual(pair.b)
        pair.a.rotated180.rotated180.isAlmostEqual(pair.a)
        (-(pair.a)).isAlmostEqual(pair.b)
    }

    @Test("vector rotate 90 degs", arguments: [
        (Vec2.zero, .zero),
        (Vec2(x: 3), Vec2(y: 3)),
        (Vec2(y: -3), Vec2(x: 3)),
        (Vec2(x: -3), Vec2(y: -3)),
        (Vec2(x: 2, y: 3), Vec2(x: -3, y: 2)),
        (Vec2(x: 3, y: -2), Vec2(x: 2, y: 3)),
        (Vec2(x: -2, y: -3), Vec2(x: 3, y: -2)),
        (Vec2(x: -3, y: 2), Vec2(x: -2, y: -3)),
    ].map(Pair.init))
    func test_vectorRotate90(pair: Pair<Vec2, Vec2>) {
        pair.a.rotated90CCW.isAlmostEqual(pair.b)
        pair.a.rotated90CW.isAlmostEqual(-pair.b)
        pair.a.rotated90CCW.rotated90CW.isAlmostEqual(pair.a)
        pair.b.rotated90CCW.rotated90CCW.rotated90CCW.isAlmostEqual(pair.b.rotated90CW)
        pair.b.rotated90CCW.rotated90CCW.rotated90CCW.rotated90CCW.isAlmostEqual(pair.b)
    }

    @Test("is to side is false for same value", arguments: [
        (Vec2.zero, Vec2.zero),
        (Vec2(xy: 1.1), Vec2(xy: 1.1)),
        (Vec2(xy: -2.5), Vec2(xy: -2.5)),
        (Vec2(xy: 1.1), -Vec2(xy: 1.1)),
        (Vec2(xy: -2.5), -Vec2(xy: -2.5)),
    ].map(Pair.init))
    func test_vectorIsToSideForZeroAndZero(pair: Pair<Vec2, Vec2>) {
        #expect(!pair.a.isToLeft(ofVector: pair.b))
        #expect(!pair.a.isToRight(ofVector: pair.b))
    }

    @Test("is to side is false for zero and vector", arguments: [
        (Vec2.zero, Vec2(xy: 1.1)),
        (Vec2.zero, Vec2(xy: -2.95)),
        (Vec2.zero, Vec2(x: -1, y: 17.2345)),
    ].map(Pair.init))
    func test_vectorIsToSideForZeroAndVector(pair: Pair<Vec2, Vec2>) {
        // a, b
        #expect(!pair.a.isToLeft(ofVector: pair.b))
        #expect(!pair.a.isToRight(ofVector: pair.b))
        // and other way round: b, a
        #expect(!pair.b.isToLeft(ofVector: pair.a))
        #expect(!pair.b.isToRight(ofVector: pair.a))
    }

    @Test("is to side", arguments: [
        (Vec2(x: -1, y: 1), Vec2(y: 9)),
        (Vec2(x: -0.01, y: 0.1), Vec2(y: 1)),
        (Vec2(x: -0.01, y: 999.12), Vec2(y: 0.01)),
        (Vec2(x: -9999.01, y: 0.0001), Vec2(y: 0.01)),
        (Vec2(x: 9999.01, y: -0.0001), Vec2(y: -0.01)),
        (Vec2(x: 0.01, y: -0.0001), Vec2(y: -999998)),
    ].map(Pair.init))
    func test_vectorIsToSide(pair: Pair<Vec2, Vec2>) {
        // a, b
        #expect(pair.a.isToLeft(ofVector: pair.b))
        #expect(!pair.a.isToRight(ofVector: pair.b))
        #expect(pair.b.isToRight(ofVector: pair.a))
        #expect(!pair.b.isToLeft(ofVector: pair.a))
    }

    @Test("vec is same direction as itself", arguments: [
        Vec2(y: 1),
        Vec2(x: -1, y: 1),
        Vec2(x: -0.01, y: 0.1),
        Vec2(x: -0.01, y: 999.12),
        Vec2(y: 0.01),
        Vec2(y: -0.01),
        Vec2(x: -9999.01, y: 0.0001),
        Vec2(x: 9999.01, y: -0.0001),
        Vec2(x: 0.01, y: -0.0001),
        Vec2(y: -999998),
    ])
    func test_vectorIsSameDirectionAsItself(value: Vec2) {
        // a, b
        #expect(value.isSameDirection(asVector: value))
        #expect(value.isOppositeDirection(asVector: -value))
    }

    @Test("quadrant for reference vec", arguments: [
        (Vec2(y: 1), Vec2(y: 1), Quadrant.northEast),
    ].map(Triple.init))
    func test_quadrant(triple: Triple<Vec2, Vec2, Quadrant>) {
        #expect(triple.a.quadrant(referenceVector: triple.b) == triple.c)
    }


    // end real tests



//        #expect(Vec2(y: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
//        #expect(Vec2(x: 1, y: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
//        #expect(Vec2(x: 99, y: 0.1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
//
//        // what about the edge cases? that lie on two quadrants?
//        // this is neither NE or SE.
//        // make a strict quadrant?
//        // or just have default 'quadrant' impl pref north, and right?
//        // ^^ latter part is what happens now.
//        // this tests that:
//        #expect(Vec2(x: 1).quadrant(referenceVector: Vec2(y: 1)) == .northEast)
//        #expect(Vec2(y: -1).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
//        #expect(Vec2(x: -1).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
//
//        #expect(Vec2(x: 2, y: -0.01).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
//        #expect(Vec2(x: 0.001, y: -100).quadrant(referenceVector: Vec2(y: 1)) == .southEast)
//
//        #expect(Vec2(x: -0.001, y: -100).quadrant(referenceVector: Vec2(y: 1)) == .southWest)
//        #expect(Vec2(x: -200, y: -0.01).quadrant(referenceVector: Vec2(y: 1)) == .southWest)
//
//        #expect(Vec2(x: -200, y: 0.01).quadrant(referenceVector: Vec2(y: 1)) == .northWest)
//        #expect(Vec2(x: -0.01, y: 0.98).quadrant(referenceVector: Vec2(y: 1)) == .northWest)





////    @Test
////    func test_vectorRejectionLeft() {
////        // the rejection of A left of B --> A right of B
////        #expect(Vec2(x: 2, y: 7).rejectionLeft(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//////        #expect(Vec2(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
////
////        // the rejection of A right of B --> A left of B
////        #expect(Vec2(x: 2, y: -7).rejectionLeft(ontoVector: Vec2(x: 5, y: 0)) == Vec2(y: 7))
//////        #expect(Vec2(x: 2, y: -2).rejection(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
////
////    }
////
////    // don't think this make sense
//////    func test_vectorPositiveOrthogonalProjection() {
//////        // zero a sized A vecs have zero sized projection
//////        #expect(Vec2.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: -4)), .zero)
//////        #expect(Vec2.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: 11, y: 4)), .zero)
//////        #expect(Vec2.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: 4)), .zero)
//////        #expect(Vec2.zero.positiveProjectedOrthogonally(ontoVector: Vec2(x: -11, y: -4)), .zero)
//////
//////        // zero a sized B vecs have undefined projection
//////        assert(Vec2(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////        assert(Vec2(x: -4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////        assert(Vec2(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////        assert(Vec2(x: 4, y: 11).positiveProjectedOrthogonally(ontoVector: .zero).isUndefined)
//////
//////        // colinear vecs have zero sized orth projection
//////        #expect(Vec2(x: 4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: 4, y: -11)), .zero)
//////        #expect(Vec2(x: -4, y: -11).positiveProjectedOrthogonally(ontoVector: Vec2(x: -4, y: -11)), .zero)
//////        #expect(Vec2(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: 20)), .zero)
//////        #expect(Vec2(x: 0, y: 10).positiveProjectedOrthogonally(ontoVector: Vec2(x: 0, y: -20)), .zero)
//////
//////        // the projected orth vector is to right of B
//////        #expect(Vec2(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: 7))
//////        #expect(Vec2(x: 2, y: -2).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)), Vec2(y: -2))
//////
//////        // sum of projection and orth project equals the original B vector
//////        #expect(Vec2(x: 2, y: 7).projected(ontoVector: Vec2(x: 5, y: 0))
//////            + Vec2(x: 2, y: 7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 5, y: 0)),
//////                    Vec2(x: 2, y: 7))
//////
//////        // when colinear: sum of projection and orth project equals the original B vector
//////        #expect(Vec2(x: -2, y: -7).projected(ontoVector: Vec2(x: -2, y: -7))
//////            + Vec2(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: -2, y: -7)),
//////                    Vec2(x: -2, y: -7))
//////
//////        // when orth: sum of projection and orth project equals the original B vector
//////        #expect(Vec2(x: -2, y: -7).projected(ontoVector: Vec2(x: 7, y: -2))
//////            + Vec2(x: -2, y: -7).positiveProjectedOrthogonally(ontoVector: Vec2(x: 7, y: -2)),
//////                    Vec2(x: -2, y: -7))
//////    }
////
////
////    // use CGVector!
////    @Test
////    func test_rotate() {
////        #expect(Vec2(x: 1).rotate(byVector: Vec2(y: 1)) == Vec2(x: 1))
////        #expect(Vec2(y: 1).rotate(byVector: Vec2(y: 1)) == Vec2(y: 1))
////        #expect(Vec2(x: -1).rotate(byVector: Vec2(y: 1)) == Vec2(x: -1))
////        #expect(Vec2(y: -1).rotate(byVector: Vec2(y: 1)) == Vec2(y: -1))
////
////        #expect(Vec2(x: 1).rotate(byVector: Vec2(y: -1)) == Vec2(x: -1))
////        #expect(Vec2(y: 1).rotate(byVector: Vec2(y: -1)) == Vec2(y: -1))
////        #expect(Vec2(x: -1).rotate(byVector: Vec2(y: -1)) == Vec2(x: 1))
////        #expect(Vec2(y: -1).rotate(byVector: Vec2(y: -1)) == Vec2(y: 1))
////
////        #expect(Vec2(x: 1).rotate(byVector: Vec2(x: 1)) == Vec2(y: -1))
////
//////        #expect(Vec2(x: 1).rotate(byVector: Vec2(x: 1)) == Vec2(y: -1))
//////        #expect(Vec2(x: 1) == Vec2(x: 0.5.squareRoot()).rotate(byVector: Vec2(x: 0.5.squareRoot())))
//////        #expect(Vec2.zero == Vec2(x: 0.5.squareRoot()).rotate(byVector: Vec2(x: -0.5.squareRoot())))
//////        #expect(Vec2(x: -1) == Vec2(x: 1).rotate(byVector: Vec2(y: 0.1)))
////    }
////
////    // TODO do lazy calc props so that things not calc mult times if used multiple times?
////    // TODO add generic or similar for notion of unit vector -- which can then
////    // have simpler calculations in specialisations (as we know it's a unit already)



    // collected constant-y ones:

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


    // can't repro Testing problems folk have reported with below
//    enum Yenno {
//        case yes
//        case no
//    }
//
//    @Test("yenno enum test", arguments: [
//        (Yenno.yes, 1),
//        (Yenno.no, 1)
//    ])
//    func test_enum(optional: Yenno, x: Int) {
////        print(optional)
//        #expect(optional == optional)
////        #expect(optional == Yenno.no)
//    }
//
//    @Test("optional enum test", arguments: [
//        Optional.some(false),
//        Optional.none
//    ])
//    func test_enum(optional: Optional<Bool>) {
//        #expect(optional == optional)
//    }
}


/// ____________________________________________________________________________________________________
/// ____________________________________________________________________________________________________
/// ____________________________________________________________________________________________________
/// ____________________________________________________________________________________________________
/// ____________________________________________________________________________________________________
/// ____________________________________________________________________________________________________
/// ____________________________________________________________________________________________________



// BUMPH

////        Int(1).magnitude // ok
////        //        Int(1).magnitudeSquared // not found
////        Double(4.0).magnitudeSquared
////        Float(4.0).magnitudeSquared

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

