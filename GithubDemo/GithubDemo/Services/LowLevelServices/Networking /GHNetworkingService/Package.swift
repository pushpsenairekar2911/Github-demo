// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GHNetworkingService",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GHNetworkingService",
            targets: ["GHNetworkingService"]),
    ],
    dependencies: [],
    targets: [.target(
        name: "GHNetworkingService",
        dependencies: [],
        path: "Sources"),
    ]
)
