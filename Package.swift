// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "JKOShop",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "App", targets: ["App"]),
        .library(name: "CartFeature", targets: ["CartFeature"]),
        .library(name: "ItemRowFeature", targets: ["ItemRowFeature"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "OrderFeature", targets: ["OrderFeature"]),
        .library(name: "ProductFeature", targets: ["ProductFeature"]),
        .library(name: "SharedServices", targets: ["SharedServices"]),
        .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift", from: "6.24.2"),
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "CartFeature",
                "OrderFeature",
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
            name: "Models",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "SwiftDate", package: "SwiftDate")
            ]
        ),
        .target(
            name: "OrderFeature",
            dependencies: [
                "ItemRowFeature",
                "Models",
                "SharedServices",
                "SwiftUIHelpers",
            ]
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
