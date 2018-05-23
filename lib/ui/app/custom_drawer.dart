import 'package:flutter/material.dart';
import 'package:invoiceninja/routes.dart';
import 'package:invoiceninja/data/models/entities.dart';

class CustomDrawer extends StatelessWidget {
  final String companyName;
  final bool hasMultipleCompanies;
  final List<CompanyEntity> companies;
  final String selectedCompanyId;

  CustomDrawer({
    Key key,
    @required this.companyName,
    @required this.hasMultipleCompanies,
    @required this.companies,
    @required this.selectedCompanyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _singleCompany = Align(
      alignment: FractionalOffset.bottomLeft,
      child: Text(companyName),
    );

    final _multipleCompanies = Align(
      alignment: FractionalOffset.bottomLeft,
      child: new DropdownButton<String>(
        value: this.selectedCompanyId,
        items: this.companies.map((CompanyEntity company) =>
          DropdownMenuItem<String>(
            value: (this.companies.indexOf(company) + 1).toString(),
            child: Text(company.name),
          )
        ).toList(),
        onChanged: (value) {
          print('on change: ' + value);
        },
      ),
      /*
      child: DropdownButton(
        items: this.companies.map((CompanyEntity company) {
          return DropdownMenuItem(
            child: Text(company.name),
          );
        }),
      ),
      */
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
                    child: Text('Logo'),
                  ),
                ),
                this.companies.length > 1 ? _multipleCompanies : _singleCompany,
              ],
            )),
            color: Colors.white10,
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.dashboard);
            },
          ),
          /*
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Clients'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRoutes.clientScreen);
            },
          ),
          */
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Products'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.products);
            },
          ),
          /*
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Invoices'),
            onTap: () {},
          ),
          */
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Log Out'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
