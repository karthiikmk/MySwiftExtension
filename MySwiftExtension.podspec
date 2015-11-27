
Pod::Spec.new do |s|
  s.name             = "MySwiftExtension"
  s.version          = "1.0"
  s.summary          = "A simple Extension for Swift"

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/MySwiftExtension"

  s.license          = 'MIT'
  s.author           = { "karthik-dev" => "mkkarthiik@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/MySwiftExtension.git", :tag => s.version.to_s }


  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MySwiftExtension' => ['Pod/Assets/*.png']
  }

end
