// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

export 'package:invoiceninja_flutter/data/models/client_model.dart';
export 'package:invoiceninja_flutter/data/models/company_model.dart';
export 'package:invoiceninja_flutter/data/models/credit_model.dart';
export 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
export 'package:invoiceninja_flutter/data/models/document_model.dart';
export 'package:invoiceninja_flutter/data/models/settings_model.dart';
export 'package:invoiceninja_flutter/data/models/entities.dart';
export 'package:invoiceninja_flutter/data/models/expense_model.dart';
export 'package:invoiceninja_flutter/data/models/subscription_model.dart';
export 'package:invoiceninja_flutter/data/models/expense_category_model.dart';
export 'package:invoiceninja_flutter/data/models/token_model.dart';
export 'package:invoiceninja_flutter/data/models/webhook_model.dart';
export 'package:invoiceninja_flutter/data/models/invoice_model.dart';
export 'package:invoiceninja_flutter/data/models/payment_model.dart';
export 'package:invoiceninja_flutter/data/models/product_model.dart';
export 'package:invoiceninja_flutter/data/models/design_model.dart';
export 'package:invoiceninja_flutter/data/models/project_model.dart';
export 'package:invoiceninja_flutter/data/models/static/country_model.dart';
export 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
export 'package:invoiceninja_flutter/data/models/static/date_format_model.dart';
export 'package:invoiceninja_flutter/data/models/static/datetime_format_model.dart';
export 'package:invoiceninja_flutter/data/models/static/industry_model.dart';
export 'package:invoiceninja_flutter/data/models/static/invoice_status_model.dart';
export 'package:invoiceninja_flutter/data/models/static/language_model.dart';
export 'package:invoiceninja_flutter/data/models/static/payment_type_model.dart';
export 'package:invoiceninja_flutter/data/models/static/size_model.dart';
export 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';
export 'package:invoiceninja_flutter/data/models/static/timezone_model.dart';
export 'package:invoiceninja_flutter/data/models/task_model.dart';
export 'package:invoiceninja_flutter/data/models/task_status_model.dart';
export 'package:invoiceninja_flutter/data/models/user_model.dart';
export 'package:invoiceninja_flutter/data/models/vendor_model.dart';
export 'package:invoiceninja_flutter/data/models/bank_account_model.dart';
export 'package:invoiceninja_flutter/data/models/transaction_model.dart';
// STARTER: export - do not remove comment
export 'package:invoiceninja_flutter/data/models/schedule_model.dart';
export 'package:invoiceninja_flutter/data/models/transaction_rule_model.dart';

part 'models.g.dart';

class EntityAction extends EnumClass {
  const EntityAction._(String name) : super(name);

  static Serializer<EntityAction> get serializer => _$entityActionSerializer;

  static const EntityAction edit = _$edit;
  static const EntityAction archive = _$archive;
  static const EntityAction delete = _$delete;
  static const EntityAction purge = _$purge;
  static const EntityAction restore = _$restore;
  static const EntityAction remove = _$remove;
  static const EntityAction clone = _$clone;
  static const EntityAction cloneToOther = _$cloneToOther;
  static const EntityAction cloneToCredit = _$cloneToCredit;
  static const EntityAction cloneToInvoice = _$cloneToInvoice;
  static const EntityAction cloneToQuote = _$cloneToQuote;
  static const EntityAction cloneToExpense = _$cloneToExpense;
  static const EntityAction cloneToRecurring = _$cloneToRecurring;
  static const EntityAction cloneToPurchaseOrder = _$cloneToPurchaseOrder;
  static const EntityAction approve = _$approve;
  static const EntityAction applyCredit = _$applyCredit;
  static const EntityAction applyPayment = _$applyPayment;
  static const EntityAction download = _$download;
  static const EntityAction documents = _$documents;
  static const EntityAction bulkDownload = _$bulkDownload;
  static const EntityAction sendEmail = _$sendEmail;
  static const EntityAction sendNow = _$sendNow;
  static const EntityAction bulkSendEmail = _$bulkSendEmail;
  static const EntityAction markSent = _$markSent;
  static const EntityAction markPaid = _$markPaid;
  static const EntityAction newClient = _$newClient;
  static const EntityAction newInvoice = _$newInvoice;
  static const EntityAction newRecurringInvoice = _$newRecurringInvoice;
  static const EntityAction newRecurringExpense = _$newRecurringExpense;
  static const EntityAction newRecurringQuote = _$newRecurringQuote;
  static const EntityAction newQuote = _$newQuote;
  static const EntityAction newCredit = _$newCredit;
  static const EntityAction newExpense = _$newExpense;
  static const EntityAction newProject = _$newProject;
  static const EntityAction newTask = _$newTask;
  static const EntityAction newVendor = _$newVendor;
  static const EntityAction newPurchaseOrder = _$newPurchaseOrder;
  static const EntityAction newTransaction = _$newTransaction;
  static const EntityAction clientPortal = _$clientPortal;
  static const EntityAction vendorPortal = _$vendorPortal;
  static const EntityAction newPayment = _$newPayment;
  static const EntityAction settings = _$settings;
  static const EntityAction refundPayment = _$refundPayment;
  static const EntityAction viewPdf = _$viewPdf;
  static const EntityAction viewStatement = _$viewStatement;
  static const EntityAction viewDocument = _$viewDocument;
  static const EntityAction more = _$more;
  static const EntityAction printPdf = _$printPdf;
  static const EntityAction start = _$start;
  static const EntityAction resume = _$resume;
  static const EntityAction stop = _$stop;
  static const EntityAction toggleMultiselect = _$toggleMultiselect;
  static const EntityAction reverse = _$reverse;
  static const EntityAction cancelInvoice = _$cancelInvoice;
  static const EntityAction copy = _$copy;
  static const EntityAction invoiceTask = _$invoiceTask;
  static const EntityAction invoiceExpense = _$invoiceExpense;
  static const EntityAction invoiceProject = _$invoiceProject;
  static const EntityAction resendInvite = _$resendInvite;
  static const EntityAction disconnect = _$disconnect;
  static const EntityAction viewInvoice = _$viewInvoice;
  static const EntityAction viewExpense = _$viewExpense;
  static const EntityAction changeStatus = _$changeStatus;
  static const EntityAction addToInvoice = _$addToInvoice;
  static const EntityAction back = _$back;
  static const EntityAction save = _$save;
  static const EntityAction accept = _$accept;
  static const EntityAction addToInventory = _$addToInventory;
  static const EntityAction convert = _$convert;
  static const EntityAction convertMatched = _$convertMatched;
  static const EntityAction convertToExpense = _$convertToExpense;
  static const EntityAction convertToPayment = _$convertToPayment;
  static const EntityAction convertToInvoice = _$convertToInvoice;
  static const EntityAction convertToProject = _$convertToProject;
  static const EntityAction merge = _$merge;
  static const EntityAction bulkPrint = _$bulkPrint;
  static const EntityAction autoBill = _$autoBill;
  static const EntityAction schedule = _$schedule;
  static const EntityAction updatePrices = _$updatePrices;
  static const EntityAction increasePrices = _$increasePrices;
  static const EntityAction setTaxCategory = _$setTaxCategory;
  static const EntityAction eInvoice = _$eInvoice;
  static const EntityAction unlink = _$unlink;
  static const EntityAction runTemplate = _$runTemplate;

  @override
  String toString() {
    if (this == EntityAction.addToInvoice) {
      return 'action_add_to_invoice';
    } else if (this == EntityAction.viewDocument) {
      return 'view';
    }

    return toSnakeCase(super.toString());
  }

  bool get applyMaxLimit => ![
        EntityAction.bulkDownload,
      ].contains(this);

  bool get isServerSide => [
        EntityAction.start,
        EntityAction.stop,
        EntityAction.markPaid,
        EntityAction.markSent,
        EntityAction.convertToInvoice,
        EntityAction.approve,
        EntityAction.cancelInvoice,
        EntityAction.resume,
        EntityAction.archive,
        EntityAction.delete,
        EntityAction.restore,
        EntityAction.purge,
        EntityAction.sendNow,
        EntityAction.autoBill,
      ].contains(this);

  bool get requiresSecondRequest => [
        EntityAction.archive,
        EntityAction.delete,
        EntityAction.restore,
      ].contains(this);

  bool get isClientSide => !isServerSide;

  String toApiParam() {
    final value = toString();

    if (this == EntityAction.runTemplate) {
      return 'template';
    }

    if (this == EntityAction.sendEmail || this == EntityAction.bulkSendEmail) {
      return 'email';
    } else if (this == EntityAction.cancelInvoice) {
      return 'cancel';
    } else if (this == EntityAction.convertToExpense) {
      return 'expense';
    } else if (this == EntityAction.resume) {
      return 'start';
    } else if (this == EntityAction.setTaxCategory) {
      return 'set_tax_id';
    }

    // else if (value == 'approve') {
    //  return 'approved';
    // }

    return value;
  }

  static EntityAction? newEntityType(EntityType? entityType) {
    switch (entityType) {
      case EntityType.client:
        return EntityAction.newClient;
      case EntityType.invoice:
        return EntityAction.newInvoice;
      case EntityType.recurringInvoice:
        return EntityAction.newRecurringInvoice;
      case EntityType.quote:
        return EntityAction.newQuote;
      case EntityType.credit:
        return EntityAction.newCredit;
      case EntityType.payment:
        return EntityAction.newPayment;
      case EntityType.expense:
        return EntityAction.newExpense;
      case EntityType.recurringExpense:
        return EntityAction.newRecurringExpense;
      case EntityType.project:
        return EntityAction.newProject;
      case EntityType.task:
        return EntityAction.newTask;
      case EntityType.vendor:
        return EntityAction.newVendor;
      case EntityType.purchaseOrder:
        return EntityAction.newPurchaseOrder;
      case EntityType.transaction:
        return EntityAction.newTransaction;
      default:
        print(
            '## ERROR: entityType $entityType not defined in EntityAction.newEntityType');
        return null;
    }
  }

  static BuiltSet<EntityAction> get values => _$values;

  static EntityAction valueOf(String name) => _$valueOf(name);
}
