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

public func concavexPolygon(vertices: [Vec2], containsPoint point: Vec2) -> Bool {

    let edges = vertices.mapPairs(wrap: true, Edge.init(start:end:))

    guard var previousEdge = edges.last else { return false }
    var start_edge_index = 0

    while true {
        let edge = edges[start_edge_index]
        if edge.direction.isToRight(ofVector: previousEdge.direction) {
            break
        }
        previousEdge = edge
        start_edge_index += 1
    }

    p("Start index: \(start_edge_index) for ")
    var failOnNextRight = false

    var edge_index = start_edge_index

    var edges_scanned = 0

    while edges_scanned <= vertices.count {
        edges_scanned += 1
        let edge = edges[edge_index]
        let edgeIsToRightPrevEdge = edge.direction.isToRight(ofVector: previousEdge.direction)

        if edgeIsToRightPrevEdge, failOnNextRight {
            return false
        }
        let pointIsToLeftEdge = (point - edge.start).isToLeft(ofVector: edge.direction)
        failOnNextRight = pointIsToLeftEdge && (edgeIsToRightPrevEdge || failOnNextRight)
        previousEdge = edge
        edge_index = (edge_index + 1) % vertices.count
    }
    return true
}
