// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let minimumChatSDKVersion: Version = "4.20.0"
let xcframeworkVersion = "1.0.0-beta.0"
let xcframeworkChecksum = "abf3c3e36505574d97f6415a23eeb241658acaadbd051e8b9317fdb41e18654e"

let package = Package(
    name: "SendbirdSwiftUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SendbirdSwiftUI",
            targets: ["SendbirdUIKit"]
        ),
        .library(
            name: "SendbirdSwiftUIDynamic",
            type: .dynamic,
            targets: ["SendbirdSwiftUITarget"]
        ),
        .library(
            name: "SendbirdSwiftUIXCFramework",
            targets: ["SendbirdSwiftUITarget"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/sendbird/sendbird-chat-sdk-ios",
            from: minimumChatSDKVersion
        ),
    ],
    targets: [
        // Source-based
        .target(
            name: "SendbirdUIKit",
            dependencies: [
                .product(name: "SendbirdChatSDK", package: "sendbird-chat-sdk-ios")
            ],
            exclude: ["../../Sample"],
            resources: [
                .process("Resource")
            ],
            swiftSettings: [
                .define("SWIFTUI"),
                .define("PROCESS_RESOURCE"),
                .unsafeFlags(["-suppress-warnings"]),
            ]
        ),
        // Binary-based
        .binaryTarget(
            name: "SendbirdSwiftUI",
            url: "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/\(xcframeworkVersion)/SendbirdSwiftUI.xcframework.zip",
            checksum: xcframeworkChecksum
            
        ),
        .target(
            name: "SendbirdSwiftUITarget",
            dependencies: [
                .target(name: "SendbirdSwiftUI"),
                .product(name: "SendbirdChatSDK", package: "sendbird-chat-sdk-ios")
            ],
            path: "Framework/Dependency",
            exclude: ["../../Sample", "../../Sources"]
        ),
    ]
)
