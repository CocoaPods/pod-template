desc "Runs the specs [EMPTY]"
task :spec do
  # Provide your own implementation
end

task :version do
  puts "-- fetching version number from github"
  sh 'git fetch'

  puts "The current released version of your pod is " + current_released_version
  print "Enter the version you want to release (" + suggested_version + ") "
  new_version = $stdin.gets.strip
  if new_version == ""
    new_version = suggested_version
  end

  replace_version_number(new_version)
end

desc "Release a new version of the Pod"
task :release do

  puts "* Running version"
  sh "rake version"

  unless ENV['SKIP_CHECKS']
    if `git symbolic-ref HEAD 2>/dev/null`.strip.split('/').last != 'master'
      $stderr.puts "[!] You need to be on the `master' branch in order to be able to do a release."
      exit 1
    end

    if `git tag`.strip.split("\n").include?(spec_version)
      $stderr.puts "[!] A tag for version `#{spec_version}' already exists. Change the version in the podspec"
      exit 1
    end

    puts "You are about to release `#{spec_version}`, is that correct? [y/n]"
    exit if $stdin.gets.strip.downcase != 'y'
  end

  puts "* Running specs"
  sh "rake spec"
 
  puts "* Linting the podspec"
  sh "pod lib lint"

  # Then release
  sh "git commit #{podspec_path} CHANGELOG.md -m 'Release #{spec_version}'"
  sh "git tag -a #{spec_version} -m 'Release #{spec_version}'"
  sh "git push origin master"
  sh "git push origin --tags"
  sh "pod push master #{podspec_path}"
end

# @return [Pod::Version] The version as reported by the Podspec.
#
def spec_version
  require 'cocoapods'
  spec = Pod::Specification.from_file(podspec_path)
  spec.version
end

# @return [String] The relative path of the Podspec.
#
def podspec_path
  podspecs = Dir.glob('*.podspec')
  if podspecs.count == 1
    podspecs.first
  else
    raise "Could not select a podspec"
  end
end

def current_released_version
  diff_version_lines = `git diff *.podspec | grep \'\\-  s.version\'`.strip.split("\n")
  if diff_version_lines.count == 0
    spec_version.to_s()
  else
    diff_version_line = diff_version_lines.first
    remote_version = diff_version_line.split("=").last.strip.gsub("\"","").gsub("\'","")
    remote_version
  end
end

def suggested_version
  if spec_version.to_s() != current_released_version
    spec_version.to_s()
  else
    version_components = spec_version.to_s().split(".");
    last = (version_components.last.to_i() + 1).to_s
    version_components[-1] = last
    version_components.join(".")
  end
end

def replace_version_number(new_version_number)
  text = File.read(podspec_path)
  text.gsub!(/(s.version( )*= ")#{spec_version}(")/, "\\1#{new_version_number}\\3")
  File.open(podspec_path, "w") { |file| file.puts text }
end