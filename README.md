# Invoice Ninja

Companion app for the [Invoice Ninja](https://github.com/invoiceninja/invoiceninja) web app.

## Open Beta
- Android: https://play.google.com/apps/testing/com.invoiceninja.flutter
- iOS: Email contact@invoiceninja.com for a Test Flight code

Note: the beta is currently available to self host users and requires the latest version of the web app (v4.5.4).

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
- [ ] Credits
- [ ] Recurring
- [ ] Vendors
- [ ] Expenses
- [ ] Projects
- [ ] Tasks
- [ ] Tablet support
- [ ] Desktop support

## Application Architecture

The application was created using the [Flutter Redux Starter](https://github.com/hillelcoren/flutter-redux-starter).

The architecture is based off these two projects:

- [Redux Sample](https://github.com/brianegan/flutter_architecture_samples/tree/master/example/redux) - [Brian Egan](https://twitter.com/brianegan)
- [inKino](https://github.com/roughike/inKino) - [Iiro Krankka](https://twitter.com/koorankka)

## Developer Notes
- Run `cp lib/.env.dart.example lib/.env.dart` to create the config file
- Run `cp android/key.properties.example android/key.properties` to create the keys file
- Run `flutter packages pub run build_runner build` to regenerate the model files

## Contributions

We gladly accept contributions! If you'd like to get involved with development please join our [Slack group](http://slack.invoiceninja.com/).