// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Trending",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Trending",
            targets: ["Trending"]),
    ],
    dependencies: [
        .package(name: "TMDBSchemeModels", path: "../TMDBSchemeModels"),
        .package(name: "TMDBRepo",path: "../TMDBRepo"),
        .package(name: "UIModels", path: "../UIModels"),
        .package(name: "UIErrorView", path: "../UIErrorView"),
        .package(name: "MovieDetails", path: "../MovieDetails"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Trending", dependencies: ["TMDBSchemeModels", "TMDBRepo", "UIModels", "UIErrorView", "MovieDetails"]),
        .testTarget(
            name: "TrendingTests",
            dependencies: ["Trending", "TMDBSchemeModels", "TMDBRepo", "UIModels", "UIErrorView", "MovieDetails"]
        ),
    ]
)
