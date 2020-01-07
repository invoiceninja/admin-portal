import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PersistUI {}

class PersistPrefs {}

class PersistData {}

class PersistStatic {}

class RefreshClient {
  RefreshClient(this.clientId);

  final String clientId;
}

class SwitchListTableLayout implements PersistUI, PersistPrefs {}

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

class LoadStaticSuccess implements PersistStatic {
  LoadStaticSuccess({this.data});

  final StaticDataEntity data;
}

class UserSettingsChanged implements PersistPrefs {
  UserSettingsChanged({
    this.layout,
    this.sidebar,
    this.enableDarkMode,
    this.emailPayment,
    this.requireAuthentication,
    this.autoStartTasks,
    this.longPressSelectionIsDefault,
    this.addDocumentsToInvoice,
    this.accentColor,
    this.menuMode,
    this.historyMode,
  });

  final AppLayout layout;
  final AppSidebar sidebar;
  final AppSidebarMode menuMode;
  final AppSidebarMode historyMode;
  final bool enableDarkMode;
  final bool longPressSelectionIsDefault;
  final bool emailPayment;
  final bool requireAuthentication;
  final bool autoStartTasks;
  final bool addDocumentsToInvoice;
  final String accentColor;
}

class LoadAccountSuccess {
  LoadAccountSuccess(
      {this.loginResponse, this.completer, this.loadCompanies = true});

  final Completer completer;
  final LoginResponse loginResponse;
  final bool loadCompanies;
}

class RefreshData {
  RefreshData({this.platform, this.completer, this.loadCompanies = true});

  final String platform;
  final Completer completer;
  final bool loadCompanies;
}

class RefreshDataFailure {
  const RefreshDataFailure(this.error);
  final dynamic error;
}

class ClearLastError {}

class DiscardChanges {}

class FilterCompany implements PersistUI {
  FilterCompany(this.filter);

  final String filter;
}

abstract class AbstractNavigatorAction {
  AbstractNavigatorAction({this.navigator});

  final NavigatorState navigator;

  BuildContext get context => navigator.overlay.context ?? navigator.context;
}

void filterEntitiesByType({
  @required BuildContext context,
  @required EntityType entityType,
  @required BaseEntity filterEntity,
}) {
  final store = StoreProvider.of<AppState>(context);

  switch (entityType) {
    case EntityType.client:
      store.dispatch(FilterClientsByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.user:
      store.dispatch(FilterUsersByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.project:
      store.dispatch(FilterProjectsByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.taxRate:
      store.dispatch(FilterTaxRatesByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.companyGateway:
      store.dispatch(FilterCompanyGatewaysByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.invoice:
      store.dispatch(FilterInvoicesByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
    //break;
    case EntityType.quote:
      store.dispatch(FilterQuotesByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.vendor:
      store.dispatch(FilterVendorsByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.task:
      store.dispatch(FilterTasksByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.expense:
      store.dispatch(FilterExpensesByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
    //break;
    case EntityType.payment:
      store.dispatch(FilterPaymentsByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    case EntityType.group:
      store.dispatch(FilterGroupsByEntity(
        entityId: filterEntity.id,
        entityType: filterEntity.entityType,
      ));
      break;
    // TODO Add to starter
  }
}

void viewEntitiesByType({
  @required BuildContext context,
  @required EntityType entityType,
  BaseEntity filterEntity,
}) {
  final store = StoreProvider.of<AppState>(context);
  final navigator = Navigator.of(context);

  if (filterEntity != null) {
    filterEntitiesByType(
      context: context,
      entityType: entityType,
      filterEntity: filterEntity,
    );
  }

  switch (entityType) {
    case EntityType.client:
      store.dispatch(ViewClientList(navigator: navigator));
      break;
    case EntityType.user:
      store.dispatch(ViewUserList(navigator: navigator));
      break;
    case EntityType.project:
      store.dispatch(ViewProjectList(navigator: navigator));
      break;
    case EntityType.taxRate:
      store.dispatch(ViewTaxRateList(navigator: navigator));
      break;
    case EntityType.companyGateway:
      store.dispatch(ViewCompanyGatewayList(navigator: navigator));
      break;
    case EntityType.invoice:
      store.dispatch(ViewInvoiceList(navigator: navigator));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
    //break;
    case EntityType.quote:
      store.dispatch(ViewQuoteList(navigator: navigator));
      break;
    case EntityType.vendor:
      store.dispatch(ViewVendorList(navigator: navigator));
      break;
    case EntityType.product:
      store.dispatch(ViewProductList(navigator: navigator));
      break;
    case EntityType.task:
      store.dispatch(ViewTaskList(navigator: navigator));
      break;
    case EntityType.expense:
      store.dispatch(ViewExpenseList(navigator: navigator));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
    //break;
    case EntityType.payment:
      store.dispatch(ViewPaymentList(navigator: navigator));
      break;
    case EntityType.group:
      store.dispatch(ViewGroupList(navigator: navigator));
      break;
    // TODO Add to starter
  }
}

void viewEntityById(
    {BuildContext context,
    String entityId,
    EntityType entityType,
    bool force = false}) {
  final store = StoreProvider.of<AppState>(context);
  final navigator = Navigator.of(context);

  if (!store.state.getEntityMap(entityType).containsKey(entityId)) {
    showErrorDialog(
        context: context,
        message: AppLocalization.of(context).failedToFindRecord);
    return;
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
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
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
    // TODO Add to starter
  }
}

void viewEntity(
        {BuildContext context, BaseEntity entity, bool force = false}) =>
    viewEntityById(
        context: context,
        entityId: entity.id,
        entityType: entity.entityType,
        force: force);

void createEntityByType(
    {BuildContext context, EntityType entityType, bool force = false}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final navigator = Navigator.of(context);

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
        user: UserEntity(state: state)
            .rebuild((b) => b..userCompany.replace(UserCompanyEntity())),
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
            isQuote: true,
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
    // TODO Add to starter
  }
}

void createEntity({
  BuildContext context,
  BaseEntity entity,
  bool force = false,
  Completer completer,
  Completer cancelCompleter,
}) {
  final store = StoreProvider.of<AppState>(context);
  final navigator = Navigator.of(context);

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
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
    //break;
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
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
    //break;
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
    // TODO Add to starter
  }
}

void editEntityById(
    {@required BuildContext context,
    @required String entityId,
    @required EntityType entityType,
    int subIndex,
    Completer completer}) {
  final store = StoreProvider.of<AppState>(context);
  final navigator = Navigator.of(context);
  final localization = AppLocalization.of(context);
  final map = store.state.getEntityMap(entityType);
  final entity = map[entityId] as BaseEntity;

  switch (entityType) {
    case EntityType.client:
      store.dispatch(
        EditClient(
            client: map[entityId],
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
            user: map[entityId],
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
          project: map[entityId],
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
          taxRate: map[entityId],
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
          companyGateway: map[entityId],
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
        invoice: map[entityId],
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
    //case EntityType.recurringInvoice:
    //store.dispatch(EditRecurringInvoice(recurringInvoice: map[entityId], navigator: navigator));
    //break;
    case EntityType.quote:
      store.dispatch(EditQuote(
        quote: map[entityId],
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
        vendor: map[entityId],
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
          product: map[entityId],
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
        task: map[entityId],
        navigator: navigator,
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
        expense: map[entityId],
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
    //store.dispatch(EditExpenseCategory(taxRate: map[entityId], navigator: navigator));
    //break;
    //case EntityType.credit:
    //store.dispatch(EditCredit(credit: map[entityId], navigator: navigator));
    //break;
    case EntityType.payment:
      store.dispatch(EditPayment(
        payment: map[entityId],
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
        group: map[entityId],
        navigator: navigator,
        completer: completer ??
            snackBarCompleter<GroupEntity>(
                context,
                entity.isNew
                    ? localization.createdGroup
                    : localization.updatedGroup),
      ));
      break;
    // TODO Add to starter
  }
}

void editEntity(
        {@required BuildContext context,
        @required BaseEntity entity,
        int subIndex,
        Completer completer}) =>
    editEntityById(
        context: context,
        entityId: entity.id,
        entityType: entity.entityType,
        subIndex: subIndex,
        completer: completer);

void handleEntityAction(
    BuildContext context, BaseEntity entity, dynamic action) {
  handleEntitiesActions(context, [entity], action);
}

void handleEntitiesActions(
    BuildContext context, List<BaseEntity> entities, dynamic action) {
  if (entities.isEmpty) {
    return;
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
  }
}
