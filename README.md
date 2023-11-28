# Invoice Ninja

Client application for [Invoice Ninja](https://github.com/invoiceninja/invoiceninja).

#### Desktop Apps
- [Windows](https://apps.microsoft.com/store/detail/invoice-ninja/9N3F2BBCFDR6)
- [macOS](https://apps.apple.com/app/id1503970375?platform=mac)
- [Linux - Snap](https://snapcraft.io/invoiceninja)
- [Linux - Flatpak](https://flathub.org/apps/com.invoiceninja.InvoiceNinja)

#### Mobile Apps
- [iOS](https://apps.apple.com/app/id1503970375?platform=iphone)
- [Android](https://play.google.com/store/apps/details?id=com.invoiceninja.app)
- [F-Droid](https://f-droid.org/en/packages/com.invoiceninja.app)

<p align="center">
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/1.png" alt="Dashboard" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/2.png" alt="View Invoice" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/3.png" alt="List Invoice" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/4.png" alt="New Invoice" width="200"/>
</p>

# Table of Contents

- [Setting up the app](#setting-up-the-app)
- [Steps to remove non-FOSS code](#steps-to-remove-non-foss-code)
- [Application Architecture](#application-architecture)
    - [Package Structure](#package-structure)
    - [Blog Posts](#blog-posts)
- [Code generation](#code-generation)
- [Tests](#tests)
- [Code signing](#code-signing)
- [Credits](#credits)
- [Contributions](#contributions)

---

## Setting up the app

- Initialize the config file

    `cp lib/.env.dart.example lib/.env.dart`

- Support running the code unsigned on Android

    `cp android/app/build.gradle.dev android/app/build.gradle`

- Run the app

    `flutter run`

Note: if you don't have an Invoice Ninja backend setup you can test the app with these credentials:

- Email: `demo@invoiceninja.com`
- Password: `Password0`
- URL: `demo.invoiceninja.com`

## Steps to remove non-FOSS code

```
cp android/build.gradle.foss android/build.gradle
cp lib/utils/oauth.dart.foss lib/utils/oauth.dart
cp lib/utils/app_review.dart.foss lib/utils/app_review.dart
cp lib/ui/app/upgrade_dialog.dart.foss lib/ui/app/upgrade_dialog.dart
cp lib/ui/app/pinput.dart.foss lib/ui/app/pinput.dart
cp android/app/src/main/AndroidManifest.foss.xml android/app/src/main/AndroidManifest.xml
cp pubspec.foss.yaml pubspec.yaml 
rm pubspec.lock
```

## Application Architecture

The application was created using the [Flutter Redux Starter](https://github.com/hillelcoren/flutter-redux-starter).

The architecture is based off these two projects:

- [Redux Sample](https://github.com/brianegan/flutter_architecture_samples/tree/master/redux) - [Brian Egan](https://twitter.com/brianegan)
- [inKino](https://github.com/roughike/inKino) - [Iiro Krankka](https://twitter.com/koorankka)

### File Structure

A High-level overview of the project structure:
```

lib/                     # Root Package
|
├─ data/                 # For data handling
│  ├─ mock/              # sample used for testing
│  ├─ models/            # Objects representing data
│  ├─ repositories/      # Source of data
|
├─ redux/                # manages app state
│  ├─ component/         # app building block
│     ├─ actions         # methods to update app state
|     ├─ middleware      # run in response to actions, execute before reducer
|     ├─ reducer         # intercepts actions, responsible for updating the state
|     ├─ selectors       # read data from the state, queries against your 'state database'
|     ├─ state           # immutable object that lives at the top of the widget hierarchy
|
├─ ui/                   # app views
│  ├─ component/         # views for different components
│    ├─ view/            # generel view for component
│    ├─ edit/            # change values on the views fields
|
├─ utils/                # Utility classes

```

The ui and redux folders contain components that are paired together.
Put simply you will find an 'auth' folder in both the ui and redux folders.

For additional information on [Redux architecture](https://blog.logrocket.com/flutter-redux-complete-tutorial-with-examples/)



### Blog Posts
- [Intro to Google Flutter](https://hillel.dev/2018/05/18/flutter-is-darts-killer-app/)
- [Using Redux to manage state](https://hillel.dev/2018/06/01/building-a-large-flutter-app-with-redux/)
- [Handling complex forms](https://hillel.dev/2018/06/18/flutter-using-redux-to-manage-complex-forms-with-multiple-tabs-and-relationships/)
- [Architectural review](https://hillel.dev/2018/08/10/an-architectural-review-of-the-invoice-ninja-flutter-app/)
- [Additional thoughts](https://hillel.dev/2018/08/24/ongoing-adventures-with-flutter-and-redux/)

## Code generation
- Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to regenerate the model files. It will also remove the old generated files so conflicts are avoided..

## Tests
- Run `flutter drive --target=test_driver/all_it.dart` to run the tests
    
## Credits

[https://github.com/invoiceninja/invoiceninja#credits](https://github.com/invoiceninja/invoiceninja/tree/v5-develop#credits)

## Contributions

We gladly accept contributions! If you'd like to get involved with development please join our [Slack group](http://slack.invoiceninja.com/) or [Discord Server](https://discord.gg/ZwEdtfCwXA).
