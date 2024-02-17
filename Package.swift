// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "JKOShop",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "App", targets: ["App"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "ProductFeature", targets: ["ProductFeature"]),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "ProductFeature",
            ]
        ),
        .target(
            name: "Models"
        ),
        .target(
            name: "ProductFeature",
            dependencies: [
                "Models",
            ]
        )
    ]
)
