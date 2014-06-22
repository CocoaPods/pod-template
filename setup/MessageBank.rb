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

    def run_command command
      puts "  " + command.magenta
      system command
    end


    def welcome_message
      unless @configurator.validate_user_details
        run_setup_questions
      end

      puts "We need to ask 3 questions to get you started, this should only take a minute."
    end

    def farewell_message
      puts "\n Congrats, you're ready to go."
      puts " We will start off by opening your project in Xcode"
      run_command "open 'Example/" + @configurator.pod_name + ".xcworkspace'"
    end


    def run_setup_questions

      puts yellow_bang + "Before you can create a new library we need to setup your git credentials."

      unless @configurator.user_name.length > 0
        puts "\n What is your name? "
        answer = ""

        loop do
          show_prompt

          answer = gets.downcase.chomp
          break if answer.length > 0

          puts red_bang + "Please enter a name."
        end

        puts ""
        puts green_bang + "Setting your name in git to " + answer
        run_command('git config --global user.name "' + answer + '"')
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
        run_command('git config --global user.email "' + answer + '"')
      end

    end

  end
end
