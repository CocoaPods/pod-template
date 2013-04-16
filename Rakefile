desc "Runs the specs [EMPTY]"
task :spec do
  # Provide your own implementation
end

desc "Release a new version of the Pod"
task :release do

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

    diff_lines = `git diff --name-only`.strip.split("\n")


    diff_lines.delete('CHANGELOG.md')
    if diff_lines != [podspec_path]
      $stderr.puts "[!] Only change the version number in a release commit!"
      exit 1
    end
  end

  puts "* Running specs"
  sh "rake spec"

  puts "* Linting the podspec"
  sh "pod lib lint"

  # Then release
  sh "git commit lib/cocoapods/gem_version.rb CHANGELOG.md -m 'Release #{spec_version}'"
  sh "git tag -a #{spec_version} -m 'Release #{spec_version}'"
  sh "git push origin master"
  sh "git push origin --tags"
  sh "pod push #{podspec_path}"
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

