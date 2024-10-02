Pod::Spec.new do |s|
	s.name = "SendbirdSwiftUI"
	s.version = "1.0.0-beta.2"
	s.summary = "Sendbird SwiftUI SDK based on SendbirdChatSDK"
	s.description = "SendbirdSwiftUI is a framework composed of basic UI components based on SwiftUI and SendbirdChatSDK."
	s.homepage = "https://sendbird.com"
	s.documentation_url = 'https://sendbird.com/docs/chat/uikit/v3/swiftui/overview'
	s.license = "Commercial"
	s.authors = {
	"Tez" => "tez.park@sendbird.com",
	"Celine" => "celine.moon@senrbid.com",
	"Damon" => "damon.park@sendbird.com",
	"Jed" => "jed.gyeong@sendbird.com",
	"Minhyuk" => "minhyuk.kim@sendbird.com", 
	"Young" => "young.hwang@sendbird.com",
	"Kai" => "kai.lee@sendbird.com"
  	}
	s.platform = :ios, "15.0"
	s.source = { :http => "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/#{s.version}/SendbirdSwiftUI.zip", :sha1 => "7707988dde5aa55cea4af0f46c4c76f869300699"  }
	s.ios.vendored_frameworks = 'SendbirdSwiftUI/SendbirdSwiftUI.xcframework'
	s.ios.frameworks = ["UIKit", "SwiftUI", "Foundation", "CoreData", "SendbirdChatSDK"]
	s.requires_arc = true
	s.dependency "SendbirdChatSDK", ">= 4.21.1"
	s.ios.library = "icucore"
end
