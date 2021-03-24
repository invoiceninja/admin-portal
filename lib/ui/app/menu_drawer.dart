import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/flutter_version.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/health_check_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/resources/cached_image.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/system/update_dialog.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final MenuDrawerVM viewModel;
  static const LOGO_WIDTH = 38.0;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;
    final localization = AppLocalization.of(context);
    final account = state.account;
    final company = viewModel.selectedCompany;

    if (company == null) {
      return Container();
    }

    Widget _companyLogo(CompanyEntity company) => company
                    .settings.companyLogo !=
                null &&
            company.settings.companyLogo.isNotEmpty
        ? CachedImage(
            width: MenuDrawer.LOGO_WIDTH,
            url: company.settings.companyLogo,
          )
        : Image.asset('assets/images/logo.png', width: MenuDrawer.LOGO_WIDTH);

    Widget _companyListItem(CompanyEntity company) {
      final userCompany = state.userCompanyStates
          .firstWhere(
              (userCompanyState) => userCompanyState.company.id == company.id)
          .userCompany;
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _companyLogo(company),
          SizedBox(width: 15, height: kTopBottomBarHeight),
          Expanded(
            child: Text(
              company.displayName.isEmpty
                  ? localization.newCompany
                  : company.displayName,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (userCompany.settings.accentColor != null &&
              state.companies.length > 1)
            Container(
              padding: const EdgeInsets.only(right: 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: convertHexStringToColor(
                      userCompany.settings.accentColor)),
              width: 10,
              height: 10,
              //color: Colors.red,
            ),
        ],
      );
    }

    final _collapsedCompanySelector = PopupMenuButton<String>(
      tooltip: localization.selectCompany,
      child: SizedBox(
        height: 48,
        width: MenuDrawer.LOGO_WIDTH,
        child: _companyLogo(viewModel.selectedCompany),
      ),
      color: Theme.of(context).cardColor,
      itemBuilder: (BuildContext context) => [
        ...viewModel.state.companies
            .map((company) => PopupMenuItem<String>(
                  child: _companyListItem(company),
                  value: company.id,
                ))
            .toList(),
        if (state.canAddCompany)
          PopupMenuItem<String>(
            value: 'company',
            child: Row(
              children: <Widget>[
                SizedBox(width: 2),
                Icon(Icons.add_circle, size: 32),
                SizedBox(width: 20),
                Text(localization.addCompany),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: <Widget>[
              SizedBox(width: 2),
              Icon(Icons.logout, size: 32),
              SizedBox(width: 20),
              Text(localization.logout),
            ],
          ),
        ),
      ],
      onSelected: (String companyId) {
        if (companyId == 'company') {
          viewModel.onAddCompany(context);
        } else if (companyId == 'logout') {
          viewModel.onLogoutTap(context);
        } else {
          final company =
              state.companies.firstWhere((company) => company.id == companyId);
          final index = state.companies.indexOf(company);
          viewModel.onCompanyChanged(context, index, company);
        }
      },
    );

    final _expandedCompanySelector = state.companies.isEmpty
        ? SizedBox()
        : AppDropdownButton<String>(
            value: viewModel.selectedCompanyIndex,
            items: [
              ...state.companies
                  .map((CompanyEntity company) => DropdownMenuItem<String>(
                      value: (state.companies.indexOf(company)).toString(),
                      child: _companyListItem(company)))
                  .toList(),
              if (state.canAddCompany)
                DropdownMenuItem<String>(
                  value: 'company',
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 2),
                      Icon(Icons.add_circle, size: 32),
                      SizedBox(width: 20),
                      Text(localization.addCompany),
                    ],
                  ),
                ),
              DropdownMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 2),
                    Icon(Icons.logout, size: 32),
                    SizedBox(width: 20),
                    Text(localization.logout),
                  ],
                ),
              ),
            ],
            onChanged: (dynamic value) {
              if (value == 'company') {
                viewModel.onAddCompany(context);
              } else if (value == 'logout') {
                viewModel.onLogoutTap(context);
              } else {
                final index = int.parse(value);
                viewModel.onCompanyChanged(
                    context, index, state.companies[index]);
              }
            },
          );

    return Container(
      width: state.isMenuCollapsed ? 65 : kDrawerWidth,
      child: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Hide options while refreshing data
              state.credentials.token.isEmpty
                  ? Expanded(child: SizedBox())
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                      color: enableDarkMode
                          ? Colors.white10
                          : Theme.of(context).cardColor,
                      child: state.isMenuCollapsed
                          ? _collapsedCompanySelector
                          : _expandedCompanySelector),
              state.credentials.token.isEmpty
                  ? SizedBox()
                  : Expanded(
                      child: Container(
                      color: Theme.of(context).cardColor,
                      child: ScrollableListView(
                        children: <Widget>[
                          if (state.account.debugEnabled && kReleaseMode)
                            if (state.isMenuCollapsed)
                              Tooltip(
                                message: localization.debugModeIsEnabled,
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  onTap: () => launch(kDebugModeUrl),
                                  leading:
                                      Icon(Icons.warning, color: Colors.red),
                                ),
                              )
                            else
                              ListTile(
                                tileColor: Colors.red.shade800,
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: IconText(
                                    icon: Icons.warning,
                                    text: localization.debugModeIsEnabled,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                subtitle: Text(
                                  localization.debugModeIsEnabledHelp,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () => launch(kDebugModeUrl),
                              ),
                          if (state.company.isDisabled)
                            if (state.isMenuCollapsed)
                              Tooltip(
                                message: localization.companyDisabledWarning,
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  onTap: () {
                                    store.dispatch(ViewSettings(
                                        navigator: Navigator.of(context),
                                        section: kSettingsAccountManagement));
                                  },
                                  leading:
                                      Icon(Icons.warning, color: Colors.orange),
                                ),
                              )
                            else
                              ListTile(
                                tileColor: Colors.orange.shade800,
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: IconText(
                                    icon: Icons.warning,
                                    text: localization.warning,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                subtitle: Text(
                                  localization.companyDisabledWarning,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  store.dispatch(ViewSettings(
                                      navigator: Navigator.of(context),
                                      section: kSettingsAccountManagement));
                                },
                              ),
                          DrawerTile(
                            company: company,
                            icon: getEntityIcon(EntityType.dashboard),
                            title: localization.dashboard,
                            onTap: () => viewEntitiesByType(
                                context: context,
                                entityType: EntityType.dashboard),
                            onLongPress: () => store.dispatch(ViewDashboard(
                                navigator: Navigator.of(context), filter: '')),
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.client,
                            icon: getEntityIcon(EntityType.client),
                            title: localization.clients,
                            iconTooltip: localization.newClient,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.product,
                            icon: getEntityIcon(EntityType.product),
                            title: localization.products,
                            iconTooltip: localization.newProduct,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.invoice,
                            icon: getEntityIcon(EntityType.invoice),
                            title: localization.invoices,
                            iconTooltip: localization.newInvoice,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.payment,
                            icon: getEntityIcon(EntityType.payment),
                            title: localization.payments,
                            iconTooltip: localization.newPayment,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.recurringInvoice,
                            icon: getEntityIcon(EntityType.recurringInvoice),
                            title: localization.recurringInvoices,
                            iconTooltip: localization.newRecurringInvoice,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.quote,
                            icon: getEntityIcon(EntityType.quote),
                            title: localization.quotes,
                            iconTooltip: localization.newQuote,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.credit,
                            icon: getEntityIcon(EntityType.credit),
                            title: localization.credits,
                            iconTooltip: localization.newCredit,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.project,
                            icon: getEntityIcon(EntityType.project),
                            title: localization.projects,
                            iconTooltip: localization.newProject,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.task,
                            icon: getEntityIcon(EntityType.task),
                            title: localization.tasks,
                            iconTooltip: localization.newTask,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.vendor,
                            icon: getEntityIcon(EntityType.vendor),
                            title: localization.vendors,
                            iconTooltip: localization.newVendor,
                          ),
                          DrawerTile(
                            company: company,
                            entityType: EntityType.expense,
                            icon: getEntityIcon(EntityType.expense),
                            title: localization.expenses,
                            iconTooltip: localization.newExpense,
                          ),
                          // STARTER: menu - do not remove comment
                          DrawerTile(
                            company: company,
                            icon: getEntityIcon(EntityType.reports),
                            title: localization.reports,
                            onTap: () => viewEntitiesByType(
                                context: context,
                                entityType: EntityType.reports),
                          ),
                          DrawerTile(
                            company: company,
                            icon: getEntityIcon(EntityType.settings),
                            title: localization.settings,
                            onTap: () => viewEntitiesByType(
                                context: context,
                                entityType: EntityType.settings),
                          ),
                        ],
                      ),
                    )),
              SizedBox(
                height: kTopBottomBarHeight,
                child: AppBorder(
                  isTop: true,
                  child: Align(
                    child: state.isMenuCollapsed
                        ? SidebarFooterCollapsed()
                        : SidebarFooter(),
                    alignment: Alignment(0, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatefulWidget {
  const DrawerTile({
    @required this.company,
    @required this.icon,
    @required this.title,
    this.onTap,
    this.entityType,
    this.onLongPress,
    this.onCreateTap,
    this.iconTooltip,
  });

  final CompanyEntity company;
  final EntityType entityType;
  final IconData icon;
  final String title;
  final Function onTap;
  final Function onLongPress;
  final Function onCreateTap;
  final String iconTooltip;

  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  //bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final userCompany = state.userCompany;
    final NavigatorState navigator = Navigator.of(context);

    if (!Config.DEMO_MODE) {
      if (widget.entityType != null &&
          !userCompany.canViewOrCreate(widget.entityType)) {
        return Container();
      }
    }

    final enableDarkMode = state.prefState.enableDarkMode;
    final localization = AppLocalization.of(context);
    final route = widget.title == localization.dashboard
        ? kDashboard
        : widget.title == localization.settings
            ? kSettings
            : widget.title == localization.reports
                ? kReports
                : widget.entityType.name;

    final isSelected =
        uiState.currentRoute.startsWith('/${toSnakeCase(route)}') &&
            (state.uiState.filterEntityType == null ||
                !state.prefState.showFilterSidebar);

    final textColor = Theme.of(context)
        .textTheme
        .bodyText1
        .color
        .withOpacity(isSelected ? 1 : .7);

    Widget trailingWidget;
    if (!state.isMenuCollapsed) {
      if (widget.title == localization.dashboard) {
        trailingWidget = IconButton(
          icon: Icon(
            Icons.search,
            color: textColor,
          ),
          onPressed: () {
            if (isMobile(context)) {
              navigator.pop();
            }
            store.dispatch(ViewDashboard(
                navigator: Navigator.of(context),
                filter: uiState.mainRoute == 'dashboard' && uiState.filter == ''
                    ? null
                    : ''));
          },
        );
      } else if (userCompany.canCreate(widget.entityType)) {
        trailingWidget = IconButton(
          tooltip: widget.iconTooltip,
          icon: Icon(
            Icons.add_circle_outline,
            color: textColor,
          ),
          onPressed: () {
            if (isMobile(context)) {
              navigator.pop();
            }
            createEntityByType(
              context: context,
              entityType: widget.entityType,
              applyFilter: false,
            );
          },
        );
      }
    }

    Widget child = Material(
      color: isSelected
          ? convertHexStringToColor(enableDarkMode
              ? kDefaultDarkSelectedColorMenu
              : kDefaultLightSelectedColorMenu)
          : Colors.transparent,
      child: ListTile(
        dense: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            widget.icon,
            size: 24,
            color: textColor,
          ),
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 16,
                color: textColor,
              ),
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
        onTap: () {
          if (widget.entityType != null) {
            viewEntitiesByType(context: context, entityType: widget.entityType);
          } else {
            widget.onTap();
          }
        },
        onLongPress: () => widget.onLongPress != null
            ? widget.onLongPress()
            : widget.entityType != null
                ? createEntityByType(
                    context: context,
                    entityType: widget.entityType,
                    applyFilter: false,
                  )
                : null,
        /*
            trailing: _isHovered ||
                    !RendererBinding.instance.mouseTracker.mouseIsConnected
                ? trailingWidget
                : null,

             */
        trailing: state.isMenuCollapsed ? null : trailingWidget,
      ),
    );

    if (state.isMenuCollapsed) {
      child = Tooltip(
        message: widget.title,
        child: child,
      );
    }

    return MouseRegion(
      //onEnter: (event) => setState(() => _isHovered = true),
      //onExit: (event) => setState(() => _isHovered = false),
      child: child,
    );
  }
}

class SidebarFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final account = state.userCompany.account;

    return Material(
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (state.isMenuCollapsed) ...[
            Expanded(child: SizedBox())
          ] else ...[
            if (!Config.DEMO_MODE && !state.isDemo)
              if (state.isSelfHosted && !account.isSchedulerRunning)
                IconButton(
                  tooltip: localization.error,
                  icon: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  onPressed: () => showMessageDialog(
                      context: context,
                      message: localization.cronsNotEnabled,
                      secondaryActions: [
                        TextButton(
                          child: Text(localization.learnMore.toUpperCase()),
                          onPressed: () {
                            launch(kCronsHelpUrl,
                                forceSafariVC: false, forceWebView: false);
                          },
                        ),
                        TextButton(
                          child: Text(localization.refreshData.toUpperCase()),
                          onPressed: () {
                            store.dispatch(RefreshData());
                            Navigator.of(context).pop();
                          },
                        ),
                      ]),
                )
              else if (state.credentials.token.isEmpty)
                IconButton(
                  tooltip: localization.error,
                  icon: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  onPressed: () => showErrorDialog(
                    context: context,
                    clearErrorOnDismiss: true,
                  ),
                )
              else if (state.isSelfHosted && account.isUpdateAvailable)
                IconButton(
                  tooltip: localization.updateAvailable,
                  icon: Icon(
                    Icons.warning,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => _showUpdate(context),
                ),
            IconButton(
              icon: Icon(Icons.mail),
              onPressed: () => state.uiState.isShowingPdf && kIsWeb
                  ? null
                  : _showContactUs(context),
              tooltip: localization.contactUs,
            ),
            IconButton(
              icon: Icon(Icons.forum),
              onPressed: () => launch(kForumUrl),
              tooltip: localization.supportForum,
            ),
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () => launch(kDocsUrl),
              tooltip: localization.help,
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              // prevent the modal from being stuck over the pdf
              onPressed: state.uiState.isShowingPdf && kIsWeb
                  ? null
                  : () => _showAbout(context),
              tooltip: localization.about,
            ),
            /*
            if (kDebugMode)
              IconButton(
                icon: Icon(Icons.memory),
                onPressed: () => showDialog<StateInspector>(
                    context: context,
                    builder: (BuildContext context) {
                      return StateInspector();
                    }),
              ),
             */
            /*
            IconButton(
              icon: Icon(Icons.filter),
              onPressed: () => viewPdf(InvoiceEntity(), context),
            ),
             */
            //if (state.lastError.isNotEmpty && (state.isSelfHosted || !kReleaseMode))
            if (state.lastError.isNotEmpty && !Config.DEMO_MODE)
              IconButton(
                icon: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                tooltip: localization.error,
                onPressed: () => showDialog<ErrorDialog>(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorDialog(
                        state.lastError,
                        clearErrorOnDismiss: true,
                      );
                    }),
              ),
            /*
          if (isHosted(context) &&
              !isPaidAccount(context)) ...[
            Spacer(),
            TextButton(
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
           */
            Spacer(),
            if (isNotMobile(context) &&
                state.prefState.menuSidebarMode == AppSidebarMode.collapse)
              AppBorder(
                isLeft: true,
                child: Tooltip(
                  message: localization.hideMenu,
                  child: InkWell(
                    onTap: () => store.dispatch(
                        UpdateUserPreferences(sidebar: AppSidebar.menu)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.chevron_left),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class SidebarFooterCollapsed extends StatelessWidget {
  const SidebarFooterCollapsed();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final isUpdateAvailable =
        state.isSelfHosted && state.account.isUpdateAvailable;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).cardColor,
      child: state.uiState.filterEntityType != null &&
              state.prefState.showFilterSidebar
          ? PopupMenuButton<String>(
              icon: isUpdateAvailable
                  ? Icon(Icons.warning, color: Theme.of(context).accentColor)
                  : Icon(Icons.info_outline),
              onSelected: (value) {
                if (value == localization.updateAvailable) {
                  _showUpdate(context);
                } else if (value == localization.about) {
                  _showAbout(context);
                } else if (value == localization.contactUs) {
                  _showContactUs(context);
                }
              },
              itemBuilder: (BuildContext context) => [
                if (isUpdateAvailable)
                  PopupMenuItem<String>(
                    child: ListTile(
                      leading: Icon(
                        Icons.warning,
                        color: Theme.of(context).accentColor,
                      ),
                      title: Text(localization.updateAvailable),
                    ),
                    value: localization.updateAvailable,
                  ),
                PopupMenuItem<String>(
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(localization.contactUs),
                  ),
                  value: localization.contactUs,
                ),
                PopupMenuItem<String>(
                  child: ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text(localization.documentation),
                  ),
                  value: localization.documentation,
                ),
                PopupMenuItem<String>(
                  child: ListTile(
                    leading: Icon(Icons.forum),
                    title: Text(localization.supportForum),
                  ),
                  value: localization.supportForum,
                ),
                PopupMenuItem<String>(
                  child: ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text(localization.about),
                  ),
                  value: localization.about,
                ),
              ],
            )
          : IconButton(
              icon: Icon(
                Icons.chevron_right,
                color: isUpdateAvailable ? state.accentColor : null,
              ),
              tooltip: localization.showMenu,
              onPressed: () {
                store.dispatch(UpdateUserPreferences(sidebar: AppSidebar.menu));
              },
            ),
    );
  }
}

void _showContactUs(BuildContext context) {
  showDialog<ContactUsDialog>(
    context: context,
    builder: (BuildContext context) => ContactUsDialog(),
  );
}

void _showUpdate(BuildContext context) {
  showDialog<UpdateDialog>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => UpdateDialog(),
  );
}

void _showAbout(BuildContext context) async {
  //final packageInfo = await PackageInfo.fromPlatform();
  final Store<AppState> store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.bodyText2;
  final TextStyle linkStyle =
      themeData.textTheme.bodyText2.copyWith(color: themeData.accentColor);

  final appLegalese = '© ${DateTime.now().year} Invoice Ninja';
  final apppIcon = Image.asset(
    'assets/images/logo.png',
    width: 40.0,
    height: 40.0,
  );

  showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              child: Text(localization.viewLicenses.toUpperCase()),
              onPressed: () => showLicensePage(
                context: context,
                applicationName: 'Invoice Ninja',
                applicationIcon: apppIcon,
                applicationLegalese: appLegalese,
                applicationVersion: state.appVersion,
              ),
            ),
            TextButton(
              child: Text(localization.close.toUpperCase()),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: apppIcon,
                  ),
                  title: Text(
                    'Invoice Ninja',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(state.appVersion),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: state.appVersion));
                    showToast(localization.copiedToClipboard
                        .replaceFirst(':value', state.appVersion));
                  },
                  onLongPress: () {
                    showMessageDialog(
                      context: context,
                      message: FLUTTER_VERSION['channel'].toUpperCase() +
                          ' • ' +
                          FLUTTER_VERSION['frameworkVersion'],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          style: aboutTextStyle,
                          text: localization.thankYouForUsingOurApp +
                              '\n\n' +
                              localization.ifYouLikeIt,
                        ),
                        TextSpan(
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(getAppURL(context), forceSafariVC: false);
                            },
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: AppButton(
                    label: localization.appPlatforms.toUpperCase(),
                    iconData: MdiIcons.desktopMac,
                    onPressed: () {
                      showDialog<AlertDialog>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  child: Text(
                                      localization.sourceCode.toUpperCase()),
                                  onPressed: () {
                                    showDialog<AlertDialog>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actions: [
                                            TextButton(
                                              child: Text(localization.close
                                                  .toUpperCase()),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text('Backend'),
                                              AppButton(
                                                label: 'Laravel/PHP',
                                                iconData: MdiIcons.server,
                                                onPressed: () =>
                                                    launch(kSourceCodeBackend),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                child: Text('Frontend'),
                                              ),
                                              AppButton(
                                                label: 'Flutter/Dart',
                                                iconData:
                                                    MdiIcons.desktopClassic,
                                                onPressed: () =>
                                                    launch(kSourceCodeFrontend),
                                              ),
                                              AppButton(
                                                label: 'Storefront SDK',
                                                iconData: MdiIcons.tools,
                                                onPressed: () => launch(
                                                    kSourceCodeFrontendSDK),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Text(localization.close.toUpperCase()),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(localization.desktop + ' • BETA'),
                                  AppButton(
                                    label: 'macOS',
                                    iconData: MdiIcons.apple,
                                    onPressed: () => launch(kMacOSUrl),
                                  ),
                                  AppButton(
                                    label: 'Linux',
                                    iconData: MdiIcons.linux,
                                    onPressed: () => launch(kLinuxUrl),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text('Windows coming soon...'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Text(localization.mobile),
                                  ),
                                  AppButton(
                                    label: 'iOS',
                                    iconData: MdiIcons.apple,
                                    onPressed: () => launch(kAppleStoreUrl),
                                  ),
                                  AppButton(
                                    label: 'Android',
                                    iconData: MdiIcons.android,
                                    onPressed: () => launch(kGoogleStoreUrl),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
                if (state.isSelfHosted || !kReleaseMode) ...[
                  AppButton(
                    label: localization.healthCheck.toUpperCase(),
                    iconData: MdiIcons.shieldHalfFull,
                    color: Colors.green,
                    onPressed: () {
                      showDialog<HealthCheckDialog>(
                          context: context,
                          builder: (BuildContext context) {
                            return HealthCheckDialog();
                          });
                    },
                  ),
                  if (!state.account.disableAutoUpdate)
                    AppButton(
                      label: (state.account.isUpdateAvailable
                              ? localization.updateApp
                              : localization.forceUpdate)
                          .toUpperCase(),
                      iconData: MdiIcons.cloudDownload,
                      color: Colors.orange,
                      onPressed: () => _showUpdate(context),
                    ),
                ],
              ],
            ),
          ),
        );
      });
}

class ContactUsDialog extends StatefulWidget {
  @override
  _ContactUsDialogState createState() => _ContactUsDialogState();
}

class _ContactUsDialogState extends State<ContactUsDialog> {
  String _message = '';
  bool _includeLogs = false;
  bool _isSaving = false;

  void _sendMessage() {
    if (_message.isEmpty) {
      return;
    }

    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    setState(() => _isSaving = true);
    WebClient()
        .post(state.credentials.url + '/support/messages/send',
            state.credentials.token,
            data: json.encode({
              'message': _message,
              'send_logs': _includeLogs ? 'true' : '',
            }))
        .then((dynamic response) async {
      setState(() => _isSaving = false);
      await showDialog<MessageDialog>(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog(localization.yourMessageHasBeenReceived);
          });
      Navigator.pop(context);
    }).catchError((dynamic error) {
      print('error: $error');
      setState(() => _isSaving = false);
      showErrorDialog(context: context, message: '$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final user = state.user;

    return AlertDialog(
      contentPadding: EdgeInsets.all(25),
      title: Text(localization.contactUs),
      actions: <Widget>[
        if (_isSaving)
          Padding(
            padding: const EdgeInsets.all(12),
            child: CircularProgressIndicator(),
          ),
        if (!_isSaving)
          TextButton(
            child: Text(localization.cancel.toUpperCase()),
            onPressed: () => Navigator.pop(context),
          ),
        if (!_isSaving)
          TextButton(
            child: Text(localization.send.toUpperCase()),
            onPressed: () => _sendMessage(),
          ),
      ],
      content: SingleChildScrollView(
        child: Container(
          width: isMobile(context) ? null : 500,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: localization.from,
                  ),
                  initialValue: '${user.fullName} <${user.email}>',
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: localization.message,
                  ),
                  minLines: 4,
                  maxLines: 4,
                  onChanged: (value) => _message = value,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 10),
                SwitchListTile(
                  value: _includeLogs,
                  onChanged: (value) {
                    setState(() => _includeLogs = value);
                  },
                  title: Text(localization.includeRecentErrors),
                  activeColor: Theme.of(context).accentColor,
                ),
              ]),
        ),
      ),
    );
  }
}
