# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '12.0'

target 'KlikDokterIOSTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Kingfisher', '7.6.1'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Alamofire'
  # Pods for KlikDokterIOSTest

  target 'KlikDokterIOSTestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KlikDokterIOSTestUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
