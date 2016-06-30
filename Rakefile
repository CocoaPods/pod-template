require 'rake'
require 'rspec/core/rake_task'
require 'colored'

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  # Configure RSpec
  t.pattern = './spec/**/*_spec.rb'
  t.rspec_opts = '--format documentation'
  # Prepare testing area
  puts 'Wiping out staging area for testing'
  FileUtils.rm_rf 'spec/staging'
  FileUtils::mkdir_p 'spec/staging'
end

task :default => :spec do
  puts "All RSpec testing is complete".blue
  puts "You can manually inspect test artifacts in spec/staging/".blue
end
