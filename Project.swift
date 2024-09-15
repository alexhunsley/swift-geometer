import ProjectDescription

let project = Project(
    name: "swift-geometer",
    targets: [
        .target(
            name: "swift-geometer",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.swift-geometer",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["swift-geometer/Sources/**"],
            resources: ["swift-geometer/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "swift-geometerTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.swift-geometerTests",
            infoPlist: .default,
            sources: ["swift-geometer/Tests/**"],
            resources: [],
            dependencies: [.target(name: "swift-geometer")]
        ),
    ]
)
