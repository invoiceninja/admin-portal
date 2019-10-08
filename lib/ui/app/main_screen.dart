import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/group/group_screen.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/ui/product/product_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/buy_now_buttons_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/credit_cards_and_banks_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/data_visualizations_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_list_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_design_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/localization_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/notifications_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/online_payments_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/products_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_rates_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details_vm.dart';
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
          final mainRoute = uiState.mainRoute;
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
                      listWidget: InvoiceScreen(),
                      viewWidget: InvoiceViewScreen(),
                      editWidget: InvoiceEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.payment,
                      listWidget: PaymentScreen(),
                      viewWidget: PaymentViewScreen(),
                      editWidget: PaymentEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.quote,
                      listWidget: QuoteScreen(),
                      viewWidget: QuoteViewScreen(),
                      editWidget: QuoteEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.project,
                      listWidget: ProjectScreen(),
                      viewWidget: ProjectViewScreen(),
                      editWidget: ProjectEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.task,
                      listWidget: TaskScreen(),
                      viewWidget: TaskViewScreen(),
                      editWidget: TaskEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.vendor,
                      listWidget: VendorScreen(),
                      viewWidget: VendorViewScreen(),
                      editWidget: VendorEditScreen(),
                    ),
                    EntityScreens(
                      entityType: EntityType.expense,
                      listWidget: ExpenseScreen(),
                      viewWidget: ExpenseViewScreen(),
                      editWidget: ExpenseEditScreen(),
                    ),
                    // TODO profile/time to see if this optimization helps
                    mainRoute == 'settings' ? SettingsScreens() : SizedBox(),
                    //SettingsScreens(),
                  ],
                ),
              ),
            ],
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
    final subRoute = uiState.subRoute;
    final index = subRoute.isEmpty
        ? kSettingsSections.length
        : kSettingsSections.indexOf(subRoute);

    return Row(
      children: <Widget>[
        Expanded(
          child: SettingsScreen(),
          flex: 2,
        ),
        VerticalDivider(width: isDarkMode(context) ? 1 : .5),
        Expanded(
          flex: 3,
          child: IndexedStack(
            index: index,
            children: <Widget>[
              CompanyDetailsScreen(),
              UserDetailsScreen(),
              LocalizationScreen(),
              OnlinePaymentsScreen(),
              TaxRatesScreen(),
              ProductSettingsScreen(),
              NotificationsSettingsScreen(),
              ImportExportScreen(),
              DeviceSettingsScreen(),
              GroupSettingsScreen(),
              GroupViewScreen(),
              GroupEditScreen(),
              InvoiceSettingsScreen(),
              InvoiceDesignScreen(),
              ClientPortalScreen(),
              BuyNowButtonsScreen(),
              EmailSettingsScreen(),
              TemplatesAndRemindersScreen(),
              CreditCardsAndBanksScreen(),
              DataVisualizationsScreen(),
              BlankScreen(),
            ],
          ),
        ),
      ],
    );
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
        VerticalDivider(width: isDarkMode(context) ? 1 : .5),
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
      appBar: AppBar(),
      body: HelpText(message ?? ''),
    );
  }
}
