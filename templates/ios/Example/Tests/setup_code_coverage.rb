# Keeps the Podfile simple and to the point

def enable_code_coverage(name, installer)
  # get the library's target from Pods project
  pods_project = installer.pods_project
  pods_targets = pods_project.targets
  pod_target = pods_targets.find { |target| target.name == name }

  # get the example's project scheme
  example_project = installer.aggregate_targets.map(&:user_project_path).uniq.first
  example_shared_data_dir = Xcodeproj::XCScheme.shared_data_dir(example_project)
  example_scheme_filename = "#{name}-Example.xcscheme"
  example_scheme = Xcodeproj::XCScheme.new File.join(example_shared_data_dir, example_scheme_filename)

  # create a build action that points to the pod target
  pod_build_action_entry = Xcodeproj::XCScheme::BuildAction::Entry.new pod_target

  # add the pod build action to the example project's build actions
  example_build_action = example_scheme.build_action
  example_build_action.add_entry(pod_build_action_entry)

  example_scheme.save!
end
