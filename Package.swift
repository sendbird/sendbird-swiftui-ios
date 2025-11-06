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
            from: "4.32.0"
        ),
        .package(
            url: "https://github.com/sendbird/sendbird-uikit-ios-spm",
            from: "3.32.3"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SendbirdSwiftUI",
            url: "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/1.1.2/SendbirdSwiftUI.xcframework.zip", // SendbirdSwiftUI_URL
            checksum: "91c877b1b9e66e8d456a4b461ab52b3a7f6a0b7959c02fc183dd3d0c4c5d2199" // SendbirdSwiftUI_CHECKSUM
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
