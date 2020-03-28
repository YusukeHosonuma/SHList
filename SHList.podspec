Pod::Spec.new do |spec|
    spec.name         = "SHList"
    spec.version      = "0.1.0"
    spec.summary      = "HList for Swift"

    spec.description  = <<-DESC
    HList for Swift as statically meta-programming.
    DESC

    spec.homepage         = "https://github.com/YusukeHosonuma/SHList"
    spec.license          = { :type => 'MIT', :file => 'LICENSE' }
    spec.authors          = { "Yusuke Hosonuma" => "tobi462@gmail.com" }
    spec.social_media_url = "https://twitter.com/tobi462"

    spec.ios.deployment_target     = "9.3"
    # spec.osx.deployment_target     = "9.3"
    # spec.watchos.deployment_target = "9.3"
    # spec.tvos.deployment_target    = "9.3"

    spec.source = { :git => "https://github.com/YusukeHosonuma/SHList.git", :tag => "#{spec.version}" }
    spec.source_files  = "Sources/SHList/**/*.{swift}"
    spec.swift_version = "5.1"
  end
