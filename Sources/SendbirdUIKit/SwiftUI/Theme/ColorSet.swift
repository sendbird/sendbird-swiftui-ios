//
//  ColorSet.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/9/24.
//

import SwiftUI
import UIKit

/// This struct is a wrapper of `SBUColor` of UIKit for SwiftUI.
/// - WARNING: `ColorSet` must be set before `SendbirdSwiftUI` initialization, and if you change it at runtime, you must call `SBUTheme.set(theme:)'` to reflect it in the generated theme.
public class ColorSet {
    // swiftlint:disable all
    // MARK: - Primary
    public static var primaryExtraLight: Color {
        get { Color(SBUColorSet.primaryExtraLight) }
        set { SBUColorSet.primaryExtraLight = newValue.asUIColor() }
    }
    public static var primaryLight: Color {
        get { Color(SBUColorSet.primaryLight) }
        set { SBUColorSet.primaryLight = newValue.asUIColor() }
    }
    public static var primaryMain: Color {
        get { Color(SBUColorSet.primaryMain) }
        set { SBUColorSet.primaryMain = newValue.asUIColor() }
    }
    public static var primaryDark: Color {
        get { Color(SBUColorSet.primaryDark) }
        set { SBUColorSet.primaryDark = newValue.asUIColor() }
    }
    public static var primaryExtraDark: Color {
        get { Color(SBUColorSet.primaryExtraDark) }
        set { SBUColorSet.primaryExtraDark = newValue.asUIColor() }
    }
    
    // MARK: - Secondary
    public static var secondaryExtraLight: Color {
        get { Color(SBUColorSet.secondaryExtraLight) }
        set { SBUColorSet.secondaryExtraLight = newValue.asUIColor() }
    }
    public static var secondaryLight: Color {
        get { Color(SBUColorSet.secondaryLight) }
        set { SBUColorSet.secondaryLight = newValue.asUIColor() }
    }
    public static var secondaryMain: Color {
        get { Color(SBUColorSet.secondaryMain) }
        set { SBUColorSet.secondaryMain = newValue.asUIColor() }
    }
    public static var secondaryDark: Color {
        get { Color(SBUColorSet.secondaryDark) }
        set { SBUColorSet.secondaryDark = newValue.asUIColor() }
    }
    public static var secondaryExtraDark: Color {
        get { Color(SBUColorSet.secondaryExtraDark) }
        set { SBUColorSet.secondaryExtraDark = newValue.asUIColor() }
    }
    
    // MARK: - Background
    public static var background50: Color {
        get { Color(SBUColorSet.background50) }
        set { SBUColorSet.background50 = newValue.asUIColor() }
    }
    public static var background100: Color {
        get { Color(SBUColorSet.background100) }
        set { SBUColorSet.background100 = newValue.asUIColor() }
    }
    public static var background200: Color {
        get { Color(SBUColorSet.background200) }
        set { SBUColorSet.background200 = newValue.asUIColor() }
    }
    public static var background300: Color {
        get { Color(SBUColorSet.background300) }
        set { SBUColorSet.background300 = newValue.asUIColor() }
    }
    public static var background400: Color {
        get { Color(SBUColorSet.background400) }
        set { SBUColorSet.background400 = newValue.asUIColor() }
    }
    public static var background500: Color {
        get { Color(SBUColorSet.background500) }
        set { SBUColorSet.background500 = newValue.asUIColor() }
    }
    public static var background600: Color {
        get { Color(SBUColorSet.background600) }
        set { SBUColorSet.background600 = newValue.asUIColor() }
    }
    public static var background700: Color {
        get { Color(SBUColorSet.background700) }
        set { SBUColorSet.background700 = newValue.asUIColor() }
    }
    
    // MARK: - Overlay
    public static var overlayDark: Color {
        get { Color(SBUColorSet.overlayDark) }
        set { SBUColorSet.overlayDark = newValue.asUIColor() }
    }
    public static var overlayLight: Color {
        get { Color(SBUColorSet.overlayLight) }
        set { SBUColorSet.overlayLight = newValue.asUIColor() }
    }
    
    // MARK: - On Light
    public static var onLightTextHighEmphasis: Color {
        get { Color(SBUColorSet.onLightTextHighEmphasis) }
        set { SBUColorSet.onLightTextHighEmphasis = newValue.asUIColor() }
    }
    public static var onLightTextMidEmphasis: Color {
        get { Color(SBUColorSet.onLightTextMidEmphasis) }
        set { SBUColorSet.onLightTextMidEmphasis = newValue.asUIColor() }
    }
    public static var onLightTextLowEmphasis: Color {
        get { Color(SBUColorSet.onLightTextLowEmphasis) }
        set { SBUColorSet.onLightTextLowEmphasis = newValue.asUIColor() }
    }
    public static var onLightTextDisabled: Color {
        get { Color(SBUColorSet.onLightTextDisabled) }
        set { SBUColorSet.onLightTextDisabled = newValue.asUIColor() }
    }
    
    // MARK: - On Dark
    public static var onDarkTextHighEmphasis: Color {
        get { Color(SBUColorSet.onDarkTextHighEmphasis) }
        set { SBUColorSet.onDarkTextHighEmphasis = newValue.asUIColor() }
    }
    public static var onDarkTextMidEmphasis: Color {
        get { Color(SBUColorSet.onDarkTextMidEmphasis) }
        set { SBUColorSet.onDarkTextMidEmphasis = newValue.asUIColor() }
    }
    public static var onDarkTextLowEmphasis: Color {
        get { Color(SBUColorSet.onDarkTextLowEmphasis) }
        set { SBUColorSet.onDarkTextLowEmphasis = newValue.asUIColor() }
    }
    public static var onDarkTextDisabled: Color {
        get { Color(SBUColorSet.onDarkTextDisabled) }
        set { SBUColorSet.onDarkTextDisabled = newValue.asUIColor() }
    }
    
    // MARK: - Error
    public static var errorExtraLight: Color {
        get { Color(SBUColorSet.errorExtraLight) }
        set { SBUColorSet.errorExtraLight = newValue.asUIColor() }
    }
    public static var errorLight: Color {
        get { Color(SBUColorSet.errorLight) }
        set { SBUColorSet.errorLight = newValue.asUIColor() }
    }
    public static var errorMain: Color {
        get { Color(SBUColorSet.errorMain) }
        set { SBUColorSet.errorMain = newValue.asUIColor() }
    }
    public static var errorDark: Color {
        get { Color(SBUColorSet.errorDark) }
        set { SBUColorSet.errorDark = newValue.asUIColor() }
    }
    public static var errorExtraDark: Color {
        get { Color(SBUColorSet.errorExtraDark) }
        set { SBUColorSet.errorExtraDark = newValue.asUIColor() }
    }
    
    // MARK: - Information
    public static var informationExtraDark: Color {
        get { Color(SBUColorSet.informationExtraDark) }
        set { SBUColorSet.informationExtraDark = newValue.asUIColor() }
    }
    public static var informationDark: Color {
        get { Color(SBUColorSet.informationDark) }
        set { SBUColorSet.informationDark = newValue.asUIColor() }
    }
    public static var informationMain: Color {
        get { Color(SBUColorSet.informationMain) }
        set { SBUColorSet.informationMain = newValue.asUIColor() }
    }
    public static var informationLight: Color {
        get { Color(SBUColorSet.informationLight) }
        set { SBUColorSet.informationLight = newValue.asUIColor() }
    }
    public static var informationExtraLight: Color {
        get { Color(SBUColorSet.informationExtraLight) }
        set { SBUColorSet.informationExtraLight = newValue.asUIColor() }
    }
    
    // MARK: - Highlight
    public static var highlight: Color {
        get { Color(SBUColorSet.highlight) }
        set { SBUColorSet.highlight = newValue.asUIColor() }
    }
    // swiftlint:enable all
}

extension ColorSet {
    public static func restoreDefaultColors() {
        SBUColorSet.restoreDefaultColors()
    }
}
