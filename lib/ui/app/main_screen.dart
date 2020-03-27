import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/ui/payment/refund/payment_refund_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        onInit: (Store<AppState> store) => store.dispatch(LoadClients()),
        builder: (BuildContext context, Store<AppState> store) {
          final uiState = store.state.uiState;
          final prefState = store.state.prefState;
          final mainRoute = '/' + uiState.mainRoute;
          final subRoute = '/' + uiState.subRoute;
          Widget screen = BlankScreen();

          bool isFullScreen = false;
          if (prefState.isDesktop) {
            if ([
                  InvoiceScreen.route,
                  QuoteScreen.route,
                  CreditScreen.route,
                ].contains(mainRoute) &&
                subRoute == '/edit') {
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
                screen = InvoiceEditScreen();
                break;
              case QuoteScreen.route:
                screen = QuoteEditScreen();
                break;
              case CreditScreen.route:
                screen = CreditEditScreen();
                break;
              default:
                switch (uiState.currentRoute) {
                  case DesignEditScreen.route:
                    screen = DesignEditScreen();
                    break;
                }
            }
          } else {
            switch (mainRoute) {
              case DashboardScreenBuilder.route:
                screen = Row(
                  children: <Widget>[
                    Expanded(
                      child: DashboardScreenBuilder(),
                      flex: 5,
                    ),
                    if (prefState.showHistory) ...[
                      _CustomDivider(),
                      HistoryDrawerBuilder(),
                    ],
                  ],
                );
                break;
              case ClientScreen.route:
                screen = EntityScreens(
                    entityType: EntityType.client,
                    listWidget: ClientScreenBuilder(),
                    viewWidget: ClientViewScreen(),
                    editWidget: ClientEditScreen());
                break;
              case ProductScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.product,
                  listWidget: ProductScreenBuilder(),
                  viewWidget: ProductViewScreen(),
                  editWidget: ProductEditScreen(),
                );
                break;
              case InvoiceScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.invoice,
                  listWidget: InvoiceScreenBuilder(),
                  viewWidget: InvoiceViewScreen(),
                  editWidget: InvoiceEditScreen(),
                  emailWidget: InvoiceEmailScreen(),
                );
                break;
              case PaymentScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.payment,
                  listWidget: PaymentScreenBuilder(),
                  viewWidget: PaymentViewScreen(),
                  editWidget: PaymentEditScreen(),
                  refundWidget: PaymentRefundScreen(),
                );
                break;
              case QuoteScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.quote,
                  listWidget: QuoteScreenBuilder(),
                  viewWidget: QuoteViewScreen(),
                  editWidget: QuoteEditScreen(),
                );
                break;
              case CreditScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.credit,
                  listWidget: CreditScreenBuilder(),
                  viewWidget: CreditViewScreen(),
                  editWidget: CreditEditScreen(),
                );
                break;
              case ProjectScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.project,
                  listWidget: ProjectScreenBuilder(),
                  viewWidget: ProjectViewScreen(),
                  editWidget: ProjectEditScreen(),
                );
                break;
              case TaskScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.task,
                  listWidget: TaskScreenBuilder(),
                  viewWidget: TaskViewScreen(),
                  editWidget: TaskEditScreen(),
                );
                break;
              case VendorScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.vendor,
                  listWidget: VendorScreenBuilder(),
                  viewWidget: VendorViewScreen(),
                  editWidget: VendorEditScreen(),
                );
                break;
              case ExpenseScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.expense,
                  listWidget: ExpenseScreenBuilder(),
                  viewWidget: ExpenseViewScreen(),
                  editWidget: ExpenseEditScreen(),
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
                    if (prefState.showHistory) ...[
                      _CustomDivider(),
                      HistoryDrawerBuilder(),
                    ],
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
              final history = historyList[isEditing ? 0 : 1];

              if (!isEditing) {
                store.dispatch(PopLastHistory());
              }

              switch (history.entityType) {
                case EntityType.dashboard:
                  store.dispatch(
                      ViewDashboard(navigator: Navigator.of(context)));
                  break;
                case EntityType.reports:
                  store.dispatch(ViewReports(navigator: Navigator.of(context)));
                  break;
                case EntityType.settings:
                  store
                      .dispatch(ViewSettings(navigator: Navigator.of(context)));
                  break;
                default:
                  viewEntityById(
                    context: context,
                    entityId: history.id,
                    entityType: history.entityType,
                    showError: false,
                  );
              }

              return false;
            },
            child: FocusTraversalGroup(
              policy: WidgetOrderTraversalPolicy(),
              child: Row(children: <Widget>[
                if (prefState.showMenu) ...[
                  MenuDrawerBuilder(),
                  _CustomDivider(),
                ],
                Expanded(child: screen),
              ]),
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
    }

    return Row(children: <Widget>[
      Expanded(
        child: SettingsScreenBuilder(),
        flex: 2,
      ),
      _CustomDivider(),
      Expanded(
        flex: 3,
        child: screen,
      ),
      if (prefState.showHistory) ...[
        _CustomDivider(),
        HistoryDrawerBuilder(),
      ],
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
    this.refundWidget,
  });

  final Widget listWidget;
  final Widget viewWidget;
  final Widget editWidget;
  final Widget emailWidget;
  final Widget refundWidget;
  final EntityType entityType;

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

    if (prefState.isModuleList || subRoute == 'email') {
      listFlex = 2;
      previewFlex = 3;
    } else if (!isPreviewShown) {
      listFlex = 5;
    }

    Widget child;
    if (subRoute == 'email') {
      child = emailWidget;
    } else if (subRoute == 'refund') {
      child = refundWidget;
    } else if (subRoute == 'edit') {
      child = editWidget;
    } else if ((entityUIState.selectedId ?? '').isNotEmpty &&
        state.getEntityMap(entityType).containsKey(entityUIState.selectedId)) {
      child = viewWidget;
    } else {
      child = BlankScreen(AppLocalization.of(context).noRecordSelected);
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: listWidget,
          flex: listFlex,
        ),
        _CustomDivider(),
        if (prefState.isModuleList || isPreviewShown)
          Expanded(
            flex: previewFlex,
            child: child,
          ),
        if (prefState.showHistory) ...[
          _CustomDivider(),
          HistoryDrawerBuilder(),
        ],
      ],
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen([this.message]);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isMobile(context),
      ),
      body: HelpText(message ?? ''),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //VerticalDivider(width: isDarkMode(context) ? 1 : .5, color: Colors.black),
    return Container(
      width: .5,
      height: double.infinity,
      color: Colors.black38,
    );
  }
}
