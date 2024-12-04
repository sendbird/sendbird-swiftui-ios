# **SwiftUI GA**
:tada: Exciting Announcement: SendbirdSwiftUI now goes GA :tada:
Previously launched as beta, SendbirdSwiftUI is now official.
SendbirdSwiftUI 1.0.0 includes new interfaces that enable even further and wider customization upon out-of-the-box SwiftUI Views with live chat data. The new interfaces mainly include View Providers for each View, and events methods of SendbirdSwiftUI Views.
For detailed information and documentation, please visit our [docs homepage](https://sendbird.com/docs/chat/uikit/v3/swiftui/overview).


# **Changes: Beta → GA**

## **New Interfaces**
New functionalities and interfaces have been added

### **CreateGroupChannelView**
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `CreateGroupChannelViewProvider`
  - `CreateGroupChannelEventHandlers`

### **CreateOpenChannelView**
- `init(provider:headerItem:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `CreateOpenChannelViewProvider`
  - `CreateOpenChannelEventHandlers`

### **GroupBannedUserListView**
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `GroupBannedUserListViewProvider`
  - `GroupBannedUserListViewEventHandlers`

### **GroupChannelView**
- `init(provider:)`
- `init(provider:headerItem:listItem:inputItem:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `GroupChannelViewProvider`
  - `GroupChannelViewEventHandlers`

### **GroupChannelListView**
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdSelectLeaveChannel(_:)`
- `onSendbirdChangePushTriggerOption(_:)`
- `onSendbirdConnectionStateChange(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `GroupChannelListViewProvider`
  - `GroupChannelListEventHandlers`

### **GroupChannelPushSettingsView**
- `init(provider:)`
- `init(provider:headerItem:)`
- **Provider and EventHandlers**:
  - `GroupChannelPushSettingsViewProvider`

### **GroupChannelRegisterOperatorView**
- `init(provider:)`
- `init(provider:headerItem:)`
- **Provider and EventHandlers**:
  - `GroupChannelRegisterOperatorViewProvider`
  - `GroupChannelRegisterOperatorViewEventHandlers`

### **GroupChannelSettingsView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- **Provider and EventHandlers**:
  - `GroupChannelSettingsViewProvider`

### **GroupMemberListView**
- `init(provider:)`
- `init(provider:userListType:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `GroupMemberListViewProvider`
  - `GroupMemberListViewEventHandlers`

### **GroupModerationsView**
- `init(provider:)`
- `init(provider:headerItem:)`
- **Provider and EventHandlers**:
  - `GroupModerationsViewProvider`
  - `GroupModerationsViewEventHandlers`

### **GroupMutedMemberListView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `GroupMutedMemberListViewProvider`
  - `GroupMutedMemberListViewEventHandlers`

### **GroupOperatorListView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `GroupOperatorListViewProvider`
  - `GroupOperatorListViewEventHandlers`

### **InviteUserView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- **Provider and EventHandlers**:
  - `InviteUserViewProvider`

### **MessageSearchView**
- `init(provider:)`
- **Provider and EventHandlers**:
  - `MessageSearchViewProvider`

### **MessageThreadView**
- `init(provider:)`
- `init(provider:headerItem:parentInfoItem:listItem:inputItem:)`
- **Provider and EventHandlers**:
  - `MessageThreadViewProvider`
  - `MessageThreadViewEventHandlers`

### **OpenBannedUserListView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `OpenBannedUserListViewProvider`
  - `OpenBannedUserListViewEventHandlers`

### **OpenChannelView**
- `init(provider:)`
- `init(provider:headerItem:listItem:inputItem:)`
- **Provider and EventHandlers**:
  - `OpenChannelViewProvider`
  - `OpenChannelEventHandlers`

### **OpenChannelListView**
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdConnectionStateChange(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `OpenChannelListViewProvider`
  - `OpenChannelListEventHandlers`

### **OpenChannelRegisterOperatorView**
- `init(provider:)`
- `init(provider:headerItem:)`
- **Provider and EventHandlers**:
  - `OpenChannelRegisterOperatorViewProvider`
  - `OpenChannelRegisterOperatorViewEventHandlers`

### **OpenChannelSettingsView**
- `init(provider:)`
- `init(provider:headerItem:)`
- **Provider and EventHandlers**:
  - `OpenChannelSettingsViewProvider`
  - `OpenChannelSettingsEventHandlers`

### **OpenModerationsView**
- `init(provider:)`
- `init(provider:headerItem:)`
- **Provider and EventHandlers**:
  - `OpenModerationsViewProvider`
  - `OpenModerationsViewEventHandlers`

### **OpenMutedParticipantListView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `OpenMutedParticipantListViewProvider`
  - `OpenMutedParticipantListViewEventHandlers`

### **OpenOperatorListView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `OpenOperatorListViewProvider`
  - `OpenOperatorListViewEventHandlers`

### **OpenParticipantListView**
- `init(provider:)`
- `init(provider:headerItem:listItem:)`
- `onSendbirdSelectRow(_:)`
- `onSendbirdError(_:)`
- **Provider and EventHandlers**:
  - `OpenParticipantListViewProvider`
  - `OpenParticipantListViewEventHandlers`


---

## **Unavailbale Interfaces**
The following interfaces that were available in the Beta version have been removed in the GA release:

### **CreateGroupChannelView**
- **Constructor Changes**:
  - `init(users:type:headerItem:listItem:)`
  - `init(users:type:headerItem:list:)`

### **CreateOpenChannelView**
- **Constructor Changes**:
  - `init()`
  - `init(headerItem:)`

### **GroupBannedUserListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`

### **GroupChannelView**
- **Constructor Changes**:
  - `init()`
  - `init(users:type:headerItem:listItem:)`
  - `init(users:type:headerItem:list:)`

### **GroupChannelListView**
- **Constructor Changes**:
  - `init(channelListQuery:headerItem:listItem:)`
  - `init(channelListQuery:headerItem:list:)`

### **GroupChannelPushSettingsView**
- **Constructor Changes**:
  - `init(channelURL:)`
  - `init(channelURL:headerItem:)`

### **GroupChannelRegisterOperatorView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:)`

### **GroupChannelSettingsView**
- **Constructor Changes**:
  - `init(channelURL:headerItem:listItem:)`
  - `init(channelURL:headerItem:list:)`

### **GroupMemberListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:userListType:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **GroupModerationsView**
- **Constructor Changes**:
  - `init(channelURL:)`

### **GroupMutedMemberListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **GroupOperatorListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **InviteUserView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **MessageSearchView**
- **Constructor Changes**:
  - `init(channelURL:)`
  - `init(channelURL:headerItem:listItem:)`

### **MessageThreadView**
- **Constructor Changes**:
  - `init(channelURL:parentMessageId:delegate:threadedMessageListParams:startingPoint:voiceFileInfos:)`
  - `init(channelURL:parentMessageId:delegate:threadedMessageListParams:startingPoint:voiceFileInfos:headerItem:parentInfoItem:listItem:inputItem:)`
  - `init(channelURL:parentMessageId:delegate:threadedMessageListParams:startingPoint:voiceFileInfos:headerItem:list:inputItem:)`

### **OpenBannedUserListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **OpenChannelView**
- **Constructor Changes**:
  - `init(channelURL:startingPoint:messageListParams:)`
  - `init(channelURL:startingPoint:messageListParams:headerItem:listItem:inputItem:)`
  - `init(channelURL:startingPoint:messageListParams:headerItem:list:inputItem:)`

### **OpenChannelListView**
- **Constructor Changes**:
  - `init(channelListQuery:)`
  - `init(channelListQuery:headerItem:listItem:)`
  - `init(channelListQuery:headerItem:list:)`

### **OpenChannelRegisterOperatorView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **OpenChannelSettingsView**
- **Constructor Changes**:
  - `init(channelURL:)`
  - `init(channelURL:headerItem:)`

### **OpenModerationsView**
- **Constructor Changes**:
  - `init(channelURL:)`
  - `init(channelURL:headerItem:)`

### **OpenMutedParticipantListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **OpenOperatorListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`

### **OpenParticipantListView**
- **Constructor Changes**:
  - `init(channelURL:users:)`
  - `init(channelURL:users:headerItem:listItem:)`
  - `init(channelURL:users:headerItem:list:)`
