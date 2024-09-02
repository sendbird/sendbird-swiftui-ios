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
            from: "4.20.0"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SendbirdSwiftUI",
            url: "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/1.0.0-beta.1/SendbirdSwiftUI.xcframework.zip",
            checksum: "cd882856d77ba496eb313b16eeec35d8c981f49dcac3818194badac4a3960183"
            
        ),
        .target(
            name: "SendbirdSwiftUITarget",
            dependencies: [
                .target(name: "SendbirdSwiftUI"),
                .product(name: "SendbirdChatSDK", package: "SendbirdChatSDK")
            ],
            path: "Framework/Dependency",
            exclude: ["../../Sample", "../../Sources"]
        ),
    ]
)
