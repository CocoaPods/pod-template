pod-template
============

An opinionated template for creating a Pod with the following features:

- Git as the source control management system.
- Clean folder structure.
- MIT license.
- Rake as task management tool.

## Getting started

1. Recursively delete the `delete_me` files.
- Replace the placeholders in the license file.
- Create your project in the `Example` folder.
   - Optionally integrate your project with CocoaPods.
   - The Podfile inherits the dependencies your podspec.
- Add the source files of your library in the `Classes` folder.
- Add the resources of your library in the `Resources` folder.
- Use `$ rake -T` to see the available tasks.
- Use `$ rake release` to release a new version of the Pod (after editing the
  version number in the podspec).
- Replace the contents of this file.

## Best practices

## Requirements:

- CocoaPods 0.19
