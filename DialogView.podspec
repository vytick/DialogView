Pod::Spec.new do |s|
  s.name         = "DialogView"
  s.version      = "0.1"
  s.summary      = "Highly customisable dialog (alert) view made in swift"
  s.homepage     = "https://github.com/manGoweb/DialogView"
  s.screenshots  = "https://raw.githubusercontent.com/vikmeup/SCPopUpView/master/errorScreenshot.png", "https://raw.githubusercontent.com/vikmeup/SCPopUpView/master/successScreenshot.png"

  # s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENCE" }
  s.author             = { "Viktor" => "yazexel@gmail.com" }
  s.social_media_url   = "http://twitter.com/vikmeup"
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/vikmeup/SCLAlertView-Swift.git", :tag => "0.5.1" }
  s.source_files  = "SCLAlertView/*"
  #s.framework  = "QuartzCore"
  s.requires_arc = true
end