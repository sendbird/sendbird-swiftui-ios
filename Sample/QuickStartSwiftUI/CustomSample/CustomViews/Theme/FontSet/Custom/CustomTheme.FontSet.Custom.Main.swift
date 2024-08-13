import SwiftUI

/// WARNING: `FontSet`, `ColorSet` must be set before `SendbirdSwiftUI` initialization, and if you change them at runtime, you must call `SBUTheme.set(theme:)'` to reflect them in the generated theme.
extension CustomTheme.FontSet.Custom {
    struct Main: View {
        init() {
            applyCustomFont()
        }
        
        var body: some View {
            GroupChannelListView()
                .onDisappear {
                    FontSet.restoreDefaultFonts()
                    SBUTheme.set(theme: .light)
                }
        }
    }
}

#Preview {
    CustomTheme.FontSet.Custom.Main()
}

extension CustomTheme.FontSet.Custom.Main {
    func applyCustomFont() {
        FontSet.h1 = Font.largeTitle
        FontSet.h2 = Font.largeTitle
        FontSet.h3 = Font.largeTitle
        FontSet.body1 = Font.largeTitle
        FontSet.body2 = Font.largeTitle
        FontSet.body3 = Font.largeTitle
        FontSet.body4 = Font.largeTitle
        FontSet.button1 = Font.largeTitle
        FontSet.button2 = Font.largeTitle
        FontSet.button3 = Font.largeTitle
        FontSet.button4 = Font.largeTitle
        FontSet.caption1 = Font.largeTitle
        FontSet.caption2 = Font.largeTitle
        FontSet.caption3 = Font.largeTitle
        FontSet.caption4 = Font.largeTitle
        FontSet.subtitle1 = Font.largeTitle
        FontSet.subtitle2 = Font.largeTitle
        FontSet.subtitle3 = Font.largeTitle
        
        SBUTheme.set(theme: .light)
    }
}
