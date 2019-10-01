import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/resources/cached_image.dart';
import 'package:invoiceninja_flutter/ui/app/upgrade_dialog.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:url_launcher/url_launcher.dart';
// STARTER: import - do not remove comment

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final AppDrawerVM viewModel;

  @override
  Widget build(BuildContext context) {
    final company = viewModel.selectedCompany;

    if (company == null) {
      return Container();
    }

    final _singleCompany = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        viewModel.isLoading
            ? SizedBox(
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
                width: 32,
                height: 30,
              )
            : company.logoUrl != null && company.logoUrl.isNotEmpty
                ? CachedImage(
                    width: 32,
                    height: 30,
                    url: company.logoUrl,
                  )
                : Image.asset('assets/images/logo.png', width: 32, height: 30),
        SizedBox(width: 28, height: 50),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                company.name,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Text(viewModel.user.email,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
        )
      ],
    );

    final _multipleCompanies = DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      isExpanded: true,
      value: viewModel.selectedCompanyIndex,
      items: viewModel.companies
          .map((CompanyEntity company) => DropdownMenuItem<String>(
                value: (viewModel.companies.indexOf(company) + 1).toString(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    company.logoUrl != null && company.logoUrl.isNotEmpty
                        ? CachedImage(
                            width: 32,
                            height: 30,
                            url: company.logoUrl,
                          )
                        : Image.asset('assets/images/logo.png',
                            width: 32, height: 30),
                    SizedBox(width: 28),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            company.name,
                            style: Theme.of(context).textTheme.subhead,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(viewModel.user.email,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption)
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
      onChanged: (value) {
        viewModel.onCompanyChanged(
            context, value, viewModel.companies[int.parse(value) - 1]);
      },
    ));

    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final NavigatorState navigator = Navigator.of(context);
    final state = store.state;
    final enableDarkMode = state.uiState.enableDarkMode;
    final localization = AppLocalization.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Hide options while refreshing data
            state.credentials.token.isEmpty
                ? Container(
                    padding: EdgeInsets.only(top: 40),
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                    color: enableDarkMode ? Colors.white10 : Colors.grey[200],
                    child:
                        viewModel.companies.length > 1 && !viewModel.isLoading
                            ? _multipleCompanies
                            : _singleCompany),
            state.credentials.token.isEmpty
                ? SizedBox()
                : Expanded(
                    child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      DrawerTile(
                        company: company,
                        icon: FontAwesomeIcons.tachometerAlt,
                        title: localization.dashboard,
                        onTap: () =>
                            store.dispatch(ViewDashboard(context: context)),
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.client,
                        icon: getEntityIcon(EntityType.client),
                        title: localization.clients,
                        onTap: () =>
                            store.dispatch(ViewClientList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditClient(
                              client: ClientEntity(), context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.product,
                        icon: getEntityIcon(EntityType.product),
                        title: localization.products,
                        onTap: () {
                          store.dispatch(ViewProductList(context: context));
                        },
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditProduct(
                              product: ProductEntity(), context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.invoice,
                        icon: getEntityIcon(EntityType.invoice),
                        title: localization.invoices,
                        onTap: () =>
                            store.dispatch(ViewInvoiceList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditInvoice(
                              invoice: InvoiceEntity(company: company),
                              context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.payment,
                        icon: getEntityIcon(EntityType.payment),
                        title: localization.payments,
                        onTap: () =>
                            store.dispatch(ViewPaymentList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditPayment(
                              payment: PaymentEntity(company: company),
                              context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.quote,
                        icon: getEntityIcon(EntityType.quote),
                        title: localization.quotes,
                        onTap: () =>
                            store.dispatch(ViewQuoteList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditQuote(
                              quote: InvoiceEntity(isQuote: true),
                              context: context));
                        },
                      ),
                      /*
                      DrawerTile(
                        company: company,
                        entityType: EntityType.project,
                        icon: getEntityIcon(EntityType.project),
                        title: localization.projects,
                        onTap: () =>
                            store.dispatch(ViewProjectList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditProject(
                              project: ProjectEntity(), context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.task,
                        icon: getEntityIcon(EntityType.task),
                        title: localization.tasks,
                        onTap: () =>
                            store.dispatch(ViewTaskList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditTask(
                              task: TaskEntity(
                                  isRunning: state.uiState.autoStartTasks),
                              context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.vendor,
                        icon: getEntityIcon(EntityType.vendor),
                        title: localization.vendors,
                        onTap: () =>
                            store.dispatch(ViewVendorList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditVendor(
                              vendor: VendorEntity(), context: context));
                        },
                      ),
                      DrawerTile(
                        company: company,
                        entityType: EntityType.expense,
                        icon: getEntityIcon(EntityType.expense),
                        title: localization.expenses,
                        onTap: () =>
                            store.dispatch(ViewExpenseList(context: context)),
                        onCreateTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(EditExpense(
                              expense: ExpenseEntity(
                                  company: company, uiState: state.uiState),
                              context: context));
                        },
                      ),
                      */
                      // STARTER: menu - do not remove comment
                      DrawerTile(
                        company: company,
                        icon: FontAwesomeIcons.cog,
                        title: localization.settings,
                        onTap: () {
                          if (isMobile(context)) {
                            navigator.pop();
                          }
                          store.dispatch(ViewSettings(context: context));
                        },
                      ),
                    ],
                  )),
            Align(
              child: SidebarFooter(),
              alignment: Alignment(0, 1),
            ),
          ],
        ),
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
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final userCompany = store.state.userCompany;

    if (entityType != null && !userCompany.canViewOrCreate(entityType)) {
      return Container();
    } else if (!company.isModuleEnabled(entityType)) {
      return Container();
    }

    final localization = AppLocalization.of(context);
    final route = title == localization.dashboard
        ? 'dashboard'
        : title == localization.settings ? 'settings' : entityType.name;

    return SelectedIndicator(
      isSelected: uiState.containsRoute(route),
      child: ListTile(
        dense: true,
        leading: Icon(icon, size: 22.0),
        title: Tooltip(message: title, child: Text(title)),
        onTap: onTap,
        trailing: onCreateTap == null || !userCompany.canCreate(entityType)
            ? null
            : IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: onCreateTap,
              ),
      ),
    );
  }
}

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

class SidebarFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    void showAbout() {
      showAboutDialog(
        context: context,
        applicationName: 'Invoice Ninja',
        applicationIcon: Image.asset(
          'assets/images/logo.png',
          width: 40.0,
          height: 40.0,
        ),
        applicationVersion: 'Version: $kAppVersion',
        applicationLegalese: '© ${DateTime.now().year} Invoice Ninja',
        children: <Widget>[
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
      );
    }

    return Container(
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () => launch('https://www.invoiceninja.com/contact'),
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => launch('https://docs.invoiceninja.com'),
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => showAbout(),
          ),
          if (state.lastError.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.warning,
                color: Colors.red,
              ),
              onPressed: () => viewPdf(InvoiceEntity(), context),
              /*
              onPressed: () => showDialog<ErrorDialog>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      state.lastError,
                      clearErrorOnDismiss: true,
                    );
                  }),
               */
            ),
          if (!Platform.isIOS &&
              isHosted(context) &&
              !isPaidAccount(context)) ...[
            Spacer(),
            FlatButton(
              child: Text(localization.upgrade),
              color: Colors.green,
              onPressed: () => showDialog<UpgradeDialog>(
                  context: context,
                  builder: (BuildContext context) {
                    return UpgradeDialog();
                  }),
            ),
            SizedBox(width: 14)
          ],
        ],
      ),
    );
  }
}
