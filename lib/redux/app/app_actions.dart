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

class PersistUI {}

class PersistPrefs {}

class PersistData {}

class PersistStatic {}

class RefreshClient {
  RefreshClient(this.clientId);

  final String clientId;
}

class ViewMainScreen {
  ViewMainScreen(this.context);

  BuildContext context;
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

void viewEntitiesByType({
  BuildContext context,
  EntityType entityType,
  BaseEntity filterEntity,
}) {
  final store = StoreProvider.of<AppState>(context);
  final navigator = Navigator.of(context);

  switch (entityType) {
    case EntityType.client:
      if (filterEntity != null) {
        store.dispatch(FilterClientsByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewClientList(navigator: navigator));
      break;
    case EntityType.user:
      if (filterEntity != null) {
        store.dispatch(FilterUsersByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewUserList(navigator: navigator));
      break;
    case EntityType.project:
      if (filterEntity != null) {
        store.dispatch(FilterProjectsByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewProjectList(navigator: navigator));
      break;
    case EntityType.taxRate:
      if (filterEntity != null) {
        store.dispatch(FilterTaxRatesByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewTaxRateList(navigator: navigator));
      break;
    case EntityType.companyGateway:
      if (filterEntity != null) {
        store.dispatch(FilterCompanyGatewaysByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewCompanyGatewayList(navigator: navigator));
      break;
    case EntityType.invoice:
      if (filterEntity != null) {
        store.dispatch(FilterInvoicesByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewInvoiceList(navigator: navigator));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
    //break;
    case EntityType.quote:
      if (filterEntity != null) {
        store.dispatch(FilterQuotesByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewQuoteList(navigator: navigator));
      break;
    case EntityType.vendor:
      if (filterEntity != null) {
        store.dispatch(FilterVendorsByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewVendorList(navigator: navigator));
      break;
    case EntityType.product:
      store.dispatch(ViewProductList(navigator: navigator));
      break;
    case EntityType.task:
      if (filterEntity != null) {
        store.dispatch(FilterTasksByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewTaskList(navigator: navigator));
      break;
    case EntityType.expense:
      if (filterEntity != null) {
        store.dispatch(FilterExpensesByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewExpenseList(navigator: navigator));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
    //break;
    case EntityType.payment:
      if (filterEntity != null) {
        store.dispatch(FilterPaymentsByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
      store.dispatch(ViewPaymentList(navigator: navigator));
      break;
    case EntityType.group:
      if (filterEntity != null) {
        store.dispatch(FilterGroupsByEntity(
            entityId: filterEntity.id, entityType: filterEntity.entityType));
      }
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
    return;
  }

  switch (entityType) {
    case EntityType.client:
      store.dispatch(
          ViewClient(clientId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.user:
      store.dispatch(
          ViewUser(userId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.project:
      store.dispatch(
          ViewProject(projectId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.taxRate:
      store.dispatch(
          ViewTaxRate(taxRateId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.companyGateway:
      store.dispatch(ViewCompanyGateway(
          companyGatewayId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.invoice:
      store.dispatch(
          ViewInvoice(invoiceId: entityId, navigator: navigator, force: force));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
    //break;
    case EntityType.quote:
      store.dispatch(
          ViewQuote(quoteId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.vendor:
      store.dispatch(
          ViewVendor(vendorId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.product:
      store.dispatch(
          ViewProduct(productId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.task:
      store.dispatch(
          ViewTask(taskId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.expense:
      store.dispatch(
          ViewExpense(expenseId: entityId, navigator: navigator, force: force));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, navigator: navigator));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, navigator: navigator));
    //break;
    case EntityType.payment:
      store.dispatch(
          ViewPayment(paymentId: entityId, navigator: navigator, force: force));
      break;
    case EntityType.group:
      store.dispatch(
          ViewGroup(groupId: entityId, navigator: navigator, force: force));
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
  final company = state.company;
  final navigator = Navigator.of(context);

  switch (entityType) {
    case EntityType.client:
      store.dispatch(EditClient(
        client: ClientEntity(),
        navigator: navigator,
        force: force,
      ));
      break;
    case EntityType.user:
      store.dispatch(
          EditUser(navigator: navigator, force: force, user: UserEntity()));
      break;
    case EntityType.project:
      store.dispatch(EditProject(
          navigator: navigator, force: force, project: ProjectEntity()));
      break;
    case EntityType.taxRate:
      store.dispatch(EditTaxRate(
          navigator: navigator, force: force, taxRate: TaxRateEntity()));
      break;
    case EntityType.companyGateway:
      store.dispatch(EditCompanyGateway(
          navigator: navigator,
          force: force,
          companyGateway: CompanyGatewayEntity()));
      break;
    case EntityType.invoice:
      store.dispatch(EditInvoice(
        navigator: navigator,
        force: force,
        invoice: InvoiceEntity(company: company),
      ));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, navigator: navigator));
    //break;
    case EntityType.quote:
      store.dispatch(EditQuote(
          navigator: navigator,
          force: force,
          quote: InvoiceEntity(company: company, isQuote: true)));
      break;
    case EntityType.vendor:
      store.dispatch(EditVendor(
          navigator: navigator, force: force, vendor: VendorEntity()));
      break;
    case EntityType.product:
      store.dispatch(EditProduct(
          navigator: navigator, force: force, product: ProductEntity()));
      break;
    case EntityType.task:
      store.dispatch(EditTask(
          navigator: navigator,
          force: force,
          task: TaskEntity(isRunning: state.prefState.autoStartTasks)));
      break;
    case EntityType.expense:
      store.dispatch(EditExpense(
          navigator: navigator,
          force: force,
          expense: ExpenseEntity(prefState: state.prefState)));
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
          payment: PaymentEntity(company: company)));
      break;
    case EntityType.group:
      store.dispatch(
          EditGroup(navigator: navigator, force: force, group: GroupEntity()));
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
  final map = store.state.getEntityMap(entityType);

  switch (entityType) {
    case EntityType.client:
      store.dispatch(EditClient(
        client: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.user:
      store.dispatch(EditUser(
        user: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.project:
      store.dispatch(EditProject(
        project: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.taxRate:
      store.dispatch(EditTaxRate(
        taxRate: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.companyGateway:
      store.dispatch(EditCompanyGateway(
        companyGateway: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.invoice:
      store.dispatch(EditInvoice(
        invoice: map[entityId],
        navigator: navigator,
        completer: completer,
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
        completer: completer,
        quoteItemIndex: subIndex,
      ));
      break;
    case EntityType.vendor:
      store.dispatch(EditVendor(
        vendor: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.product:
      store.dispatch(EditProduct(
        product: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.task:
      store.dispatch(EditTask(
        task: map[entityId],
        navigator: navigator,
        completer: completer,
      ));
      break;
    case EntityType.expense:
      store.dispatch(EditExpense(
        expense: map[entityId],
        navigator: navigator,
        completer: completer,
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
        completer: completer,
      ));
      break;
    case EntityType.group:
      store.dispatch(EditGroup(
        group: map[entityId],
        navigator: navigator,
        completer: completer,
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
