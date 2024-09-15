// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGeometer",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftGeometer",
            targets: ["swift-geometer"]),
    ],
    targets: [
        .target(
            name: "swift-geometer",
            path: "Sources/SwiftGeometer"
        ),
        .testTarget(
            name: "swift-geometer-tests",
            path: "Sources/Tests",
            dependencies: ["swift-geometer"]),
    ]
)
