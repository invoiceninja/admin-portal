# Invoice Ninja

Companion app for the [Invoice Ninja](https://github.com/invoiceninja/invoiceninja) web app.

- [Google Play Store](https://play.google.com/store/apps/details?id=com.invoiceninja.flutter)
- [Apple App Store](https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8)

Note: the mobile app requires the latest version of the web app.

<p align="center">
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_01.png" alt="View Invoice" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_02.png" alt="List Invoices" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_03.png" alt="Contact Details" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_04.png" alt="Edit Product" width="200"/>
</p>

## Features

- [x] Dashboard
- [x] Clients
- [x] Products
- [x] Invoices
- [x] Quotes
- [x] Payments
- [x] Projects
- [x] Tasks
- [ ] Vendors
- [ ] Expenses
- [ ] Credits
- [ ] Recurring
- [ ] Tablet support
- [ ] Desktop support

## Application Architecture

The application was created using the [Flutter Redux Starter](https://github.com/hillelcoren/flutter-redux-starter).

The architecture is based off these two projects:

- [Redux Sample](https://github.com/brianegan/flutter_architecture_samples/tree/master/example/redux) - [Brian Egan](https://twitter.com/brianegan)
- [inKino](https://github.com/roughike/inKino) - [Iiro Krankka](https://twitter.com/koorankka)

### Blog Posts
- [Intro to Google Flutter](https://hillelcoren.com/2018/05/18/flutter-is-darts-killer-app/)
- [Using Redux to manage state](https://hillelcoren.com/2018/06/01/building-a-large-flutter-app-with-redux/)
- [Handling complex forms](https://hillelcoren.com/2018/06/18/flutter-using-redux-to-manage-complex-forms-with-multiple-tabs-and-relationships/)
- [Architectural review](https://hillelcoren.com/2018/08/10/an-architectural-review-of-the-invoice-ninja-flutter-app/)
- [Additional thoughts](https://hillelcoren.com/2018/08/24/ongoing-adventures-with-flutter-and-redux/)

## Developer Notes
- Run `cp lib/.env.dart.example lib/.env.dart` to create the config file
- Run `cp android/key.properties.example android/key.properties` to create the keys file
- Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to regenerate the model files. It will also remove the old generated files so conflicts are avoided.
- Run `keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias invoiceninja` to generate a key to be able to sign the android application.
- Update `android/key.properties` according to the parameters you entered in previous command when you generated the key 
- Open a new Firebase project from your console. Firebase is used for authentication.
    - Inside the project go to Authentication and enable at least one method.
    - After go to add a new Android application. For the package name add `com.invoiceninja.flutter`
    - Press "Register App" button.
    - Download "google-services.json" and put it in `android/app` directory.
- Run `flutter run` while you have a device connected to the computer or an emulator running and now you can run it.    
- Run `flutter drive --target=test_driver/products_it.dart` to run the tests
    
## Contributions

We gladly accept contributions! If you'd like to get involved with development please join our [Slack group](http://slack.invoiceninja.com/).