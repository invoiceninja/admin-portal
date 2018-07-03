import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/formatting.dart';

part 'entities.g.dart';



class EntityType extends EnumClass {
  const EntityType._(String name) : super(name);

  static Serializer<EntityType> get serializer => _$entityTypeSerializer;

  static const EntityType invoice = _$invoice;
  static const EntityType invoiceItem = _$invoiceItem;
  static const EntityType quote = _$quote;
  static const EntityType product = _$product;
  static const EntityType client = _$client;
  static const EntityType contact = _$contact;
  static const EntityType task = _$task;
  static const EntityType project = _$project;
  static const EntityType expense = _$expense;
  static const EntityType vendor = _$vendor;
  static const EntityType credit = _$credit;
  static const EntityType payment = _$payment;
  static const EntityType country = _$country;
  static const EntityType currency = _$currency;
  static const EntityType language = _$language;

  String get plural {
    return toString() + 's';
  }

  static BuiltSet<EntityType> get values => _$typeValues;
  static EntityType valueOf(String name) => _$typeValueOf(name);
}


class EntityState extends EnumClass {

  const EntityState._(String name) : super(name);

  static Serializer<EntityState> get serializer => _$entityStateSerializer;

  static const EntityState active = _$active;
  static const EntityState archived = _$archived;
  static const EntityState deleted = _$deleted;

  static BuiltSet<EntityState> get values => _$values;
  static EntityState valueOf(String name) => _$valueOf(name);
}

abstract class SelectableEntity {
  @nullable
  int get id;

  bool matchesSearch(String search) => true;
  String matchesSearchValue(String search) => null;

  String get listDisplayName => 'Error: listDisplayName not set';

  String listDisplayCost(AppState state) => 'Error: listDisplayCost not set';
}

abstract class BaseEntity extends Object with SelectableEntity {

  @nullable
  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

  String get entityKey => '__${entityType}__${id}__';

  EntityType get entityType => throw 'EntityType not set: ${this}';

  bool get isNew => id == null || id < 0;
  bool get isActive => archivedAt == null;
  bool get isArchived => archivedAt != null && ! isDeleted;

  bool matchesStates(BuiltList<EntityState> states) {
    if (states.isEmpty) {
      return true;
    }

    if (states.contains(EntityState.active) && isActive) {
      return true;
    }

    if (states.contains(EntityState.archived) && isArchived) {
      return true;
    }

    if (states.contains(EntityState.deleted) && isDeleted) {
      return true;
    }

    return false;
  }
}

abstract class ConvertToInvoiceItem {
  InvoiceItemEntity get asInvoiceItem;
}

abstract class CalculateInvoiceTotal {
  bool get isAmountDiscount;
  double get taxRate1;
  double get taxRate2;
  double get discount;
  double get customValue1;
  double get customValue2;
  bool get customTaxes1;
  bool get customTaxes2;
  BuiltList<InvoiceItemEntity> get invoiceItems;

  double calculateTotal([bool useInclusiveTaxes = false]) {
    double total = baseTotal;
    double itemTax = 0.0;

    invoiceItems.forEach((item) {
      final double qty = round(item.qty, 4);
      final double cost = round(item.cost, 4);
      final double itemDiscount = round(item.discount, 2);
      final double taxRate1 = round(item.taxRate1, 3);
      final double taxRate2 = round(item.taxRate2, 3);

      double lineTotal = qty * cost;

      if (itemDiscount != 0) {
        if (isAmountDiscount) {
          lineTotal -= itemDiscount;
        } else {
          lineTotal -= round(lineTotal * itemDiscount / 100, 4);
        }
      }

      if (discount != 0) {
        if (isAmountDiscount) {
          if (total != 0) {
            lineTotal -= round(lineTotal / total * discount, 4);
          }
        }
      }
      if (taxRate1 != 0) {
        itemTax += round(lineTotal * taxRate1 / 100, 2);
      }
      if (taxRate2 != 0) {
        itemTax += round(lineTotal * taxRate2 / 100, 2);
      }
    });

    if (discount != 0.0) {
      if (isAmountDiscount) {
        total -= round(discount, 2);
      } else {
        total -= round(total * discount / 100, 2);
      }
    }

    if (customValue1 != 0.0 && customTaxes1) {
      total += round(customValue1, 2);
    }

    if (customValue2 != 0.0 && customTaxes2) {
      total += round(customValue2, 2);
    }

    if (! useInclusiveTaxes) {
      final double taxAmount1 = round(total * taxRate1 / 100, 2);
      final double taxAmount2 = round(total * taxRate1 / 100, 2);

      total += itemTax + taxAmount1 + taxAmount2;
    }

    if (customValue1 != 0.0 && ! customTaxes1) {
      total += round(customValue1, 2);
    }

    if (customValue2 != 0.0 && ! customTaxes2) {
      total += round(customValue2, 2);
    }

    return total;
  }

  double get baseTotal {
    var total = 0.0;

    invoiceItems.forEach((item) {
      final double qty = round(item.qty, 4);
      final double cost = round(item.cost, 4);
      final double discount = round(item.discount, 2);

      double lineTotal = qty * cost;

      if (discount != 0) {
        if (isAmountDiscount) {
          lineTotal -= discount;
        } else {
          lineTotal -= round(lineTotal * discount / 100, 4);
        }
      }

      total += round(lineTotal, 2);
    });

    return total;
  }
}


abstract class ErrorMessage implements Built<ErrorMessage, ErrorMessageBuilder> {

  factory ErrorMessage([void updates(ErrorMessageBuilder b)]) = _$ErrorMessage;
  ErrorMessage._();

  String get message;

  static Serializer<ErrorMessage> get serializer => _$errorMessageSerializer;
}


abstract class LoginResponse implements Built<LoginResponse, LoginResponseBuilder> {

  factory LoginResponse([void updates(LoginResponseBuilder b)]) = _$LoginResponse;
  LoginResponse._();

  LoginResponseData get data;

  @nullable
  ErrorMessage get error;

  static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;
}

abstract class LoginResponseData implements Built<LoginResponseData, LoginResponseDataBuilder> {

  factory LoginResponseData([void updates(LoginResponseDataBuilder b)]) = _$LoginResponseData;
  LoginResponseData._();

  BuiltList<CompanyEntity> get accounts;
  String get version;
  StaticData get static;

  static Serializer<LoginResponseData> get serializer => _$loginResponseDataSerializer;
}

abstract class StaticData implements Built<StaticData, StaticDataBuilder> {

  factory StaticData([void updates(StaticDataBuilder b)]) = _$StaticData;
  StaticData._();

  BuiltList<CurrencyEntity> get currencies;
  BuiltList<SizeEntity> get sizes;
  BuiltList<IndustryEntity> get industries;
  BuiltList<TimezoneEntity> get timezones;
  BuiltList<DateFormatEntity> get dateFormats;
  BuiltList<DatetimeFormatEntity> get datetimeFormats;
  BuiltList<LanguageEntity> get languages;
  BuiltList<PaymentTypeEntity> get paymentTypes;
  BuiltList<CountryEntity> get countries;
  BuiltList<InvoiceStatusEntity> get invoiceStatus;
  BuiltList<FrequencyEntity> get frequencies;

  static Serializer<StaticData> get serializer => _$staticDataSerializer;
}



abstract class DashboardResponse implements Built<DashboardResponse, DashboardResponseBuilder> {

  factory DashboardResponse([void updates(DashboardResponseBuilder b)]) = _$DashboardResponse;
  DashboardResponse._();

  DashboardEntity get data;

  static Serializer<DashboardResponse> get serializer => _$dashboardResponseSerializer;
}


abstract class DashboardEntity implements Built<DashboardEntity, DashboardEntityBuilder> {

  factory DashboardEntity([void updates(DashboardEntityBuilder b)]) = _$DashboardEntity;
  DashboardEntity._();

  @nullable
  double get paidToDate;

  @nullable
  int get paidToDateCurrency;

  @nullable
  double get balances;

  @nullable
  int get balancesCurrency;

  @nullable
  double get averageInvoice;

  @nullable
  int get averageInvoiceCurrency;

  @nullable
  int get invoicesSent;

  @nullable
  int get activeClients;

  static Serializer<DashboardEntity> get serializer => _$dashboardEntitySerializer;
}
