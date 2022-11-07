platform :ios, ‘14.0’
inhibit_all_warnings!
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target 'Astra' do
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'RxCocoa'

  pod 'NotificationBannerSwift'
  pod 'lottie-ios'
  pod 'Kingfisher'
  pod 'SwiftCharts', '~> 0.6.5'
  
  pod 'Purchases'
  pod 'ApphudSDK'
  pod 'Qonversion'
  pod 'Adapty', '~> 1.15'
  pod 'Purchasely', '~> 2.7.4'
  pod 'SwiftyStoreKit'
  
  pod 'OtterScaleiOS', :git => "https://github.com/AgentChe/OtterScaleiOS.git"
  
  pod 'FBSDKCoreKit'
  pod 'Amplitude-iOS'
  pod 'Branch'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Messaging'
  pod 'AppsFlyerFramework'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
    end
  end
end
  
  
  
  
