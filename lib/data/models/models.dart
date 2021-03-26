import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
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

part 'models.g.dart';

class EntityAction extends EnumClass {
  const EntityAction._(String name) : super(name);

  static Serializer<EntityAction> get serializer => _$entityActionSerializer;

  static const EntityAction edit = _$edit;
  static const EntityAction archive = _$archive;
  static const EntityAction delete = _$delete;
  static const EntityAction restore = _$restore;
  static const EntityAction remove = _$remove;
  static const EntityAction clone = _$clone;
  static const EntityAction cloneToOther = _$cloneToOther;
  static const EntityAction cloneToCredit = _$cloneToCredit;
  static const EntityAction cloneToInvoice = _$cloneToInvoice;
  static const EntityAction cloneToQuote = _$cloneToQuote;
  static const EntityAction cloneToRecurring = _$cloneToRecurring;
  static const EntityAction convertToInvoice = _$convertToInvoice;
  static const EntityAction approve = _$approve;
  static const EntityAction apply = _$apply;
  static const EntityAction download = _$download;
  static const EntityAction emailInvoice = _$emailInvoice;
  static const EntityAction emailQuote = _$emailQuote;
  static const EntityAction emailCredit = _$emailCredit;
  static const EntityAction emailPayment = _$emailPayment;
  static const EntityAction markSent = _$markSent;
  static const EntityAction markPaid = _$markPaid;
  static const EntityAction newClient = _$newClient;
  static const EntityAction newInvoice = _$newInvoice;
  static const EntityAction newRecurringInvoice = _$newRecurringInvoice;
  static const EntityAction newQuote = _$newQuote;
  static const EntityAction newCredit = _$newCredit;
  static const EntityAction newExpense = _$newExpense;
  static const EntityAction newProject = _$newProject;
  static const EntityAction newTask = _$newTask;
  static const EntityAction newVendor = _$newVendor;
  static const EntityAction clientPortal = _$clientPortal;
  static const EntityAction newPayment = _$newPayment;
  static const EntityAction settings = _$settings;
  static const EntityAction refund = _$refund;
  static const EntityAction viewPdf = _$viewPdf;
  static const EntityAction more = _$more;
  static const EntityAction start = _$start;
  static const EntityAction resume = _$resume;
  static const EntityAction stop = _$stop;
  static const EntityAction toggleMultiselect = _$toggleMultiselect;
  static const EntityAction reverse = _$reverse;
  static const EntityAction cancel = _$cancel;
  static const EntityAction copy = _$copy;
  static const EntityAction invoiceTask = _$invoiceTask;
  static const EntityAction invoiceExpense = _$invoiceExpense;
  static const EntityAction invoiceProject = _$invoiceProject;
  static const EntityAction resendInvite = _$resendInvite;

  @override
  String toString() {
    return toSnakeCase(super.toString());
  }

  String toApiParam() {
    final value = toString();

    if (value.startsWith('email')) {
      return 'email';
    }

    return value;
  }

  static EntityAction emailEntityType(EntityType entityType) {
    switch (entityType) {
      case EntityType.invoice:
        return EntityAction.emailInvoice;
      case EntityType.quote:
        return EntityAction.emailQuote;
      case EntityType.credit:
        return EntityAction.emailCredit;
      default:
        return null;
    }
  }

  static EntityAction newEntityType(EntityType entityType) {
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
      case EntityType.project:
        return EntityAction.newProject;
      case EntityType.task:
        return EntityAction.newTask;
      case EntityType.vendor:
        return EntityAction.newVendor;
      default:
        print(
            'ERROR: entityType $entityType not defined in EntityAction.newEntityType');
        return null;
    }
  }

  static BuiltSet<EntityAction> get values => _$values;

  static EntityAction valueOf(String name) => _$valueOf(name);
}
