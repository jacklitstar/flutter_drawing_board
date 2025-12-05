Pod::Spec.new do |s|
  s.name             = 'flutter_drawing_board'
  s.version          = '0.9.8'
  s.summary          = 'Flutter drawing board plugin'
  s.description      = 'A Flutter package of drawing board, provides basic drawing tools, canvas operations, and image data acquisition.'
  s.homepage         = 'https://github.com/fluttercandies/flutter_drawing_board'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'fluttercandies' => 'opensource@fluttercandies.com' }
  s.source           = { :path => '.' }

  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'
  s.static_framework = true

  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
end