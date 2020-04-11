# Invoice Ninja

Client app for the [Invoice Ninja](https://github.com/invoiceninja/invoiceninja) web app.

- [Google Play Store](https://play.google.com/store/apps/details?id=com.invoiceninja.flutter)
- [Apple App Store](https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8)

Note: the mobile app requires the latest version of the web app.

<p align="center">
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_01.png" alt="View Invoice" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_02.png" alt="List Invoices" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_03.png" alt="Contact Details" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_04.png" alt="Edit Product" width="200"/>
</p>

## Install Flutter

The current code set doesn't work on the latest version of flutter. Please install version 1.15.17

- Run `git clone https://github.com/flutter/flutter.git -b v1.15.17` to get this version
- Run `flutter doctor` to install required packages
- Run `flutter config --enable-web` to enable web support
  
## Setting up the app
- Run `cp lib/.env.dart.example lib/.env.dart` to create the config file.
- Run `cp android/app/build.gradle.dev android/app/build.gradle` to support running the code unsigned.
- Run `flutter run` while you have a device connected to the computer or an emulator running and now you can run it.

## Application Architecture

The application was created using the [Flutter Redux Starter](https://github.com/hillelcoren/flutter-redux-starter).

The architecture is based off these two projects:

- [Redux Sample](https://github.com/brianegan/flutter_architecture_samples/tree/master/redux) - [Brian Egan](https://twitter.com/brianegan)
- [inKino](https://github.com/roughike/inKino) - [Iiro Krankka](https://twitter.com/koorankka)

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
    
## Code Signing
- Run `cp android/app/build.gradle.prod android/app/build.gradle` to support running the code signed
- Run `cp android/key.properties.example android/key.properties` to create the keys file
- Run `keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias invoiceninja` to generate a key to be able to sign the android application.
- Update `android/key.properties` according to the parameters you entered in previous command when you generated the key 
- Open a new Firebase project from your console. Firebase is used for authentication.
    - Inside the project go to Authentication and enable at least one method.
    - After go to add a new Android application. For the package name add `com.invoiceninja.flutter`
    - Press "Register App" button.
    - Download "google-services.json" and put it in `android/app` directory.

## Credits
* [Hillel Coren](https://hillel.dev)
* [David Bomba](https://github.com/turbo124)
* [All contributors](https://github.com/invoiceninja/flutter-mobile/graphs/contributors)

**Special thanks to:**
* [Efthymios Sarmpanis](https://github.com/esarbanis)
* [Gianfranco Gasbarri](https://github.com/gincos)

## Contributions

We gladly accept contributions! If you'd like to get involved with development please join our [Slack group](http://slack.invoiceninja.com/).
