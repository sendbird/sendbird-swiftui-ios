//
//  UIFont+Sendbird.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/17/24.
//

import SwiftUI
import UIKit
import CoreText

extension UIFont {
    // Font.TextStyle -> UIFont.TextStyle
    private class func uiFontTextStyle(from textStyle: Font.TextStyle) -> UIFont.TextStyle {
        switch textStyle {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .callout: return .callout
        case .caption: return .caption1
        case .caption2: return .caption2
        case .footnote: return .footnote
        default: return .body
        }
    }
    
    // Font.Weight -> UIFont.Weight
    private class func uiFontWeight(from weight: Font.Weight) -> UIFont.Weight {
        switch weight {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default: return .regular
        }
    }
    
    // Font -> UIFont
    class func preferredFont(from font: Font) -> UIFont {
        let mirror = Mirror(reflecting: font)
        
        /// Font handling based on text style
        /// ex) `Font.largeTitle`, `Font.title2`
        /// ex) `Font.system(_ style:)`, `Font.system(_ style:design:weight:)`
        /// `Font.Design` cannot be handled
        if let textStyle = mirror.descendant("provider", "base", "style") as? Font.TextStyle {
            let uiTextStyle = uiFontTextStyle(from: textStyle)

            if let fontWeight = mirror.descendant("provider", "base", "weight") as? Font.Weight {
                let uiFontWeight = uiFontWeight(from: fontWeight)
                
                let preferredFont = UIFont.preferredFont(forTextStyle: uiTextStyle)
                let fontDescriptor = preferredFont.fontDescriptor
                let fontDescriptorWithWeight = fontDescriptor.addingAttributes([
                    .traits: [
                        UIFontDescriptor.TraitKey.weight: uiFontWeight
                    ]
                ])
                return UIFont(descriptor: fontDescriptorWithWeight, size: preferredFont.pointSize)
            }
            
            return UIFont.preferredFont(forTextStyle: uiTextStyle)
        }
        
        /// Font handling based on custom
        /// ex) `Font.custom("Arial-BoldMT", size: 29)`, `Font.custom("Arial-BoldMT", fixedSize: 29)`
        if let fontName = mirror.descendant("provider", "base", "name") as? String,
           let fontSize = mirror.descendant("provider", "base", "size") as? CGFloat {
            if let font = UIFont(name: fontName, size: fontSize) {
                return font
            }
            
            SBULog.warning("Font is not set. Default font is applied.")
            return UIFont.preferredFont(forTextStyle: .body)
        }
        
        /// Font handling based on system
        /// ex) `Font.system(size:)`, `Font.system(size:weight:)`, `Font.system(size:weight:design:)`
        /// `Font.Design` cannot be handled
        if let fontSize = mirror.descendant("provider", "base", "size") as? CGFloat {
            if let fontWeight = mirror.descendant("provider", "base", "weight") as? Font.Weight {
                let uiFontWeight = uiFontWeight(from: fontWeight)
                return UIFont.systemFont(ofSize: fontSize, weight: uiFontWeight)
            } else {
                return UIFont.systemFont(ofSize: fontSize)
            }
        }
        
        SBULog.warning("Font is not set. Default font is applied.")
        return UIFont.preferredFont(forTextStyle: .body)
    }
}

class InternalFontManager {
    static let systemFont = UIFont.systemFont(ofSize: 16, weight: .bold)
}

extension UIFont {
    /// UIFont -> Font
    public func asFont() -> Font {
        guard InternalFontManager.systemFont.familyName == self.familyName else {
            return Font.custom(self.fontName, size: self.pointSize)
        }
        
        if self.fontName.contains("Bold") {
            return Font.system(size: self.pointSize, weight: .bold, design: .default)
        } else if self.fontName.contains("Semibold") {
            return .system(size: self.pointSize, weight: .semibold, design: .default)
        } else if self.fontName.contains("Medium") {
            return .system(size: self.pointSize, weight: .medium, design: .default)
        } else if self.fontName.contains("Light") {
            return .system(size: self.pointSize, weight: .light, design: .default)
        } else if self.fontName.contains("Thin") {
            return .system(size: self.pointSize, weight: .thin, design: .default)
        } else if self.fontName.contains("Ultralight") {
            return .system(size: self.pointSize, weight: .ultraLight, design: .default)
        } else {
            return .system(size: self.pointSize, weight: .regular, design: .default)
        }
    }
}

extension Font {
    /// Font -> UIFont
    public func asUIFont() -> UIFont {
        return UIFont.preferredFont(from: self)
    }
}
