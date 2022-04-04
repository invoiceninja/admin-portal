// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/flutter_version.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/health_check_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/resources/cached_image.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/system/update_dialog.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

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
    final company = viewModel.selectedCompany;
    final inactiveColor = state.prefState
            .customColors[PrefState.THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR] ??
        '';

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
        : Image.asset('assets/images/icon.png', width: MenuDrawer.LOGO_WIDTH);

    Widget _companyListItem(
      CompanyEntity company, {
      bool showAccentColor = true,
    }) {
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
          if (showAccentColor &&
              userCompany.settings.accentColor != null &&
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
        height: kTopBottomBarHeight,
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
        if (companyId == 'logout') {
          viewModel.onLogoutTap(context);
        } else if (state.isLoading) {
          showMessageDialog(
              context: context, message: localization.waitForLoading);
          return;
        } else if (state.isSaving) {
          showMessageDialog(
              context: context, message: localization.waitForSaving);
          return;
        } else if (!state.isLoaded) {
          showMessageDialog(
              context: context, message: localization.waitForData);
          return;
        } else if (companyId == 'company') {
          viewModel.onAddCompany(context);
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
        : SizedBox(
            height: kTopBottomBarHeight,
            child: AppDropdownButton<String>(
              key: ValueKey(kSelectCompanyDropdownKey),
              value: viewModel.selectedCompanyIndex,
              selectedItemBuilder: (context) => state.companies
                  .map((company) =>
                      _companyListItem(company, showAccentColor: false))
                  .toList(),
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
                if (value == 'logout' && !state.isLoading && !state.isSaving) {
                  viewModel.onLogoutTap(context);
                } else if (state.isLoading) {
                  showMessageDialog(
                      context: context, message: localization.waitForLoading);
                  return;
                } else if (state.isSaving) {
                  showMessageDialog(
                      context: context, message: localization.waitForSaving);
                  return;
                } else if (!state.isLoaded) {
                  showMessageDialog(
                      context: context, message: localization.waitForData);
                  return;
                } else if (value == 'company') {
                  viewModel.onAddCompany(context);
                } else {
                  final index = int.parse(value);
                  viewModel.onCompanyChanged(
                      context, index, state.companies[index]);
                }
              },
            ),
          );

    return FocusTraversalGroup(
      child: Container(
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
                        color: inactiveColor.isNotEmpty
                            ? convertHexStringToColor(inactiveColor)
                            : Theme.of(context).cardColor,
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
                                Material(
                                  child: ListTile(
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
                                ),
                            if (state.company.isDisabled &&
                                state.userCompany.isAdmin)
                              if (state.isMenuCollapsed)
                                Tooltip(
                                  message: localization.companyDisabledWarning,
                                  child: ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                    onTap: () {
                                      // TODO once v4 is sunset change to ViewSettings
                                      launch(
                                          'https://invoiceninja.github.io/docs/hosted-activate/');
                                      /*
                                      store.dispatch(ViewSettings(
                                        section: kSettingsAccountManagement,
                                        company: company,
                                      ));
                                      */
                                    },
                                    leading: Icon(Icons.warning,
                                        color: Colors.orange),
                                  ),
                                )
                              else
                                Material(
                                  child: ListTile(
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
                                      // TODO once v4 is sunset change to ViewSettings
                                      launch(
                                          'https://invoiceninja.github.io/docs/hosted-activate/');

                                      /*
                                      store.dispatch(ViewSettings(
                                        section: kSettingsAccountManagement,
                                        company: company,
                                      ));
                                      */
                                    },
                                  ),
                                ),
                            if (state.userCompany.isOwner &&
                                !isPaidAccount(context) &&
                                !isApple())
                              Material(
                                child: Tooltip(
                                  message: state.isMenuCollapsed
                                      ? localization.upgrade
                                      : '',
                                  child: ListTile(
                                    dense: true,
                                    tileColor: Colors.green,
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.arrow_circle_up,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: state.isMenuCollapsed
                                        ? SizedBox()
                                        : Text(
                                            localization.upgrade,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                          ),
                                    onTap: () {
                                      if (isHosted(context)) {
                                        launch(
                                            state.userCompany.ninjaPortalUrl);
                                      } else {
                                        launch(kWhiteLabelUrl);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            DrawerTile(
                              company: company,
                              icon: getEntityIcon(EntityType.dashboard),
                              title: localization.dashboard,
                              onTap: () => viewEntitiesByType(
                                  entityType: EntityType.dashboard),
                              onLongPress: () =>
                                  store.dispatch(ViewDashboard(filter: '')),
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
                              entityType: EntityType.recurringInvoice,
                              icon: getEntityIcon(EntityType.recurringInvoice),
                              title: localization.recurringInvoices,
                              iconTooltip: localization.newRecurringInvoice,
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
                              entityType: EntityType.recurringExpense,
                              icon: getEntityIcon(EntityType.recurringExpense),
                              title: localization.recurringExpenses,
                            ),
                            DrawerTile(
                              company: company,
                              icon: getEntityIcon(EntityType.reports),
                              title: localization.reports,
                              onTap: () => viewEntitiesByType(
                                  entityType: EntityType.reports),
                            ),
                            DrawerTile(
                              company: company,
                              icon: getEntityIcon(EntityType.settings),
                              title: localization.settings,
                              onTap: () => viewEntitiesByType(
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

    String route;
    if (widget.title == localization.dashboard) {
      route = kDashboard;
    } else if (widget.title == localization.settings) {
      route = kSettings;
    } else if (widget.title == localization.reports) {
      route = kReports;
    } else if (widget.title == localization.kanban) {
      route = kKanban;
    } else {
      route = widget.entityType.name;
    }

    final isSelected =
        uiState.currentRoute.startsWith('/${toSnakeCase(route)}') &&
            (state.uiState.filterEntityType == null ||
                !state.prefState.isFilterVisible);

    final prefState = state.prefState;
    final inactiveColor = prefState
            .customColors[PrefState.THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR] ??
        '';
    final inactiveFontColor =
        prefState.customColors[PrefState.THEME_SIDEBAR_INACTIVE_FONT_COLOR] ??
            '';
    final activeColor = prefState
            .customColors[PrefState.THEME_SIDEBAR_ACTIVE_BACKGROUND_COLOR] ??
        '';
    final activeFontColor =
        prefState.customColors[PrefState.THEME_SIDEBAR_ACTIVE_FONT_COLOR] ?? '';

    Color color = Colors.transparent;
    Color textColor = Theme.of(context)
        .textTheme
        .bodyText1
        .color
        .withOpacity(isSelected ? 1 : .7);

    if (isSelected) {
      if (activeColor.isNotEmpty) {
        color = convertHexStringToColor(activeColor);
      } else {
        color = convertHexStringToColor(enableDarkMode
            ? kDefaultDarkSelectedColorMenu
            : kDefaultLightSelectedColorMenu);
      }
      if (activeFontColor.isNotEmpty) {
        textColor = convertHexStringToColor(activeFontColor);
      }
    } else {
      if (inactiveColor.isNotEmpty) {
        color = convertHexStringToColor(inactiveColor);
      }
      if (inactiveFontColor.isNotEmpty) {
        textColor = convertHexStringToColor(inactiveFontColor);
      }
    }

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
      color: color,
      child: Opacity(
        opacity: isSelected ? 1 : .8,
        child: ListTile(
          dense: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Icon(
              widget.icon,
              size: 22,
              color: textColor,
            ),
          ),
          title: state.isMenuCollapsed
              ? SizedBox()
              : Text(
                  widget.title,
                  key: ValueKey('menu_${widget.title}'),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 14,
                        color: textColor,
                      ),
                ),
          onTap: () {
            if (widget.entityType != null) {
              viewEntitiesByType(
                entityType: widget.entityType,
              );
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => _showUpdate(context),
                )
              else if (state.isHosted && hasUnconnectedStripeAccount(state))
                IconButton(
                  onPressed: () => _showConnectStripe(context),
                  icon: Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                )
              else if (kIsWeb &&
                  !state.dismissedNativeWarning &&
                  !state.prefState.hideDesktopWarning)
                IconButton(
                  onPressed: () => showMessageDialog(
                    context: context,
                    message: isMobileOS()
                        ? localization.recommendMobile
                        : localization.recommendDesktop,
                    onDismiss: () =>
                        store.dispatch(DismissNativeWarningPermanently()),
                    secondaryActions: [
                      TextButton(
                        autofocus: true,
                        onPressed: () {
                          final platform = getNativePlatform();
                          final url = getNativeAppUrl(platform);
                          launch(url);
                          Navigator.of(context).pop();
                        },
                        child: Text(localization.download.toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () => launch(kDocsPerformance),
                        child: Text(localization.learnMore.toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          store.dispatch(DismissNativeWarning());
                        },
                        child: Text(localization.remindMe.toUpperCase()),
                      ),
                    ],
                  ),
                  icon: Icon(
                    Icons.notification_important,
                    color: Colors.orange,
                  ),
                ),
            IconButton(
              icon: Icon(Icons.mail),
              onPressed: () => _showContactUs(context),
              tooltip: localization.contactUs,
            ),
            IconButton(
              icon: Icon(Icons.forum),
              onPressed: () => launch(kForumUrl),
              tooltip: localization.supportForum,
            ),
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                String url = kDocsUrl;
                final uiState = state.uiState;
                final subRoute = uiState.baseSubRoute;

                if (uiState.isInSettings) {
                  if (kAdvancedSettings.contains(subRoute)) {
                    url += '/advanced-settings/#$subRoute';
                  } else {
                    url += '/basic-settings/#$subRoute';
                  }
                } else if (uiState.mainRoute == kDashboard) {
                  url += '/introduction';
                } else if (uiState.mainRoute == kReports) {
                  url += '/$kReports';
                } else {
                  final route = state.uiState.entityTypeRoute.plural;
                  url += '/' + toSnakeCase(route).replaceAll('_', '-');
                }

                launch(url);
              },
              tooltip: localization.userGuide,
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              // prevent the modal from being stuck over the pdf
              onPressed: () => _showAbout(context),
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
            if (!kReleaseMode && state.lastError.isNotEmpty)
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
              state.prefState.isFilterVisible
          ? PopupMenuButton<String>(
              icon: isUpdateAvailable
                  ? Icon(Icons.warning,
                      color: Theme.of(context).colorScheme.secondary)
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
                        color: Theme.of(context).colorScheme.secondary,
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

void _showConnectStripe(BuildContext context) {
  final localization = AppLocalization.of(context);
  showMessageDialog(
      context: context,
      message: localization.unauthorizedStripeWarning,
      secondaryActions: [
        TextButton(
          child: Text(localization.viewSettings.toUpperCase()),
          onPressed: () {
            final context = navigatorKey.currentContext;
            Navigator.of(context).pop();
            final store = StoreProvider.of<AppState>(context);
            final gateway = getUnconnectedStripeAccount(store.state);
            editEntity(context: context, entity: gateway);
          },
        ),
      ]);
}

void _showAbout(BuildContext context) async {
  //final packageInfo = await PackageInfo.fromPlatform();
  final Store<AppState> store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);

  final appLegalese = '© ${DateTime.now().year} Invoice Ninja';
  final apppIcon = Image.asset(
    'assets/images/icon.png',
    width: 40.0,
    height: 40.0,
  );

  final daysActive = DateTime.now()
      .difference(convertTimestampToDate(state.company.createdAt))
      .inDays;

  showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return PointerInterceptor(
          child: AlertDialog(
            actions: [
              TextButton(
                child: Text(localization.viewLicenses.toUpperCase()),
                onPressed: () => showLicensePage(
                  context: context,
                  applicationName: 'Invoice Ninja v5',
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
                          secondaryActions: [
                            TextButton(
                              child: Text(localization.logout.toUpperCase()),
                              onPressed: () => store.dispatch(UserLogout()),
                            ),
                          ]);
                    },
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(state.user.fullName),
                    subtitle: Text(state.user.email),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
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
                                                  onPressed: () => launch(
                                                      kSourceCodeBackend),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: Text('Frontend'),
                                                ),
                                                AppButton(
                                                  label: 'Flutter/Dart',
                                                  iconData:
                                                      MdiIcons.desktopClassic,
                                                  onPressed: () => launch(
                                                      kSourceCodeFrontend),
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
                                    child:
                                        Text(localization.close.toUpperCase()),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(localization.desktop),
                                    AppButton(
                                      label: 'Windows',
                                      iconData: MdiIcons.microsoftWindows,
                                      onPressed: () => launch(kWindowsUrl),
                                    ),
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
                                    AppButton(
                                      label: 'F-Droid',
                                      iconData: MdiIcons.android,
                                      onPressed: () => launch(kGoogleFDroidUrl),
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
                  if (daysActive > 100)
                    AppButton(
                      label: localization.reviewApp.toUpperCase(),
                      iconData: Icons.star,
                      color: Colors.purple,
                      onPressed: () => launch(getRateAppURL(context)),
                    ),
                  SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      IconButton(
                        tooltip: 'Twitter',
                        onPressed: () => launch(kTwitterUrl),
                        icon: Icon(MdiIcons.twitter),
                      ),
                      IconButton(
                        tooltip: 'Facebook',
                        onPressed: () => launch(kFacebookUrl),
                        icon: Icon(MdiIcons.facebook),
                      ),
                      IconButton(
                        tooltip: 'GitHub',
                        onPressed: () => launch(kGitHubUrl),
                        icon: Icon(MdiIcons.github),
                      ),
                      IconButton(
                        tooltip: 'YouTube',
                        onPressed: () => launch(kYouTubeUrl),
                        icon: Icon(MdiIcons.youtube),
                      ),
                      IconButton(
                        tooltip: 'Slack',
                        onPressed: () => launch(kSlackUrl),
                        icon: Icon(MdiIcons.slack),
                      ),
                    ],
                  ),
                ],
              ),
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
              'platform': getPlatformLetter(),
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
      print('## ERROR: $error');
      setState(() => _isSaving = false);
      showErrorDialog(context: context, message: '$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final user = state.user;

    return PointerInterceptor(
      child: AlertDialog(
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
                    initialValue: '${user.fullName} • ${user.email}',
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: localization.message,
                    ),
                    minLines: 4,
                    maxLines: 4,
                    onChanged: (value) => _message = value,
                    keyboardType: TextInputType.multiline,
                  ),
                  if (state.isSelfHosted) ...[
                    SizedBox(height: 10),
                    SwitchListTile(
                      value: _includeLogs,
                      onChanged: (value) {
                        setState(() => _includeLogs = value);
                      },
                      title: Text(localization.includeRecentErrors),
                      activeColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ]
                ]),
          ),
        ),
      ),
    );
  }
}
