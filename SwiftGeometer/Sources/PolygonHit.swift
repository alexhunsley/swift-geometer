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

    let edgesMap = vertices.mapPairs(wrap: true, Edge.init(start:end:))

    // add first edge to end, we process that twice due to how alg works
    let edges = edgesMap + [edgesMap.first!]

    guard var previousEdge = edgesMap.first else { return false }
    var start_edge_index = 1

    while true {
        let edge = edges[start_edge_index]
        if edge.direction.isToRight(ofVector: previousEdge.direction) {
            break
        }
        previousEdge = edge

        start_edge_index = (start_edge_index + 1) % (vertices.count + 1)
        // TODO put a check for it being 1 again after incr?
        // to avoid looping forever in worst case.
    }

    print("Start index: \(start_edge_index) for ")
    var failOnNextRight = false
    var numLefts = 0

    var edge_index = start_edge_index

    let max_edges_scan = vertices.count + 1
    var edges_scanned = 0

    while edges_scanned <= max_edges_scan {
        edges_scanned += 1

        let edge = edges[edge_index]
        let edgeIsRightTurn = edge.direction.isToRight(ofVector: previousEdge.direction)
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
                // is previous point to left?
                failOnNextRight = (point - previousEdge.start).isToLeft(ofVector: previousEdge.direction)
                print("**  <> assigning prev_pointIsToLeft = \(failOnNextRight) to failOnNextRight")
            }
        }
        print("**  end of loop, got failOnNextRight = \(failOnNextRight)")
        previousEdge = edge

        edge_index = (edge_index + 1) % (vertices.count + 1)
    }
    return true
}
