
Pod::Spec.new do |s|

  s.name         = "cURLLook"
  s.version      = "0.0.1"
  s.summary      = "Make your NSURLRequest a cURL command"

  s.description  = <<-DESC
                   This μ-framework serializes your NSURLRequest object to
                   a cURL command, so you can convey to a backend person
                   clearly what kind of HTTP request your code is making.

                   DESC

  s.homepage     = "https://github.com/dduan/cURLLook"

  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author             = { "Daniel Duan" => "daniel@duan.org" }
  s.social_media_url   = "https://twitter.com/Daniel_Duan"

   s.ios.deployment_target = "9.0"
   s.osx.deployment_target = "10.10"

  s.source       = { :git => "https://github.com/dduan/cURLLook.git", :tag => "v#{s.version}" }

  s.source_files  = "cURLLook", "cURLLook/**/*.{swift}"

end
