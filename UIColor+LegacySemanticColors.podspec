Pod::Spec.new do |s|
  s.name     = 'UIColor+LegacySemanticColors'
  s.version  = '1.0.0'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A UIColor category that backports the new semantic colors of iOS 13 to iOS 12.'
  s.homepage = 'https://github.com/TimOliver/UIColor-LegacySemanticColors'
  s.author   = 'Tim Oliver'
  s.source   = { :git => 'https://github.com/TimOliver/UIColor-LegacySemanticColors.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.platform = :ios, '12.0'
  s.source_files = 'UIColor-LegacySemanticColors/**/*.{h,m}'
end
