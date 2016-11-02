source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target "realms" do
    pod "Realm"
    pod "RealmSwift"
    pod 'SwiftyJSON', :git => 'https://github.com/acegreen/SwiftyJSON.git', :branch => 'swift3'
    pod 'ObjectMapper'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

