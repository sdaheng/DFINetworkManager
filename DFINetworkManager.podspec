Pod::Spec.new do |s|
  s.name         = "DFINetworkManager"
  s.version      = "0.0.3"
  s.summary      = "A lib wrap AFNetworking."

  s.homepage     = "https://github.com/sdaheng/DFINetworkManager.git"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "sdaheng" => "sdaheng@gmail.com" }
  
  s.ios.deployment_target = "8.0"
  #s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/sdaheng/DFINetworkManager.git", :tag => "0.0.3" }

  s.source_files  =  "DFINetworkManager/*.{h,m}"

  s.public_header_files = ["DFINetworkManager/DFINetworkManager.h",
			   "DFINetworkManager/DFINetworkManagerTypes.h",
			   "DFINetworkManager/DFINetworkServiceProtocol.h",
			   "DFINetworkManager/DFINetworkService.h",
			   "DFINetworkManager/DFINetworkAPIRequest.h",
			   "DFINetworkManager/DFINetworkServiceAPIRequestDelegate.h",
			   "DFINetworkManager/DFINetworkReachabilityManager.h",
			   "DFINetworkManager/DFINetworkManagerDefines.h",
			   "DFINetworkManager/DFINetworkNotificationNames.h",
			   "DFINetworkManager/DFINetworkHTTPConfiguration.h",
			   "DFINetworkManager/DFINetworkService+RACSupport.h",
			   "DFINetworkManager/DFINetworkServiceRACSupportProtocol.h"]

  s.framework  = "SystemConfiguration"

  s.requires_arc = true

  s.dependency "AFNetworking"

end
