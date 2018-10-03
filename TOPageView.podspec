Pod::Spec.new do |s|
s.name             = "TOPageView"
s.version          = "1.0.3"
s.summary          = "一个可视化编辑的分页菜单。支持storyboard、xib、autolayout。动态加载页面，支持懒加载。属性和内容支持动态修改"
s.description      = <<-DESC
TOPageViewController是一个可视化编辑的分页菜单。支持storyboard、xib、autolayout。动态加载页面，支持懒加载。属性和内容支持动态修改
DESC
s.homepage         = "https://github.com/TonyJR/TOPageViewController"
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { "Tony.JR" => "show_3@163.com" }
s.source           = { :git => "https://github.com/TonyJR/TOPageViewController.git", :tag => "#{s.version}" }
s.platform         = :ios, '7.0'           
s.requires_arc     = true  
             
s.source_files     = 'TOPageView/*.{h,m}','TOPageView/tools/*.{h,m}','TOPageView/models/*.{h,m}'

s.frameworks       = 'Foundation'


end
