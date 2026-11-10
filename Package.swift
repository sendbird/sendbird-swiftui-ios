// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SendbirdSwiftUI",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SendbirdSwiftUI",
            targets: ["SendbirdSwiftUITarget"]),
        
    ],
    dependencies: [
        .package(
            url: "https://github.com/sendbird/sendbird-chat-sdk-ios",
            from: "4.39.13"
        ),
        .package(
            url: "https://github.com/sendbird/sendbird-uikit-ios-spm",
            from: "3.36.4"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SendbirdSwiftUI",
            url: "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/1.2.3/SendbirdSwiftUI.xcframework.zip", // SendbirdSwiftUI_URL
            checksum: "f8580d8024721c770037a7576a7a3db3dc864e5205bd3136faa2e78101346ad4" // SendbirdSwiftUI_CHECKSUM
        ),
        .target(
            name: "SendbirdSwiftUITarget",
            dependencies: [
                .target(name: "SendbirdSwiftUI"),
                .product(name: "SendbirdChatSDK", package: "sendbird-chat-sdk-ios"),
                .product(name: "SendbirdUIMessageTemplate", package: "sendbird-uikit-ios-spm"),
            ],
            path: "Framework/Dependency",
            exclude: ["../../Sample", "../../Sources"]
        ),
    ]
)
