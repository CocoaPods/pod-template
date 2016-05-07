pod-template
============

[![Build Status](https://travis-ci.org/fulldecent/pod-template.svg?branch=master)](https://travis-ci.org/fulldecent/pod-template)

An opinionated template for Swift and Objective-C frameworks with the following features:

- Prompt-based project generation
- Support for CocoaPods, Carthage and project layout compatible with Swift Package Manager
- Clean folder structure
- MIT license
- Testing as a standard
- Turnkey access to Travis CI


## Getting started

Most CocoaPods framework developers will use `pod-template` by running `pod lib create POD_NAME`. You can also follow along with the guide at: https://guides.cocoapods.org/making/using-pod-lib-create.html

You must run **CocoaPods 1.0.0+** to use this template.


## Hacking

To modify these templates or to create your own, please fork this repository or edit locally. Test your changes by running `pod lib create --template-url='YOUR_GIT_URL' POD_NAME`. Note that you can use a local git URL such as `file:///Users/username/Developer/pod-template`.

To understand how this repository is used by CocoaPods, please start with `configure`. You can see the calling code in `configure_template` defined in [lib/cocoapods/command/lib.rb](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/command/lib.rb).


## Best practices

This project welcomes communal input, but please discuss new features and new ideas as an issue before sending a pull request. In general we try to think if an average Xcode user is going to use this feature or not, if it's unlikely is it a _very strongly_ encouraged best practice (à la testing / continuous integration). If it's something useful for saving a few minutes every deploy, or isn't easily documented in the guide it is likely to be denied in order to keep this project as simple as possible.
