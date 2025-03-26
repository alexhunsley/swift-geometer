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

    guard var previousEdge = edges.last else { return false }
    var failOnNextRight = false
    var prev_pointIsToLeft = (point - previousEdge.start).isToLeft(ofVector: previousEdge.direction)
    var numLefts = 0

    print("** start edge loop")
    // add first edge to end, we process that twice due to how alg works
    let edgesLooped = edges + [edges.first!]

    for edge in edgesLooped {
        let edgeIsRightTurn = edge.direction.isToRight(ofVector: previousEdge.direction)
        previousEdge = edge
        print("**  edge = \(edge), curr edge is right turn = \(edgeIsRightTurn)")
        // TODO lazify this?
        let pointIsToLeft = (point - edge.start).isToLeft(ofVector: edge.direction)
        print("**  pointIsToLeft = \(pointIsToLeft)")

        if edgeIsRightTurn {
            if failOnNextRight {
                print("**   RET false! is right turn, and failOnNextRight == true")
                return false
            }
            print("**  >>> right turn, reset numLefts to 0")
            numLefts = 0
            if pointIsToLeft {
                failOnNextRight = true
            }
        }
        else {
            numLefts += 1
            print("**  <<< left turn (count: \(numLefts))")
            if !pointIsToLeft {
                print("**   !edgeIsRightTurn == false so setting failOnNextRight = false")
                failOnNextRight = false
            }
            else if numLefts == 1 {
                failOnNextRight = prev_pointIsToLeft
                print("**  <> assigning prev_pointIsToLeft = \(failOnNextRight) to failOnNextRight")
            }
        }
        prev_pointIsToLeft = pointIsToLeft
        print("**  end of loop, got failOnNextRight = \(failOnNextRight)")
    }
    return true
}
