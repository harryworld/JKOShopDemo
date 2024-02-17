// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "JKOShop",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "App", targets: ["App"]),
        .library(name: "CartFeature", targets: ["CartFeature"]),
        .library(name: "ItemRowFeature", targets: ["ItemRowFeature"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "ProductFeature", targets: ["ProductFeature"]),
        .library(name: "SharedServices", targets: ["SharedServices"]),
        .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "ProductFeature",
            ]
        ),
        .target(
            name: "CartFeature",
            dependencies: [
                "ItemRowFeature",
                "SharedServices",
                "SwiftUIHelpers",
            ]
        ),
        .target(
            name: "ItemRowFeature",
            dependencies: [
                "Models",
                "SwiftUIHelpers",
            ]
        ),
        .target(
            name: "Models"
        ),
        .target(
            name: "ProductFeature",
            dependencies: [
                "CartFeature",
                "ItemRowFeature",
                "SharedServices",
                "SwiftUIHelpers",
            ]
        ),
        .target(
            name: "SharedServices",
            dependencies: [
                "Models",
            ]
        ),
        .target(
            name: "SwiftUIHelpers"
        )
    ]
)
