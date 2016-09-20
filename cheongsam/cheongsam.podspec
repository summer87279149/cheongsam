Pod::Spec.new do |s|
  s.name         = 'cheongsam'
  s.version      = '<#Project Version#>'
  s.license      = '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      = '<#Author Name#>': '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  git: '<#Github Repo URL#>', :tag => s.version
  s.source_files = '<#Resources#>'
  s.frameworks   =  '<#Required Frameworks#>'
  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'AFNetworking'
  s.dependencies =	pod 'SDCycleScrollView'
  s.dependencies =	pod 'Masonry'
  s.dependencies =	pod 'SDAutoLayout'
  s.dependencies =	pod 'MBProgressHUD'
  s.dependencies =	pod 'MJRefresh'
  s.dependencies =	pod 'WMPageController'
  s.dependencies =	pod 'SDWebImage'
  s.dependencies =	pod 'ReactiveCocoa','2.5'
  s.dependencies =	pod 'MJExtension'
  s.dependencies =	pod 'MJRefresh'
  s.dependencies =	pod 'UMengSocialCOM'
  s.dependencies =	pod 'YYText'
  s.dependencies =	pod 'YYWebImage'

end