Pod::Spec.new do |s|
	s.name = "SendbirdSwiftUI"
	s.version = "1.0.0-beta.0"
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
	s.source = { :git => "https://github.com/sendbird/sendbird-swiftui-ios/releases/download/#{s.version}/SendbirdSwiftUI.zip", :sha1 => "ac0e1e7741d69b4e1f0ffc6cb0bf76d6f6de0923"  }
	s.ios.vendored_frameworks = 'Framework/SendbirdSwiftUI.xcframework'
	s.ios.frameworks = ["UIKit", "SwiftUI", "Foundation", "CoreData", "SendbirdChatSDK"]
	s.requires_arc = true
	s.dependency "SendbirdChatSDK", ">= 4.20.0"
	s.ios.library = "icucore"
end
