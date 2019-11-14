import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
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
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';

class PersistUI {}

class PersistData {}

class PersistStatic {}

class RefreshClient {
  RefreshClient(this.clientId);

  final String clientId;
}

class UpdateSidebar implements PersistUI {
  UpdateSidebar(this.sidebar);

  final AppSidebar sidebar;
}

class UpdateLayout implements PersistUI {
  UpdateLayout(this.layout);

  final AppLayout layout;
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

class UserSettingsChanged implements PersistUI {
  UserSettingsChanged({
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

  final bool enableDarkMode;
  final bool longPressSelectionIsDefault;
  final bool emailPayment;
  final bool requireAuthentication;
  final bool autoStartTasks;
  final bool addDocumentsToInvoice;
  final String accentColor;
  final AppSidebarMode menuMode;
  final AppSidebarMode historyMode;
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

class FilterCompany {
  FilterCompany(this.filter);

  final String filter;
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
