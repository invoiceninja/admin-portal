import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

export 'package:invoiceninja_flutter/data/models/entities.dart';
export 'package:invoiceninja_flutter/data/models/product_model.dart';
export 'package:invoiceninja_flutter/data/models/client_model.dart';
export 'package:invoiceninja_flutter/data/models/company_model.dart';
export 'package:invoiceninja_flutter/data/models/credit_model.dart';
export 'package:invoiceninja_flutter/data/models/project_model.dart';
export 'package:invoiceninja_flutter/data/models/payment_model.dart';
export 'package:invoiceninja_flutter/data/models/invoice_model.dart';
export 'package:invoiceninja_flutter/data/models/task_model.dart';
export 'package:invoiceninja_flutter/data/models/expense_model.dart';
export 'package:invoiceninja_flutter/data/models/vendor_model.dart';
export 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';
export 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
export 'package:invoiceninja_flutter/data/models/static/size_model.dart';
export 'package:invoiceninja_flutter/data/models/static/industry_model.dart';
export 'package:invoiceninja_flutter/data/models/static/timezone_model.dart';
export 'package:invoiceninja_flutter/data/models/static/date_format_model.dart';
export 'package:invoiceninja_flutter/data/models/static/datetime_format_model.dart';
export 'package:invoiceninja_flutter/data/models/static/language_model.dart';
export 'package:invoiceninja_flutter/data/models/static/payment_type_model.dart';
export 'package:invoiceninja_flutter/data/models/static/country_model.dart';
export 'package:invoiceninja_flutter/data/models/static/invoice_design_model.dart';
export 'package:invoiceninja_flutter/data/models/static/invoice_status_model.dart';
export 'package:invoiceninja_flutter/data/models/static/frequency_model.dart';

part 'models.g.dart';

class EntityAction extends EnumClass {

  const EntityAction._(String name) : super(name);

  static Serializer<EntityAction> get serializer => _$entityActionSerializer;

  static const EntityAction edit = _$edit;
  static const EntityAction archive = _$archive;
  static const EntityAction delete = _$delete;
  static const EntityAction restore = _$restore;
  static const EntityAction clone = _$clone;
  static const EntityAction cloneToInvoice = _$cloneToInvoice;
  static const EntityAction cloneToQuote = _$cloneToQuote;
  static const EntityAction convert = _$convert;
  static const EntityAction download = _$download;
  static const EntityAction sendEmail = _$sendEmail;
  static const EntityAction markSent = _$markSent;
  static const EntityAction newInvoice = _$newInvoice;
  static const EntityAction viewInvoice = _$viewInvoice;
  static const EntityAction clientPortal = _$clientPortal;
  static const EntityAction enterPayment = _$enterPayment;
  static const EntityAction pdf = _$pdf;
  static const EntityAction more = _$more;
  static const EntityAction start = _$start;
  static const EntityAction resume = _$resume;
  static const EntityAction stop = _$stop;

  static BuiltSet<EntityAction> get values => _$values;
  static EntityAction valueOf(String name) => _$valueOf(name);
}

