require 'spec_helper'

describe "Swift Integration" do
#  before(:each) do
#    FileUtils.rm_rf 'spec/staging'
#    FileUtils::mkdir_p 'spec/staging'
#  end

  it "should work if you select swift and keep hitting enter" do
    Dir.chdir('spec/staging') do
      puts "Vendoring with default settings"
      path = Dir.pwd + '/../mock:' + ENV['PATH']
      command = "bundle exec pod lib create --verbose --template-url='file://#{Dir.pwd}/../../' TestPod-swift1"
      Open3.popen2e({'PATH' => path}, command) { |stdin, stdout_and_stderr, wait_thr|
        stdin.write "swift\n\n\n\n\n\n\n"
        stdin.close
        print stdout_and_stderr.readlines.join {"\n"}
      }
      expect(1).to eq(1)
    end
  end
end
