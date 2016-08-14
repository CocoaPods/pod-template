# THIS IS THE MAIN ENTRY POINT FOR CONFIGURATION
#
# We are responsible to:
#  - Prepare the staging/ directory
#  - Ask some questions, delegate to other configurators if necessary
#  - Do other stuff in staging/ directory
#  - Deploy the staging/ directory
#

require 'fileutils'
require 'colored'

module Pod
  class MainConfigurator
    attr_reader :pod_name, :pods_for_podfile, :prefixes, :test_example_file, :username, :email

    def user_name
      (ENV['GIT_COMMITTER_NAME'] || `git config user.name`).strip
    end

    def user_email
      (ENV['GIT_COMMITTER_EMAIL'] || `git config user.email`).strip
    end

    def year
      Time.now.year.to_s
    end

    def date
      Time.now.strftime "%Y-%m-%d"
    end

    def podfile_path
      'Example/Podfile'
    end

    def initialize(pod_name)
      @pod_name = pod_name
      @pods_for_podfile = []
      @prefixes = []
      @message_bank = MessageBank.new(self)
    end

    #----------------------------------------#

    def run
      @message_bank.welcome_message
      prepare_staging_directory
      use_baseline_template

      framework = self.ask_with_answers("What language do you want to use?", ["Swift", "ObjC"]).to_sym
      case framework
        when :swift
          SwiftConfigurator.perform(configurator: self)
        when :objc
          ObjectiveCConfigurator.perform(configurator: self)
      end

      Dir.chdir('staging') do
        replace_variables_in_files
        replace_variables_in_file_names
        add_pods_to_podfile(podfile_path)
        customise_prefix
        run_pod_install
        initialize_git_repo
      end

      deploy_staging_directory

      @message_bank.farewell_message
    end

    def prepare_staging_directory
      FileUtils::mkdir_p 'staging'
    end

    def use_baseline_template
      FileUtils.cp_r 'templates/baseline/.', 'staging'
    end

    def replace_variables_in_files
      Dir.glob("**/*") do |file_name|
        next if File.directory?(file_name)
        # See https://robots.thoughtbot.com/fight-back-utf-8-invalid-byte-sequences
        text = File.read(file_name).encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
        text.gsub!("${POD_NAME}", @pod_name)
        text.gsub!("PROJECT", @pod_name)
        text.gsub!("${REPO_NAME}", @pod_name.gsub('+', '-'))
        text.gsub!("${USER_NAME}", user_name)
        text.gsub!("${USER_EMAIL}", user_email)
        text.gsub!("${YEAR}", year)
        text.gsub!("${DATE}", date)
        File.open(file_name, "w") { |file| file.puts text }
      end
    end

    def replace_variables_in_file_names
      Dir.foreach('.') do |file_name|
        next if file_name == '.' or file_name == '..'
        if file_name.match('PROJECT')
          FileUtils.mv file_name, file_name.gsub('PROJECT', @pod_name)
        end
        if File.directory?(file_name.gsub('PROJECT', @pod_name))
          Dir.chdir(file_name.gsub('PROJECT', @pod_name)) do
            replace_variables_in_file_names
          end
        end
      end
    end

    def add_pods_to_podfile(podfile_path)
      podfile = File.read podfile_path
      podfile_content = @pods_for_podfile.map do |pod|
        "pod '" + pod + "'"
      end.join("\n  ")
      podfile.gsub!("${INCLUDED_PODS}", podfile_content)
      File.open(podfile_path, "w") { |file| file.puts podfile }
    end

    def customise_prefix
      prefix_path = "Example/Tests/Tests-Prefix.pch"
      return unless File.exists? prefix_path

      pch = File.read prefix_path
      pch.gsub!("${INCLUDED_PREFIXES}", @prefixes.join("\n  ") )
      File.open(prefix_path, "w") { |file| file.puts pch }
    end

    def run_pod_install
      puts "\nRunning " + "pod install".magenta + " on your new library."
      puts ""

      Dir.chdir("Example") do
        system "pod install"
      end
    end

    def initialize_git_repo
      `git init`
      `git add -A`
      `git commit -m "Initial commit"`
    end

    def deploy_staging_directory
      Dir.foreach('.') do |file_name|
        next if file_name == '.' or file_name == '..'
        next if file_name == 'staging'
        FileUtils.rm_rf file_name
      end
      FileUtils.cp_r 'staging/.', '.'
      FileUtils.rm_rf 'staging'
    end

    #----------------------------------------#

    def ask(question)
      answer = ""
      loop do
        puts "\n#{question}?"

        @message_bank.show_prompt
        answer = gets.chomp

        break if answer.length > 0

        print "\nYou need to provide an answer."
      end
      answer
    end

    def ask_with_answers(question, possible_answers)

      print "\n#{question}? ["

      print_info = Proc.new {

        possible_answers_string = possible_answers.each_with_index do |answer, i|
           _answer = (i == 0) ? answer.underline : answer
           print " " + _answer
           print(" /") if i != possible_answers.length-1
        end
        print " ]\n"
      }
      print_info.call

      answer = ""

      loop do
        @message_bank.show_prompt
        answer = gets.downcase.chomp

        answer = "yes" if answer == "y"
        answer = "no" if answer == "n"

        # default to first answer
        if answer == ""
          answer = possible_answers[0].downcase
          print answer.yellow
        end

        break if possible_answers.map { |a| a.downcase }.include? answer

        print "\nPossible answers are ["
        print_info.call
      end

      answer
    end

    def add_pod_to_podfile podname
      @pods_for_podfile << podname
    end

    def add_line_to_pch line
      @prefixes << line
    end

    def validate_user_details
        return (user_email.length > 0) && (user_name.length > 0)
    end

  end
end
