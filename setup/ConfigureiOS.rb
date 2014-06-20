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
      `mv ./templates/ios/* ./`
      configurator.replace_variables_in_files(additional_files)
      
      framework = configurator.ask_with_answers("What testing frameworks will you use", ["Specta", "Kiwi"]).to_sym
      case framework
        when :specta
          configurator.add "Specta"
          configurator.add "Expecta"
        when :kiwi
          configurator.add "Kiwi"
      end
      
      snapshots = configurator.ask_with_answers("Would you like to do view based testing", ["Yes", "No"]).to_sym
      case snapshots
        when :yes
          configurator.add "FBSnapshotTestCase"
          configurator.add "EXPMatchers+FBSnapshotTest" if framework == :specta
      end
      
      remove_demo = configurator.ask_with_answers("Would you like to have a demo project also", ["Yes", "No"]).to_sym
      
      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "teamplates/ios/Example/PROJECT.xcodeproj",
        :platform => :ios,
        :remove_demo_project => (remove_demo == :no)
      }).run
      
    end

    private
    def additional_files
      ["UnitTests/UnitTests.m"]
    end
  end
  
end