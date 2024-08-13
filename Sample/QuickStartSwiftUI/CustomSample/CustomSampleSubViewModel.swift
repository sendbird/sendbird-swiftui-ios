//
//  CustomSampleSubViewModel.swift
//  SwiftUITestApp
//
//  Created by Tez Park on 6/3/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

class CustomSampleSubViewModel: ObservableObject {
    @Published var groupChannel: GroupChannel?
    @Published var openChannel: OpenChannel?
    @Published var parentMessage: BaseMessage?
    
    var keyfunction: CustomSampleInfo.KeyFunction
    
    init(with keyfunction: CustomSampleInfo.KeyFunction) {
        self.keyfunction = keyfunction
    }
    
    func loadEnvironment(for viewItem: CustomSampleInfo.ViewItem) async {
        do {
            let user = try await CustomSampleManager.connectIfNeeded()
        } catch {
            print("Error: Connect failed")
            return
        }
        
        SBViewConverterSet.resetAll()
        
        // TODO: messageThread 나 setting 등 처리는 여기서 옵션을 받거나 하는 형태로 처리
        switch getRequiredDataContext(viewItem) {
        case .openChannel:
            do {
                let channel = try await CustomSampleManager.getSampleOpenChannel()
                DispatchQueue.main.async {
                    self.openChannel = channel
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .groupChannel:
            do {
                let channel = try await CustomSampleManager.getSampleGroupChannel()
                DispatchQueue.main.async {
                    self.groupChannel = channel
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .messageThread:
            do {
                let (channel, parentMessage) = try await CustomSampleManager.getSampleMessageThreadUserMessage()
                DispatchQueue.main.async {
                    self.groupChannel = channel
                    self.parentMessage = parentMessage
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .messageThreadFileMessage:
            do {
                let (channel, parentMessage) = try await CustomSampleManager.getSampleMessageThreadFileMessage()
                DispatchQueue.main.async {
                    self.groupChannel = channel
                    self.parentMessage = parentMessage
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .messageThreadWebView:
            do {
                let (channel, parentMessage) = try await CustomSampleManager.getSampleMessageThreadWebView()
                DispatchQueue.main.async {
                    self.groupChannel = channel
                    self.parentMessage = parentMessage
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .messageThreadMultipleFilesMessage:
            do {
                let (channel, parentMessage) = try await CustomSampleManager.getSampleMessageThreadMultipleFilesMessage()
                DispatchQueue.main.async {
                    self.groupChannel = channel
                    self.parentMessage = parentMessage
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .groupChannelOperator:
            do {
                self.groupChannel = try await CustomSampleManager.getSampleGroupChannelOperator()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .openChannelOperator:
            do {
                self.openChannel = try await CustomSampleManager.getSampleOpenChannelOperator()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        case .none:
            print("none.")
        }
        
        // keyfunction.name
        // viewItem
//        - viewTitle : "Main"
//        - viewType : "[View]"
//        - viewDesc : "SwiftUI"
//        - viewFullPath : "CustomGroupChannelRegisterOperator.SwiftUI.View.Main"
    }
    
    
    func getRequiredDataContext(_ viewItem: CustomSampleInfo.ViewItem) -> DataContext {
        if self.keyfunction.name.contains("Open") {
            if self.keyfunction.name.contains("RegisterOperator") {
                return .openChannelOperator
            }
            return .openChannel
        } else if self.keyfunction.name.contains("Group") {
            if self.keyfunction.name.contains("RegisterOperator") ||
                self.keyfunction.name.contains("GroupModerations") ||
                viewItem.viewFullPath.contains("pushSettings") {
                return .groupChannelOperator
            }
            return .groupChannel
        } else if self.keyfunction.name.contains("MessageThread") {
            if viewItem.viewFullPath.contains("ParentInfo.fileContentView") {
                return .messageThreadFileMessage
            } else if viewItem.viewFullPath.contains("ParentInfo.multipleFileContentView") {
                return .messageThreadMultipleFilesMessage
            } else if viewItem.viewFullPath.contains("ParentInfo.webView") {
                return .messageThreadWebView
            }
            return .messageThread
        } else if self.keyfunction.name.contains("InviteUser") ||
            self.keyfunction.name.contains("MessageSearch"){
            return .groupChannel
        } else {
            return .none
        }
    }
    
    enum DataContext {
        case groupChannel
        case openChannel
        case messageThread
        case messageThreadFileMessage
        case messageThreadMultipleFilesMessage
        case messageThreadWebView
        case groupChannelOperator
        case openChannelOperator
        case none
    }
}
