//
//  SBUMessageSearchViewModel.swift
//  SendbirdUIKit
//
//  Created by Hoon Sung on 2021/02/09.
//  Copyright © 2021 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

/// `SBUMessageSearchViewModelDelegate` protocol
/// This protocol defines the methods that a delegate of a `SBUMessageSearchViewModel` object should implement.
/// This protocol inherits from `SBUCommonViewModelDelegate`.
public protocol SBUMessageSearchViewModelDelegate: SBUCommonViewModelDelegate {
    /// Called when the search results has been changed.
    func searchViewModel(_ viewModel: SBUMessageSearchViewModel, didChangeSearchResults results: [BaseMessage], needsToReload: Bool)
    
}

/// `SBUMessageSearchViewModel` open class
///
/// This class is responsible for managing and handling the search functionality in the chat.
open class SBUMessageSearchViewModel {
    // MARK: - Constants
    static let limit: UInt = 20
    
    // MARK: - Property (Public)
    /// The channel that the search will be performed on.
    public private(set) var channel: BaseChannel?
    /// The URL of the current channel. // 3.26.0
    public private(set) var channelURL: String?

    /// The list of search results.
    @SBUAtomic public private(set) var searchResultList: [BaseMessage] = []

    /// This param will be used on entering a channel from selecting an item from the search results.
    public var messageListParams: MessageListParams?
    
    /// The query object that is used to perform message search in the channel.
    public private(set) var messageSearchQuery: MessageSearchQuery?
    
    // MARK: - Property (Private)
    weak var delegate: SBUMessageSearchViewModelDelegate?

    var customMessageSearchQueryParams: MessageSearchQueryParams?
    
    var keyword: String?
    
    // MARK: - Lifecycle
    /// Initializes a new `SBUMessageSearchViewModel` instance.
    ///
    /// - Parameters:
    ///   - channel: The `BaseChannel` object where the search will be performed.
    ///   - params: The `MessageSearchQueryParams` object that will be used for the search. Default is `nil`.
    ///   - delegate: The `SBUMessageSearchViewModelDelegate` object that will handle delegate methods. Default is `nil`.
    required public init(
        channel: BaseChannel,
        params: MessageSearchQueryParams? = nil,
        delegate: SBUMessageSearchViewModelDelegate? = nil
    ) {
        self.delegate = delegate
        self.customMessageSearchQueryParams = params
        self.channel = channel
    }
    
    /// Initializes a new `SBUMessageSearchViewModel` instance.
    ///
    /// - Parameters:
    ///   - channelURL: The URL of the channel.
    ///   - params: The `MessageSearchQueryParams` object that will be used for the search. Default is `nil`.
    ///   - delegate: The `SBUMessageSearchViewModelDelegate` object that will handle delegate methods. Default is `nil`.
    /// - Since: 3.26.0
    required public init(
        channelURL: String,
        params: MessageSearchQueryParams? = nil,
        delegate: SBUMessageSearchViewModelDelegate? = nil
    ) {
        self.delegate = delegate
        self.customMessageSearchQueryParams = params
        self.channelURL = channelURL
        
        self.loadChannel(channelURL: channelURL)
    }
    
    /// This function loads channel information.
    /// - Parameters:
    ///   - channelURL: channel url
    ///   - type: channel type
    /// - Since: 3.26.0
    public func loadChannel(channelURL: String) {
        self.delegate?.shouldUpdateLoadingState(true)
        
        SendbirdUI.connectIfNeeded { [weak self] _, error in
            guard let self = self else { return }
            defer { self.delegate?.shouldUpdateLoadingState(false) }
            
            if let error = error {
                self.delegate?.didReceiveError(error, isBlocker: false)
            } else {
                let completionHandler: ((BaseChannel?, SBError?) -> Void) = { [weak self] channel, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        self.delegate?.didReceiveError(error, isBlocker: false)
                    } else if let channel = channel {
                        self.channel = channel
                    }
                }
                
                GroupChannel.getChannel(url: channelURL, completionHandler: completionHandler)
            }
        }
    }
    
    /// Performs keyword search in the channel
    ///
    /// if you set the ``customMessageSearchQueryParams`` value, this method only use ``customMessageSearchQueryParams``.
    ///
    /// - Parameter keyword: keyword to search for.
    open func search(keyword: String) {
        guard let channel = self.channel else {
            let error = SBError(domain: "Requires a channel object for message search", code: -1, userInfo: nil)
            self.delegate?.didReceiveError(error)
            return
        }
        
        let params: MessageSearchQueryParams
        
        if let customMessageSearchQueryParams = customMessageSearchQueryParams {
            // Customized
            params = customMessageSearchQueryParams
        } else {
            // Defaults
            params = MessageSearchQueryParams { params in
                // Default search from ts.
                // Only search for messages after a user has joined.
                if let groupChannel = self.channel as? GroupChannel {
                    // FIXME: - Change to joinedTs when core SDK is ready
                    params.messageTimestampFrom = groupChannel.invitedAt
                }
                
                if params.limit <= 0 {
                    // Default limit
                    params.limit = SBUMessageSearchViewModel.limit
                }
                // Below are reserved params.
                params.order = .timestamp
            }
        }
        
        // Common settings
        params.channelURL = channel.channelURL
        params.keyword = keyword
        
        let query = SendbirdChat.createMessageSearchQuery(params: params)
        
        self.search(keyword: keyword, query: query)
    }
    
    /// Performs keyword search
    ///
    /// - Parameters:
    ///   - keyword: keyword to search for.
    ///   - query: ``messageSearchQuery`` object to search for
    public func search(keyword: String, query: MessageSearchQuery) {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedKeyword.isEmpty else {
            SBULog.info("Keyword shouldn't be empty.")
            return
        }
        guard trimmedKeyword != self.keyword else {
            SBULog.info("Same keyword.")
            return
        }
        
        SBULog.info("new search keyword : [\(trimmedKeyword)]")
        
        self.searchResultList.removeAll()
        
        self.keyword = trimmedKeyword
        self.messageSearchQuery = query
        
        self.delegate?.shouldUpdateLoadingState(true)
        self.loadMore()
    }
    
    /// Loads the following list
    public func loadMore() {
        SBULog.info("query : \(String(describing: self.messageSearchQuery))")
        guard let messageSearchQuery = self.messageSearchQuery,
              messageSearchQuery.hasNext &&
                !messageSearchQuery.isLoading
        else {
            self.delegate?.shouldUpdateLoadingState(false)
            return
        }
        
        SBULog.info("loading next page.")
        messageSearchQuery.loadNextPage { [weak self] messageList, error in
            guard let self = self else { return }
            
            self.delegate?.shouldUpdateLoadingState(false)
            
            if let error = error {
                self.delegate?.didReceiveError(error, isBlocker: true)
            } else {
                guard let messageList = messageList else { return }

                let filteredList = messageList.filter { message in
                    return SBUUtils.findIndex(of: message, in: self.searchResultList) == nil
                }
                
                self.searchResultList.append(contentsOf: filteredList)
                self.delegate?.searchViewModel(
                    self,
                    didChangeSearchResults: self.searchResultList,
                    needsToReload: true
                )
            }
        }
    }
}
