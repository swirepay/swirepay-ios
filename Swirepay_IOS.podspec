#
# Be sure to run `pod lib lint Swirepay_IOS_SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Swirepay_IOS'
  s.version          = '1.0'
  s.summary          = 'The Swirepay_iOS SDK makes it quick and easy to build an excellent payment experience in your iOS app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = "Swirepay iOS SDK helps developers implement a native payment experience in their iOS application. The SDK requires minimal setup to get started and helps developers process payments under 30 seconds while being PCI compliant."

  s.homepage         = 'https://www.swirepay.com/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Swirepay' => 'developer@swirepay.com' }
  s.source           = { :git => 'https://github.com/swirepay/swirepay-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.0'

  s.source_files = 'Swirepay_IOS_SDK/Classes/**/*'

#   s.resource_bundles = {
#     'Swirepay_IOS_SDK' => ['Swirepay_IOS_SDK/Assets/Swirepay.storyboard']
#   }
   s.resource = "Swirepay_IOS_SDK/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'Alamofire', '~> 4.0'
   s.dependency  'SwiftyJSON', '~> 4.0'
  
end
