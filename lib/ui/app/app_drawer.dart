import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';

import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(viewModel.selectedCompany.name),
          Text(viewModel.selectedCompany.user.email,
              style: Theme.of(context).textTheme.caption)
        ],
      ),
    );

    final _multipleCompanies = Align(
      alignment: FractionalOffset.bottomLeft,
      child: viewModel.companies.isNotEmpty
          ? DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: viewModel.selectedCompanyIndex,
                items: viewModel.companies
                    .map((CompanyEntity company) => DropdownMenuItem<String>(
                          value: (viewModel.companies.indexOf(company) + 1)
                              .toString(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(company.name),
                              Text(company.user.email,
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  viewModel.onCompanyChanged(context, value);
                },
              ),
            )
          : Container(),
    );

    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final NavigatorState navigator = Navigator.of(context);
    final user = store.state.user;
    final company = viewModel.selectedCompany;

    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: viewModel.selectedCompany.logoUrl != null &&
                              viewModel.selectedCompany.logoUrl.isNotEmpty
                          ? Image.network(viewModel.selectedCompany.logoUrl)
                          : Image.asset('assets/images/logo.png',
                              width: 100.0, height: 100.0)),
                  /*
                      child: viewModel.selectedCompany.logoUrl != null &&
                              viewModel.selectedCompany.logoUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: viewModel.selectedCompany.logoUrl,
                              placeholder: CircularProgressIndicator(),
                              errorWidget: Icon(Icons.error),
                            )
                          : Image.asset('assets/images/logo.png',
                              width: 100.0, height: 100.0)),
                              */
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
                    Opacity(
                      opacity: viewModel.isLoading ? 1.0 : 0.0,
                      child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 20.0,
                          height: 20.0),
                    )
                  ],
                ),
              ],
            )),
            color: Colors.white10,
          ),
          user.isAdmin
              ? DrawerTile(
                  company: company,
                  icon: FontAwesomeIcons.tachometerAlt,
                  title: AppLocalization.of(context).dashboard,
                  onTap: () => store.dispatch(ViewDashboard(context)),
                )
              : Container(),
          DrawerTile(
            company: company,
            entityType: EntityType.client,
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
            company: company,
            entityType: EntityType.product,
            icon: FontAwesomeIcons.cube,
            title: AppLocalization.of(context).products,
            onTap: () {
              store.dispatch(ViewProductList(context));
            },
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditProduct(product: ProductEntity(), context: context));
            },
          ),
          DrawerTile(
            company: company,
            entityType: EntityType.invoice,
            icon: FontAwesomeIcons.filePdf,
            title: AppLocalization.of(context).invoices,
            onTap: () => store.dispatch(ViewInvoiceList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditInvoice(invoice: InvoiceEntity(), context: context));
            },
          ),
          // STARTER: menu - do not remove comment
          DrawerTile(
            company: company,
            entityType: EntityType.payment,
            icon: FontAwesomeIcons.creditCard,
            title: AppLocalization.of(context).payments,
            onTap: () => store.dispatch(ViewPaymentList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(EditPayment(
                  payment: PaymentEntity(company), context: context));
            },
          ),
          DrawerTile(
            company: company,
            entityType: EntityType.quote,
            icon: FontAwesomeIcons.fileAlt,
            title: AppLocalization.of(context).quotes,
            onTap: () => store.dispatch(ViewQuoteList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(EditQuote(
                  quote: InvoiceEntity(isQuote: true), context: context));
            },
          ),
          DrawerTile(
            company: company,
            icon: FontAwesomeIcons.cog,
            title: AppLocalization.of(context).settings,
            onTap: () {
              navigator.pop();
              navigator.pushNamed(SettingsScreen.route);
            },
          ),
          AboutListTile(
            icon: Icon(FontAwesomeIcons.info, size: 22.0),
            applicationName: 'Invoice Ninja',
            applicationIcon: Image.asset(
              'assets/images/logo.png',
              width: 40.0,
              height: 40.0,
            ),
            applicationVersion: 'Version ' + kAppVersion + ' - BETA',
            applicationLegalese: '© 2018 Invoice Ninja',
            aboutBoxChildren: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: aboutTextStyle,
                        text:
                            'Thanks for trying out the beta!\n\nPlease join us on the #mobile channel on ',
                      ),
                      _LinkTextSpan(
                        style: linkStyle,
                        url: 'http://slack.invoiceninja.com',
                        text: 'Slack',
                      ),
                      TextSpan(
                        style: aboutTextStyle,
                        text: ' to help make the app better.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    @required this.company,
    @required this.icon,
    @required this.title,
    @required this.onTap,
    this.onCreateTap,
    this.entityType,
  });

  final CompanyEntity company;
  final EntityType entityType;
  final IconData icon;
  final String title;
  final Function onTap;
  final Function onCreateTap;

  @override
  Widget build(BuildContext context) {
    final user = company.user;

    if (entityType != null && !user.canViewOrCreate(entityType)) {
      return Container();
    } else if (!company.isModuleEnabled(entityType)) {
      return Container();
    }

    return ListTile(
      dense: true,
      leading: Icon(icon, size: 22.0),
      title: Text(title),
      onTap: onTap,
      trailing: onCreateTap == null || !user.canCreate(entityType)
          ? null
          : IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: onCreateTap,
            ),
    );
  }
}

/*
'recurring_invoices' => 'files-o',
'credits' => 'credit-card',
'proposals' => 'th-large',
'tasks' => 'clock-o',
'expenses' => 'file-image-o',
'vendors' => 'building',
'projects' => 'briefcase',
*/

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(url, forceSafariVC: false);
              });
}
