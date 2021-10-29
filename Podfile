# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'


def default_pods
  pod 'Alamofire', '~> 5.1.0'
  pod 'AlamofireImage'
  pod 'CodableAlamofire', '~> 1.2.1'
  pod 'CryptoSwift'
end


target 'MarvelApplication' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MarvelApplication
	default_pods

  target 'MarvelApplicationTests' do
    inherit! :search_paths
    # Pods for testing
	default_pods
  end

  target 'MarvelApplicationUITests' do
    # Pods for testing
	default_pods
  end

end

target 'MarvelApplication MOCK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MarvelApplication MOCK
	default_pods

end


