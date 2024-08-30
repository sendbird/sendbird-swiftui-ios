//
//  UIColor+SBUIKit.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 02/03/2020.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//
// swiftlint:disable identifier_name

import UIKit

extension UIColor {
    /// This function creates a UIColor from an image.
    /// - Parameters:
    ///   - image: The image to create the UIColor from.
    ///   - imageView: An optional UIImageView. If not provided, a new one will be created.
    ///   - size: The size of the image.
    ///   - backgroundColor: The background color of the image.
    /// - Returns: A UIColor created from the image.
    public static func sbu_from(
        image: UIImage,
        imageView: UIImageView? = nil,
        size: CGFloat,
        backgroundColor: UIColor
    ) -> UIColor {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size*3, height: size))
        let imageView = imageView ?? UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = image
        imageView.contentMode = .center
        view.addSubview(imageView)
        
        UIGraphicsBeginImageContextWithOptions(
            view.frame.size,
            false,
            UIApplication.shared.currentWindow?.screen.scale ?? 1.0
        )
        
        guard let context = UIGraphicsGetCurrentContext() else { return .clear }
        
        view.layer.render(in: context)
        let contextImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = contextImage else { return .clear }
        
        return UIColor(patternImage: image)
    }
    
    // MARK: - Hex
    
    // https://stackoverflow.com/a/33397427
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
// swiftlint:enable identifier_name
