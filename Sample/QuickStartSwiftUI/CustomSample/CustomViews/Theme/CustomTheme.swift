import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomTheme: View {
    var body: some View {
        GroupChannelListView()
    }
}

#Preview {
    CustomTheme()
}

extension CustomTheme {
    struct ColorSet {
        struct Custom {
        }
    }
    struct FontSet {
        struct Custom {
        }
    }
    struct IconSet {
        struct Custom {
        }
    }
    struct Theme {
        struct Custom {
        }
    }
}
