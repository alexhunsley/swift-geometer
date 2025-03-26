//
//  CollectionHelpersTests.swift
//  SwiftGeometerTests
//
//  Created by Alex Hunsley on 26/03/2025.
//

import Testing

struct CollectionHelpersTests {
    @Test("mapWrappedPairs", arguments: [
        ([], []),
        ([1], []),
        ([1, 2], ["1.2", "2.1"]),
        ([1, 2, 3, 4], ["1.2", "2.3", "3.4", "4.1"]),
        // contiguous repeated instances of an Equatable aren't 'deduplicated' somehow
        ([1, 1, 2, 2, 2, 3, 1], ["1.1", "1.2", "2.2", "2.2", "2.3", "3.1", "1.1"]),
    ])
    func test_mapWrappedPairs(values: [Int], expected: [String]) {
        let output: [String] = values.mapPairs(wrap: true) { a, b in "\(a).\(b)" }
        #expect(output == expected)
    }

    @Test("mapPairs", arguments: [
        ([], []),
        ([1], []),
        ([1, 2], ["1.2"]),
        ([1, 2, 3, 4], ["1.2", "2.3", "3.4"]),
        // contiguous repeated instances of an Equatable aren't 'deduplicated' somehow
        ([1, 1, 2, 2, 2, 3, 1], ["1.1", "1.2", "2.2", "2.2", "2.3", "3.1"]),
    ])
    func test_mapPairs(values: [Int], expected: [String]) {
        let output: [String] = values.mapPairs { a, b in "\(a).\(b)" }
        #expect(output == expected)
    }
}
