Pod::Spec.new do |s|
  s.name          = "IntrepidTesting"
  s.version       = "0.16.0"
  s.summary       = "A collection of test extensions to the Swift Standard Library"
  s.description   = <<-DESC
                    Collection of test extensions and utility classes by and for the developers at Intrepid Pursuits.
                    DESC
  s.homepage      = "https://github.com/IntrepidPursuits/swift-wisdom"
  s.license       = "MIT"
  s.authors       = { "Colden Prime" => "colden@intrepid.io" }
  s.source        = { :git => "https://github.com/IntrepidPursuits/swift-wisdom.git", :tag => "#{s.version}" }
  s.platform      = :ios
  s.ios.deployment_target = "10.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.4' }
  s.default_subspec = "Core"
  s.swift_versions = ['4.2', '5.0', '5.1', '5.2', '5.3']

  s.subspec "Core" do |cs|
    cs.frameworks    = "XCTest"
    cs.source_files  = "SwiftWisdomTests/Testing/**/*.swift"
  end
end
