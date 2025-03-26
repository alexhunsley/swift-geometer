//
//  PolygonHit.swift
//  SwiftGeometer
//
//  Created by Alex Hunsley on 26/03/2025.
//

import Foundation

public struct Edge: CustomStringConvertible {
    let start: Vec2
    let direction: Vec2

    init(start: Vec2, end: Vec2) {
        self.start = start
        direction = end - start
    }

    public var description: String { "[\(start) \(direction)]" }
}

public func polygon(vertices: [Vec2], containsPoint point: Vec2) -> Bool {
    let edges = vertices.mapPairs(wrap: true, Edge.init(start:end:))
    print("goom: ", edges)

    guard var previousEdge = edges.last else { return false }

    // this set to false if we see a right, since we might have finished a cavity
//    var isInsideCurrentCavity = false

    var failOnNextRight = false

    var prev_pointIsToLeft = (point - previousEdge.start).isToLeft(ofVector: previousEdge.direction)

    // incremented on every left
    var numLefts = 0

    print("** start edge loop")
    for edge in edges {
        let edgeIsRightTurn = edge.direction.isToRight(ofVector: previousEdge.direction)
        previousEdge = edge

        print("**  edge = \(edge), is right turn = \(edgeIsRightTurn)")

        if edgeIsRightTurn {
            numLefts = 0
            print("**  >>> right turn")
//            isInsideCurrentCavity = false

            if failOnNextRight {
//            if isInsideCurrentCavity {
                print("**   RET false! is right turn, and failOnNextRight == true")
//                print("**   RET false! is right turn and isInsideCurrentCavity == true")

                return false
            }
        }
        else {
            numLefts += 1
            print("**  <<< left turn (count: \(numLefts))")
            // a left turn = default to being in a cavity.
            // we set false if we to right at any point
//            isInsideCurrentCavity = true

            if numLefts == 1 {
                // on first left, use previous in/out
                failOnNextRight = prev_pointIsToLeft
            }
            else {
                failOnNextRight = true
            }
        }

        // ah. add check of previous turn here.
        //

        let pointIsToLeft = (point - edge.start).isToLeft(ofVector: edge.direction)
        if pointIsToLeft {
//            return false
//            failOnNextRight = true
        }
        else if !edgeIsRightTurn {
//            isInsideCurrentCavity = false
            print("**   !edgeIsRightTurn == false so setting failOnNextRight = false")
            failOnNextRight = false
        }
        prev_pointIsToLeft = pointIsToLeft

        print("**  have assigned failOnNextRight = \(failOnNextRight)")
    }
    return true
}
