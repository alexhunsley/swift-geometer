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

func p(_ str: String) {
//    p(str)
}

public func polygon(vertices: [Vec2], containsPoint point: Vec2) -> Bool {

    let edges = vertices.mapPairs(wrap: true, Edge.init(start:end:))

    guard var previousEdge = edges.first else { return false }
    var start_edge_index = 1

    // only check right edges if they are to right of prevCheckedRightTurnEdge
//    var prevCheckedRightTurnEdge = Vec2.zero

    while true {
        let edge = edges[start_edge_index]
        if edge.direction.isToRight(ofVector: previousEdge.direction) {
            break
        }
        previousEdge = edge

        start_edge_index = (start_edge_index + 1) % vertices.count
        // TODO put a check for it being 1 again after incr?
        // to avoid looping forever in worst case.
    }

    p("Start index: \(start_edge_index) for ")
    var failOnNextRight = false
    var numLefts = 0

    var edge_index = start_edge_index

    var edges_scanned = 0

    while edges_scanned <= vertices.count {
        edges_scanned += 1

        let edge = edges[edge_index]
        let edgeStartIsRightTurn = edge.direction.isToRight(ofVector: previousEdge.direction)
        p("**  edge = \(edge), curr edge is right turn = \(edgeStartIsRightTurn)")
        // TODO lazify this?
        let pointIsToLeft = (point - edge.start).isToLeft(ofVector: edge.direction)
        p("**  pointIsToLeft = \(pointIsToLeft)")

        if edgeStartIsRightTurn {
            if failOnNextRight {
                p("**   RET false! is right turn, and failOnNextRight == true")
                return false
            }
            p("**  >>> right turn, reset numLefts to 0")
            numLefts = 0

//            if prevCheckedRightTurnEdge == .zero || edge.direction.isToRight(ofVector: prevCheckedRightTurnEdge) {
//                prevCheckedRightTurnEdge = edge.direction
                if pointIsToLeft {
                    failOnNextRight = true
                }
//            }
        }
        else {
            numLefts += 1
            p("**  <<< left turn (count: \(numLefts))")
            if !pointIsToLeft {
                p("**   !edgeIsRightTurn == false so setting failOnNextRight = false")
                failOnNextRight = false
            }
            else if numLefts == 1 {
                // is previous point to left?
                failOnNextRight = (point - previousEdge.start).isToLeft(ofVector: previousEdge.direction)
                p("**  <> assigning prev_pointIsToLeft = \(failOnNextRight) to failOnNextRight")
            }
        }
        p("**  end of loop, got failOnNextRight = \(failOnNextRight)")
        previousEdge = edge
        edge_index = (edge_index + 1) % vertices.count
    }
    return true
}
