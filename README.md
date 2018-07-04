# Invoice Ninja - Mobile

This is a companion app for the [Invoice Ninja](https://github.com/invoiceninja/invoiceninja) web app.

The project is under active development, for the time being we recommend using the existing [mobile apps](https://www.invoiceninja.com/iphone-android/).

<p align="center">
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_01.png" alt="Product List" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_02.png" alt="Edit Product" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_03.png" alt="Drawer" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_04.png" alt="Dashboard" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_05.png" alt="Client Overview" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_06.png" alt="Contact Details" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_07.png" alt="Edit Contacts" width="200"/>
    <img src="https://github.com/invoiceninja/flutter-mobile/blob/master/samples/screenshots/screenshot_08.png" alt="New Invoice" width="200"/>
</p>

## Features

- [x] Dashboard
- [x] Clients
- [x] Products
- [x] Invoices
- [ ] Payments
- [ ] Quotes
- [ ] Recurring
- [ ] Credits
- [ ] Vendors
- [ ] Expenses
- [ ] Projects
- [ ] Tasks

## Code Samples

- Redux Starter: [hillelcoren/flutter-redux-starter](https://github.com/hillelcoren/flutter-redux-starter)
- Forms: [Keys](https://github.com/invoiceninja/flutter-mobile/blob/master/samples/form_keys.dart) vs [Redux](https://github.com/invoiceninja/flutter-mobile/blob/master/samples/form_redux.dart)

## Application Architecture

The architecture is based off these two projects:

- [Redux Sample](https://github.com/brianegan/flutter_architecture_samples/tree/master/example/redux) - [Brian Egan](https://twitter.com/brianegan)
- [inKino](https://github.com/roughike/inKino) - [Iiro Krankka](https://twitter.com/koorankka)

## Developer Notes
- Run `cp lib/.env.dart.example lib/.env.dart` when setting up the app to create the config file.
- Run `flutter packages pub run build_runner build` to regenerate the model files

## Contributions

We gladly accept contributions! If you'd like to get involved with development please join our [Slack group](http://slack.invoiceninja.com/).