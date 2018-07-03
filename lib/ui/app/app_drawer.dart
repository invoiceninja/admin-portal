import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redux/redux.dart';

class AppDrawer extends StatelessWidget {
  final AppDrawerVM viewModel;

  const AppDrawer({
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
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

    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final NavigatorState navigator = Navigator.of(context);

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
                        child: viewModel.companies.length > 1 &&
                                !viewModel.isLoading
                            ? _multipleCompanies
                            : _singleCompany),
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
              navigator.pop();
              store.dispatch(ViewDashboard(context));
            },
          ),
          DrawerTile(
            icon: FontAwesomeIcons.users,
            title: AppLocalization.of(context).clients,
            onTap: () => store.dispatch(ViewClientList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditClient(client: ClientEntity(), context: context));
            },
          ),
          DrawerTile(
            icon: FontAwesomeIcons.cube,
            title: AppLocalization.of(context).products,
            onTap: () => store.dispatch(ViewProductList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditProduct(product: ProductEntity(), context: context));
            },
          ),
          DrawerTile(
            icon: FontAwesomeIcons.filePdfO,
            title: AppLocalization.of(context).invoices,
            onTap: () => store.dispatch(ViewInvoiceList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditInvoice(invoice: InvoiceEntity(), context: context));
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
  const DrawerTile({
    this.icon,
    this.title,
    this.onTap,
    this.onCreateTap,
  });

  final IconData icon;
  final String title;
  final Function onTap;
  final Function onCreateTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon, size: 22.0),
      title: Text(title),
      onTap: () => onTap(),
      trailing: onCreateTap == null
          ? null
          : IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: onCreateTap,
            ),
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
