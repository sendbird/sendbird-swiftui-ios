import SwiftUI

extension CustomTheme.IconSet.Custom {
    struct Main: View {
        init() {
            applyCustomIcon()
        }
        var body: some View {
            GroupChannelListView()
                .onDisappear {
                    SBUIconSet.restoreDefaultIcons()
                }
        }
    }
}

#Preview {
    CustomTheme.IconSet.Custom.Main()
}

extension CustomTheme.IconSet.Custom.Main {
    func applyCustomIcon() {
        
        if let iconCreateCustom = UIImage(systemName: "folder.fill.badge.plus") {
            SBUIconSet.iconCreate = iconCreateCustom
        }
        
        if let iconUserCustom = UIImage(systemName: "figure.wave") {
            SBUIconSet.iconUser = iconUserCustom
        }
    }
}
