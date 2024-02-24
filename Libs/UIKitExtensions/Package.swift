// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitExtensions",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UIKitExtensions",
            targets: ["UIKitExtensions"]),
    ],
    dependencies: [.package(name: "ImageLoader",path: "../ImageLoader")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UIKitExtensions", dependencies: ["ImageLoader"]),
        .testTarget(
            name: "UIKitExtensionsTests",
            dependencies: ["UIKitExtensions", "ImageLoader"]),
    ]
)
