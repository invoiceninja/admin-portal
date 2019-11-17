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

class UserSettingsChanged implements PersistUI, PersistPrefs {
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

void viewEntitiesByType({BuildContext context, EntityType entityType}) {
  final store = StoreProvider.of<AppState>(context);
  switch (entityType) {
    case EntityType.client:
      store.dispatch(ViewClientList(context: context));
      break;
    case EntityType.user:
      store.dispatch(ViewUserList(context: context));
      break;
    case EntityType.project:
      store.dispatch(ViewProjectList(context: context));
      break;
    case EntityType.taxRate:
      store.dispatch(ViewTaxRateList(context: context));
      break;
    case EntityType.companyGateway:
      store.dispatch(ViewCompanyGatewayList(context: context));
      break;
    case EntityType.invoice:
      store.dispatch(ViewInvoiceList(context: context));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, context: context));
    //break;
    case EntityType.quote:
      store.dispatch(ViewQuoteList(context: context));
      break;
    case EntityType.vendor:
      store.dispatch(ViewVendorList(context: context));
      break;
    case EntityType.product:
      store.dispatch(ViewProductList(context: context));
      break;
    case EntityType.task:
      store.dispatch(ViewTaskList(context: context));
      break;
    case EntityType.expense:
      store.dispatch(ViewExpenseList(context: context));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, context: context));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, context: context));
    //break;
    case EntityType.payment:
      store.dispatch(ViewPaymentList(context: context));
      break;
    case EntityType.group:
      store.dispatch(ViewGroupList(context: context));
      break;
    // TODO Add to starter
  }
}

void viewEntityById(
    {BuildContext context, String entityId, EntityType entityType}) {
  final store = StoreProvider.of<AppState>(context);
  switch (entityType) {
    case EntityType.client:
      store.dispatch(ViewClient(clientId: entityId, context: context));
      break;
    case EntityType.user:
      store.dispatch(ViewUser(userId: entityId, context: context));
      break;
    case EntityType.project:
      store.dispatch(ViewProject(projectId: entityId, context: context));
      break;
    case EntityType.taxRate:
      store.dispatch(ViewTaxRate(taxRateId: entityId, context: context));
      break;
    case EntityType.companyGateway:
      store.dispatch(
          ViewCompanyGateway(companyGatewayId: entityId, context: context));
      break;
    case EntityType.invoice:
      store.dispatch(ViewInvoice(invoiceId: entityId, context: context));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, context: context));
    //break;
    case EntityType.quote:
      store.dispatch(ViewQuote(quoteId: entityId, context: context));
      break;
    case EntityType.vendor:
      store.dispatch(ViewVendor(vendorId: entityId, context: context));
      break;
    case EntityType.product:
      store.dispatch(ViewProduct(productId: entityId, context: context));
      break;
    case EntityType.task:
      store.dispatch(ViewTask(taskId: entityId, context: context));
      break;
    case EntityType.expense:
      store.dispatch(ViewExpense(expenseId: entityId, context: context));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, context: context));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, context: context));
    //break;
    case EntityType.payment:
      store.dispatch(ViewPayment(paymentId: entityId, context: context));
      break;
    case EntityType.group:
      store.dispatch(ViewGroup(groupId: entityId, context: context));
      break;
    // TODO Add to starter
  }
}

void createEntityByType({BuildContext context, EntityType entityType}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final company = state.company;
  switch (entityType) {
    case EntityType.client:
      store.dispatch(EditClient(context: context, client: ClientEntity()));
      break;
    case EntityType.user:
      store.dispatch(EditUser(context: context, user: UserEntity()));
      break;
    case EntityType.project:
      store.dispatch(EditProject(context: context, project: ProjectEntity()));
      break;
    case EntityType.taxRate:
      store.dispatch(EditTaxRate(context: context, taxRate: TaxRateEntity()));
      break;
    case EntityType.companyGateway:
      store.dispatch(EditCompanyGateway(
          context: context, companyGateway: CompanyGatewayEntity()));
      break;
    case EntityType.invoice:
      store.dispatch(EditInvoice(
          context: context, invoice: InvoiceEntity(company: company)));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(ViewRecurringInvoice(recurringInvoiceId: entityId, context: context));
    //break;
    case EntityType.quote:
      store.dispatch(EditQuote(
          context: context,
          quote: InvoiceEntity(company: company, isQuote: true)));
      break;
    case EntityType.vendor:
      store.dispatch(EditVendor(context: context, vendor: VendorEntity()));
      break;
    case EntityType.product:
      store.dispatch(EditProduct(context: context, product: ProductEntity()));
      break;
    case EntityType.task:
      store.dispatch(EditTask(
          context: context,
          task: TaskEntity(isRunning: state.prefState.autoStartTasks)));
      break;
    case EntityType.expense:
      store.dispatch(EditExpense(
          context: context,
          expense: ExpenseEntity(prefState: state.prefState)));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(ViewExpenseCategory(taxRateId: entityId, context: context));
    //break;
    //case EntityType.credit:
    //store.dispatch(ViewCredit(creditId: entityId, context: context));
    //break;
    case EntityType.payment:
      store.dispatch(EditPayment(
          context: context, payment: PaymentEntity(company: company)));
      break;
    case EntityType.group:
      store.dispatch(EditGroup(context: context, group: GroupEntity()));
      break;
    // TODO Add to starter
  }
}

void editEntityById(
    {BuildContext context, String entityId, EntityType entityType}) {
  final store = StoreProvider.of<AppState>(context);
  final map = store.state.getEntityMap(entityType);
  switch (entityType) {
    case EntityType.client:
      store.dispatch(EditClient(client: map[entityId], context: context));
      break;
    case EntityType.user:
      store.dispatch(EditUser(user: map[entityId], context: context));
      break;
    case EntityType.project:
      store.dispatch(EditProject(project: map[entityId], context: context));
      break;
    case EntityType.taxRate:
      store.dispatch(EditTaxRate(taxRate: map[entityId], context: context));
      break;
    case EntityType.companyGateway:
      store.dispatch(
          EditCompanyGateway(companyGateway: map[entityId], context: context));
      break;
    case EntityType.invoice:
      store.dispatch(EditInvoice(invoice: map[entityId], context: context));
      break;
    //case EntityType.recurringInvoice:
    //store.dispatch(EditRecurringInvoice(recurringInvoice: map[entityId], context: context));
    //break;
    case EntityType.quote:
      store.dispatch(EditQuote(quote: map[entityId], context: context));
      break;
    case EntityType.vendor:
      store.dispatch(EditVendor(vendor: map[entityId], context: context));
      break;
    case EntityType.product:
      store.dispatch(EditProduct(product: map[entityId], context: context));
      break;
    case EntityType.task:
      store.dispatch(EditTask(task: map[entityId], context: context));
      break;
    case EntityType.expense:
      store.dispatch(EditExpense(expense: map[entityId], context: context));
      break;
    //case EntityType.expenseCategory:
    //store.dispatch(EditExpenseCategory(taxRate: map[entityId], context: context));
    //break;
    //case EntityType.credit:
    //store.dispatch(EditCredit(credit: map[entityId], context: context));
    //break;
    case EntityType.payment:
      store.dispatch(EditPayment(payment: map[entityId], context: context));
      break;
    case EntityType.group:
      store.dispatch(EditGroup(group: map[entityId], context: context));
      break;
    // TODO Add to starter
  }
}
