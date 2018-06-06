import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          items: viewModel.companies.map((CompanyEntity company) =>
            DropdownMenuItem<String>(
              value: (viewModel.companies.indexOf(company) + 1).toString(),
              child: Text(company.name),
            )
          ).toList(),
          onChanged: (value) {
            viewModel.onCompanyChanged(context, value);
          },
        ),
      ),
    );

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: viewModel.selectedCompany.logoUrl != null ? Image.network(viewModel.selectedCompany.logoUrl) : null
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                viewModel.companies.length > 1 ? _multipleCompanies : _singleCompany,
              ],
            )),
            color: Colors.white10,
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.tachometerAlt),
            title: Text(AppLocalization.of(context).dashboard),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(DashboardScreen.route);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.users),
            title: Text(AppLocalization.of(context).clients),
            onTap: () {
              StoreProvider.of<AppState>(context).dispatch(SearchClients(null));
              Navigator.of(context).pushReplacementNamed(ClientScreen.route);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.cube),
            title: Text(AppLocalization.of(context).products),
            onTap: () {
              StoreProvider.of<AppState>(context).dispatch(SearchProducts(null));
              Navigator.of(context).pushReplacementNamed(ProductScreen.route);
            },
          ),
          /*
          ListTile(
            leading: Icon(Icons.email),
            title: Text(''),
            onTap: () {},
          ),
          */
          ListTile(
            leading: Icon(FontAwesomeIcons.powerOff),
            title: Text(AppLocalization.of(context).logOut),
            onTap: () {
              viewModel.onLogoutTapped(context);
            },
          ),
          AboutListTile(
            applicationName: 'Invoice Ninja',
            applicationIcon: Image.asset('assets/images/logo.png', width: 40.0, height: 40.0,),
            applicationVersion: 'v' + kAppVersion,
            icon: Icon(FontAwesomeIcons.info),
          ),
        ],
      ),
    );
  }
}
