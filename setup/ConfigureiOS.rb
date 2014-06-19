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
      
      configurator.ask_with_answers("What testing frameworks will you use", ["Specta", "Kiwi"]).to_sym
      case platform
        when :specta
          configurator.add "Specta"
          configurator.add "Expecta"
        when :kiwi
          configurator.add "Kiwi"
      end
      
      
    end

    private
    def additional_files
      ["UnitTests/UnitTests.m"]
    end
  end
  
  endx