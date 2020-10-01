import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/blank_screen.dart';
import 'package:invoiceninja_flutter/ui/app/change_layout_banner.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_email_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/edit/payment_term_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/view/payment_term_view_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/token/token_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/webhook_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        //onInit: (Store<AppState> store) => store.dispatch(RefreshData()),
        builder: (BuildContext context, Store<AppState> store) {
      final state = store.state;
      final uiState = state.uiState;
      final prefState = state.prefState;
      final subRoute = '/' + uiState.subRoute;
      String mainRoute = '/' + uiState.mainRoute;
      Widget screen = BlankScreen();

      bool isFullScreen = false;
      bool isEdit = false;
      bool isEmail = false;

      if (prefState.isDesktop) {
        isEdit = subRoute == '/edit';
        isEmail = subRoute == '/email';
        if ([
              InvoiceScreen.route,
              QuoteScreen.route,
              CreditScreen.route,
              RecurringInvoiceScreen.route,
            ].contains(mainRoute) &&
            (isEdit || isEmail)) {
          isFullScreen = true;
        }
      }
      if (prefState.isNotMobile &&
          DesignEditScreen.route == uiState.currentRoute) {
        isFullScreen = true;
      }

      if (isFullScreen) {
        switch (mainRoute) {
          case InvoiceScreen.route:
            screen = isEmail ? InvoiceEmailScreen() : InvoiceEditScreen();
            break;
          case QuoteScreen.route:
            screen = isEmail ? QuoteEmailScreen() : QuoteEditScreen();
            break;
          case CreditScreen.route:
            screen = isEmail ? CreditEmailScreen() : CreditEditScreen();
            break;
          case RecurringInvoiceScreen.route:
            screen = RecurringInvoiceEditScreen();
            break;
          default:
            switch (uiState.currentRoute) {
              case DesignEditScreen.route:
                screen = DesignEditScreen();
                break;
              default:
                print('## ERROR: screen not defined in main_screen');
                break;
            }
        }
      } else {
        bool editingFilterEntity = false;
        if (prefState.showFilterSidebar &&
            uiState.filterEntityId != null &&
            subRoute == '/edit') {
          if (mainRoute == '/${uiState.filterEntityType}') {
            mainRoute = '/' + uiState.previousMainRoute;
            editingFilterEntity = true;
          }
        }

        switch (mainRoute) {
          case DashboardScreenBuilder.route:
            screen = Row(
              children: <Widget>[
                Expanded(
                  child: DashboardScreenBuilder(),
                  flex: 5,
                ),
                if (prefState.showHistory)
                  AppBorder(
                    child: HistoryDrawerBuilder(),
                    isLeft: true,
                  ),
              ],
            );
            break;
          case ClientScreen.route:
            screen = EntityScreens(
              entityType: EntityType.client,
              listWidget: ClientScreenBuilder(),
              viewWidget: ClientViewScreen(),
              editWidget: ClientEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case ProductScreen.route:
            screen = EntityScreens(
              entityType: EntityType.product,
              listWidget: ProductScreenBuilder(),
              viewWidget: ProductViewScreen(),
              editWidget: ProductEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case InvoiceScreen.route:
            screen = EntityScreens(
              entityType: EntityType.invoice,
              listWidget: InvoiceScreenBuilder(),
              viewWidget: InvoiceViewScreen(),
              editWidget: InvoiceEditScreen(),
              emailWidget: InvoiceEmailScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case RecurringInvoiceScreen.route:
            screen = EntityScreens(
              entityType: EntityType.recurringInvoice,
              listWidget: RecurringInvoiceScreenBuilder(),
              viewWidget: RecurringInvoiceViewScreen(),
              editWidget: RecurringInvoiceEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case PaymentScreen.route:
            screen = EntityScreens(
              entityType: EntityType.payment,
              listWidget: PaymentScreenBuilder(),
              viewWidget: PaymentViewScreen(),
              editWidget: PaymentEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case QuoteScreen.route:
            screen = EntityScreens(
              entityType: EntityType.quote,
              listWidget: QuoteScreenBuilder(),
              viewWidget: QuoteViewScreen(),
              editWidget: QuoteEditScreen(),
              emailWidget: QuoteEmailScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case CreditScreen.route:
            screen = EntityScreens(
              entityType: EntityType.credit,
              listWidget: CreditScreenBuilder(),
              viewWidget: CreditViewScreen(),
              editWidget: CreditEditScreen(),
              emailWidget: CreditEmailScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case ProjectScreen.route:
            screen = EntityScreens(
              entityType: EntityType.project,
              listWidget: ProjectScreenBuilder(),
              viewWidget: ProjectViewScreen(),
              editWidget: ProjectEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case TaskScreen.route:
            screen = EntityScreens(
              entityType: EntityType.task,
              listWidget: TaskScreenBuilder(),
              viewWidget: TaskViewScreen(),
              editWidget: TaskEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case VendorScreen.route:
            screen = EntityScreens(
              entityType: EntityType.vendor,
              listWidget: VendorScreenBuilder(),
              viewWidget: VendorViewScreen(),
              editWidget: VendorEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;
          case ExpenseScreen.route:
            screen = EntityScreens(
              entityType: EntityType.expense,
              listWidget: ExpenseScreenBuilder(),
              viewWidget: ExpenseViewScreen(),
              editWidget: ExpenseEditScreen(),
              editingFIlterEntity: editingFilterEntity,
            );
            break;

          case SettingsScreen.route:
            screen = SettingsScreens();
            break;
          case ReportsScreen.route:
            screen = Row(
              children: <Widget>[
                Expanded(
                  child: ReportsScreenBuilder(),
                  flex: 5,
                ),
                if (prefState.showHistory)
                  AppBorder(
                    child: HistoryDrawerBuilder(),
                    isLeft: true,
                  )
              ],
            );
            break;
        }
      }

      return WillPopScope(
        onWillPop: () async {
          final state = store.state;
          final historyList = state.historyList;

          if (historyList.length <= 1) {
            return true;
          }

          final isEditing = state.uiState.isEditing;
          final index = isEditing ? 0 : 1;
          HistoryRecord history;

          for (int i = index; i < historyList.length; i++) {
            final item = historyList[i];
            if ([
              EntityType.dashboard,
              EntityType.reports,
              EntityType.settings,
            ].contains(item.entityType)) {
              history = item;
              break;
            } else {
              if (item.id == null) {
                continue;
              }

              final entity =
                  state.getEntityMap(item.entityType)[item.id] as BaseEntity;
              if (entity == null || !entity.isActive) {
                continue;
              }

              history = item;
              break;
            }
          }

          if (!isEditing) {
            store.dispatch(PopLastHistory());
          }

          if (history == null) {
            return false;
          }

          switch (history.entityType) {
            case EntityType.dashboard:
              store.dispatch(ViewDashboard(navigator: Navigator.of(context)));
              break;
            case EntityType.reports:
              store.dispatch(ViewReports(navigator: Navigator.of(context)));
              break;
            case EntityType.settings:
              store.dispatch(ViewSettings(
                  navigator: Navigator.of(context), section: history.id));
              break;
            default:
              viewEntityById(
                context: context,
                entityId: history.id,
                entityType: history.entityType,
              );
          }

          return false;
        },
        child: SafeArea(
          child: FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: ChangeLayoutBanner(
              appLayout: prefState.appLayout,
              suggestedLayout: AppLayout.desktop,
              child: Row(children: <Widget>[
                if (prefState.showMenu) MenuDrawerBuilder(),
                Expanded(
                    child: AppBorder(
                  child: screen,
                  isLeft: prefState.showMenu,
                )),
              ]),
            ),
          ),
        ),
      );
    });
  }
}

class SettingsScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;

    Widget screen = BlankScreen();

    switch (uiState.subRoute) {
      case kSettingsCompanyDetails:
        screen = CompanyDetailsScreen();
        break;
      case kSettingsPaymentTerms:
        screen = PaymentTermScreenBuilder();
        break;
      case kSettingsPaymentTermEdit:
        screen = PaymentTermEditScreen();
        break;
      case kSettingsPaymentTermView:
        screen = PaymentTermViewScreen();
        break;
      case kSettingsUserDetails:
        screen = UserDetailsScreen();
        break;
      case kSettingsLocalization:
        screen = LocalizationScreen();
        break;
      case kSettingsOnlinePayments:
        screen = CompanyGatewayScreenBuilder();
        break;
      case kSettingsOnlinePaymentsView:
        screen = CompanyGatewayViewScreen();
        break;
      case kSettingsOnlinePaymentsEdit:
        screen = CompanyGatewayEditScreen();
        break;
      case kSettingsTaxSettings:
        screen = TaxSettingsScreen();
        break;
      case kSettingsTaxRates:
        screen = TaxRateScreenBuilder();
        break;
      case kSettingsTaxRatesView:
        screen = TaxRateViewScreen();
        break;
      case kSettingsTaxRatesEdit:
        screen = TaxRateEditScreen();
        break;
      case kSettingsProducts:
        screen = ProductSettingsScreen();
        break;
      case kSettingsIntegrations:
        screen = IntegrationSettingsScreen();
        break;
      case kSettingsImportExport:
        screen = ImportExportScreen();
        break;
      case kSettingsDeviceSettings:
        screen = DeviceSettingsScreen();
        break;
      case kSettingsGroupSettings:
        screen = GroupScreenBuilder();
        break;
      case kSettingsGroupSettingsView:
        screen = GroupViewScreen();
        break;
      case kSettingsGroupSettingsEdit:
        screen = GroupEditScreen();
        break;
      case kSettingsGeneratedNumbers:
        screen = GeneratedNumbersScreen();
        break;
      case kSettingsCustomFields:
        screen = CustomFieldsScreen();
        break;
      case kSettingsWorkflowSettings:
        screen = WorkflowSettingsScreen();
        break;
      case kSettingsInvoiceDesign:
        screen = InvoiceDesignScreen();
        break;
      case kSettingsClientPortal:
        screen = ClientPortalScreen();
        break;
      case kSettingsBuyNowButtons:
        screen = BuyNowButtonsScreen();
        break;
      case kSettingsEmailSettings:
        screen = EmailSettingsScreen();
        break;
      case kSettingsTemplatesAndReminders:
        screen = TemplatesAndRemindersScreen();
        break;
      case kSettingsCreditCardsAndBanks:
        screen = CreditCardsAndBanksScreen();
        break;
      case kSettingsDataVisualizations:
        screen = DataVisualizationsScreen();
        break;
      case kSettingsUserManagement:
        screen = UserScreenBuilder();
        break;
      case kSettingsUserManagementView:
        screen = UserViewScreen();
        break;
      case kSettingsUserManagementEdit:
        screen = UserEditScreen();
        break;
      case kSettingsCustomDesigns:
        screen = DesignScreenBuilder();
        break;
      case kSettingsCustomDesignsView:
        screen = DesignViewScreen();
        break;
      case kSettingsCustomDesignsEdit:
        screen = DesignEditScreen();
        break;
      case kSettingsAccountManagement:
        screen = AccountManagementScreen();
        break;
      case kSettingsTokens:
        screen = TokenScreenBuilder();
        break;
      case kSettingsTokenView:
        screen = TokenViewScreen();
        break;
      case kSettingsTokenEdit:
        screen = TokenEditScreen();
        break;
      case kSettingsWebhooks:
        screen = WebhookScreenBuilder();
        break;
      case kSettingsWebhookView:
        screen = WebhookViewScreen();
        break;
      case kSettingsWebhookEdit:
        screen = WebhookEditScreen();
        break;
    }

    return Row(children: <Widget>[
      Expanded(
        child: SettingsScreenBuilder(),
        flex: 2,
      ),
      Expanded(
        flex: 3,
        child: AppBorder(
          child: screen,
          isLeft: true,
        ),
      ),
      if (prefState.showHistory)
        AppBorder(
          child: HistoryDrawerBuilder(),
          isLeft: true,
        ),
    ]);
  }
}

class EntityScreens extends StatelessWidget {
  const EntityScreens({
    @required this.listWidget,
    @required this.editWidget,
    @required this.viewWidget,
    @required this.entityType,
    this.emailWidget,
    this.editingFIlterEntity,
  });

  final Widget listWidget;
  final Widget viewWidget;
  final Widget editWidget;
  final Widget emailWidget;
  final EntityType entityType;
  final bool editingFIlterEntity;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;
    final subRoute = uiState.subRoute;
    final entityUIState = state.getUIState(entityType);
    final isPreviewVisible = prefState.isPreviewVisible;
    final isPreviewShown =
        isPreviewVisible || (subRoute != 'view' && subRoute.isNotEmpty);

    int listFlex = 3;
    int previewFlex = 2;

    if (prefState.isModuleTable && !isPreviewShown) {
      listFlex = 5;
    } else if (subRoute == 'email') {
      listFlex = 2;
      previewFlex = 3;
    } else if (prefState.isMenuCollapsed) {
      listFlex += 1;
    }

    Widget child;
    if (subRoute == 'email') {
      child = emailWidget;
    } else if (subRoute == 'edit' && !editingFIlterEntity) {
      child = editWidget;
    } else if ((entityUIState.selectedId ?? '').isNotEmpty &&
        state.getEntityMap(entityType).containsKey(entityUIState.selectedId)) {
      child = viewWidget;
    } else {
      child = BlankScreen(AppLocalization.of(context).noRecordSelected);
    }

    Widget leftFilterChild;
    Widget topFilterChild;

    if (uiState.filterEntityType != null) {
      if (prefState.showFilterSidebar) {
        switch (uiState.filterEntityType) {
          case EntityType.client:
            leftFilterChild = editingFIlterEntity
                ? ClientEditScreen()
                : ClientViewScreen(isFilter: true);
            break;
          case EntityType.invoice:
            leftFilterChild = editingFIlterEntity
                ? InvoiceViewScreen()
                : InvoiceViewScreen(isFilter: true);
            break;
          case EntityType.quote:
            leftFilterChild = editingFIlterEntity
                ? QuoteViewScreen()
                : QuoteViewScreen(isFilter: true);
            break;
          case EntityType.credit:
            leftFilterChild = editingFIlterEntity
                ? CreditViewScreen()
                : CreditViewScreen(isFilter: true);
            break;
          case EntityType.payment:
            leftFilterChild = editingFIlterEntity
                ? PaymentEditScreen()
                : PaymentViewScreen(isFilter: true);
            break;
          case EntityType.user:
            leftFilterChild = editingFIlterEntity
                ? UserEditScreen()
                : UserViewScreen(isFilter: true);
            break;
          case EntityType.group:
            leftFilterChild = editingFIlterEntity
                ? GroupEditScreen()
                : GroupViewScreen(isFilter: true);
            break;
          case EntityType.companyGateway:
            leftFilterChild = editingFIlterEntity
                ? CompanyGatewayEditScreen()
                : CompanyGatewayViewScreen(isFilter: true);
            break;
        }
      }
    }

    topFilterChild = _EntityFilter(
      show: uiState.filterEntityType != null,
    );

    return Row(
      children: <Widget>[
        if (leftFilterChild != null)
          Expanded(
            child: leftFilterChild,
            flex: previewFlex,
          ),
        Expanded(
          child: ClipRRect(
            child: AppBorder(
              isLeft: leftFilterChild != null,
              child: topFilterChild == null
                  ? listWidget
                  : Column(
                      children: [
                        topFilterChild,
                        Expanded(
                          child: AppBorder(
                            isTop: uiState.filterEntityType != null,
                            child: listWidget,
                          ),
                        )
                      ],
                    ),
            ),
          ),
          flex: listFlex,
        ),
        if (prefState.isModuleList || isPreviewShown)
          Expanded(
            flex: previewFlex,
            child: AppBorder(
              child: child,
              isLeft: true,
            ),
          ),
        if (prefState.showHistory)
          AppBorder(
            child: HistoryDrawerBuilder(),
            isLeft: true,
          ),
      ],
    );
  }
}

class _EntityFilter extends StatelessWidget {
  const _EntityFilter({@required this.show});

  final bool show;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;

    final filterEntityType = uiState.filterEntityType;
    final routeEntityType = uiState.entityTypeRoute;

    final entityMap = state.getEntityMap(filterEntityType);
    final filterEntity =
        entityMap != null ? entityMap[uiState.filterEntityId] : null;
    final relatedTypes = filterEntityType?.relatedTypes
            ?.where((element) => state.company.isModuleEnabled(element))
            ?.toList() ??
        [];

    final backgroundColor =
        !state.prefState.enableDarkMode && state.hasAccentColor
            ? state.accentColor
            : Theme.of(context).cardColor;

    return Material(
      color: backgroundColor,
      child: AnimatedContainer(
        height: show ? 46 : 0,
        duration: Duration(milliseconds: kDefaultAnimationDuration),
        curve: Curves.easeInOutCubic,
        child: AnimatedOpacity(
          opacity: show ? 1 : 0,
          duration: Duration(milliseconds: kDefaultAnimationDuration),
          curve: Curves.easeInOutCubic,
          child: filterEntity == null
              ? Container(
                  color: backgroundColor,
                )
              : Row(
                  children: [
                    SizedBox(width: 4),
                    if (!state.prefState.showFilterSidebar)
                      IconButton(
                        tooltip: localization.showSidebar,
                        icon: Icon(Icons.chrome_reader_mode),
                        onPressed: () => store.dispatch(
                            UpdateUserPreferences(showFilterSidebar: true)),
                      ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 180),
                      child: FlatButton(
                        visualDensity: VisualDensity.compact,
                        child: Text(
                          '${localization.lookup('$filterEntityType')}  ›  ${filterEntity.listDisplayName}',
                          style: TextStyle(
                              fontSize: 17, color: state.headerTextColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        onPressed: () => viewEntity(
                          entity: filterEntity,
                          context: context,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: OverflowView.flexible(
                          spacing: 4,
                          children: <Widget>[
                            for (int i = 0; i < relatedTypes.length; i++)
                              FlatButton(
                                color: relatedTypes[i] == routeEntityType
                                    ? state.accentColor
                                    : null,
                                minWidth: 0,
                                visualDensity: VisualDensity.compact,
                                child: Text(localization
                                    .lookup('${relatedTypes[i].plural}')),
                                onPressed: () {
                                  viewEntitiesByType(
                                    context: context,
                                    entityType: relatedTypes[i],
                                    filterEntity: filterEntity,
                                  );
                                },
                              )
                          ],
                          builder: (context, remaining) {
                            return PopupMenuButton<EntityType>(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Text(localization.more),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                              initialValue: routeEntityType,
                              onSelected: (EntityType value) {
                                if (value == filterEntityType) {
                                  viewEntity(
                                    entity: filterEntity,
                                    context: context,
                                  );
                                } else {
                                  viewEntitiesByType(
                                    context: context,
                                    entityType: value,
                                    filterEntity: filterEntity,
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  filterEntityType.relatedTypes
                                      .sublist(relatedTypes.length - remaining)
                                      .where((element) => state.company
                                          .isModuleEnabled(element))
                                      .map((type) => PopupMenuItem<EntityType>(
                                            value: type,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: 75,
                                              ),
                                              child: Text(type ==
                                                      filterEntityType
                                                  ? localization.overview
                                                  : '${localization.lookup(type.plural)}'),
                                            ),
                                          ))
                                      .toList(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => store.dispatch(FilterByEntity(
                        entityId: uiState.filterEntityId,
                        entityType: uiState.filterEntityType,
                      )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
