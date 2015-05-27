Pod::Spec.new do |s|
  s.name         = "TBXML-CBAdditions"
  s.version      = "1.0.0"
  s.summary      = "Turn TBXML parsing codes from nested while loops into one line."
  s.description  = <<-DESC
                   TBXML-CBAdditions makes your codes clearer by using structed case handlers instead of using nested while loops.
                   DESC
  s.homepage     = "https://github.com/CocoaBob/TBXML-CBAdditions"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "CocoaBob"
  s.social_media_url = 'https://twitter.com/CocoaBob'
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/CocoaBob/TBXML-CBAdditions.git", :tag => "1.0.0" }
  s.source_files  = "*.{h,m}"
  s.dependency "TBXML"
  s.requires_arc = true
end
