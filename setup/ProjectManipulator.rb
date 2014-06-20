module Pod

  class ProjectManipulator
    attr_reader :configurator, :xcodeproj_path, :platform, :remove_demo_target, :string_replacements

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @xcodeproj_path = options.fetch(:xcodeproj_path)
      @configurator = options.fetch(:configurator)
      @platform = options.fetch(:platform)
      @remove_demo_target = options.fetch(:remove_demo_project)
    end

    def perform
      project  = Xcodeproj::Project.open @xcodeproj_path
      app_project = project.targets.select { |target| target.product_type == "com.apple.product-type.application" }.first
      test_target = project.targets.select { |target| target.product_type == "com.apple.product-type.bundle.unit-test" }.first
      
      if @remove_demo_target
        test_dependency = test_target.dependencies.first
        test_dependency.remove_from_project
        app_project.remove_from_project
        project.save
      end
      
      @string_replacements = {
        "PROJECT" => @configurator.name,
        "TODAYS_DATE" => @configurator.date,
        "PROJECT_OWNER" => @configurator.user_name
      }
      
      replace_internal_project_settings
      rename_files
      rename_project_folder
    end
    
    def project_folder
      File.dirname @xcodeproj_path
    end
    
    def rename_files
      File.rename(project_folder + "PROJECT.xcodeproj", project_folder + @configurator.name + ".xcodeproj")

      ["PROJECT-Info.plist", "PROJECT-Prefix.pch"].each do |file|
        before = project_folder + "/PROJECT/" + file
        after = project_folder + "/PROJECT/" + file.gsub("PROJECT", @configurator.name)
        File.rename before, after
      end      
    end
    
    def rename_project_folder
      File.rename("PROJECT.xcodeproj", @configurator.name + ".xcodeproj")
    end
    
    def replace_internal_project_settings      
      Dir.glob(project_folder + "/*/*").each do |name|
        next if Dir.exists? name
        text = File.read(name)
  
        for find, replace in @string_replacements
            text = text.gsub(find, replace)
        end
  
        File.open(name, "w") { |file| file.puts text }
      end
    end
    
  end
  
end