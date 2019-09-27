platform :ios, '13.0'

inhibit_all_warnings!

target 'SunCity' do
    use_frameworks!

    pod 'SkyFloatingLabelTextField'
    pod 'NodeKit'
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
