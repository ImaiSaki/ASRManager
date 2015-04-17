#
# Be sure to run `pod lib lint ASRManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ASRManager"
  s.version          = "0.1.9"
  s.summary          = "ASRManager make app easier to use AsReader."
  s.homepage         = "https://github.com/asx-co-jp/ASRManager"
  s.license          = 'MIT'
	s.author           = { "Asterisk.inc Technical Team" => "tech@asx.co.jp" }
  s.source           = { :git => "https://github.com/asx-co-jp/ASRManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Example/Pods/RcpLib/*.{h,mm}'
  s.ios.vendored_library = 'Example/Pods/RcpLib/libAreteUart.a'

  s.resource_bundles = {
    'ASRManager' => ['Pod/Assets/*.png']
  }
  s.frameworks = 'ExternalAccessory'
end
