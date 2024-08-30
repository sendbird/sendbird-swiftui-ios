//
//  FontSet.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/15/24.
//

// swiftlint:disable identifier_name
import SwiftUI
import UIKit
import CoreText

/// This struct is a wrapper of `SBUFontSet` of UIKit for SwiftUI.
/// - WARNING: `FontSet` must be set before `SendbirdSwiftUI` initialization, and if you change it at runtime, you must call `SBUTheme.set(theme:)'` to reflect it in the generated theme.
public class FontSet {
    // MARK: - H
    /// Bold, 18pt
    public static var h1: Font {
        get { Font(SBUFontSet.h1) }
        set { SBUFontSet.h1 = newValue.asUIFont() }
    }
    /// Medium, 18pt, Line height: 20pt
    public static var h2: Font {
        get { Font(SBUFontSet.h2) }
        set { SBUFontSet.h2 = newValue.asUIFont() }
    }
    /// Bold, 16pt
    public static var h3: Font {
        get { Font(SBUFontSet.h3) }
        set { SBUFontSet.h3 = newValue.asUIFont() }
    }
    
    // MARK: - Body
    /// Regular, 16pt, Line height: 20pt
    public static var body1: Font {
        get { Font(SBUFontSet.body1) }
        set { SBUFontSet.body1 = newValue.asUIFont() }
    }
    /// Semibold, 14pt, Line height: 16pt
    public static var body2: Font {
        get { Font(SBUFontSet.body2) }
        set { SBUFontSet.body2 = newValue.asUIFont() }
    }
    /// Regular, 14pt, Line height: 16pt
    public static var body3: Font {
        get { Font(SBUFontSet.body3) }
        set { SBUFontSet.body3 = newValue.asUIFont() }
    }
    /// Bold, 14pt, Line height: 20pt
    public static var body4: Font {
        get { Font(SBUFontSet.body4) }
        set { SBUFontSet.body4 = newValue.asUIFont() }
    }
    
    // MARK: - Button
    /// Semibold, 18pt, Line height: 24pt
    public static var button1: Font {
        get { Font(SBUFontSet.button1) }
        set { SBUFontSet.button1 = newValue.asUIFont() }
    }
    /// Medium, 16pt, Line height: 16pt
    public static var button2: Font {
        get { Font(SBUFontSet.button2) }
        set { SBUFontSet.button2 = newValue.asUIFont() }
    }
    /// Medium, 14pt, Line height: 16pt
    public static var button3: Font {
        get { Font(SBUFontSet.button3) }
        set { SBUFontSet.button3 = newValue.asUIFont() }
    }
    /// Bold, 14pt, Line height: 16pt
    public static var button4: Font {
        get { Font(SBUFontSet.button4) }
        set { SBUFontSet.button4 = newValue.asUIFont() }
    }
    
    // MARK: - Caption
    /// Bold, 12pt, Line height: 12pt
    public static var caption1: Font {
        get { Font(SBUFontSet.caption1) }
        set { SBUFontSet.caption1 = newValue.asUIFont() }
    }
    /// Regular, 12pt, Line height: 12pt
    public static var caption2: Font {
        get { Font(SBUFontSet.caption2) }
        set { SBUFontSet.caption2 = newValue.asUIFont() }
    }
    /// Bold, 11pt, Line height: 12pt
    public static var caption3: Font {
        get { Font(SBUFontSet.caption3) }
        set { SBUFontSet.caption3 = newValue.asUIFont() }
    }
    /// Regular, 11pt, Line height: 12pt
    public static var caption4: Font {
        get { Font(SBUFontSet.caption4) }
        set { SBUFontSet.caption4 = newValue.asUIFont() }
    }
    
    // MARK: - Subtitle
    /// Medium, 16pt, Line height 22pt
    public static var subtitle1: Font {
        get { Font(SBUFontSet.subtitle1) }
        set { SBUFontSet.subtitle1 = newValue.asUIFont() }
    }
    /// Regular, 16pt, Line height: 24pt
    public static var subtitle2: Font {
        get { Font(SBUFontSet.subtitle2) }
        set { SBUFontSet.subtitle2 = newValue.asUIFont() }
    }
    /// Regular, 14pt, Line height: 20pt
    public static var subtitle3: Font {
        get { Font(SBUFontSet.subtitle3) }
        set { SBUFontSet.subtitle3 = newValue.asUIFont() }
    }
}

extension FontSet {
    public static func restoreDefaultFonts() {
        SBUFontSet.restoreDefaultFonts()
    }
}
// swiftlint:enable identifier_name
