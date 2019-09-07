module Pod

  class ConfigureIOS
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform

      keep_demo = configurator.ask_with_answers("Would you like to include a demo application with your library", ["Yes", "No"]).to_sym

      framework = configurator.ask_with_answers("Which testing frameworks will you use", ["Specta", "Kiwi", "None"]).to_sym
      case framework
        when :specta
          configurator.add_pod_to_podfile "Specta"
          configurator.add_pod_to_podfile "Expecta"

          configurator.add_line_to_pch "@import Specta;"
          configurator.add_line_to_pch "@import Expecta;"

          configurator.set_test_framework("specta", "m", "ios")

        when :kiwi
          configurator.add_pod_to_podfile "Kiwi"
          configurator.add_line_to_pch "@import Kiwi;"
          configurator.set_test_framework("kiwi", "m", "ios")

        when :none
          configurator.set_test_framework("xctest", "m", "ios")
      end

      snapshots = configurator.ask_with_answers("Would you like to do view based testing", ["Yes", "No"]).to_sym
      case snapshots
        when :yes
          configurator.add_pod_to_podfile "FBSnapshotTestCase"
          configurator.add_line_to_pch "@import FBSnapshotTestCase;"

          if keep_demo == :no
              puts " Putting demo application back in, you cannot do view tests without a host application."
              keep_demo = :yes
          end

          if framework == :specta
              configurator.add_pod_to_podfile "Expecta+Snapshots"
              configurator.add_line_to_pch "@import Expecta_Snapshots;"
          end
      end

      prefix = nil

      loop do
        prefix = configurator.ask("What is your class prefix").upcase

        if prefix.include?(' ')
          puts 'Your class prefix cannot contain spaces.'.red
        else
          break
        end
      end

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "templates/ios/Example/PROJECT.xcodeproj",
        :platform => :ios,
        :remove_demo_project => (keep_demo == :no),
        :prefix => prefix
      }).run

      # There has to be a single file in the Classes dir
      # or a framework won't be created, which is now default
      `touch Pod/Classes/ReplaceMe.m`

      `mv ./templates/ios/* ./`

      # remove podspec for osx
      `rm ./NAME-osx.podspec`
    end
  end

end
