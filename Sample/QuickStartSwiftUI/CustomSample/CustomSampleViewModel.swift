//
//  CustomSampleViewModel.swift
//  SwiftUITestApp
//
//  Created by Tez Park on 4/24/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SwiftUI
struct TestURL {
    // userID: jun.14
    static let groupChannel = "sendbird_group_channel_364092536_d9b6b1bc05818e4eae9d82ef4fa130eebdd94ad8"
    static let groupChannelWithReactions = "sendbird_group_channel_329798443_fc5fe2bdfa125cb85f023e19ea420dcaef36be9d"
    static let groupChannelOperator = "sendbird_group_channel_366140780_3561fa4cce9525f78e2297914d50c4083913c690"
    
    static let openChannel = "sendbird_open_channel_162422_1a8f4ae8c921854f049474376f8bbea37a18fbe0"
    static let openChannelOperator = "sendbird_open_channel_162422_7a76f8e6e0f3b1b9156bf161c2c97813d16b41b8"
    
    static let threadMessageChannel = "sendbird_group_channel_364092536_d9b6b1bc05818e4eae9d82ef4fa130eebdd94ad8"
    
    static let leaveGroupChannel = "sendbird_group_channel_358775975_5d1e9d6d588ef2512bc3f30de0ffe37426a169ed"
}

struct TestMessageId {
    static let threadMessageId: Int64 = 3716589076
    static let fileThreadMessageId: Int64 = 3693694525
    static let mfmThreadMessageId: Int64 = 3693694598
    static let webThreadMessageId: Int64 = 3693696780
}

class CustomSampleViewModel: ObservableObject {
    var keyfunctions: [CustomSampleInfo.KeyFunction] = []

    init() {
        keyfunctions = self.load()
    }

    func load() -> [CustomSampleInfo.KeyFunction] {
        guard let jsonFilePath = Bundle.main.path(forResource: "SampleListSwiftUI", ofType: "json") else {
            fatalError("not found json file")
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            let decoder = JSONDecoder()
            let sampleInfo = try decoder.decode(CustomSampleInfo.self, from: jsonData)

            return sampleInfo.keyFunctions
        } catch {
            print("Decoding error: \(error)")
            return []
        }
    }
}


struct CustomSampleInfo: Codable {
    let keyFunctions: [KeyFunction]
    
    struct KeyFunction: Codable {
        let name: String
        let viewItems: [ViewItem]
    }

    struct ViewItem: Codable {
        let viewTitle: String
        let viewType: String
        let viewDesc: String
        let viewFullPath: String        
    }
}
