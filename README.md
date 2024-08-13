# [Sendbird](https://sendbird.com) SwiftUI for iOS


[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://cocoapods.org/pods/SendBirdUIKit)
[![Languages](https://img.shields.io/badge/language-SwiftUI-orange.svg)](https://github.com/sendbird/sendbird-swiftui-ios)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-green.svg)](https://cocoapods.org/pods/SendBirdUIKit)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-green.svg)](https://github.com/sendbird/sendbird-swiftui-ios)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Commercial License](https://img.shields.io/badge/license-Commercial-green.svg)](https://github.com/sendbird/sendbird-swiftui-ios/blob/main/LICENSE.md)

:tada: Exciting Announcement: Now Supports SwiftUI! :partying_face:

We're thrilled to introduce the latest version of 1.0.0-beta.0, bringing modern SwiftUI support to our popular Chat SDK!

Our previous UIKit-based SDK allowed for rapid UI integration and simple customization. Now, we're extending these benefits to SwiftUI, the cutting-edge framework for building user interfaces.

We offer the same level of features with our UIKit SDK.
For detailed information and documentation, please visit our docs homepage.

## Table of contents

  1. [Introduction](#introduction)
  1. [Requirements](#requirements)
  1. [Before you start](#before-you-start)
  1. [Get started](#get-started)
  
<br />

# Introduction
 
Sendbird Chat SwiftUI is a set of prebuilt UI components that allows you to easily craft an in-app chat with all the essential messaging features. Our development kit includes light and dark themes, fonts, colors and more. You can customize these components to create an interactive messaging interface unique to your brand identity.

Sendbird Chat SwiftUI supports both [group channels](/docs/chat/uikit/v3/swiftui/views/chat-in-a-group-channel) and [open channels](/docs/chat/uikit/v3/swiftui/views/chat-in-a-open-channel). Follow the guide below to start sending a message from scratch using SwiftUI.

![Image|Three SwiftUI views on the Light theme are shown: list of channels, chat view, channel information view.](https://static.sendbird.com/docs/uikit-ios-theme-light.png)


---

## Requirements

The minimum requirements for Sendbird Chat SwiftUI are:

* `iOS 15.0 and later`
* `Swift 5.9+`
* `Xcode 15.1 or later`
* `Sendbird Chat SDK for iOS 4.20.0 or later`

---

## Before you start

In this quickstart guide, you will be installing a Sendbird SDK, implementing codes to create a group channel with a user, and send a message within a few minutes. Before you start, you need to have the following:


- Sendbird application on [Sendbird Dashboard](https://dashboard.sendbird.com)
- A user in the Sendbird application

### Create a Sendbird application from dashboard

A Sendbird application comprises everything required in a chat service including users, messages, and channels. You need the Application ID of your Sendbird application from the dashboard when initializing the Chat SDK.

1. Go to [Sendbird Dashboard](https://dashboard.sendbird.com/auth/signin) and create an account for a free trial. If you already have a Sendbird account, sign into your account.

2. Create a new application by clicking **Create +** at the bottom right of your screen.

3. Enter a name for your application. Choose a **Product Type** and **Region**. Then, click **Confirm**.

4. Click the application you just created under **Applications**. You will see the application's Application ID which you will need when initializing the Chat SDK.

>__Note__: Each Sendbird application can be integrated with a single client app. Within the same application, users can communicate with each other across all platforms, whether they are on mobile devices or on the web.

### Create a user in the Sendbird application

In order to send a message, you need a user in a channel. You can either create a user on the Sendbird dashboard first or you can use a new unique ID that hasn’t been taken by any of your Sendbird application users. In the latter case, a new user is automatically created in your Sendbird application before being connected.

In this guide, we will create a user on the Sendbird dashboard first.

1. Go to the [**Users**](https://dashboard.sendbird.com/application-id/users) menu on the left-hand side of the dashboard and click **Create user+**.

2. Enter the **User ID** and **Nickname**. It is recommended that you check the box next to **Issue access token** for user authentication. Then, click **Create**.

>__Note__: Sendbird supports user authentication through access token for stronger security. However, on the dashboard, you can also configure the token permission in **Settings** > **Application** > **Security** > **Access token permission** to allow users without a token to access our functionalities. To learn more, see [Authentication](/docs/chat/uikit/v3/swiftui/introduction/authentication#1-authentication).

3. Copy and store the user ID. You will use it to connect to the Sendbird server.


---

## Get started

You can start building a messaging experience in your app by installing Sendbird Chat SwiftUI. This developer kit is an add-on feature to [Sendbird Chat SDK](/docs/chat/sdk/v4/ios/getting-started/send-first-message) so installing it will also install the core Chat SDK.

### **Step 1** Create a project

To get started, open `Xcode` and create a new project.

![Image|Setting up your project in the Create new project dialog.](https://static.sendbird.com/docs/uikit-ios-quickstart-create-project.png)
<!-- SWIFTUI TODO: 이미지 변경 필요, Interface 가 SwiftUI 가 되야함 -->

### **Step 2** Install Sendbird Chat SwiftUI

You can install Sendbird Chat SwiftUI through either Swift Packages or CocoaPods.

### Swift Packages

1. In Xcode, select **File** > **Add Packages Dependencies...**.

2. Add `SendbirdSwiftUI` into your `Package Repository` as below:

```bash,cs-katherine.kim-06aug24-001
https://github.com/sendbird/sendbird-swiftui-ios.git
```

3. Swift Package Manager automatically sets the dependency rule to "Up To Next Major" and installs the latest version. Adjust the dependency rule and version according to your needs. You can check out the latest Sendbird Chat SwiftUI version on [Sendbird Chat SwiftUI releases](https://github.com/sendbird/sendbird-swiftui-ios/releases).

> __Note__: A build error may occur while using Swift packages with Xcode due to issues with caching. To resolve this error, try resetting the Xcode package caches. Open the `File` menu, go to `Packages`, and select `Reset Package Caches`. This deletes all local package data and re-downloads each package from its online source.

### CocoaPods

1. Add `SendBirdSwiftUI` into your `Podfile` in Xcode as below:

```bash,cs-katherine.kim-06aug24-002
platform :ios, '15.0'
use_frameworks!

target YOUR_PROJECT_TARGET do
    pod 'SendbirdSwiftUI' # Add this line.
end
```

2. Install the `SendbirdSwiftUI` framework through `CocoaPods`.

```bash,cs-katherine.kim-06aug24-003
$ pod install
```

3. Update the `SendbirdSwiftUI` framework through `CocoaPods`.

```bash,cs-katherine.kim-06aug24-004
$ pod update
```

### **Step 3** Initialize with APP_ID

To integrate and run Sendbird Chat SwiftUI in your app, you need to first initialize the `SendbirdUI` instance through [`SwiftUI App Struct`](https://developer.apple.com/documentation/SwiftUI/App).

Sendbird Chat SwiftUI relies on local caching and synchronization for efficient data handling. Due to local caching, the data base must be migrated during the initialization process of the `SendbirdSwiftUI` instance. And, the Sendbird Chat SwiftUI won’t advance to subsequent steps until its initialization process has been fully completed. To enhance user experience and manage expectations during this process, we recommend you implement a visual loading indicator as follows:

- Display when `startHandler` is called.
- Hide when `completionHandler` is called.

> __Note__: If you wish to have the initialization run asynchronously, you can set the `needsSynchronous` parameter to `false` within `InitParams` of the `initParamsBuilder` block.

<div component="AdvancedCode" title="MyApp.swift">

```swift,cs-katherine.kim-06aug24-005
import SendbirdSwiftUI

@main
struct MyApp: App {
    init() {
        setupSendbird()
    }
    
    var body: some Scene {
        WindowGroup {
            Text("Hello, world!")
        }
    }
}

private extension MyApp {
    func setupSendbird() {
        let APP_ID = "YOUR_APP_ID"    // Specify your Sendbird application ID.
        
        SendbirdUI.initialize(
            applicationId: APP_ID
        ) { params in
            // This is the builder block where you can modify the initParameter.
            //
            // [example]
            // params.needsSynchronous = false
        } startHandler: {
            // This is the origin.
            // Initialization of SendbirdSwiftUI has started.
            // We recommend showing a loading indicator once started.
        } migrationHandler: {
            // DB migration has started.
        } completionHandler: { error in
            // If DB migration is successful, proceed to the next step.
            // If DB migration fails, an error exists.
            // We recommend hiding the loading indicator once done.
        }
    }
}
```

</div>

> __Note__: For more information about initialization of Sendbird Chat SwiftUI, see the [Basics of the improved Sendbird Chat SwiftUI initialization](https://github.com/sendbird/sendbird-uikit-ios/discussions/86) page in the Github discussion.

<!-- SWIFTUI TODO: SwiftUI discussion 으로 복제 후 링크 변경 -->

### **Step 4** Set current user

Before initiating Sendbird Chat SwiftUI, configure the `currentUser` information in the `SBUGlobals`. This information is essential for the kit to perform various tasks. Failing to set `currentUser` in advance can result in operational limitations within the Sendbird Chat SwiftUI.

Specifically, the `userID` field shown below must be defined as in the code below, which is the unique ID set to [the user you've created on the dashboard](/docs/chat/uikit/v3/swiftui/introduction/send-first-message#2-before-you-start-3-create-a-user-in-the-sendbird-application). Other fields such as `nickname` and `profileURL` are optional, and if not specified, they'll be filled with default values. 

The Sendbird Chat SwiftUI internally makes connect requests when needed and connects to the Sendbird server using the user information set in `SBUGlobals.currentUser`. If you haven't created a user yet, specify a unique `USER_ID` in the code snippet provided. This action will automatically generate a new user when you connect to the Sendbird server.


>__Note__: Sendbird supports user authentication via access tokens, but defaults to allowing access without a token for ease of initial use. For enhanced security, we recommend adjusting the access settings of new users under **Settings** > **Application** > **Security** > **Access token permission** on the dashboard. To learn about authentication, see the [Authentication](/docs/chat/uikit/v3/swiftui/introduction/authentication#1-authentication) guide.


Set `currentUser` for Sendbird Chat SwiftUI through the [`SwiftUI App Struct`](https://developer.apple.com/documentation/SwiftUI/App) as below:

>__Note__: Even if you don't use `SwiftUI App Struct`, you should still register user information before launching a chat service.

<div component="AdvancedCode" title="MyApp.swift">

```swift,cs-katherine.kim-06aug24-006
import SendbirdSwiftUI

@main
struct MyApp: App {
    init() {
        ...
        setupCurrentUser()
    }
    
    var body: some Scene {
        WindowGroup {
            Text("Hello, world!")
        }
    }
}

private extension MyApp {
    func setupCurrentUser() {
        // Set current user.
        // Case 1: USER_ID only
        SBUGlobals.currentUser = SBUUser(userId: {USER_ID})

        // Case 2: Specify all fields
        SBUGlobals.currentUser = SBUUser(userId: {USER_ID}, nickname:{(opt)NICKNAME}, profileURL:{(opt)PROFILE_URL})
    }
}
```

</div>

### **Step 5** Display channel list

`GroupChannelListView` is a good starting point for launching SwiftUI in your app. Implement the code below wherever you would like to start SwiftUI. You can see a complete list of group channels that you're a member of.


<div component="AdvancedCode" title="Swift">

```swift,cs-katherine.kim-06aug24-007
import SwiftUI
import SendbirdSwiftUI

struct ContentView: View {
    var body: some View {
        GroupChannelListView()
    }
}
```

</div>

>__Note__: `SendbirdSwiftUI` Views have navigation organized internally.

### **Step 6** Send your first message

You can now run the app on a simulator or a plugged-in device. To send a message, you must first create a group channel by tapping the icon in the top-right corner. Then, you can select users you wish to invite as members to your channel. Once the channel has been created, enter your first message and send.

>__Note__: Sendbird Chat SwiftUI offers features to attach or save files such as photos, videos, and documents in addition to sending text messages. To learn more about using these features, refer to [Get attachment permission](/docs/chat/uikit/v3/swiftui/introduction/send-first-message#2-get-attachment-permission) in the sample app.

<video src="https://static.sendbird.com/docs/uikit-ios-quickstart.mp4" controls autoplay loop></video>
<!-- SWIFTUI TODO: SwiftUI 링크로? -->

You've successfully sent your first message with Sendbird.

---

## Get attachment permission

Sendbird Chat SwiftUI allows users to attach or save files such as photos, videos, and documents. To use these functionalities, you need to request permission from users using your client apps.

### Media attachment permission

Client apps must acquire permission from end users to use their photos or save media to their library. Once the permission is granted, users can send image or video messages and download media assets.

```xml,cs-katherine.kim-06aug24-008
...
<key>NSPhotoLibraryUsageDescription</key>
    <string>$(PRODUCT_NAME) would like access to your photo library</string>
<key>NSCameraUsageDescription</key>
    <string>$(PRODUCT_NAME) would like to use your camera</string>
<key>NSMicrophoneUsageDescription</key>
    <string>$(PRODUCT_NAME) would like to use your microphone (for videos)</string>
<key>NSPhotoLibraryAddUsageDescription</key>
    <string>$(PRODUCT_NAME) would like to save photos to your photo library</string>
...

```

![Image|Media attachment permission](https://static.sendbird.com/docs/uikit/ios/getting-started-02_20200416.png)

### Document attachment permission (optional)

To attach documents from `iCloud` to file messages, you need to activate the `iCloud` feature. Once activated, users can send file messages containing documents from `iCloud`. Go to your Xcode project's **Signing & Capabilities**, add **+ Capability**, and select **iCloud**.  Check **iCloud Documents**.

![Image|Document attachment permission](https://static.sendbird.com/docs/uikit/ios/getting-started-03_20200416.png)
