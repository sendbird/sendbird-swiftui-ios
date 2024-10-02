//
//  SBUEmojiManager.swift
//  SendbirdUIKit
//
//  Created by Harry Kim on 2020/05/19.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

/// `SBUEmojiManager` is a class responsible for managing emojis in the application.
public class SBUEmojiManager {
    // MARK: - Private keys
    static let kEmojiCacheKey = "LOCAL_CACHING_EMOJI_CONTAINER"
    
    // MARK: - Private property
    static let shared = SBUEmojiManager()
    private var container: EmojiContainer? {
        didSet { self.didSetContainer() }
    }
    private var emojiHash: String? {
        container?.emojiHash
    }
    
    // MARK: - Public function
    
    /// This function gets a list of the emoji categories.
    /// - Returns: `EmojiCategory` type array
    public static func getEmojiCategories() -> [EmojiCategory] {
        guard let container = shared.container else {
            SBULog.error("[Failed] Emoji Categories: load emoji")
            return []
        }

        guard SBUAvailable.isSupportReactions() else {
            SBULog.error("[Failed] Emoji Categories: enableReactions is false")
            return []
        }

        let categories = container.categories

        if categories.isEmpty {
            SBULog.error("[Failed] Emoji Categories: Category is empty")
        }

        return categories
    }

    /// This function gets a list of all emojis.
    /// - Returns: `Emoji` type array
    public static func getAllEmojis() -> [Emoji] {
        guard let container = shared.container else {
            SBULog.error("[Failed] Emoji List: load emoji")
            return []
        }

        guard SBUAvailable.isSupportReactions() else {
            SBULog.error("[Failed] Emoji List: enableReactions is false")
            return []
        }

        let emojis = container.categories.reduce([]) { $0 + $1.emojis }

        if emojis.isEmpty {
            SBULog.error("[Failed] Emoji List: emoji list is empty")
        }

        return emojis
    }

    /// This function gets a list of emojis corresponding to category id.
    /// - Returns: `Emoji` type array
    public static func getEmojis(emojiCategoryId: Int64) -> [Emoji] {
        guard let container = shared.container else {
            SBULog.error("[Failed] Emojis with category id: load emoji")
            return []
        }

        guard SBUAvailable.isSupportReactions() else {
            SBULog.error("[Failed] Emojis with category id: enableReactions is false")
            return []
        }

        let categories = container.categories
        if categories.isEmpty {
            SBULog.warning("[Warning] Emojis with category id: Category is empty")
            return []
        }

        guard let category = categories.first(where: { $0.cid == emojiCategoryId }) else {
            SBULog.warning("[Warning] Emojis with category id: Can not find category")
            return []
        }

        return category.emojis
    }
    
    static func getEmojis(with categoryIds: [Int64]) -> [Emoji] {
        guard let container = shared.container else {
            SBULog.error("[Failed] Emojis with categoryIds")
            return []
        }
        
        let categories = container.categories
        guard !categories.isEmpty else {
            return []
        }
        
        let filteredEmojiCategories = categories.filter { categoryIds.contains($0.cid) }
        let filteredEmojis = filteredEmojiCategories.reduce([]) { $0 + $1.emojis}
        
        if filteredEmojis.isEmpty {
            SBULog.warning("Emojis for emojiCategoryIds is empty.")
        }
        
        return filteredEmojis
    }
    
    // MARK: - private function
    static func isReactionEnabled(channel: BaseChannel?) -> Bool {
        guard let groupChannel = channel as? GroupChannel else { return false }
        
        return !groupChannel.isBroadcast &&
            (groupChannel.isSuper ?
            SBUAvailable.isSupportReactions(for: .superGroup) :
            SBUAvailable.isSupportReactions(for: .group))
    }
    
    /// Decides whether to show the member list for each reaction upon long press on an emoji.
    /// - Since: 3.19.0
    static func isEmojiLongPressEnabled(channel: BaseChannel?) -> Bool {
        guard let groupChannel = channel as? GroupChannel else { return false }
        
        return !groupChannel.isSuper
    }
    
    /// Loads all Emojis from ChatSDK.
    /// - Parameter completionHandler: The callback that includes either `EmojiContainer` or `SBError`.
    public static func loadAllEmojis(completionHandler: @escaping (
        _ container: EmojiContainer?,
        _ error: SBError?) -> Void
    ) {
        guard let appInfo = SendbirdChat.getAppInfo(),
              self.shared.emojiHash == nil || appInfo.isEmojiUpdateNeeded(prevEmojiHash: shared.emojiHash ?? "")
        else {
            completionHandler(shared.container, nil)
            return
        }
        
        SBULog.info("[Request] Load all emojis")
        
        // Load from cached data first.
        if let cachedContainer = UserDefaults.standard.data(forKey: SBUEmojiManager.kEmojiCacheKey) {
            let container = EmojiContainer.build(fromSerializedData: cachedContainer)
            shared.container = container
        }
        
        SendbirdChat.getAllEmojis { container, error in
            if let error = error {
                if let cachedContainer = shared.container, container == nil {
                    SBULog.info("[Succeed] Load all emojis from cache")
                    completionHandler(cachedContainer, nil)
                } else {
                    SBULog.error("[Failed] Load all emojis: \(error.localizedDescription)")
                    completionHandler(nil, error)
                }
                return
            }
            
            guard let container = container else {
                if let cachedContainer = shared.container {
                    SBULog.info("[Succeed] Load all emojis from cache")
                    completionHandler(cachedContainer, nil)
                } else {
                    SBULog.error("[Failed] Load all emojis: EmojiContainer is not set")
                    completionHandler(nil, nil)
                }
                return
            }
            
            SBULog.info("[Succeed] Load all emojis")
            shared.container = container
            completionHandler(container, nil)
        }
    }
    
    private func didSetContainer() {
        if let serializedContainer = container?.serialize() {
            UserDefaults.standard.setValue(serializedContainer, forKey: SBUEmojiManager.kEmojiCacheKey)
        }
    }
    
    /// Checks if an emoji is available in current app.
    /// - Since: 3.27.0
    static func isEmojiAvailable(
        emojiKey: String,
        message: BaseMessage
    ) -> Bool {
        if let categoryIds = SBUGlobals.emojiCategoryFilter(message) {
            let emojiKeys = getEmojis(with: categoryIds).map { $0.key }
            if emojiKeys.contains(emojiKey) == false {
                return false
            }
        }
        return true
    }
    
    static func getAvailableEmojis(message: BaseMessage?) -> [Emoji] {
        if let message, let categoryIds = SBUGlobals.emojiCategoryFilter(message) {
            return getEmojis(with: categoryIds)
        } else {
            return getAllEmojis()
        }
    }
}
