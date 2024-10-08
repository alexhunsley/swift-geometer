import ProjectDescription

let project = Project(
    name: "SwiftGeometer",
    targets: [
        .target(
            name: "SwiftGeometer",
            destinations: .iOS,
            product: .dynamicLibrary,
            bundleId: "io.tuist.swift-geometer",
//            infoPlist: .extendingDefault(
//                with: [
//                    "UILaunchScreen": [
//                        "UIColorName": "",
//                        "UIImageName": "",
//                    ],
//                ]
//            ),
            sources: ["SwiftGeometer/Sources/**"],
//            resources: ["swift-geometer/Resources/**"],
            dependencies: [],
            settings: .settings(
                base: [
                    "OTHER_SWIFT_FLAGS": [
                        "-Xfrontend", "-strict-concurrency=complete"
                    ]
                ]
            )
        ),
        .target(
            name: "SwiftGeometerTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.swift-geometerTests",
            infoPlist: .default,
            sources: ["SwiftGeometer/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SwiftGeometer")],
            settings: .settings(
                base: [
                    "OTHER_SWIFT_FLAGS": [
                        "-Xfrontend", "-strict-concurrency=complete"
                    ]
                ]
            )
        ),
    ],
    additionalFiles: [
        "Package.swift",
        "README.md"
    ]
)
