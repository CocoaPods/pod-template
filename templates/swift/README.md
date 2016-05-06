FDChessboardView
================

[![CI Status](http://img.shields.io/travis/fulldecent/FDChessboardView.svg?style=flat)](https://travis-ci.org/fulldecent/FDChessboardView)
[![Version](https://img.shields.io/cocoapods/v/FDChessboardView.svg?style=flat)](http://cocoadocs.org/docsets/FDChessboardView)
[![License](https://img.shields.io/cocoapods/l/FDChessboardView.svg?style=flat)](http://cocoadocs.org/docsets/FDChessboardView)
[![Platform](https://img.shields.io/cocoapods/p/FDChessboardView.svg?style=flat)](http://cocoadocs.org/docsets/FDChessboardView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

<a href="http://imgur.com/kcBBESo"><img width=200 height=200 src="http://i.imgur.com/kcBBESo.png" title="Hosted by imgur.com" /></a>

Features
========

 * High resolution graphics
 * Customizable themes and game graphics
 * Supports all single board chess variants: suicide, losers, atomic, etc.
 * Supports games with odd piece arrangement and non-standard castling (Fisher 960)
 * Very clean API, this is just a view
 * Supports a minimum deployment target of iOS 8 or OS X Mavericks (10.9)

Usage
=====

Import, add the view to your storyboard and then set it up with:

```swift
import FDChessboardView
...
self.chessboard.dataSource = self
```

Then implement the data source:

```swift
func chessboardView(board: FDChessboardView, pieceForSquare square: FDChessboardSquare) -> FDChessboardPiece? {
    return piecesByIndex[square.index] // you figure out which piece to show
}
```


Installation
============

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build FDChessboardView 0.1.0+.

To integrate FDChessboardView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'FDChessboardView', '~> 0.1'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate FDChessboardView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "fulldecent/FDChessboardView" ~> 0.1
```

Run `carthage update` to build the framework and drag the built `FDChessboardView.framework` into your Xcode project.


Upcoming Features
=================

These following items are in the API for discussion and awaiting implementation:

 * Display for last move
 * Mutable game state (i.e. can move the pieces)
 * Animation for piece moves
 * Highlighting of legal squares for a piece after begin dragging
 * Premove


See Also
===========

See also Kibitz for Mac which is making a comeback https://github.com/fulldecent/kibitz
