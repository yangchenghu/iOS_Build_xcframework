source 'https://cdn.cocoapods.org/'

project 'PodsHost/PodsHost.xcodeproj'

ENV['SWIFT_VERSION'] = '5'

platform :ios, '12.0'

use_frameworks!   :linkage => :static # :dynamic # :static
#use_modular_headers!

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
                config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
            end
        end
    end
end

# config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
# 解决：No 'swiftinterface' files found within 问题。来源：https://blog.csdn.net/qq_19484963/article/details/131599401



target 'ios-app' do
   pod 'MJRefresh', '3.7.2'
end

