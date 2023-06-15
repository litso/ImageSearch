// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ImgurClient",
            targets: ["ImgurClient"]),
        .library(
            name: "Models",
            targets: ["Models"]
        ),
        .library(
            name: "PackageDependencies",
            targets: ["PackageDependencies"]
        ),
        .library(
            name: "Secrets",
            targets: ["Secrets"]),
        .library(
            name: "SearchResultsFeature",
            targets: ["SearchResultsFeature"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.8.0"))
    ],
    targets: [
        .target(
            name: "ImgurClient",
            dependencies: ["Secrets"]
        ),
        .target(
            name: "PackageDependencies",
            dependencies: [
                "Kingfisher"
            ]
        ),
        .target(name: "Models"),
        .testTarget(
            name: "ModelsTests",
            dependencies: ["Models"]
        ),
        .target(name: "Secrets"),
        .target(
            name: "SearchResultsFeature",
            dependencies: [
                "ImgurClient",
                "Kingfisher",
                "Models"
            ]
        ),
    ]
)
