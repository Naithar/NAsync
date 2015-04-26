Pod::Spec.new do |s|
  s.name             = "NAsync"
  s.version          = "0.5.0"
  s.summary          = "Asynchronous tasks library."
  s.description      = <<-DESC
                       Library for asynchronous tasks. Presents queues, promises and chaining.
                       Tasks can return type to chained task if needed.
                       DESC
  s.homepage         = "https://github.com/naithar/NAsync"
  s.license          = 'MIT'
  s.author           = { "Naithar" => "devias.naith@gmail.com" }
  s.source           = { :git => "https://github.com/naithar/NAsync.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/naithar'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/**/*'

  s.public_header_files = 'Pod/*.h'
  s.weak_framework = 'XCTest'
  s.framework = 'XCTest'
end
