// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "JKOShop",
    products: [
        .library(name: "Models", targets: ["Models"]),
    ],
    targets: [
        .target(
            name: "Models"
        ),
    ]
)
