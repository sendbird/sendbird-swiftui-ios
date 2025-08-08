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
            name: "SendbirdChatSDK",
            url: "https://github.com/sendbird/sendbird-chat-sdk-ios",
            from: "4.29.0"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SendbirdSwiftUI",
            url: "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/0.0.1000/SendbirdSwiftUI.xcframework.zip", // SendbirdSwiftUI_URL
            checksum: "67f1f715fe0634e9486cb8c37deda90f243e3a99ba316c002500562ce51680d4" // SendbirdSwiftUI_CHECKSUM
            
        ),
        .binaryTarget(
            name: "SendbirdUIMessageTemplate",
            url: "https://github.com/sendbird/sendbird-uikit-ios/releases/download/3.32.1/SendbirdUIMessageTemplate.xcframework.zip", // SendbirdUIMessageTemplate_URL
            checksum: "66c35c47fe8b6024f63d57e5adbb520d1b78cce29b011c710be1642a257626fa" // SendbirdUIMessageTemplate_CHECKSUM
        ),
        .target(
            name: "SendbirdSwiftUITarget",
            dependencies: [
                .target(name: "SendbirdSwiftUI"),
                .target(name: "SendbirdUIMessageTemplate"),
                .product(name: "SendbirdChatSDK", package: "SendbirdChatSDK")
            ],
            path: "Framework/Dependency",
            exclude: ["../../Sample", "../../Sources"]
        ),
    ]
)
