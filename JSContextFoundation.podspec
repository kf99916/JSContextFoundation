Pod::Spec.new do |s|
  s.name = 'JSContextFoundation'
  s.module_name = 'JSContextFoundation'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'JSContextFoundation is a Swift adapter for the JavaScriptCore Framework to build up the JavaScript runtime environment.'
  s.homepage = 'https://github.com/kf99916/JSContextFoundation'
  s.authors = { 'Zheng-Xiang Ke' => 'https://www.facebook.com/zhengxiang.ke' }
  s.source = { :git => 'https://github.com/kf99916/JSContextFoundation.git', :tag => "#{s.version}" }
  s.platform = :ios, "8.0"
  s.source_files = 'JSContextFoundation/*.swift'
end
