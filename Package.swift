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
            from: "4.29.0"
        ),
        .package(
            url: "https://github.com/sendbird/sendbird-uikit-ios-spm",
            from: "3.32.2"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SendbirdSwiftUI",
            url: "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/1.1.1/SendbirdSwiftUI.xcframework.zip", // SendbirdSwiftUI_URL
            checksum: "cc2815f523db320c30092e97a48bf0575496742f5a074130d5bf4dbc7f4e4d80" // SendbirdSwiftUI_CHECKSUM
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
