# Recipe

This recipe documents exactly how we created the template. Please follow along and you should create a template that is identical to the one we provided. If this recipe is not perfect (or your result is different from our template) then please submit an issue or pull request.


## Ingredients

During the steps of this recipe we enter specific values where needed. These are chosen carefully so that they can be found and replaced in the template to create your project.

Some variables have spaces in them. That is intentional because it causes Xcode to use double quotes around them in its project configuration files.

-   `__PROJECT_NAME__`

    -   This must be a valid C99 extended identifier (otherwise the Xcode check dependencies step fails). It cannot contain spaces.

-   `__ORGANIZATION NAME__`

    -   This intentionally has a space which causes Xcode to use double quotes in its project configuration files.

-   `com.AN.ORGANIZATION.IDENTIFIER`

-   `__AUTHOR NAME__`

    -   This intentionally has a space which causes Xcode to use double quotes in its project configuration files.

-   `__TODAYS_DATE__`

-   `__TODAYS_YEAR__`

-   `__GITHUB_USERNAME__`


## Steps

Complete all these instructions on the same calendar day.

1.  Open Xcode Version 8.3.2 (8E2002) *(this is the latest publicly released or Gold Master version)*

2.  Create a project for your module

    1.  Click “Create a new Xcode project"

    2.  Configure the template for a Swift module

        1.  Click “iOS"

        2.  Select "Cocoa Touch Framework"

        3.  Click “Next"

    3.  Set the project options

        1.  Set project name to `__PROJECT_NAME__`

        2.  Set organization name to `__ORGANIZATION NAME__`

        3.  Set organization identifier to `com.AN.ORGANIZATION.IDENTIFIER`

        4.  Set language to "Swift"

        5.  Ensure "Include Unit Tests" is selected

        6.  Click “Next"

    4.  Save the project

        1.  Ensure “Create Git Repository" is not selected

        2.  Navigate to your Desktop folder

        3.  Click “Create"

    5.  Set up the module as shared (the same as how Alamofire does)

        1.  Select Product -> Scheme -> Manage Schemes...

        2.  Click "Shared" for the `__PROJECT_NAME__` scheme

        3.  Click "Close"

    6.  Use the directory layout like Alamofire

        1.  Use Terminal.app to rename folders

                cd ~/Desktop/__PROJECT_NAME__/
                mv __PROJECT_NAME__/ Source
                mv __PROJECT_NAME__Tests/ Tests
                mkdir Resources

        2.  Use Xcode to update the name and location of these folders

            1.  Open the file `__PROJECT_NAME__`.xcodeproj in Xcode

            2.  Enable Project navigator on the left and the File inspector on the right

            3.  Use the Project navigator to select the `__PROJECT_NAME__` folder (the yellow icon)

            4.  Use the File inspector to change the name to “Source"

            5.  Use the File inspector to change the location (the folder icon button) to ~/Desktop/`__PROJECT_NAME__`/Source

            6.  Use the Project navigator to select the `__PROJECT_NAME__Tests` folder

            7.  Use the File inspector to change the name to “Tests"

            8.  Use the File inspector to change the location (the folder icon button) to ~/Desktop/`__PROJECT_NAME__`/Tests

        3.  Fix the Info.plist file configuration (Xcode makes renaming folders a pain)

            1.  Click `__PROJECT_NAME__` on the left (the blue icon)

            2.  Click the target `__PROJECT_NAME__` in the middle (the brown toolbox icon)

            3.  Click "Build Settings" on the top of the middle

            4.  Enter "Info.plist" in the search box

            5.  Edit the "Info.plist File" to be "Source/Info.plist"

            6.  Click the target `__PROJECT_NAME__Tests` in the middle (the grey Lego block icon)

            7.  Click "Build Settings" on the top of the middle

            8.  Enter "Info.plist" in the search box

            9.  Edit the "Info.plist File" to be "Tests/Info.plist"

    7.  Add source code with some functionality to the module

        1.  Use Terminal.app to insert some files into the project

                cd ~/Desktop/__PROJECT_NAME__/
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/Resources/wk.png' -o Resources/wk.png
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/Source/__PROJECT_NAME__.swift' -o Source/__PROJECT_NAME__.swift
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/Source/__PROJECT_NAME__Label.h' -o Source/__PROJECT_NAME__.h
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/Source/__PROJECT_NAME__Label.m' -o Source/__PROJECT_NAME__Label.m

        2.  Use Xcode to add these files to the project

            1. Add `__PROJECT_NAME__`.swift to the Source folder

                1. Select the Source folder in the Project navigator

                2. Select File -> "Add Files..."

                3. Navigate to ~/Desktop/`__PROJECT_NAME__`/Source/, select `__PROJECT_NAME__`.swift and click "Add"

                4. Navigate to ~/Desktop/`__PROJECT_NAME__`/Source/, select `__PROJECT_NAME__Label`.h and click "Add"

                5. Navigate to ~/Desktop/`__PROJECT_NAME__`/Source/, select `__PROJECT_NAME__Label`.m and click "Add"

            2. Change `__PROJECT_NAME__Label`.h membership to "Public"

                1. Select the `__PROJECT_NAME__` project (blue icon) in the Project Navigator

                2. Highlight `__PROJECT_NAME__Label`.h in Project Navigator 

                3. In the right panel (File Inspector), Target Membership section, change membership to "Public"

            3. Add `__PROJECT_NAME__Label`.h to `__PROJECT_NAME__`.h file

                1. Select the `__PROJECT_NAME__` project (blue icon) in the Project Navigator

                2. Highlight `__PROJECT_NAME__`.h in Project Navigator 

                3. Add sring "#import <__PROJECT_NAME__/__PROJECT_NAME__Label.h>" to the end of file

            4. Select the `__PROJECT_NAME__` project (blue icon) in the Project Navigator

            5. Select File -> New -> Group and set the name to "Resources"

            6. Order the Source folder to above the Resources folder

            7. Add wk.png to the Resources folder

                1. Select the Resources folder in the Project navigator

                2. Select File -> "Add Files..."

                3. Navigate to ~/Desktop/`__PROJECT_NAME__`/Resources/, select wk.png and click "Add"

3.  Create a project for your iOS Example project

    1.  Select File -> New -> Project

    2.  Configure the template for Swift iOS

        1.  Click “iOS"

        2.  Select “Single View Application"

        3.  Click "Next"

    3.  Set the project options

        1.  Set Product Name to "iOS Example"

        2.  Set Organization Name to `__ORGANIZATION NAME__`

        3.  Set Organization Identifier to `com.AN.ORGANIZATION.IDENTIFIER`

        4.  Set Language to "Swift"

        5.  Set Devices to “Universal"

        6.  Ensure "Include Unit Tests" is not selected

        7.  Ensure "Include UI Tests" is not selected

        8.  Click “Next"

    4.  Save the project

        1.  Ensure “Create Git Repository" is not selected

        2.  Ensure add to is “Don’t add to any project or workspace"

        3.  Select the folder `__PROJECT_NAME__` on the desktop

        4.  Click “Create"

    5.  Set up the module as shared (the same as how Alamofire does)

        1.  Select Product -> Scheme -> Manage Schemes...

        2.  Click "Shared" for the "iOS Example" scheme

        3.  Click "Close"

    6.  Use the directory layout structure like Alamofire

        1.  Use Terminal.app to rename folders

                cd ~/Desktop/__PROJECT_NAME__/iOS\ Example/
                mv iOS\ Example/ Source

        2.  Use Xcode to update the name and location of these folders

            1.   Open the file iOS Example.xcodeproj in Xcode

            2.   Enable to Project navigator on the left and the File inspector on the right

            3.   Use the Project navigator to select the "iOS Example" folder

            4.   Use the File inspector to change the name to “Source"

            5.   Use the File inspector to change the location (the folder icon button) to ~/Desktop/`__PROJECT_NAME__`/iOS Example/Source

          3.  Fix the Info.plist file configuration (Xcode makes renaming folders a pain)

              1.  Click "iOS Example" on the left (the blue icon)

              2.  Click the target "iOS Example" in the middle

              3.  Click Build Settings on the top of the middle

              4.  Enter "Info.plist" in the search box

              5.  Edit the "Info.plist File" to be "Source/Info.plist"

    7.  Add source code with some functionality to the example

        1.  Use Terminal.app to insert some files into the project

                cd ~/Desktop/__PROJECT_NAME__/iOS\ Example/
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/iOS%20Example/Source/Base.lproj/Main.storyboard' -o Source/Base.lproj/Main.storyboard

    8.  Define packaging files for your module

        1.  Use Terminal.app to insert a templated podspec (for CocoaPods consumers)

                cd ~/Desktop/__PROJECT_NAME__/
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/__PROJECT_NAME__.podspec' -o __PROJECT_NAME__.podspec

        2.  Use Terminal.app to insert a templated Package.swift (for Swift Package Manager consumers)

                cd ~/Desktop/__PROJECT_NAME__/
                curl 'https://raw.githubusercontent.com/fulldecent/swift-package/master/__PROJECT_NAME__/Package.swift' -o Package.swift

4.  Use Xcode to manually to make the iOS Example use the module

    1. Close all projects and workspaces currently open in Xcode

    2.  Select File -> New -> Workspace

    3.  Select `__PROJECT_NAME__` on the desktop, enter the name `__PROJECT_NAME__` and click save

    4.  Use Finder and drag `__PROJECT_NAME__`.xcodeproj into the workspace in Xcode

    5.  Use Finder and drag iOS Example.xcodeproj into the workspace in Xcode (make this below the other one, be sure you do NOT make it subordinated)

    6.  Click iOS Example on the left

    7.  Click Build Phases in the middle

    8.  Under Link Binaries With Libraries click the plus icon, select `__PROJECT_NAME__`.framework, and then click "Add"

5.  Remove identifying parts of your project

    1.  Use Terminal.app to find and replace all occurrences of hard-coded strings with template variables

            find -E ~/Desktop/__PROJECT_NAME__ \
                -regex '.*\.(h|swift)' -exec sed -i '' -E -e '
                    s-(// +Created by ).*( on ).*\.-\1__AUTHOR NAME__\2__TODAYS_DATE__.-
                    s-(// +Copyright © ).*-\1__TODAYS_YEAR__ __ORGANIZATION NAME__. All rights reserved.-' \
                '{}' \;


    2.  Use Terminal.app to remove all references to development team IDs

            find ~/Desktop/__PROJECT_NAME__ -name project.pbxproj \
                -exec sed -i '' -E -e '/DevelopmentTeam = /d
                    s/(DEVELOPMENT_TEAM = )[^;]+/\1""/' '{}' \;

6.  Use Terminal.app to add additional files to the project

        cd ~/Desktop/__PROJECT_NAME__/
        curl 'https://raw.githubusercontent.com/github/gitignore/master/Swift.gitignore' -o .gitignore
        echo '__PROJECT_NAME__.framework.zip' >> .gitignore
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/.travis.yml' -o .travis.yml
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/LICENSE' -o LICENSE
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/README.md' -o README.md
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/CHANGELOG.md' -o CHANGELOG.md
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/CONTRIBUTING.md' -o CONTRIBUTING.md
        echo '3.0' > .swift-version
        # Reference https://github.com/Alamofire/Alamofire/blob/master/.swift-version
        # Reference https://github.com/CocoaPods/CocoaPods/pull/5841
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/Tests/CheckCocoaPodsQualityIndexes.rb' -o Tests/CheckCocoaPodsQualityIndexes.rb
        curl 'https://raw.githubusercontent.com/fulldecent/swift3-module-template/master/__PROJECT_NAME__/Project.swift' -o Project.swift


## Taste testing

1.  Open `__PROJECT_NAME__`.xcworkspace

2.  Use the scheme navigator to select iOS Example and the latest iPhone version

3.  Select Product -> Run

You should see a big white king. That means it worked!
