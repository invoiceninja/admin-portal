# Invoice Ninja

Client app for the [Invoice Ninja](https://github.com/invoiceninja/invoiceninja) web app.

- Google Play Store: [v4](https://play.google.com/store/apps/details?id=com.invoiceninja.flutter) | [v5](https://play.google.com/apps/testing/com.invoiceninja.app)
- Apple App Store: [v4](https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8) | [v5](https://testflight.apple.com/join/MJ6WpaXh)

<p align="center">
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/1.png" alt="Dashboard" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/2.png" alt="View Invoice" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/3.png" alt="List Invoice" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/4.png" alt="New Invoice" width="200"/>
</p>

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
cp lib/ui/app/upgrade_dialog.dart.foss lib/ui/app/upgrade_dialog.dart
cp android/app/src/main/AndroidManifest.foss.xml android/app/src/main/AndroidManifest.xml
cp pubspec.foss.yaml pubspec.yaml 
rm pubspec.lock
```

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

[https://github.com/invoiceninja/invoiceninja#credits](https://github.com/invoiceninja/invoiceninja/tree/v5-develop#credits)

## Contributions

We gladly accept contributions! If you'd like to get involved with development please join our [Slack group](http://slack.invoiceninja.com/).
