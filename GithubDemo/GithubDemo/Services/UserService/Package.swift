// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserService",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserService",
            targets: ["UserService"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../../Services/GHNetworkingService"),
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UserService",
            dependencies: ["GHNetworkingService"]),
        .testTarget(
            name: "UserServiceTests",
            dependencies: ["UserService"]),
    ]
)
