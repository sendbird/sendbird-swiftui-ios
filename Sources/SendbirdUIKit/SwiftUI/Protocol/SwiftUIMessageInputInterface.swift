//
//  SwiftUIMessageInputInterface.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 8/9/24.
//

import Foundation

// MARK: - SwiftUIMessageInputInterface

/// Public interfaces that provide access to default actions of ``SBUMessageInputView``.
protocol SwiftUIMessageInputInterface: SBUActionSheetDelegate {
    func showFileActionSheet()
    func didTapResource(_ type: MediaResourceType)
}

extension SwiftUIMessageInputInterface {
    // MARK: SBUActionSheetDelegate
    public func didSelectActionSheetItem(index: Int, identifier: Int) {
        let type = MediaResourceType.init(rawValue: index) ?? .unknown
        switch type {
        case .camera:
            SBUPermissionManager.shared.requestCameraAccess(for: .video) { [weak self] in
                guard let self = self else { return }
                didTapResource(type)
            } onDenied: { [weak self] in
                guard let self = self else { return }
                didTapResource(type)
            }
        case .library:
            SBUPermissionManager.shared.requestPhotoAccessIfNeeded { _ in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    didTapResource(type)
                }
            }
        default:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                didTapResource(type)
            }
        }
    }
}
