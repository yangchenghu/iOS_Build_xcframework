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
            end
        end
    end
end


target 'ios-app' do
   pod 'MJRefresh', '3.7.2'
end

