Pod::Spec.new do |s|
  s.name = '${POD_NAME}'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'A view controller for chess boards'
  s.homepage = 'https://github.com/fulldecent/PROJECT'
  s.authors = { 'William Entriken' => 'github.com@phor.net' }
  s.source = { :git => 'https://github.com/fulldecent/PROJECT.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/*.swift'
  s.resource_bundles = {
    'PROJECT' => ['Resources/**/*.{png}']
  }
end
