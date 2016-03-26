#
# Be sure to run `pod lib lint DialogView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DialogView"
  s.version          = "0.1.0"
  s.summary          = "Highly customisable dialog (alert) view made in swift."

  s.description      = "You can customise pretty much anything prom inner paddings and margins to all colors and views. Please refer to the README.md for instructions"

  s.homepage         = "https://github.com/manGoweb/DialogView"
  s.screenshots     = "https://raw.githubusercontent.com/manGoweb/DialogView/master/_orig/screenshot1.jpg", "https://raw.githubusercontent.com/manGoweb/DialogView/master/_orig/screenshot2.jpg"
  s.license          = 'MIT'
  s.author           = { "Ondrej Rafaj" => "rafaj@mangoweb.cz" }
  s.source           = { :git => "https://github.com/manGoweb/DialogView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rafiki270'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DialogView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 0.19.1'
end
