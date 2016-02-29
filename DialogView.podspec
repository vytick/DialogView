Pod::Spec.new do |s|
  s.name         = "DialogView"
  s.version      = "0.1"
  s.summary      = "Highly customisable dialog (alert) view made in swift"
  s.homepage     = "https://github.com/manGoweb/DialogView"
  s.screenshots  = "https://raw.githubusercontent.com/manGoweb/DialogView/master/_orig/screenshot.jpg"

  s.license      = { :type => "MIT", :file => "LICENCE" }
  s.author             = { "Ondrej Rafaj" => "developer@mangoweb.cz" }
  s.social_media_url   = "http://twitter.com/rafiki270"
  s.platform     = :ios
  s.ios.deployment_target = '8.1'
  s.source       = { :git => "https://github.com/manGoweb/DialogView.git", :tag => "0.1" }
  s.source_files  = "Classes/*"
  s.dependency = 'SnapKit'
  s.requires_arc = true
end