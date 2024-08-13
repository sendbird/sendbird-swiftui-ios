import SwiftUI

/// WARNING: `FontSet`, `ColorSet` must be set before `SendbirdSwiftUI` initialization, and if you change them at runtime, you must call `SBUTheme.set(theme:)'` to reflect them in the generated theme.
extension CustomTheme.ColorSet.Custom {
    struct Main: View {
        init() {
            applyCustomColor()
        }
        
        var body: some View {
            GroupChannelListView()
                .onDisappear {
                    ColorSet.restoreDefaultColors()
                    SBUTheme.set(theme: .light)
                }
        }
    }
}

#Preview {
    CustomTheme.ColorSet.Custom.Main()
}

extension CustomTheme.ColorSet.Custom.Main {
    func applyCustomColor() {
        ColorSet.primaryExtraLight = .red
        ColorSet.primaryLight = .red
        ColorSet.primaryMain = .red
        ColorSet.primaryDark = .red
        ColorSet.primaryExtraDark = .red
        
        ColorSet.secondaryExtraLight = .blue
        ColorSet.secondaryLight = .blue
        ColorSet.secondaryMain = .blue
        ColorSet.secondaryDark = .blue
        ColorSet.secondaryExtraDark = .blue
        
        SBUTheme.set(theme: .light)
    }
}
