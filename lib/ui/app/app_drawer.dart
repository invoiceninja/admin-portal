import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redux/redux.dart';

class AppDrawer extends StatelessWidget {
  final AppDrawerVM viewModel;

  AppDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewModel.selectedCompany == null) {
      return Container();
    }

    final _singleCompany = Align(
      alignment: FractionalOffset.bottomLeft,
      child: Text(viewModel.selectedCompany.name),
    );

    final _multipleCompanies = Align(
      alignment: FractionalOffset.bottomLeft,
      child: new DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          isDense: true,
          value: viewModel.selectedCompanyIndex,
          items: viewModel.companies
              .map((CompanyEntity company) => DropdownMenuItem<String>(
                    value:
                        (viewModel.companies.indexOf(company) + 1).toString(),
                    child: Text(company.name),
                  ))
              .toList(),
          onChanged: (value) {
            viewModel.onCompanyChanged(context, value);
          },
        ),
      ),
    );

    Store<AppState> store = StoreProvider.of<AppState>(context);
    NavigatorState navigator = Navigator.of(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: viewModel.selectedCompany.logoUrl != null
                          //? Image.network(viewModel.selectedCompany.logoUrl)
                          ? CachedNetworkImage(
                              imageUrl: viewModel.selectedCompany.logoUrl,
                              placeholder: CircularProgressIndicator(),
                              errorWidget: Icon(Icons.error),
                            )
                          : null),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: viewModel.companies.length > 1 && ! viewModel.isLoading
                          ? _multipleCompanies
                          : _singleCompany
                    ),
                    viewModel.isLoading ? SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator()
                    ) : Container(),
                  ],
                ),
              ],
            )),
            color: Colors.white10,
          ),
          DrawerTile(
              icon: FontAwesomeIcons.tachometerAlt,
              title: AppLocalization.of(context).dashboard,
              onTap: () {
                store.dispatch(UpdateCurrentRoute(DashboardScreen.route));
                navigator.pushReplacementNamed(DashboardScreen.route);
              }),
          DrawerTile(
            icon: FontAwesomeIcons.users,
            title: AppLocalization.of(context).clients,
            onTap: () {
              store.dispatch(SearchClients(null));
              store.dispatch(UpdateCurrentRoute(ClientScreen.route));
              navigator.pushReplacementNamed(ClientScreen.route);
            },
          ),
          DrawerTile(
            icon: FontAwesomeIcons.cube,
            title: AppLocalization.of(context).products,
            onTap: () {
              store.dispatch(SearchProducts(null));
              store.dispatch(UpdateCurrentRoute(ProductScreen.route));
              navigator.pushReplacementNamed(ProductScreen.route);
            },
          ),
          DrawerTile(
            icon: FontAwesomeIcons.filePdfO,
            title: AppLocalization.of(context).invoices,
            onTap: () {
              store.dispatch(SearchInvoices(null));
              store.dispatch(UpdateCurrentRoute(InvoiceScreen.route));
              navigator.pushReplacementNamed(InvoiceScreen.route);
            },
          ),
          DrawerTile(
            icon: FontAwesomeIcons.powerOff,
            title: AppLocalization.of(context).logOut,
            onTap: () {
              viewModel.onLogoutTapped(context);
            },
          ),
          AboutListTile(
            applicationName: 'Invoice Ninja',
            applicationIcon: Image.asset(
              'assets/images/logo.png',
              width: 40.0,
              height: 40.0,
            ),
            applicationVersion: 'v' + kAppVersion,
            icon: Icon(FontAwesomeIcons.info, size: 22.0),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  DrawerTile({
    this.icon,
    this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon, size: 22.0),
      title: Text(title),
      onTap: () => onTap(),
    );
  }
}

/*
'payments' => 'credit-card',
'recurring_invoices' => 'files-o',
'credits' => 'credit-card',
'quotes' => 'file-text-o',
'proposals' => 'th-large',
'tasks' => 'clock-o',
'expenses' => 'file-image-o',
'vendors' => 'building',
'projects' => 'briefcase',
*/
