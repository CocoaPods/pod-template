module Pod
  class MessageBank
    attr_reader :configurator

    def initialize(config)
      @configurator = config
    end

    def show_prompt
      print " > ".green
    end

    def yellow_bang
      "! ".yellow
    end

    def green_bang
      "! ".green
    end

    def red_bang
      "! ".red
    end

    def run_command command, output_command=nil
      output_command ||= command

      puts "  " + output_command.magenta
      system command
    end

    def welcome_message
      unless @configurator.validate_user_details
        run_setup_questions
      end

      puts "\n------------------------------"
      puts ""
      puts "To get you started we need to ask a few questions, this should only take a minute."
      puts ""

      has_run_before = `defaults read org.cocoapods.pod-template HasRunBefore`.chomp == "1"

      puts "If this is your first time we recommend running through with the guide: "
      puts " - "  + "https://guides.cocoapods.org/making/using-pod-lib-create.html".blue.underlined

      if ENV["TERM_PROGRAM"] == "iTerm.app"
        puts " ( hold cmd and click links to open in a browser. )".magenta
      else
        puts " ( hold cmd and double click links to open in a browser. )".magenta
      end

      unless has_run_before
        puts "\n Press return to continue."
        `defaults write org.cocoapods.pod-template HasRunBefore -bool true`
      end

      puts ""
    end

    def farewell_message
      puts ""

      puts " Ace! you're ready to go!"
      puts " We will start you off by opening your project in Xcode"
      pod_name = @configurator.pod_name
      run_command "open 'Example/#{pod_name}.xcworkspace'", "open '#{pod_name}/Example/#{pod_name}.xcworkspace'"
    end


    def run_setup_questions

      puts yellow_bang + "Before you can create a new library we need to setup your git credentials."

      unless @configurator.user_name.length > 0
        puts "\n What is your name? "
        answer = ""

        loop do
          show_prompt

          answer = gets.chomp
          break if answer.length > 0

          puts red_bang + "Please enter a name."
        end

        puts ""
        puts green_bang + "Setting your name in git to " + answer
        run_command('git config user.name "' + answer + '"')
      end

      unless @configurator.user_email.length > 0
        puts "\n What is your email?"
        answer = ""

        loop do
          show_prompt
          answer = gets.downcase.chomp
          break if answer.length > 0

          puts red_bang + "Please enter a email."
        end

        puts ""
        puts green_bang + "Setting your email in git to " + answer
        run_command('git config user.email "' + answer + '"')
      end

    end

  end
end
