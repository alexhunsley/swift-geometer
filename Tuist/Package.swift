// swift-tools-version: 5.9
// "Add '@preconcurrency' to treat 'Sendable'-related errors from module 'ProjectDescription' as warnings"
@preconcurrency import PackageDescription

#if TUIST
    // "Add '@preconcurrency' to treat 'Sendable'-related errors from module 'ProjectDescription' as warnings"
    @preconcurrency import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: ["GeometerSwift": .dynamicLibrary]
    )
#endif

let package = Package(
    name: "swift-geometer",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
    ]
)
