import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
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
        onInit: (Store<AppState> store) => store.dispatch(LoadDashboard()),
        builder: (BuildContext context, Store<AppState> store) {
          final uiState = store.state.uiState;
          final mainRoute = '/' + uiState.mainRoute;
          Widget screen = BlankScreen();

          switch (mainRoute) {
            case DashboardScreenBuilder.route:
              screen = Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardScreenBuilder(),
                    flex: 5,
                  ),
                  if (uiState.isHistoryVisible &&
                      uiState.historySidebarMode == AppSidebarMode.visible) ...[
                    _CustomDivider(),
                    Expanded(
                      child: HistoryDrawerBuilder(),
                      flex: 2,
                    )
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
              );
              break;
            case PaymentScreen.route:
              screen = EntityScreens(
                entityType: EntityType.payment,
                listWidget: PaymentScreenBuilder(),
                viewWidget: PaymentViewScreen(),
                editWidget: PaymentEditScreen(),
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
          }

          return Row(children: <Widget>[
            if (uiState.isMenuVisible &&
                uiState.menuSidebarMode == AppSidebarMode.visible) ...[
              MenuDrawerBuilder(),
              _CustomDivider(),
            ],
            Expanded(child: screen),
          ]);

          /*
          int mainIndex = 0;
          
          // TODO use constants array to lookup index
          if (mainRoute == EntityType.client.name) {
            mainIndex = 1;
          } else if (mainRoute == EntityType.product.name) {
            mainIndex = 2;
          } else if (mainRoute == EntityType.invoice.name) {
            mainIndex = 3;
          } else if (mainRoute == EntityType.payment.name) {
            mainIndex = 4;
          } else if (mainRoute == EntityType.quote.name) {
            mainIndex = 5;
          } else if (mainRoute == EntityType.project.name) {
            mainIndex = 6;
          } else if (mainRoute == EntityType.task.name) {
            mainIndex = 7;
          } else if (mainRoute == EntityType.vendor.name) {
            mainIndex = 8;
          } else if (mainRoute == EntityType.expense.name) {
            mainIndex = 9;
          } else if (mainRoute == 'settings') {
            mainIndex = 10;
          }

          return Row(
            children: <Widget>[
              if (uiState.isMenuVisible) AppDrawerBuilder(),
              if (uiState.isMenuVisible)
                VerticalDivider(width: isDarkMode(context) ? 1 : .5),
              Expanded(
                child: IndexedStack(
                  index: mainIndex,
                  children: <Widget>[
                    DashboardScreen(),
                    EntityScreens(
                        entityType: EntityType.client,
                        listWidget: ClientScreenBuilder(),
                        viewWidget: ClientViewScreen(),
                        editWidget: ClientEditScreen()),
                    EntityScreens(
                      entityType: EntityType.product,
                      listWidget: ProductScreenBuilder(),
                      viewWidget: ProductViewScreen(),
                      editWidget: ProductEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.invoice,
                      listWidget: InvoiceScreenBuilder(),
                      viewWidget: InvoiceViewScreen(),
                      editWidget: InvoiceEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.payment,
                      listWidget: PaymentScreenBuilder(),
                      viewWidget: PaymentViewScreen(),
                      editWidget: PaymentEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.quote,
                      listWidget: QuoteScreenBuilder(),
                      viewWidget: QuoteViewScreen(),
                      editWidget: QuoteEditScreen(),
                    ),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    /*
                    EntityScreens(
                      entityType: EntityType.project,
                      listWidget: ProjectScreenBuilder(),
                      viewWidget: ProjectViewScreen(),
                      editWidget: ProjectEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.task,
                      listWidget: TaskScreenBuilder(),
                      viewWidget: TaskViewScreen(),
                      editWidget: TaskEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.vendor,
                      listWidget: VendorScreenBuilder(),
                      viewWidget: VendorViewScreen(),
                      editWidget: VendorEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.expense,
                      listWidget: ExpenseScreenBuilder(),
                      viewWidget: ExpenseViewScreen(),
                      editWidget: ExpenseEditScreen(),
                    ),
                     */
                    SettingsScreens(),
                  ],
                ),
              ),
            ],
          );          
           */
        });
  }
}

class SettingsScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;

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
      case kSettingsNotifications:
        screen = NotificationsSettingsScreen();
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
      if (uiState.isHistoryVisible &&
          uiState.historySidebarMode == AppSidebarMode.visible) ...[
        _CustomDivider(),
        Expanded(
          child: HistoryDrawerBuilder(),
          flex: 2,
        )
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
  });

  final Widget listWidget;
  final Widget viewWidget;
  final Widget editWidget;
  final EntityType entityType;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final subRoute = uiState.subRoute;
    final entityUIState = state.getUIState(entityType);

    return Row(
      children: <Widget>[
        Expanded(
          child: listWidget,
          flex: 2,
        ),
        _CustomDivider(),
        Expanded(
          flex: 3,
          child: IndexedStack(
            index: subRoute == 'edit' ? 1 : 0,
            children: <Widget>[
              (entityUIState.selectedId ?? '').isNotEmpty
                  ? viewWidget
                  : BlankScreen(AppLocalization.of(context).noRecordSelected),
              editWidget,
            ],
          ),
        ),
        if (uiState.isHistoryVisible &&
            uiState.historySidebarMode == AppSidebarMode.visible) ...[
          _CustomDivider(),
          Expanded(
            child: HistoryDrawerBuilder(),
            flex: 2,
          )
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
