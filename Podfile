# Uncomment the next line to define a global platform for your project
platform :ios, '11.2'
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

def rx_swift
  pod 'RxSwift', '~> 5.0'
end

def rx_cocoa
  pod 'RxCocoa', '~> 5.0'
end

def test_pods
  pod 'RxTest'
  pod 'RxBlocking'
  pod 'Nimble'
end

target 'App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  rx_cocoa
  rx_swift
  pod 'QueryKit'
  pod 'Kingfisher', '~> 4.0'
  pod 'RxDataSources', '~> 4.0'
  pod "MXParallaxHeader"
  pod 'ABLoaderView'

  pod 'CHIPageControl', '~> 0.1.3'
  # individual page control
  pod 'CHIPageControl/Aji'
  pod 'CHIPageControl/Aleppo'
  pod 'CHIPageControl/Chimayo'
  pod 'CHIPageControl/Fresno'
  pod 'CHIPageControl/Jalapeno'
  pod 'CHIPageControl/Jaloro'
  pod 'CHIPageControl/Paprika'
  pod 'CHIPageControl/Puya'
  pod 'YLProgressBar', '~> 3.11.0'
  pod 'FittedSheets'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  
  pod 'Bartinter'
  target 'AppTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'Domain' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  pod 'ObjectMapper', '~> 4.2.0'

end

target 'NetworkPlatform' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'ObjectMapper', '~> 4.2.0'

end

target 'RealmPlatform' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  pod 'RxRealm', '~> 1.0.0'
  pod 'QueryKit'
  pod 'RealmSwift', '~> 3.15'
  pod 'Realm', '~> 3.15'

end

