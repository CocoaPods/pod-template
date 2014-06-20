module Pod
  class TemplateConfigurator

    attr_reader :pod_name, :pods_for_podfile, :prefixes, :test_example_file, :username, :email

    def initialize(pod_name)
      @pod_name = pod_name
      @pods_for_podfile = []
      @prefixes = []
    end

    def ask_with_answers(question, possible_answers)
      possible_answers_string = possible_answers.join(" ")
      
      puts "#{question}? [#{possible_answers_string}]"
      answer = gets.downcase.chomp
      
      unless possible_answers.map { |a| a.downcase }.include? answer
        puts "Possible answers: #{possible_answers_string}"
        ask_with_answers question, possible_answers
      end
      answer
    end

    def run
      puts "Configuring #{pod_name}"
      
      validate_user_details
      platform = ask_with_answers("platform", ["iOS", "Mac", "Both"]).to_sym

      case platform
        when :ios
          ConfigureIOS.perform(configurator: self)
        when :mac
          puts "Creating Mac templates are not supported yet, sorry!"
        when :both
          puts "Creating Mac + iOS templates are not supported yet, sorry!"
        else
          puts "UNKNOWN STATE " + platform.to_s 
      end
      
      replace_variables_in_files
      clean_template_files
      rename_template_files
      add_pods_to_podfile
      customise_prefix
      reinitialize_git_repo
      run_pod_install
      ending_message
    end

    #----------------------------------------#

    def ending_message
      puts "DONE"
    end 

    def run_pod_install
      Dir.chdir("Example") do
        system "pod install"
      end
    end

    def clean_template_files
      `rm -rf ./**/.gitkeep`
      `rm -rf configure`
      `rm -rf _CONFIGURE.rb`
      `rm -rf README.md`
      `rm -rf templates`
      `rm -rf setup`
    end

    def replace_variables_in_files
      file_names = ['LICENSE', 'POD_README.md', 'NAME.podspec', podfile_path] 
      file_names.each do |file_name|
        text = File.read(file_name)
        text.gsub!("${POD_NAME}", @pod_name)
        text.gsub!("${USER_NAME}", user_name)
        text.gsub!("${USER_EMAIL}", user_email)
        text.gsub!("${YEAR}", year)
        text.gsub!("${DATE}", date)
        File.open(file_name, "w") { |file| file.puts text }
      end
    end
    
    def add_pod_to_podfile podname
      @pods_for_podfile << podname
    end
    
    def add_pods_to_podfile
      podfile = File.read podfile_path
      podfile_content = @pods_for_podfile.map do |pod| 
        "pod '" + pod + "'"
      end.join("\n")
      podfile.gsub!("${INCLUDED_PODS}", podfile_content)
      File.open(podfile_path, "w") { |file| file.puts podfile }
    end

    def add_line_to_pch line
      @prefixes << line
    end

    def customise_prefix
      prefix_path = "Example/Tests/Tests-Prefix.pch"
      pch = File.read prefix_path
      pch.gsub!("${INCLUDED_PREFIXES}", @prefixes.join("\n  ") )
      File.open(prefix_path, "w") { |file| file.puts pch }
    end
    
    def set_test_framework(test_type)
      content_path = "setup/test_examples/" + test_type + ".m"
      tests_path = "templates/ios/Example/Tests/Tests.m"
      tests = File.read tests_path
      tests.gsub!("${TEST_EXAMPLE}", File.read(content_path) )
      File.open(tests_path, "w") { |file| file.puts tests }
    end

    def rename_template_files
      `mv POD_README.md README.md`
      `mv NAME.podspec #{pod_name}.podspec`
    end

    def reinitialize_git_repo
      `rm -rf .git`
      `git init`
      `git add -A`
      `git commit -m "Initial commit"`
    end

    def validate_user_details
      
    end

    #----------------------------------------#

    def user_name
      (ENV['GIT_COMMITTER_NAME'] || `git config user.name` || @username).strip
    end

    def user_email
      (ENV['GIT_COMMITTER_EMAIL'] || `git config user.email` || @email).strip
    end

    def year
      Time.now.year.to_s
    end

    def date
      Time.now.strftime "%m/%d/%Y"
    end

    def podfile_path
      'Example/Podfile'
    end

    #----------------------------------------#
  end
end