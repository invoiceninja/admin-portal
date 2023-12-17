// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_title_bar.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/bank_account/edit/bank_account_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/bank_account/view/bank_account_view_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_email_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_screen.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view_vm.dart';
import 'package:invoiceninja_flutter/ui/schedule/edit/schedule_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/schedule/view/schedule_view_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/payment_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction/edit/transaction_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_screen.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/edit/transaction_rule_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/view/transaction_rule_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/blank_screen.dart';
import 'package:invoiceninja_flutter/ui/app/change_layout_banner.dart';
import 'package:invoiceninja_flutter/ui/app/confirm_email_vm.dart';
import 'package:invoiceninja_flutter/ui/app/desktop_session_timeout.dart';
import 'package:invoiceninja_flutter/ui/app/entity_top_filter.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/client/client_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_email_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/ui/expense_category/edit/expense_category_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/expense_category/view/expense_category_view_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/edit/payment_term_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/payment_term/view/payment_term_view_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/edit/recurring_expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_screen.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/view/recurring_expense_view_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/expense_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/task_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/subscription/subscription_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/subscription/view/subscription_view_vm.dart';
import 'package:invoiceninja_flutter/ui/task_status/edit/task_status_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/task_status/view/task_status_view_vm.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/token/token_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/webhook_screen_vm.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      final state = store.state;
      final uiState = state.uiState;
      final prefState = state.prefState;
      final subRoute = '/' + uiState.subRoute;
      String mainRoute = '/' + uiState.mainRoute;
      Widget screen = BlankScreen();

      // This can happen if the user's permissions are changed
      if (state.authState.isAuthenticated && state.companies.isEmpty) {
        return Container(
          child: LoadingIndicator(),
          color: Theme.of(context).cardColor,
        );
      } else if (!state.isUserConfirmed) {
        return ConfirmEmailBuilder();
      }

      bool showFilterSidebar = false;
      bool editingFilterEntity = false;
      if (prefState.isFilterVisible && uiState.filterEntityId != null) {
        showFilterSidebar = true;
        if (mainRoute == '/${uiState.filterEntityType}' &&
            subRoute == '/edit') {
          // Keep the current entity preview in place
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
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case ProductScreen.route:
          screen = EntityScreens(
            entityType: EntityType.product,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case InvoiceScreen.route:
          screen = EntityScreens(
            entityType: EntityType.invoice,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case RecurringInvoiceScreen.route:
          screen = EntityScreens(
            entityType: EntityType.recurringInvoice,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case PaymentScreen.route:
          screen = EntityScreens(
            entityType: EntityType.payment,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case QuoteScreen.route:
          screen = EntityScreens(
            entityType: EntityType.quote,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case CreditScreen.route:
          screen = EntityScreens(
            entityType: EntityType.credit,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case PurchaseOrderScreen.route:
          screen = EntityScreens(
            entityType: EntityType.purchaseOrder,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case ProjectScreen.route:
          screen = EntityScreens(
            entityType: EntityType.project,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case TaskScreen.route:
          screen = EntityScreens(
            entityType: EntityType.task,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case VendorScreen.route:
          screen = EntityScreens(
            entityType: EntityType.vendor,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case ExpenseScreen.route:
          screen = EntityScreens(
            entityType: EntityType.expense,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case TransactionScreen.route:
          screen = EntityScreens(
            entityType: EntityType.transaction,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case RecurringExpenseScreen.route:
          screen = EntityScreens(
            entityType: EntityType.recurringExpense,
            editingFilterEntity: editingFilterEntity,
          );
          break;
        case DocumentScreen.route:
          screen = EntityScreens(
            entityType: EntityType.document,
            editingFilterEntity: editingFilterEntity,
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
        default:
          print('## Error: main screen route $mainRoute not defined');
      }

      return PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          final state = store.state;
          final historyList = state.historyList;
          final isEditing = state.uiState.isEditing;
          final index = isEditing ? 0 : 1;
          HistoryRecord? history;

          if (state.uiState.isPreviewing) {
            store.dispatch(PopPreviewStack());
          }

          for (int i = index; i < historyList.length; i++) {
            final item = historyList[i];
            if ([
              EntityType.dashboard,
              EntityType.reports,
              EntityType.settings,
            ].contains(item.entityType)) {
              history = item;
              break;
            } else if (item.id == null) {
              history = item;
            } else {
              final entity =
                  state.getEntityMap(item.entityType)![item.id] as BaseEntity?;
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
            store.dispatch(ViewDashboard());
          } else {
            switch (history.entityType) {
              case EntityType.dashboard:
                store.dispatch(ViewDashboard());
                break;
              case EntityType.reports:
                store.dispatch(ViewReports());
                break;
              case EntityType.settings:
                store.dispatch(ViewSettings(
                  section: history.id,
                  company: state.company,
                  user: state.user,
                  tabIndex: 0,
                ));
                break;
              default:
                if ((history.id ?? '').isEmpty) {
                  viewEntitiesByType(
                      entityType: history.entityType, page: history.page);
                } else {
                  viewEntityById(
                    entityId: history.id,
                    entityType: history.entityType,
                    showError: false,
                  );
                }
            }
          }
        },
        child: DesktopSessionTimeout(
          child: SafeArea(
            child: FocusTraversalGroup(
              policy: ReadingOrderTraversalPolicy(),
              child: Column(
                children: [
                  if (isWindows()) AppTitleBar(),
                  Expanded(
                    child: ChangeLayoutBanner(
                      appLayout: prefState.appLayout,
                      suggestedLayout: AppLayout.desktop,
                      child: Row(children: <Widget>[
                        if (prefState.showMenu) MenuDrawerBuilder(),
                        Expanded(
                            child: AppBorder(
                          child: screen,
                          isLeft: prefState.showMenu &&
                              (!state.isFullScreen || showFilterSidebar),
                        )),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class EntityScreens extends StatelessWidget {
  const EntityScreens({
    required this.entityType,
    this.editingFilterEntity,
  });

  final EntityType entityType;
  final bool? editingFilterEntity;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;
    final mainRoute = '/' + uiState.mainRoute;
    final subRoute = uiState.subRoute;
    final isEmail = subRoute == 'email';
    final isPdf = subRoute == 'pdf';

    final isFullScreen = state.isFullScreen;
    bool isPreviewShown = prefState.isPreviewVisible;

    if (subRoute != 'view' && subRoute.isNotEmpty) {
      isPreviewShown = true;
    } else if (mainRoute == '/task' &&
        prefState.showKanban &&
        state.taskUIState.selectedId!.isEmpty) {
      isPreviewShown = false;
    }

    const previewFlex = 2;
    int listFlex = 3;

    if ((prefState.isModuleTable || mainRoute == '/task') && !isPreviewShown) {
      listFlex = 5;
    } else if (prefState.isMenuCollapsed) {
      listFlex += 1;
    }

    Widget? child;

    // TODO rmeove this once full width project editor is
    if (state.uiState.isEditing &&
        state.uiState.filterEntityType == EntityType.project &&
        state.uiState.currentRoute == ProjectEditScreen.route) {
      child = ProjectEditScreen();
    } else if (isFullScreen) {
      switch (mainRoute) {
        case InvoiceScreen.route:
          child = isPdf
              ? InvoicePdfScreen()
              : isEmail
                  ? InvoiceEmailScreen()
                  : InvoiceEditScreen();
          break;
        case QuoteScreen.route:
          child = isPdf
              ? QuotePdfScreen()
              : isEmail
                  ? QuoteEmailScreen()
                  : QuoteEditScreen();
          break;
        case CreditScreen.route:
          child = isPdf
              ? CreditPdfScreen()
              : isEmail
                  ? CreditEmailScreen()
                  : CreditEditScreen();
          break;
        case PurchaseOrderScreen.route:
          child = isPdf
              ? PurchaseOrderPdfScreen()
              : isEmail
                  ? PurchaseOrderEmailScreen()
                  : PurchaseOrderEditScreen();
          break;
        case RecurringInvoiceScreen.route:
          child = isPdf
              ? RecurringInvoicePdfScreen()
              : RecurringInvoiceEditScreen();
          break;
        case TaskScreen.route:
          child = TaskEditScreen();
          break;
        case ClientScreen.route:
          child = isPdf ? ClientPdfScreen() : ClientEditScreen();
          break;
        case VendorScreen.route:
          child = VendorEditScreen();
          break;
        case ExpenseScreen.route:
          child = ExpenseEditScreen();
          break;
        case RecurringExpenseScreen.route:
          child = RecurringExpenseEditScreen();
          break;
        default:
          switch (uiState.currentRoute) {
            case DesignEditScreen.route:
              child = DesignEditScreen();
              break;
            default:
              print('## ERROR: screen not defined in main_screen');
              break;
          }
      }
    } else if (subRoute == 'edit') {
      final editEntityType =
          editingFilterEntity! ? uiState.filterEntityType : entityType;
      switch (editEntityType) {
        case EntityType.client:
          child = ClientEditScreen();
          break;
        case EntityType.product:
          child = ProductEditScreen();
          break;
        case EntityType.invoice:
          child = InvoiceEditScreen();
          break;
        case EntityType.recurringInvoice:
          child = RecurringInvoiceEditScreen();
          break;
        case EntityType.payment:
          child = PaymentEditScreen();
          break;
        case EntityType.quote:
          child = QuoteEditScreen();
          break;
        case EntityType.credit:
          child = CreditEditScreen();
          break;
        case EntityType.purchaseOrder:
          child = PurchaseOrderEditScreen();
          break;
        case EntityType.project:
          child = ProjectEditScreen();
          break;
        case EntityType.task:
          child = TaskEditScreen();
          break;
        case EntityType.vendor:
          child = VendorEditScreen();
          break;
        case EntityType.expense:
          child = ExpenseEditScreen();
          break;
        case EntityType.recurringExpense:
          child = RecurringExpenseEditScreen();
          break;
        case EntityType.transaction:
          child = TransactionEditScreen();
          break;
        case EntityType.document:
          child = DocumentEditScreen();
          break;
        default:
          print('## Edit screen not defined for $entityType');
          break;
      }
    } else {
      final previewStack = uiState.previewStack;
      final previewEntityType =
          previewStack.isEmpty ? entityType : previewStack.last;
      final entityUIState = state.getUIState(previewEntityType)!;

      if ((entityUIState.selectedId ?? '').isEmpty ||
          !state
              .getEntityMap(previewEntityType)!
              .containsKey(entityUIState.selectedId!)) {
        child = BlankScreen();
      } else {
        switch (previewEntityType) {
          case EntityType.client:
            child = ClientViewScreen();
            break;
          case EntityType.product:
            child = ProductViewScreen();
            break;
          case EntityType.invoice:
            child = InvoiceViewScreen();
            break;
          case EntityType.recurringInvoice:
            child = RecurringInvoiceViewScreen();
            break;
          case EntityType.payment:
            child = PaymentViewScreen();
            break;
          case EntityType.quote:
            child = QuoteViewScreen();
            break;
          case EntityType.credit:
            child = CreditViewScreen();
            break;
          case EntityType.purchaseOrder:
            child = PurchaseOrderViewScreen();
            break;
          case EntityType.project:
            child = ProjectViewScreen();
            break;
          case EntityType.task:
            child = TaskViewScreen();
            break;
          case EntityType.vendor:
            child = VendorViewScreen();
            break;
          case EntityType.expense:
            child = ExpenseViewScreen();
            break;
          case EntityType.user:
            child = UserViewScreen();
            break;
          case EntityType.group:
            child = GroupViewScreen();
            break;
          case EntityType.paymentLink:
            child = SubscriptionViewScreen();
            break;
          case EntityType.companyGateway:
            child = CompanyGatewayViewScreen();
            break;
          case EntityType.expenseCategory:
            child = ExpenseCategoryViewScreen();
            break;
          case EntityType.taskStatus:
            child = TaskStatusViewScreen();
            break;
          case EntityType.recurringExpense:
            child = RecurringExpenseViewScreen();
            break;
          case EntityType.transaction:
            child = TransactionViewScreen();
            break;
          case EntityType.bankAccount:
            child = BankAccountViewScreen();
            break;
          case EntityType.transactionRule:
            child = TransactionRuleViewScreen();
            break;
          case EntityType.document:
            child = DocumentViewScreen();
            break;
          default:
            print('## View screen not defined for $previewEntityType');
        }
      }
    }

    Widget? leftFilterChild;
    Widget topFilterChild;

    if (uiState.filterEntityType != null) {
      if (prefState.isFilterVisible) {
        switch (uiState.filterEntityType) {
          case EntityType.client:
            leftFilterChild = ClientViewScreen(isFilter: true);
            break;
          case EntityType.invoice:
            leftFilterChild = InvoiceViewScreen(isFilter: true);
            break;
          case EntityType.quote:
            leftFilterChild = QuoteViewScreen(isFilter: true);
            break;
          case EntityType.credit:
            leftFilterChild = CreditViewScreen(isFilter: true);
            break;
          case EntityType.purchaseOrder:
            leftFilterChild = PurchaseOrderViewScreen(isFilter: true);
            break;
          case EntityType.payment:
            leftFilterChild = PaymentViewScreen(isFilter: true);
            break;
          case EntityType.user:
            leftFilterChild = UserViewScreen(isFilter: true);
            break;
          case EntityType.group:
            leftFilterChild = GroupViewScreen(isFilter: true);
            break;
          case EntityType.paymentLink:
            leftFilterChild = SubscriptionViewScreen(isFilter: true);
            break;
          case EntityType.companyGateway:
            leftFilterChild = CompanyGatewayViewScreen(isFilter: true);
            break;
          case EntityType.recurringInvoice:
            leftFilterChild = RecurringInvoiceViewScreen(isFilter: true);
            break;
          case EntityType.expenseCategory:
            leftFilterChild = ExpenseCategoryViewScreen(isFilter: true);
            break;
          case EntityType.taskStatus:
            leftFilterChild = TaskStatusViewScreen(isFilter: true);
            break;
          case EntityType.vendor:
            leftFilterChild = VendorViewScreen(isFilter: true);
            break;
          case EntityType.project:
            leftFilterChild = ProjectViewScreen(isFilter: true);
            break;
          case EntityType.design:
            leftFilterChild = DesignViewScreen(isFilter: true);
            break;
          case EntityType.transaction:
            leftFilterChild = TransactionViewScreen(isFilter: true);
            break;
          case EntityType.expense:
            leftFilterChild = ExpenseViewScreen(isFilter: true);
            break;
          case EntityType.bankAccount:
            leftFilterChild = BankAccountViewScreen(isFilter: true);
            break;
          case EntityType.transactionRule:
            leftFilterChild = TransactionRuleViewScreen(isFilter: true);
            break;
          case EntityType.recurringExpense:
            leftFilterChild = RecurringExpenseViewScreen(isFilter: true);
            break;
          default:
            print(
                'Error: filter view not implemented for ${uiState.filterEntityType}');
        }
      }
    }

    topFilterChild = EntityTopFilter(
      show: uiState.filterEntityType != null,
    );

    Widget? listWidget;
    if (!isFullScreen) {
      switch (entityType) {
        case EntityType.client:
          listWidget = ClientScreenBuilder();
          break;
        case EntityType.product:
          listWidget = ProductScreenBuilder();
          break;
        case EntityType.invoice:
          listWidget = InvoiceScreenBuilder();
          break;
        case EntityType.recurringInvoice:
          listWidget = RecurringInvoiceScreenBuilder();
          break;
        case EntityType.payment:
          listWidget = PaymentScreenBuilder();
          break;
        case EntityType.quote:
          listWidget = QuoteScreenBuilder();
          break;
        case EntityType.credit:
          listWidget = CreditScreenBuilder();
          break;
        case EntityType.purchaseOrder:
          listWidget = PurchaseOrderScreenBuilder();
          break;
        case EntityType.project:
          listWidget = ProjectScreenBuilder();
          break;
        case EntityType.task:
          listWidget = TaskScreenBuilder();
          break;
        case EntityType.vendor:
          listWidget = VendorScreenBuilder();
          break;
        case EntityType.expense:
          listWidget = ExpenseScreenBuilder();
          break;
        case EntityType.recurringExpense:
          listWidget = RecurringExpenseScreenBuilder();
          break;
        case EntityType.transaction:
          listWidget = TransactionScreenBuilder();
          break;
        case EntityType.document:
          listWidget = DocumentScreenBuilder();
          break;
        default:
          print('## ERROR: list widget not implemented for $entityType');
          break;
      }
    }

    return Row(
      children: <Widget>[
        if (leftFilterChild != null)
          Expanded(
            child: leftFilterChild,
            flex: previewFlex,
          ),
        if (!isFullScreen)
          Expanded(
            child: ClipRRect(
              child: AppBorder(
                isLeft: leftFilterChild != null,
                child: prefState.isFilterVisible
                    ? listWidget
                    : Column(
                        children: [
                          if (prefState.isViewerFullScreen(
                              state.uiState.filterEntityType))
                            SizedBox(
                              height: 360,
                              child: topFilterChild,
                            )
                          else
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
        if ((prefState.isModuleList && mainRoute != '/task') || isPreviewShown)
          Expanded(
            flex: isFullScreen ? (listFlex + previewFlex) : previewFlex,
            child: AppBorder(
              isLeft: true,
              child: child,
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
      case kSettingsPaymentSettings:
        screen = PaymentsSettingsScreen();
        break;
      case kSettingsCompanyGateways:
        screen = CompanyGatewayScreenBuilder();
        break;
      case kSettingsCompanyGatewaysView:
        screen = CompanyGatewayViewScreen();
        break;
      case kSettingsCompanyGatewaysEdit:
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
      case kSettingsTaskStatuses:
        screen = TaskStatusScreenBuilder();
        break;
      case kSettingsTaskStatusView:
        screen = TaskStatusViewScreen();
        break;
      case kSettingsTaskStatusEdit:
        screen = TaskStatusEditScreen();
        break;
      case kSettingsProducts:
        screen = ProductSettingsScreen();
        break;
      case kSettingsTasks:
        screen = TaskSettingsScreen();
        break;
      case kSettingsExpenses:
        screen = ExpenseSettingsScreen();
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
      case kSettingsPaymentLinks:
        screen = SubscriptionScreenBuilder();
        break;
      case kSettingsPaymentLinksView:
        screen = SubscriptionViewScreen();
        break;
      case kSettingsPaymentLinksEdit:
        screen = SubscriptionEditScreen();
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
      case kSettingsExpenseCategories:
        screen = ExpenseCategoryScreenBuilder();
        break;
      case kSettingsExpenseCategoryView:
        screen = ExpenseCategoryViewScreen();
        break;
      case kSettingsExpenseCategoryEdit:
        screen = ExpenseCategoryEditScreen();
        break;
      case kSettingsBankAccounts:
        screen = BankAccountScreenBuilder();
        break;
      case kSettingsBankAccountsView:
        screen = BankAccountViewScreen();
        break;
      case kSettingsBankAccountsEdit:
        screen = BankAccountEditScreen();
        break;
      case kSettingsTransactionRules:
        screen = TransactionRuleScreenBuilder();
        break;
      case kSettingsTransactionRulesView:
        screen = TransactionRuleViewScreen();
        break;
      case kSettingsTransactionRulesEdit:
        screen = TransactionRuleEditScreen();
        break;
      case kSettingsSchedules:
        screen = ScheduleScreenBuilder();
        break;
      case kSettingsSchedulesView:
        screen = ScheduleViewScreen();
        break;
      case kSettingsSchedulesEdit:
        screen = ScheduleEditScreen();
        break;
      default:
        print(
            '## Error: main screen settings route ${uiState.subRoute} not defined');
    }

    return Row(children: <Widget>[
      if (!state.isFullScreen)
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
