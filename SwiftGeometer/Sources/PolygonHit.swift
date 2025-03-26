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
    for edge in edges {
        if (point - edge.start).isToLeft(ofVector: edge.direction) {
            return false
        }
    }
    return true
}
