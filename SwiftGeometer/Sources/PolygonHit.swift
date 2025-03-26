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
    // add first edge to end, we process that twice due to how alg works
    let edgesLooped = edges + [edges.first!]

    var isFirstLoop = true

    for edge in edgesLooped {
        let edgeIsRightTurn = edge.direction.isToRight(ofVector: previousEdge.direction)
        previousEdge = edge

        print("**  edge = \(edge), curr edge is right turn = \(edgeIsRightTurn)")

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

            if numLefts == 1, !isFirstLoop {
                // on first left, use previous in/out
                // -- actually think can just use false here, since we got this far! (prev edge was usualy L/R check and we passed it?
                // -- if we start in middle of concave section, this causes failure, since we don't
                // actually know that numLefts == 1 here!

                failOnNextRight = prev_pointIsToLeft
                print("**  <> assigning prev_pointIsToLeft = \(failOnNextRight) to failOnNextRight")
//                failOnNextRight = true
            }
            else {
//                failOnNextRight = true
            }
        }

        // ah. add check of previous turn here.
        //

        let pointIsToLeft = (point - edge.start).isToLeft(ofVector: edge.direction)
        print("**  pointIsToLeft = \(pointIsToLeft)")

        // keeping isFirstLoop below makes kite tests pass but not square,
        // getting rid of it does v.v.
        if pointIsToLeft && edgeIsRightTurn { //}&& isFirstLoop {
            failOnNextRight = true
        }
        
        if !pointIsToLeft && !edgeIsRightTurn { //}&& isFirstLoop  {

//            failOnNextRight = false
//            if !edgeIsRightTurn {
                //            isInsideCurrentCavity = false
            print("**   !edgeIsRightTurn == false so setting failOnNextRight = false")
            failOnNextRight = false
//            }
        }
        prev_pointIsToLeft = pointIsToLeft

        print("**  end of loop, got failOnNextRight = \(failOnNextRight)")

        isFirstLoop = false
    }
    return true
}
