# THIS PERFORMS ADDITIONAL CONFIGURATION IF THE USER SELECT THE SWIFT OPTION
#
# We are responsible to:
#  - Prepare items in the templates/swift directory
#  - Move items from templates/swift to the staging directory
#

module Pod
  class SwiftConfigurator
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform
      keep_demo = configurator.ask_with_answers("Would you like to include a demo application with your library", ["Yes", "No"]).to_sym

      framework = configurator.ask_with_answers("Which testing frameworks will you use", ["Quick", "None"]).to_sym
      case framework
        when :quick
          configurator.add_pod_to_podfile "Quick', '~> 0.8"
          configurator.add_pod_to_podfile "Nimble', '~> 3.0"
          `mv "templates/test_examples/quick.swift" "templates/swift/Example/Tests/Tests.swift"`
        when :none
          `mv "templates/test_examples/xctest.swift" "templates/swift/Example/Tests/Tests.swift"`
      end

      snapshots = configurator.ask_with_answers("Would you like to do view based testing", ["Yes", "No"]).to_sym
      case snapshots
        when :yes
          configurator.add_pod_to_podfile "FBSnapshotTestCase"

          if keep_demo == :no
              puts " Putting demo application back in, you cannot do view tests without a host application."
              keep_demo = :yes
          end

          if framework == :quick
              configurator.add_pod_to_podfile "Nimble-Snapshots"
          end
      end

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "templates/swift/Example/iOS Example.xcodeproj",
        :platform => :ios,
        :remove_demo_project => (keep_demo == :no),
        :prefix => ""
      }).run

      `mv ./templates/swift/* ./staging`
    end
  end
end
