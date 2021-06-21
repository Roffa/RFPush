#
# Be sure to run `pod lib lint LSPush.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LSPush'
  s.version          = '0.1.7'
  s.summary          = '推送组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      依托Mob的轻量级推送框架
                       DESC

  s.homepage         = 'http://172.18.63.220/lanshan_ios/doc/lsbasis/lspush'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'roffa' => 'roffa@qq.com' }
  s.source           = { :git => 'http://172.18.63.220/lanshan_ios/doc/lsbasis/lspush.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version    = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'LSPush/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LSPush' => ['LSPush/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  
#  s.static_framework = true
#  s.dependency 'mob_pushsdk'
#  s.default_subspecs = 'MobPush'
  
  
  s.libraries = 'c++', 'z.1.2.5'
  s.vendored_frameworks = 'LSPush/Vendors/*.framework'
#  s.preserve_paths = 'LSPush/Vendors/*.framework'
#  s.pod_target_xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '$(PODS_ROOT)/LSPush/Vendors/' }
  
#  s.prepare_command = <<-EOF
#      # 创建MobPush Module
#      rm -rf LSPush/Vendors/MobPush.framework/Modules
#      mkdir LSPush/Vendors/MobPush.framework/Modules
#      touch LSPush/Vendors/MobPush.framework/Modules/module.modulemap
#      cat <<-EOF > LSPush/Vendors/MobPush.framework/Modules/module.modulemap
#      framework module MobPush {
#        umbrella header "MobPush.h"
#        export *
#        link "libz.1.2.5"
#        link "libc++"
#      }
#      \EOF
#
#      # 创建MOBFoundation Module
#      rm -rf LSPush/Vendors/MOBFoundation.framework/Modules
#      mkdir LSPush/Vendors/MOBFoundation.framework/Modules
#      touch LSPush/Vendors/MOBFoundation.framework/Modules/module.modulemap
#      cat <<-EOF > LSPush/Vendors/MOBFoundation.framework/Modules/module.modulemap
#      framework module MOBFoundation {
#        umbrella header "MOBFoundation.h"
#        export *
#        link "libz.1.2.5"
#        link "libc++"
#      }
#      \EOF
#      # 创建MobPushServiceExtension Module
#      rm -rf LSPush/Vendors/MobPushServiceExtension.framework/Modules
#      mkdir LSPush/Vendors/MobPushServiceExtension.framework/Modules
#      touch LSPush/Vendors/MobPushServiceExtension.framework/Modules/module.modulemap
#      cat <<-EOF > LSPush/Vendors/MobPushServiceExtension.framework/Modules/module.modulemap
#      framework module MobPushServiceExtension {
#        umbrella header "MobPushServiceExtension.h"
#        export *
#        link "libz.1.2.5"
#        link "libc++"
#      }
#      \EOF
#
#    EOF

  
#  spec.vendored_libraries = 'libProj4.a', 'libJavaScriptCore.a'
end
