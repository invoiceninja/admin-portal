import 'package:flutter/material.dart';
import 'package:invoiceninja/routes.dart';
import 'package:invoiceninja/data/models/entities.dart';

class CustomDrawer extends StatelessWidget {
  final List<CompanyEntity> companies;
  final CompanyEntity selectedCompany;
  final String selectedCompanyIndex;
  final Function(String) onCompanyChanged;

  CustomDrawer({
    Key key,
    @required this.companies,
    @required this.selectedCompany,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _singleCompany = Align(
      alignment: FractionalOffset.bottomLeft,
      child: Text(selectedCompany.name),
    );

    final _multipleCompanies = Align(
      alignment: FractionalOffset.bottomLeft,
      child: new DropdownButton<String>(
        isDense: true,
        value: this.selectedCompanyIndex,
        items: this.companies.map((CompanyEntity company) =>
          DropdownMenuItem<String>(
            value: (this.companies.indexOf(company) + 1).toString(),
            child: Text(company.name),
          )
        ).toList(),
        onChanged: (value) {
          this.onCompanyChanged(value);
        },
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
                    child: Image.network(this.selectedCompany.logoUrl)
                  ),
                ),
                SizedBox(
                  height: 18.0,
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
