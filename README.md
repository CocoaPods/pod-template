pod-template
============

[![Build Status](https://travis-ci.org/CocoaPods/pod-template.svg?branch=develop)](https://travis-ci.org/CocoaPods/pod-template)

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

- Clone and `cd` into the directory
- Run some stuff you need to run for any Ruby project:
  - `gem install bundler`
  - `bundle install`
- Run the included test suite:
  - `rake`
  - Note: this uses the latest released version of CocoaPods to run this template (retrieved with Bundler above)
- Try it for real:
  - `cd ~/Desktop`
  - `pod lib create --verbose --template-url='file:///PATH/TO/pod-template' NewPod`
  - Note: this uses your INSTALLED VERSION of `pod` to run this template
- Hacking:
  - **Note: you MUST commit to git BEFORE you do `rake` testing or `pod lib create` testing. Both of those tools pull from master in your local repository. Learn how to squash commits :-)**


## Best practices

This project welcomes communal input, but please discuss new features and new ideas as an issue before sending a pull request. In general we try to think if an average Xcode user is going to use this feature or not, if it's unlikely is it a _very strongly_ encouraged best practice (à la testing / continuous integration). If it's something useful for saving a few minutes every deploy, or isn't easily documented in the guide it is likely to be denied in order to keep this project as simple as possible.
