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
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "Models"
            ]
        ),
        .target(
            name: "Models"
        ),
    ]
)
