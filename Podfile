platform :ios, '13.0'

inhibit_all_warnings!

target 'SunCity' do
    use_frameworks!
    pod 'Nuke'
    pod 'Chatto', '= 3.5.0'
	  pod 'ChattoAdditions', '= 3.5.0'
    pod 'SkyFloatingLabelTextField'
    pod 'Starscream'
    pod 'NodeKit', :git => 'https://github.com/surfstudio/NodeKit', :commit => 'b5c30f2a30ab3d047f19e5049d858cdd5c524c55'
    pod 'ImagePicker'
    pod 'YXWaveView'
    pod 'SwiftMessages'
    pod 'iCarousel'
    pod 'SurfUtils/KeyboardPresentable', :git => "https://github.com/surfstudio/iOS-Utils.git", :tag => '9.0.0'
  end

target 'SunCityTests' do
  use_frameworks!
end

# # This needed to avoid "Enable Base Internationalization" warning
# # See here: https://github.com/CocoaPods/CocoaPods/issues/8494
# post_install do |installer|
#     installer.pods_project.build_configurations.each do |config|
#         config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
#     end
# end

post_install do |installer|
    # Disables bitcode for all pods
    installer.pods_project.targets.each do |target|
      if ['Paparazzo', 'ImageSource', 'ImagePicker', 'YXWaveView'].include? target.name
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
      else
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.0'
        end
      end
    end
end
