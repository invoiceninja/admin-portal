import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_screen.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen.dart';
import 'package:invoiceninja_flutter/ui/token/token_screen.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/ui/webhook/webhook_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

// STARTER: import - do not remove comment
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';

import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';

import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

class PersistUI {}

class PersistPrefs {}

class PersistData {}

class PersistStatic {}

class RefreshClient {
  RefreshClient(this.clientId);

  final String clientId;
}

class SwitchListTableLayout implements PersistUI, PersistPrefs {}

class PopLastHistory {}

class ViewMainScreen {
  ViewMainScreen({this.navigator, this.addDelay = false});

  NavigatorState navigator;

  // This is needed to workaround around a "Duplicate GlobalKey detected
  // in widget tree." error when changing layouts in the settings
  bool addDelay;
}

class StartLoading {}

class StopLoading {}

class StartSaving {}

class StopSaving {}

class ServerVersionUpdated {
  ServerVersionUpdated({this.version});

  final String version;
}

class LoadStaticSuccess implements PersistStatic {
  LoadStaticSuccess({this.data});

  final StaticDataEntity data;
}

class UpdateUserPreferences implements PersistPrefs {
  UpdateUserPreferences({
    this.appLayout,
    this.moduleLayout,
    this.sidebar,
    this.enableDarkMode,
    this.requireAuthentication,
    this.longPressSelectionIsDefault,
    this.isPreviewVisible,
    this.accentColor,
    this.menuMode,
    this.historyMode,
    this.showFilterSidebar,
    this.alwaysShowFilterSidebar,
    this.rowsPerPage,
  });

  final AppLayout appLayout;
  final ModuleLayout moduleLayout;
  final AppSidebar sidebar;
  final AppSidebarMode menuMode;
  final AppSidebarMode historyMode;
  final bool enableDarkMode;
  final bool longPressSelectionIsDefault;
  final bool requireAuthentication;
  final bool isPreviewVisible;
  final bool showFilterSidebar;
  final bool alwaysShowFilterSidebar;
  final String accentColor;
  final int rowsPerPage;
}

class LoadAccountSuccess implements StopLoading {
  LoadAccountSuccess({
    @required this.completer,
    @required this.loginResponse,
  });

  final Completer completer;
  final LoginResponse loginResponse;
}

class RefreshData implements StartLoading {
  RefreshData({
    this.completer,
    this.clearData = false,
    this.includeStatic = false,
  });

  final Completer completer;
  final bool clearData;
  final bool includeStatic;
}

class PreviewEntity {
  const PreviewEntity({
    this.entityType,
    this.entityId,
  });

  final String entityId;
  final EntityType entityType;
}

class ClearPreviewStack {}

class PopPreviewStack {}

class ClearData {}

class RefreshDataFailure implements StopLoading {
  const RefreshDataFailure(this.error);

  final dynamic error;
}

class ClearLastError {}

class DiscardChanges {}

class ClearEntityFilter {}

class ClearEntitySelection {
  ClearEntitySelection({this.entityType});

  final EntityType entityType;
}

class FilterByEntity implements PersistUI {
  FilterByEntity({
    @required this.entityId,
    @required this.entityType,
    this.clearSelection = false,
  });

  final String entityId;
  final EntityType entityType;
  final bool clearSelection;
}

class FilterCompany implements PersistUI {
  FilterCompany(this.filter);

  final String filter;
}

abstract class AbstractNavigatorAction {
  AbstractNavigatorAction({this.navigator});

  final NavigatorState navigator;

  BuildContext get context => navigator.overlay.context ?? navigator.context;
}

void filterByEntity({
  @required BuildContext context,
  @required BaseEntity entity,
}) {
  if (entity.isNew) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  store.dispatch(FilterByEntity(
    entityId: entity.id,
    entityType: entity.entityType,
  ));
}

void viewEntitiesByType({
  @required BuildContext context,
  @required EntityType entityType,
  BaseEntity filterEntity,
}) {
  final store = StoreProvider.of<AppState>(context);
  final uiState = store.state.uiState;
  final navigator = Navigator.of(context);
  dynamic action;

  checkForChanges(
      store: store,
      context: context,
      callback: () {
        if (filterEntity != null) {
          if (uiState.filterEntityType != filterEntity.entityType ||
              uiState.filterEntityId != filterEntity.id) {
            store.dispatch(ClearEntitySelection(entityType: entityType));
            store.dispatch(FilterByEntity(
              entityId: filterEntity.id,
              entityType: filterEntity.entityType,
            ));
          }
        } else if (uiState.filterEntityType != null) {
          store.dispatch(ClearEntityFilter());
        }

        if (uiState.previewStack.isNotEmpty) {
          store.dispatch(ClearPreviewStack());
        }

        switch (entityType) {
          case EntityType.dashboard:
            action = ViewDashboard(navigator: navigator);
            break;
          case EntityType.reports:
            action = ViewReports(navigator: navigator);
            break;
          case EntityType.settings:
            action = ViewSettings(
                navigator: navigator, company: store.state.company);
            break;
          case EntityType.client:
            action = ViewClientList(navigator: navigator);
            break;
          case EntityType.user:
            action = ViewUserList(navigator: navigator);
            break;
          case EntityType.project:
            action = ViewProjectList(navigator: navigator);
            break;
          case EntityType.taxRate:
            action = ViewTaxRateList(navigator: navigator);
            break;
          case EntityType.companyGateway:
            action = ViewCompanyGatewayList(navigator: navigator);
            break;
          case EntityType.invoice:
            action = ViewInvoiceList(navigator: navigator);
            break;
          case EntityType.quote:
            action = ViewQuoteList(navigator: navigator);
            break;
          case EntityType.vendor:
            action = ViewVendorList(navigator: navigator);
            break;
          case EntityType.product:
            action = ViewProductList(navigator: navigator);
            break;
          case EntityType.task:
            action = ViewTaskList(navigator: navigator);
            break;
          case EntityType.expense:
            action = ViewExpenseList(navigator: navigator);
            break;
          case EntityType.payment:
            action = ViewPaymentList(navigator: navigator);
            break;
          case EntityType.group:
            action = ViewGroupList(navigator: navigator);
            break;
          // STARTER: view list - do not remove comment
          case EntityType.taskStatus:
            store.dispatch(ViewTaskStatusList(navigator: navigator));
            break;

          case EntityType.expenseCategory:
            store.dispatch(ViewExpenseCategoryList(navigator: navigator));
            break;

          case EntityType.recurringInvoice:
            store.dispatch(ViewRecurringInvoiceList(navigator: navigator));
            break;
          case EntityType.webhook:
            store.dispatch(ViewWebhookList(navigator: navigator));
            break;
          case EntityType.token:
            store.dispatch(ViewTokenList(navigator: navigator));
            break;
          case EntityType.paymentTerm:
            store.dispatch(ViewPaymentTermList(navigator: navigator));
            break;
          case EntityType.design:
            action = ViewDesignList(navigator: navigator);
            break;
          case EntityType.credit:
            action = ViewCreditList(navigator: navigator);
            break;
        }

        if (action != null) {
          store.dispatch(action);
        }
      });
}

void viewEntity(
        {BuildContext context,
        BaseEntity entity,
        bool force = false,
        bool addToStack = false,
        BaseEntity filterEntity}) =>
    viewEntityById(
      context: context,
      entityId: entity.id,
      entityType: entity.entityType,
      force: force,
      addToStack: addToStack,
      filterEntity: filterEntity,
    );

void viewEntityById({
  BuildContext context,
  String entityId,
  EntityType entityType,
  bool force = false,
  bool showError = true,
  bool addToStack = false,
  BaseEntity filterEntity,
}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final navigator = Navigator.of(context);
  final uiState = store.state.uiState;

  checkForChanges(
      store: store,
      context: context,
      force: force,
      callback: () {
        if (addToStack) {
          store.dispatch(PreviewEntity(
            entityId: entityId,
            entityType: entityType,
          ));
          return;
        } else if (state.uiState.previewStack.isNotEmpty) {
          store.dispatch(ClearPreviewStack());
        }

        if (filterEntity != null &&
            (uiState.filterEntityType != filterEntity.entityType ||
                uiState.filterEntityId != filterEntity.id)) {
          store.dispatch(ClearEntitySelection(entityType: entityType));
          store.dispatch(FilterByEntity(
            entityId: filterEntity.id,
            entityType: filterEntity.entityType,
          ));
          // If the user selects a different entity of the same type as the current
          // filter then we clear the selection so new records are auto-selected
        } else if (uiState.filterEntityType != null &&
            uiState.filterEntityId != entityId &&
            uiState.filterEntityType == entityType) {
          store.dispatch(FilterByEntity(
            entityId: entityId,
            entityType: entityType,
            clearSelection: true,
          ));
        }

        if (entityId != null &&
            showError &&
            !store.state.getEntityMap(entityType).containsKey(entityId)) {
          showErrorDialog(
              context: context,
              message: AppLocalization.of(context).failedToFindRecord);
          return;
        }

        if (!state.prefState.isPreviewVisible &&
            state.prefState.moduleLayout == ModuleLayout.table) {
          store.dispatch(UpdateUserPreferences(isPreviewVisible: true));
        }

        switch (entityType) {
          case EntityType.client:
            store.dispatch(ViewClient(
              clientId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.user:
            store.dispatch(ViewUser(
              userId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.project:
            store.dispatch(ViewProject(
              projectId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.taxRate:
            store.dispatch(ViewTaxRate(
              taxRateId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.companyGateway:
            store.dispatch(ViewCompanyGateway(
              companyGatewayId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.invoice:
            store.dispatch(ViewInvoice(
              invoiceId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          //case EntityType.recurringInvoice:
          //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
          //break;
          case EntityType.quote:
            store.dispatch(ViewQuote(
              quoteId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.vendor:
            store.dispatch(ViewVendor(
              vendorId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.product:
            store.dispatch(ViewProduct(
              productId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.task:
            store.dispatch(ViewTask(
              taskId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.expense:
            store.dispatch(ViewExpense(
              expenseId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          //case EntityType.expenseCategory:
          //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
          //break;
          case EntityType.payment:
            store.dispatch(ViewPayment(
              paymentId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.group:
            store.dispatch(ViewGroup(
              groupId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          // STARTER: view - do not remove comment
          case EntityType.taskStatus:
            store.dispatch(ViewTaskStatus(
              taskStatusId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;

          case EntityType.expenseCategory:
            store.dispatch(ViewExpenseCategory(
              expenseCategoryId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;

          case EntityType.recurringInvoice:
            store.dispatch(ViewRecurringInvoice(
              recurringInvoiceId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;

          case EntityType.webhook:
            store.dispatch(ViewWebhook(
              webhookId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;

          case EntityType.token:
            store.dispatch(ViewToken(
              tokenId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;

          case EntityType.paymentTerm:
            store.dispatch(ViewPaymentTerm(
              paymentTermId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
          case EntityType.design:
            store.dispatch(ViewDesign(
              designId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;

          case EntityType.credit:
            store.dispatch(ViewCredit(
              creditId: entityId,
              navigator: navigator,
              force: force,
            ));
            break;
        }
      });
}

void createEntityByType(
    {BuildContext context, EntityType entityType, bool force = false}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final navigator = Navigator.of(context);

  if (!state.userCompany.canCreate(entityType)) {
    return;
  }

  checkForChanges(
      store: store,
      context: context,
      force: force,
      callback: () {
        if (state.uiState.previewStack.isNotEmpty) {
          store.dispatch(ClearPreviewStack());
        }

        switch (entityType) {
          case EntityType.client:
            store.dispatch(EditClient(
                client: ClientEntity(state: state),
                navigator: navigator,
                force: force));
            break;
          case EntityType.user:
            store.dispatch(EditUser(
              navigator: navigator,
              force: force,
              user: UserEntity(
                state: state,
                userCompany: UserCompanyEntity(false),
              ),
            ));
            break;
          case EntityType.project:
            store.dispatch(EditProject(
                navigator: navigator,
                force: force,
                project: ProjectEntity(state: state)));
            break;
          case EntityType.taxRate:
            store.dispatch(EditTaxRate(
                navigator: navigator,
                force: force,
                taxRate: TaxRateEntity(state: state)));
            break;
          case EntityType.companyGateway:
            store.dispatch(EditCompanyGateway(
                navigator: navigator,
                force: force,
                companyGateway: CompanyGatewayEntity(state: state)));
            break;
          case EntityType.invoice:
            store.dispatch(EditInvoice(
              navigator: navigator,
              force: force,
              invoice: InvoiceEntity(state: state),
            ));
            break;
          //case EntityType.recurringInvoice:
          //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
          //break;
          case EntityType.quote:
            store.dispatch(EditQuote(
                navigator: navigator,
                force: force,
                quote: InvoiceEntity(
                  state: state,
                  entityType: EntityType.quote,
                )));
            break;
          case EntityType.vendor:
            store.dispatch(EditVendor(
                navigator: navigator,
                force: force,
                vendor: VendorEntity(state: state)));
            break;
          case EntityType.product:
            store.dispatch(EditProduct(
                navigator: navigator,
                force: force,
                product: ProductEntity(state: state)));
            break;
          case EntityType.task:
            store.dispatch(EditTask(
              navigator: navigator,
              force: force,
              task: TaskEntity(state: state),
            ));
            break;
          case EntityType.expense:
            store.dispatch(EditExpense(
                navigator: navigator,
                force: force,
                expense: ExpenseEntity(state: state)));
            break;
          //case EntityType.expenseCategory:
          //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
          //break;
          //case EntityType.credit:
          //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
          //break;
          case EntityType.payment:
            store.dispatch(EditPayment(
                navigator: navigator,
                force: force,
                payment: PaymentEntity(state: state)));
            break;
          case EntityType.group:
            store.dispatch(EditGroup(
              navigator: navigator,
              force: force,
              group: GroupEntity(state: state),
            ));
            break;
          // STARTER: create type - do not remove comment
          case EntityType.taskStatus:
            store.dispatch(EditTaskStatus(
              navigator: navigator,
              force: force,
              taskStatus: TaskStatusEntity(state: state),
            ));
            break;

          case EntityType.expenseCategory:
            store.dispatch(EditExpenseCategory(
              navigator: navigator,
              force: force,
              expenseCategory: ExpenseCategoryEntity(state: state),
            ));
            break;

          case EntityType.recurringInvoice:
            store.dispatch(EditRecurringInvoice(
              navigator: navigator,
              force: force,
              recurringInvoice: InvoiceEntity(
                  state: state, entityType: EntityType.recurringInvoice),
            ));
            break;

          case EntityType.webhook:
            store.dispatch(EditWebhook(
              navigator: navigator,
              force: force,
              webhook: WebhookEntity(state: state),
            ));
            break;

          case EntityType.token:
            store.dispatch(EditToken(
              navigator: navigator,
              force: force,
              token: TokenEntity(state: state),
            ));
            break;

          case EntityType.paymentTerm:
            store.dispatch(EditPaymentTerm(
              navigator: navigator,
              force: force,
              paymentTerm: PaymentTermEntity(state: state),
            ));
            break;
          case EntityType.design:
            store.dispatch(EditDesign(
              navigator: navigator,
              force: force,
              design: DesignEntity(state: state),
            ));
            break;
          case EntityType.credit:
            store.dispatch(EditCredit(
              navigator: navigator,
              force: force,
              credit: InvoiceEntity(
                state: state,
                entityType: EntityType.credit,
              ),
            ));
            break;
        }
      });
}

void createEntity({
  BuildContext context,
  BaseEntity entity,
  bool force = false,
  BaseEntity filterEntity,
  Completer completer,
  Completer cancelCompleter,
}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final uiState = state.uiState;
  final navigator = Navigator.of(context);

  if (!state.userCompany.canCreate(entity.entityType)) {
    return;
  }

  checkForChanges(
      store: store,
      context: context,
      force: force,
      callback: () {
        if (filterEntity != null &&
            uiState.filterEntityType != filterEntity.entityType &&
            uiState.filterEntityId != filterEntity.id) {
          filterByEntity(
            context: context,
            entity: filterEntity,
          );
        }

        if (uiState.previewStack.isNotEmpty) {
          store.dispatch(ClearPreviewStack());
        }

        switch (entity.entityType) {
          case EntityType.client:
            store.dispatch(EditClient(
              client: entity,
              navigator: navigator,
              force: force,
              completer: completer,
              cancelCompleter: cancelCompleter,
            ));
            break;
          case EntityType.user:
            store.dispatch(EditUser(
              navigator: navigator,
              user: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.project:
            store.dispatch(EditProject(
              navigator: navigator,
              project: entity,
              force: force,
              completer: completer,
              cancelCompleter: cancelCompleter,
            ));
            break;
          case EntityType.taxRate:
            store.dispatch(EditTaxRate(
              navigator: navigator,
              taxRate: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.companyGateway:
            store.dispatch(EditCompanyGateway(
              navigator: navigator,
              companyGateway: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.invoice:
            store.dispatch(EditInvoice(
              navigator: navigator,
              invoice: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.quote:
            store.dispatch(EditQuote(
              navigator: navigator,
              quote: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.vendor:
            store.dispatch(EditVendor(
              navigator: navigator,
              vendor: entity,
              force: force,
              completer: completer,
              cancelCompleter: cancelCompleter,
            ));
            break;
          case EntityType.product:
            store.dispatch(EditProduct(
              navigator: navigator,
              product: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.task:
            store.dispatch(EditTask(
              navigator: navigator,
              task: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.expense:
            store.dispatch(EditExpense(
              navigator: navigator,
              expense: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.payment:
            store.dispatch(EditPayment(
              navigator: navigator,
              payment: entity,
              force: force,
              completer: completer,
            ));
            break;
          case EntityType.group:
            store.dispatch(EditGroup(
              navigator: navigator,
              group: entity,
              force: force,
              completer: completer,
            ));
            break;
          // STARTER: create - do not remove comment
          case EntityType.taskStatus:
            store.dispatch(EditTaskStatus(
              navigator: navigator,
              taskStatus: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.expenseCategory:
            store.dispatch(EditExpenseCategory(
              navigator: navigator,
              expenseCategory: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.recurringInvoice:
            store.dispatch(EditRecurringInvoice(
              navigator: navigator,
              recurringInvoice: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.webhook:
            store.dispatch(EditWebhook(
              navigator: navigator,
              webhook: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.token:
            store.dispatch(EditToken(
              navigator: navigator,
              token: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.paymentTerm:
            store.dispatch(EditPaymentTerm(
              navigator: navigator,
              paymentTerm: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.design:
            store.dispatch(EditDesign(
              navigator: navigator,
              design: entity,
              force: force,
              completer: completer,
            ));
            break;

          case EntityType.credit:
            store.dispatch(EditCredit(
              navigator: navigator,
              credit: entity,
              force: force,
              completer: completer,
            ));
            break;
        }
      });
}

void editEntity(
    {@required BuildContext context,
    @required BaseEntity entity,
    int subIndex,
    Completer completer}) {
  final store = StoreProvider.of<AppState>(context);
  final navigator = Navigator.of(context);
  final localization = AppLocalization.of(context);
  final entityType = entity.entityType;

  if (!entity.isEditable) {
    return;
  }

  checkForChanges(
      store: store,
      context: context,
      callback: () {
        switch (entityType) {
          case EntityType.client:
            store.dispatch(
              EditClient(
                  client: entity,
                  navigator: navigator,
                  completer: completer ??
                      snackBarCompleter<ClientEntity>(
                          context,
                          entity.isNew
                              ? localization.createdClient
                              : localization.updatedClient)),
            );
            break;
          case EntityType.user:
            store.dispatch(
              EditUser(
                  user: entity,
                  navigator: navigator,
                  completer: completer ??
                      snackBarCompleter<UserEntity>(
                          context,
                          entity.isNew
                              ? localization.createdUser
                              : localization.updatedUser)),
            );
            break;
          case EntityType.project:
            store.dispatch(EditProject(
                project: entity,
                navigator: navigator,
                completer: completer ??
                    snackBarCompleter<ProjectEntity>(
                        context,
                        entity.isNew
                            ? localization.createdProject
                            : localization.updatedProject)));
            break;
          case EntityType.taxRate:
            store.dispatch(EditTaxRate(
                taxRate: entity,
                navigator: navigator,
                completer: completer ??
                    snackBarCompleter<TaxRateEntity>(
                        context,
                        entity.isNew
                            ? localization.createdTaxRate
                            : localization.updatedTaxRate)));
            break;
          case EntityType.companyGateway:
            store.dispatch(EditCompanyGateway(
                companyGateway: entity,
                navigator: navigator,
                completer: completer ??
                    snackBarCompleter<CompanyGatewayEntity>(
                        context,
                        entity.isNew
                            ? localization.createdCompanyGateway
                            : localization.updatedCompanyGateway)));
            break;
          case EntityType.invoice:
            store.dispatch(EditInvoice(
              invoice: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<InvoiceEntity>(
                      context,
                      entity.isNew
                          ? localization.createdInvoice
                          : localization.updatedInvoice),
              invoiceItemIndex: subIndex,
            ));
            break;
          case EntityType.quote:
            store.dispatch(EditQuote(
              quote: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<InvoiceEntity>(
                      context,
                      entity.isNew
                          ? localization.createdQuote
                          : localization.updatedQuote),
              quoteItemIndex: subIndex,
            ));
            break;
          case EntityType.vendor:
            store.dispatch(EditVendor(
              vendor: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<VendorEntity>(
                      context,
                      entity.isNew
                          ? localization.createdVendor
                          : localization.updatedVendor),
            ));
            break;
          case EntityType.product:
            store.dispatch(EditProduct(
                product: entity,
                navigator: navigator,
                completer: completer ??
                    snackBarCompleter<ProductEntity>(
                        context,
                        entity.isNew
                            ? localization.createdProduct
                            : localization.updatedProduct)));
            break;
          case EntityType.task:
            store.dispatch(EditTask(
              task: entity,
              navigator: navigator,
              taskTimeIndex: subIndex,
              completer: completer ??
                  snackBarCompleter<TaskEntity>(
                      context,
                      entity.isNew
                          ? localization.createdTask
                          : localization.updatedTask),
            ));
            break;
          case EntityType.expense:
            store.dispatch(EditExpense(
              expense: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<ExpenseEntity>(
                      context,
                      entity.isNew
                          ? localization.createdExpense
                          : localization.updatedExpense),
            ));
            break;
          //case EntityType.expenseCategory:
          //store.dispatch(EditExpenseCategory(taxRate: entity, navigator: navigator));
          //break;
          //case EntityType.credit:
          //store.dispatch(EditCredit(credit: entity, navigator: navigator));
          //break;
          case EntityType.payment:
            store.dispatch(EditPayment(
              payment: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<PaymentEntity>(
                      context,
                      entity.isNew
                          ? localization.createdPayment
                          : localization.updatedPayment),
            ));
            break;
          case EntityType.group:
            store.dispatch(EditGroup(
              group: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<GroupEntity>(
                      context,
                      entity.isNew
                          ? localization.createdGroup
                          : localization.updatedGroup),
            ));
            break;
          // STARTER: edit - do not remove comment
          case EntityType.taskStatus:
            store.dispatch(EditTaskStatus(
              taskStatus: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<TaskStatusEntity>(
                      context,
                      entity.isNew
                          ? localization.createdTaskStatus
                          : localization.updatedTaskStatus),
            ));
            break;

          case EntityType.expenseCategory:
            store.dispatch(EditExpenseCategory(
              expenseCategory: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<ExpenseCategoryEntity>(
                      context,
                      entity.isNew
                          ? localization.createdExpenseCategory
                          : localization.updatedExpenseCategory),
            ));
            break;

          case EntityType.recurringInvoice:
            store.dispatch(EditRecurringInvoice(
              recurringInvoice: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<InvoiceEntity>(
                      context,
                      entity.isNew
                          ? localization.createdRecurringInvoice
                          : localization.updatedRecurringInvoice),
            ));
            break;

          case EntityType.webhook:
            store.dispatch(EditWebhook(
              webhook: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<WebhookEntity>(
                      context,
                      entity.isNew
                          ? localization.createdWebhook
                          : localization.updatedWebhook),
            ));
            break;

          case EntityType.token:
            store.dispatch(EditToken(
              token: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<TokenEntity>(
                      context,
                      entity.isNew
                          ? localization.createdToken
                          : localization.updatedToken),
            ));
            break;

          case EntityType.paymentTerm:
            store.dispatch(EditPaymentTerm(
              paymentTerm: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<PaymentTermEntity>(
                      context,
                      entity.isNew
                          ? localization.createdPaymentTerm
                          : localization.updatedPaymentTerm),
            ));
            break;

          case EntityType.design:
            store.dispatch(EditDesign(
              design: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<DesignEntity>(
                      context,
                      entity.isNew
                          ? localization.createdDesign
                          : localization.updatedDesign),
            ));
            break;

          case EntityType.credit:
            store.dispatch(EditCredit(
              credit: entity,
              navigator: navigator,
              completer: completer ??
                  snackBarCompleter<InvoiceEntity>(
                      context,
                      entity.isNew
                          ? localization.createdCredit
                          : localization.updatedCredit),
            ));
            break;
        }
      });
}

void handleEntityAction(
    BuildContext context, BaseEntity entity, EntityAction action,
    {bool autoPop = false}) {
  handleEntitiesActions(context, [entity], action, autoPop: autoPop);
}

void handleEntitiesActions(
    BuildContext context, List<BaseEntity> entities, EntityAction action,
    {bool autoPop = false}) {
  if (entities.isEmpty) {
    return;
  }

  if ([EntityAction.archive, EntityAction.delete].contains(action) && autoPop) {
    if (isMobile(context)) {
      Navigator.of(context).pop();
    } else if (entities.first.entityType.isSetting) {
      final store = StoreProvider.of<AppState>(context);
      switch (entities.first.entityType) {
        case EntityType.paymentTerm:
          store.dispatch(UpdateCurrentRoute(PaymentTermScreen.route));
          break;
        case EntityType.taxRate:
          store.dispatch(UpdateCurrentRoute(TaxRateSettingsScreen.route));
          break;
        case EntityType.companyGateway:
          store.dispatch(UpdateCurrentRoute(CompanyGatewayScreen.route));
          break;
        case EntityType.user:
          store.dispatch(UpdateCurrentRoute(UserScreen.route));
          break;
        case EntityType.group:
          store.dispatch(UpdateCurrentRoute(GroupSettingsScreen.route));
          break;
        case EntityType.design:
          store.dispatch(UpdateCurrentRoute(DesignScreen.route));
          break;
        case EntityType.token:
          store.dispatch(UpdateCurrentRoute(TokenScreen.route));
          break;
        case EntityType.webhook:
          store.dispatch(UpdateCurrentRoute(WebhookScreen.route));
          break;
        default:
          print('ERROR: entty type not supported ${entities.first.entityType}');
      }
    }
  }

  switch (entities.first.entityType) {
    case EntityType.client:
      handleClientAction(context, entities, action);
      break;
    case EntityType.product:
      handleProductAction(context, entities, action);
      break;
    case EntityType.invoice:
      handleInvoiceAction(context, entities, action);
      break;
    case EntityType.payment:
      handlePaymentAction(context, entities, action);
      break;
    case EntityType.quote:
      handleQuoteAction(context, entities, action);
      break;
    case EntityType.task:
      handleTaskAction(context, entities, action);
      break;
    case EntityType.project:
      handleProjectAction(context, entities, action);
      break;
    case EntityType.expense:
      handleExpenseAction(context, entities, action);
      break;
    case EntityType.vendor:
      handleVendorAction(context, entities, action);
      break;
    case EntityType.user:
      handleUserAction(context, entities, action);
      break;
    case EntityType.companyGateway:
      handleCompanyGatewayAction(context, entities, action);
      break;
    case EntityType.taxRate:
      handleTaxRateAction(context, entities, action);
      break;
    case EntityType.group:
      handleGroupAction(context, entities, action);
      break;
    case EntityType.document:
      handleDocumentAction(context, entities, action);
      break;
    // STARTER: actions - do not remove comment
    case EntityType.taskStatus:
      handleTaskStatusAction(context, entities, action);
      break;

    case EntityType.expenseCategory:
      handleExpenseCategoryAction(context, entities, action);
      break;
    case EntityType.recurringInvoice:
      handleRecurringInvoiceAction(context, entities, action);
      break;
    case EntityType.webhook:
      handleWebhookAction(context, entities, action);
      break;
    case EntityType.token:
      handleTokenAction(context, entities, action);
      break;
    case EntityType.paymentTerm:
      handlePaymentTermAction(context, entities, action);
      break;
    case EntityType.design:
      handleDesignAction(context, entities, action);
      break;
    case EntityType.credit:
      handleCreditAction(context, entities, action);
      break;
    default:
      print(
          'Error: unhandled type ${entities.first.entityType} in handleEntitiesActions');
  }
}

void selectEntity({
  @required BuildContext context,
  @required BaseEntity entity,
  bool longPress = false,
  bool forceView = false,
  BaseEntity filterEntity,
}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final uiState = state.uiState;
  final isInMultiselect =
      state.getListState(entity.entityType).isInMultiselect();

  if (longPress == true) {
    final longPressIsSelection =
        state.prefState.longPressSelectionIsDefault ?? true;
    if (longPressIsSelection && !isInMultiselect) {
      handleEntityAction(context, entity, EntityAction.toggleMultiselect);
    } else {
      showEntityActionsDialog(
        entities: [entity],
        context: context,
      );
    }
  } else if (isInMultiselect && forceView != true) {
    handleEntityAction(context, entity, EntityAction.toggleMultiselect);
  } else if (isDesktop(context) &&
      (uiState.isEditing || uiState.previewStack.isNotEmpty)) {
    viewEntity(context: context, entity: entity);
  } else if (isDesktop(context) &&
      !forceView &&
      uiState.isViewing &&
      !entity.entityType.isSetting &&
      (state.getUIState(entity.entityType).selectedId == entity.id &&
          state.prefState.isPreviewVisible)) {
    editEntity(context: context, entity: entity);
  } else {
    ClientEntity client;
    if (forceView && entity is BelongsToClient) {
      client = state.clientState.get((entity as BelongsToClient).clientId);
    }

    viewEntity(context: context, entity: entity, filterEntity: client);
  }
}

void inspectEntity({
  BuildContext context,
  BaseEntity entity,
  bool longPress = false,
}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;

  if (isDesktop(context)) {
    if (longPress) {
      viewEntity(context: context, entity: entity);
    } else if (state.uiState.previewStack.isNotEmpty) {
      viewEntity(context: context, entity: entity, addToStack: true);
    } else {
      store.dispatch(
          FilterByEntity(entityType: entity.entityType, entityId: entity.id));
    }
  } else {
    if (longPress) {
      showEntityActionsDialog(context: context, entities: [entity]);
    } else {
      viewEntity(context: context, entity: entity);
    }
  }
}

void checkForChanges({
  @required Store<AppState> store,
  @required BuildContext context,
  @required Function callback,
  bool force = false,
}) {
  if (context == null) {
    print('WARNING: context is null in hasChanges');
    return;
  }

  if (!force && store.state.hasChanges() && !isMobile(context)) {
    showDialog<MessageDialog>(
        context: context,
        builder: (BuildContext dialogContext) {
          final localization = AppLocalization.of(context);
          return MessageDialog(localization.errorUnsavedChanges,
              dismissLabel: localization.continueEditing, onDiscard: () {
            store.dispatch(DiscardChanges());
            store.dispatch(ResetSettings());
            callback();
          });
        });
  } else {
    callback();
  }
}
