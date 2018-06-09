Pod::Spec.new do |s|
  s.name = 'GenericJSON'
  s.ios.deployment_target = '10.0'
  s.version = '1.0.0'
  s.license = { :type => 'MIT' }
  s.homepage = 'https://github.com/zoul/generic-json-swift'
  s.authors = 'Tomáš Znamenáček'
  s.summary = 'A simple Swift library for working with generic JSON structures.'
  s.description = 'A simple Swift library for working with generic JSON structures.'
  s.source = { :git => 'git@github.com:zoul/generic-json-swift.git', :tag => '1.0.0' }
  s.source_files = 'GenericJSON/*.swift'
end

