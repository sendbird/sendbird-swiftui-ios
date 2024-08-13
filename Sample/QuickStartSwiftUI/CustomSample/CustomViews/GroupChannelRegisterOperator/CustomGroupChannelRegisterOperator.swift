import SwiftUI
struct CustomGroupChannelRegisterOperator: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupChannelRegisterOperatorView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomGroupChannelRegisterOperator()
}

extension CustomGroupChannelRegisterOperator {
    struct SwiftUI {
        struct View {
        }
    }
    struct SubView {
        struct Builder {
        }
    }
    struct ViewConverter {
        struct Header {
        }
        struct List {
        }
    }
}
