// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ErrorFactory",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "ErrorFactory",
            targets: ["ErrorFactory"]),
    ],
    targets: [
        .target(
            name: "ErrorFactory",
            dependencies: []),
        .testTarget(
            name: "ErrorFactoryTests",
            dependencies: ["ErrorFactory"]),
    ]
)
