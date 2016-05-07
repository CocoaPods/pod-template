require 'spec_helper'

describe "Swift Integration" do
  before(:each) do
    FileUtils.rm_rf 'spec/staging'
    FileUtils::mkdir_p 'spec/staging'
  end

  it "should compile with default settings" do
    FileUtils::mkdir_p 'spec/staging'
    Dir.chdir('spec/staging') do
      puts "Vendoring with default settings"
      path = Dir.pwd + '/../mock:' + ENV['PATH']
      command = "bundle exec pod lib create --template-url='file://#{Dir.pwd}/../../' TestPod"
      Open3.popen3({'PATH' => path}, command) {|stdin, stdout, stderr, wait_thr|
        stdin.write "\n\n\n\n"
        print stdout.readlines.join {"\n"}
        print stderr.readlines.join {"\n"}
      }
    end
  end
end
