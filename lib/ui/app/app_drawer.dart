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
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final AppDrawerVM viewModel;

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
                  viewModel.onCompanyChanged(context, value,
                      viewModel.companies[int.parse(value) - 1]);
                },
              ),
            )
          : Container(),
    );

    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final NavigatorState navigator = Navigator.of(context);
    final state = store.state;
    final user = state.user;
    final enableDarkMode = state.uiState.enableDarkMode;
    final company = viewModel.selectedCompany;
    final localization = AppLocalization.of(context);

    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            color: enableDarkMode ? Colors.white10 : Colors.grey[200],
            child: DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: viewModel.selectedCompany.logoUrl != null &&
                              viewModel.selectedCompany.logoUrl.isNotEmpty
                          ? CachedNetworkImage(
                              key: ValueKey(viewModel.selectedCompany.logoUrl),
                              imageUrl: viewModel.selectedCompany.logoUrl,
                              placeholder: CircularProgressIndicator(),
                              errorWidget: Image.asset('assets/images/logo.png',
                                  width: 100.0, height: 100.0),
                            )
                          : Image.asset('assets/images/logo.png',
                              width: 100.0, height: 100.0)),
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
                    SizedBox(
                      child: viewModel.isLoading
                          ? CircularProgressIndicator()
                          : null,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ],
                ),
              ],
            )),
          ),
          user.isAdmin
              ? DrawerTile(
                  company: company,
                  icon: FontAwesomeIcons.tachometerAlt,
                  title: localization.dashboard,
                  onTap: () => store.dispatch(ViewDashboard(context)),
                )
              : Container(),
          DrawerTile(
            company: company,
            entityType: EntityType.client,
            icon: getEntityIcon(EntityType.client),
            title: localization.clients,
            onTap: () => store.dispatch(ViewClientList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditClient(client: ClientEntity(), context: context));
            },
          ),
          DrawerTile(
            key: Key(ProductKeys.drawer),
            company: company,
            entityType: EntityType.product,
            icon: getEntityIcon(EntityType.product),
            title: localization.products,
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
            icon: getEntityIcon(EntityType.invoice),
            title: localization.invoices,
            onTap: () => store.dispatch(ViewInvoiceList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(EditInvoice(
                  invoice: InvoiceEntity(company: company), context: context));
            },
          ),
          DrawerTile(
            company: company,
            entityType: EntityType.payment,
            icon: getEntityIcon(EntityType.payment),
            title: localization.payments,
            onTap: () => store.dispatch(ViewPaymentList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(EditPayment(
                  payment: PaymentEntity(company: company), context: context));
            },
          ),
          DrawerTile(
            company: company,
            entityType: EntityType.quote,
            icon: getEntityIcon(EntityType.quote),
            title: localization.quotes,
            onTap: () => store.dispatch(ViewQuoteList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(EditQuote(
                  quote: InvoiceEntity(isQuote: true), context: context));
            },
          ),
          // STARTER: menu - do not remove comment
          DrawerTile(
            company: company,
            entityType: EntityType.project,
            icon: getEntityIcon(EntityType.project),
            title: localization.projects,
            onTap: () => store.dispatch(ViewProjectList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(
                  EditProject(project: ProjectEntity(), context: context));
            },
          ),
          DrawerTile(
            company: company,
            entityType: EntityType.task,
            icon: getEntityIcon(EntityType.task),
            title: localization.tasks,
            onTap: () => store.dispatch(ViewTaskList(context)),
            onCreateTap: () {
              navigator.pop();
              store.dispatch(EditTask(
                  task: TaskEntity(isRunning: state.uiState.autoStartTasks),
                  context: context));
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(FontAwesomeIcons.building, size: 22.0),
            title: Text('Vendors & Expenses'),
            onTap: () {
              showDialog<AlertDialog>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      semanticLabel: 'Vendors & Expenses',
                      title: Text('Vendors & Expenses'),
                      content: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              style: aboutTextStyle,
                              text: localization.thanksForPatience + ' ',
                            ),
                            _LinkTextSpan(
                              style: linkStyle,
                              url: getLegacyAppURL(context),
                              text: localization.legacyMobileApp,
                            ),
                            TextSpan(
                              style: aboutTextStyle,
                              text: '.',
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(localization.ok.toUpperCase()),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
              );
            },
          ),
          DrawerTile(
            company: company,
            icon: FontAwesomeIcons.cog,
            title: localization.settings,
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
            applicationVersion: 'Version ' + kAppVersion,
            applicationLegalese: '© 2018 Invoice Ninja',
            aboutBoxChildren: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: aboutTextStyle,
                        text: localization.thankYouForUsingOurApp +
                            '\n\n' +
                            localization.ifYouLikeIt,
                      ),
                      _LinkTextSpan(
                        style: linkStyle,
                        url: getAppURL(context),
                        text: ' ' + localization.clickHere + ' ',
                      ),
                      TextSpan(
                        style: aboutTextStyle,
                        text: localization.toRateIt,
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
    Key key,
    @required this.company,
    @required this.icon,
    @required this.title,
    @required this.onTap,
    this.onCreateTap,
    this.entityType,
  }) : super(key: key);

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
      leading: Icon(icon, size: 22.0, key: ValueKey(title)),
      title: Tooltip(message: title, child: Text(title)),
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
