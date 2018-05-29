import 'package:flutter/material.dart';
import 'package:invoiceninja/routes.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  final AppDrawerVM viewModel;

  CustomDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            viewModel.onCompanyChanged(value);
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
              Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
            },
          ),
          /*
          ListTile(
            leading: Icon(Icons.people),
            title: Text(AppLocalization.of(context).clients),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRoutes.clientScreen);
            },
          ),
          */
          ListTile(
            leading: Icon(FontAwesomeIcons.cube),
            title: Text(AppLocalization.of(context).products),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.products);
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
              while(Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
