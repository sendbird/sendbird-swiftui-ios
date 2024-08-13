//
//  CustomSampleView.swift
//  SwiftUITestApp
//
//  Created by Tez Park on 4/18/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

// MARK: - Custom sample base
// INFO: SampleListSwiftUI.json 파일에 내용을 확장을 해주세요.
struct CustomSampleView: View {
    var viewModel = CustomSampleViewModel()

    var body: some View {
        List {
            ForEach(viewModel.keyfunctions, id: \.name) { keyfunction in
                let customView = CustomSampleSubView(
                    keyfunction: keyfunction
                )
                NavigationLink(destination: customView) {
                    Text(keyfunction.name)
                }
            }
        }
        .navigationTitle("Custom Sample List")
    }
}

#Preview {
    CustomSampleView()
}
