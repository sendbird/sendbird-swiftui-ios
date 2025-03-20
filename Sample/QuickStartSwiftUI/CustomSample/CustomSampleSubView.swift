//
//  CustomSampleSubView.swift
//  SwiftUITestApp
//
//  Created by Tez Park on 6/3/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

// MARK: - Custom sample sub
struct CustomSampleSubView: View {
    var keyfunction: CustomSampleInfo.KeyFunction
    @StateObject var viewModel: CustomSampleSubViewModel
    @State private var isActive = false
    @State private var destinationView: AnyView? = nil
    
    init(keyfunction: CustomSampleInfo.KeyFunction) {
        self.keyfunction = keyfunction
        _viewModel = StateObject(wrappedValue: CustomSampleSubViewModel(with: keyfunction))
    }
    
    var body: some View {
        List {
            ForEach(keyfunction.viewItems, id: \.viewFullPath) { viewItem in
                Button(action: {
                    Task {
                        await viewModel.loadEnvironment(for: viewItem)
                        // NOTE: Use the below if you want to change `enableViewAdaptorAutoReset` setting for a specific view. 
//                        if viewItem.viewFullPath == "CustomGroupChannel.ViewConverter.List.fileMessageView" {
//                            GlobalOptions.enableViewAdaptorAutoReset = false
//                        } else {
//                            GlobalOptions.enableViewAdaptorAutoReset = true
//                        }
                        self.destinationView = AnyView(
                            CustomSampleManager.viewForName(viewItem)
                                .environmentObject(viewModel)
                        )
                        
                        self.isActive = true
                    }
                }) {
                    CustomCell(viewItem: viewItem)
                }
                .background(
                    NavigationLink(
                        destination: destinationView,
                        isActive: $isActive,
                        label: { EmptyView() }
                    )
                    .hidden()
                )
            }
        }
        .navigationTitle(keyfunction.name)
    }
}

struct CustomCell: View {
    var viewItem: CustomSampleInfo.ViewItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(viewItem.viewType)
                    Spacer()
                    Text(viewItem.viewDesc)
                }
                .font(.caption2)
                Text(viewItem.viewTitle)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    let testKF = CustomSampleInfo.KeyFunction(
        name: "Open Channel",
        viewItems: [CustomSampleInfo.ViewItem(
            viewTitle: "Open Channel",
            viewType: "[method]]",
            viewDesc: "Open Channel Description",
            viewFullPath: "OpenChannelView"
        )]
    )
    return CustomSampleSubView(keyfunction: testKF)
}
