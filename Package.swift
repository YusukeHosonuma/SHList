// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHList",
    products: [
        .library(name: "SHList", targets: ["SHList"]),
        .executable(name: "SHListGen", targets: ["SHListGen"]),
        .library(name: "SHListGenLib", targets: ["SHListGenLib"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "SHList", dependencies: []),
        .testTarget(name: "SHListTests", dependencies: ["SHList"]),
        .target(name: "SHListGen", dependencies: ["SHListGenLib"]),
        .target(name: "SHListGenLib", dependencies: []),
        .testTarget(name: "SHListGenLibTests", dependencies: ["SHListGenLib"]),
    ]
)
