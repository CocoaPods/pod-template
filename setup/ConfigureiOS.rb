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

      remove_demo = configurator.ask_with_answers("Would you like to have a demo for your library", ["Yes", "No"]).to_sym

      framework = configurator.ask_with_answers("Which testing frameworks will you use", ["Specta", "Kiwi"]).to_sym
      case framework
        when :specta
          configurator.add_pod_to_podfile "Specta', '~> 0.2.1"
          configurator.add_pod_to_podfile "Expecta"

          configurator.add_line_to_pch "#define EXP_SHORTHAND"
          configurator.add_line_to_pch "#import <Specta/Specta.h>"
          configurator.add_line_to_pch "#import <Expecta/Expecta.h>"

          configurator.set_test_framework("specta")

        when :kiwi
          configurator.add_pod_to_podfile "Kiwi"
          configurator.add_line_to_pch "#import <Kiwi/Kiwi.h>"
          configurator.set_test_framework("kiwi")
      end

      snapshots = configurator.ask_with_answers("Would you like to do view based testing", ["Yes", "No"]).to_sym
      case snapshots
        when :yes
          configurator.add_pod_to_podfile "FBSnapshotTestCase"
          configurator.add_line_to_pch "#import <FBSnapshotTestCase/FBSnapshotTestCase.h>"

          if framework == :specta
              configurator.add_pod_to_podfile "Expecta+Snapshots"
              configurator.add_line_to_pch "#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>"
          end
      end

      prefix = nil

      loop do
        prefix = configurator.ask("What is your class prefix")

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
        :remove_demo_project => (remove_demo == :no),
        :prefix => prefix
      }).run

      `mv ./templates/ios/* ./`
    end
  end

end
