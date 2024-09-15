// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGeometer",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftGeometer",
            targets: ["SwiftGeometer"]),
    ],
    targets: [
        .target(
            name: "SwiftGeometer",
            path: "SwiftGeometer/Sources"
        ),
        .testTarget(
            name: "SwiftGeometerTests",
            path: "SwiftGeometer/Tests",
            dependencies: ["SwiftGeometer"]),
    ]
)
