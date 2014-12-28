# origin: https://github.com/CocoaPods/pod-template
#
# references:
# * http://www.objc.io/issue-6/travis-ci.html
# * https://github.com/supermarin/xcpretty#usage

$pod_name = '${POD_NAME}'
$scheme_args = "-workspace Example/#{$pod_name}.xcworkspace -scheme #{$pod_name}-Example"

task :install_pods do
  raise unless system "pod install --project-directory=Example"
end

desc "Install development dependencies"
task :install => :install_pods do
  puts
  puts "Installing xcpretty gem with sudo."
  puts
  raise unless system "sudo -k gem install xcpretty"
end

task :install_for_ci do
  # Uncomment if Pods/ is in .gitignore
  # raise unless system "gem install cocoapods --no-rdoc --no-ri --no-document --quiet" # Since Travis is not always on latest version
  # Rake::Task['install_pods'].invoke

  raise unless system "gem install xcpretty --no-rdoc --no-ri --no-document --quiet"
end

desc "Run tests on the iOS Simulator"
task :test do
  raise unless system "bash -c 'set -o pipefail && xcodebuild test #{$scheme_args} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO | xcpretty -c'"
end

desc "Clean build"
task :clean do
  raise unless system "xcodebuild clean #{$scheme_args}"
end

