import SwiftUI

extension CustomTheme.Theme.Custom {
    struct Main: View {
        init() {
            applyCustomTheme()
        }
        
        var body: some View {
            GroupChannelListView()
                .onDisappear {
                    SBUTheme.set(theme: .light)
                }
        }
    }
}

#Preview {
    CustomTheme.Theme.Custom.Main()
}

extension CustomTheme.Theme.Custom.Main {
    func applyCustomTheme() {
        SBUTheme.groupChannelCellTheme.backgroundColor = Color.red.asUIColor()
        SBUTheme.groupChannelCellTheme.titleFont = Font.largeTitle.asUIFont()
    }
}
