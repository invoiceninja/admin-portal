import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
        //onInit: (Store<AppState> store) => store.dispatch(LoadClients()),
        builder: (BuildContext context, Store<AppState> store) {
          final uiState = store.state.uiState;
          final prefState = store.state.prefState;
          final mainRoute = '/' + uiState.mainRoute;
          final subRoute = '/' + uiState.subRoute;
          Widget screen = BlankScreen();

          if ([
                InvoiceScreen.route,
                QuoteScreen.route,
              ].contains(mainRoute) &&
              subRoute == '/edit' &&
              prefState.isDesktop) {
            switch (mainRoute) {
              case InvoiceScreen.route:
                screen = InvoiceEditScreen();
                break;
              case QuoteScreen.route:
                screen = QuoteEditScreen();
                break;
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
          }

          return Row(children: <Widget>[
            if (prefState.showMenu) ...[
              MenuDrawerBuilder(),
              _CustomDivider(),
            ],
            Expanded(child: screen),
          ]);
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
  });

  final Widget listWidget;
  final Widget viewWidget;
  final Widget editWidget;
  final Widget emailWidget;
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

    if (prefState.isModuleList) {
      listFlex = 2;
      previewFlex = 3;
    } else if (!isPreviewShown) {
      listFlex = 5;
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
            child: subRoute == 'email'
                ? emailWidget
                : subRoute == 'edit'
                    ? editWidget
                    : (entityUIState.selectedId ?? '').isNotEmpty
                        ? viewWidget
                        : BlankScreen(
                            AppLocalization.of(context).noRecordSelected),
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
