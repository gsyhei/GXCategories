#
#  Be sure to run `pod spec lint GXCategories.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "GXCategories"
  s.version       = "1.1.1"
  s.swift_version = "5.0"
  s.summary       = "Swift版的常用扩展/分类。"
  s.homepage      = "https://github.com/gsyhei/GXCategories"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Gin" => "279694479@qq.com" }
  s.platform      = :ios, "13.0"
  s.source        = { :git => "https://github.com/gsyhei/GXCategories.git", :tag => "1.1.1" }
  s.requires_arc  = true
  s.source_files  = "GXCategories"
 #s.resources     = 'GXCategories/Resource/**/*'
  s.frameworks    = "UIKit"

end
