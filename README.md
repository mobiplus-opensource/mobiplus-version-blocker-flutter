# Welcome to Mobiplus Version Blocker repo!

Feel free to contact us to provide your feedback about anything.
We are always responsing the questions in discussion tab.
Let's talk and learn together.

Version Blocker intends to solve the following problems:

- To suggest users to update old versions to new ones available.
- For the developer, offering a simple and faster way of implement and personalize the message of version blocked

## For who is the Version Blocker? :thinking:

Developers that don't likes to write duplicated solutions and that wants to invest your time to impacts your app products.

Product's people that needs solutions to manage app versions intelligently.

## Motivation :robot:

The members of our current team had developed many apps in the last 11 years,
and in many cases we need to develop a similar boilerplate solution the proposed here.

The features can vary a little bit, but we can consider that is possible to apply something like the Pareto's rule.
20% of the needs variations are sufficient for 80% of the apps needs.

# Features :compass:

- Encapsulated blocked version screen display logic
- Integration with realtime database to determine the blocked versions
- Customizable text style in title, body and button
- Customizable color button and background color
- Customizable image

# Default block screen

![Screenshot_1641575605](https://user-images.githubusercontent.com/7460007/148581075-c366ad71-04f5-4e27-8b44-1216d55e623b.png)


# Get started

## Requirements

`Dart >=2.14.0` and `Flutter >=2.5.3`, [Firebase](https://firebase.google.com) project.

To run the example project you need to have your own [Firebase](https://firebase.google.com) project and depending on the platform you want to:

1. Create an iOS app with a bundle ID `com.example` (*only required for the example project, you can use anything for your app*) in [Firebase console](https://console.firebase.google.com) of your project and download generated `GoogleService-Info.plist`. Put it in the `example/ios/Runner` folder. You don't need to open Xcode to do it, it will expect this file in this folder.
2. Create an Android app with package name `com.example` (*only required for the example project, you can use anything for your app*) in [Firebase console](https://console.firebase.google.com) of your project and download generated `google-services.json`. Put it in the `example/android/app` folder.
3. Let's create the realtime database structure (*this step is necessary because this lib search and read the configuration in realtime database*)
4. [Download this Json](https://github.com/mobiplus-opensource/mobiplus-version-blocker-flutter/blob/master/open-source-mobiplus-default-rtdb-export.json) and change the name
5. In firebase console, go to Realtime Database Section
6. Click in "Import Json"
7. Import the Json downloaded in step 4
8. This will be the structure in your realtime database:
```
{
  "blockedVersions" : {
    "androidBuildNumber" : 8,
    "iosBuildNumber" : 6
  }
}
```
9. Now you will be ready to set which version of your app will be locked and will see the lock screen

## Import dependencie

```pubspec.yaml
dependencies:
  version_blocker_flutter: git@github.com:mobiplus-opensource/mobiplus-version-blocker-flutter
  ref: 2ca2ed2 --last release
```
> this approach was chosen as a temporary workaround as it quickly delivers the delivery with the latest lib version.

## Super simple to use

```dart
import 'package:version_blocker_flutter/version_blocker_flutter.dart';
```

Initialize Version Blocker

```dart
final blockApp = BlockApp();
```

You can now use the 'BlockApp()' class to show and manipulate the block screen properties

```dart
void initBlockVersion(BuildContext context) async {
    final blockApp = BlockApp();
    blockApp.titleText(titleText: 'teste de título', 
                      titleStyle: TextStyle(backgroundColor: Colors.amber));                                                               
    blockApp.button(
        buttonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)));
    await blockApp.initVersionBlocker(context);
  }
```
# What can be customized?

```
> background color(Colors? backgroundColor)
> titleText({TextStyle? titleStyle, String? titleText})
> image({Image? image})
> middleText({String? middleText, TextStyle? middleTextStyle})
> bottomText({String? bottomText, TextStyle? bottomTextStyle})
> button({String? buttonText, TextStyle? buttonTextStyle, ButtonStyle? buttonStyle})
```

## Good pratices

- We recommend the 110 character limit to keep the layout cohesive in the text fields


# Example

[Find here](https://github.com/mobiplus-opensource/mobiplus-version-blocker-flutter/tree/master/sample)

# Colaborating

## How to run the sample

- Instructions for creating a dev environment:
  - https://docs.flutter.dev/get-started/install
  - Open the project in an editor (IDE) of your choice.
  - Run the command: `flutter pub get`.
  - Open an emulator or connect a device.
  - Run the command: `flutter run`.
  - Have a good time.
- Instructions on tool versions
  - Flutter version: 2.5.3
  - Dart Version: 2.14
- Emulators, Devices

## How to contribute

We'd love you to contribute to Version Blocker Flutter.  please read our [Contribution Guide](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md)

## Found a bug? :beetle:
- open a issue with the description and the way of reproduction. Give preference to adding images.
