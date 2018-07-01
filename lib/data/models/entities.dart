import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/invoice/invoice_item.dart';

part 'entities.g.dart';



class EntityType extends EnumClass {
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

  const EntityType._(String name) : super(name);

  String get plural {
    return this.toString() + 's';
  }

  static BuiltSet<EntityType> get values => _$typeValues;
  static EntityType valueOf(String name) => _$typeValueOf(name);
}


class EntityState extends EnumClass {
  static Serializer<EntityState> get serializer => _$entityStateSerializer;

  static const EntityState active = _$active;
  static const EntityState archived = _$archived;
  static const EntityState deleted = _$deleted;

  const EntityState._(String name) : super(name);

  static BuiltSet<EntityState> get values => _$values;
  static EntityState valueOf(String name) => _$valueOf(name);
}

abstract class BaseEntity {

  @nullable
  int get id;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

  String get listDisplayName {
    return 'Error: not set';
  }

  String listDisplayCost(AppState state) {
    return 'Error: not set';
  }

  bool matchesSearch(String search) {
    return true;
  }

  String matchesSearchField(String search) {
    return null;
  }

  String matchesSearchValue(String search) {
    return null;
  }

  bool isNew() {
    return this.id == null || this.id < 0;
  }

  bool isActive() {
    return this.archivedAt == null;
  }

  bool isArchived() {
    return this.archivedAt != null && ! isDeleted;
  }

  bool matchesStates(BuiltList<EntityState> states) {
    if (states.length == 0) {
      return true;
    }

    if (states.contains(EntityState.active) && isActive()) {
      return true;
    }

    if (states.contains(EntityState.archived) && isArchived()) {
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
  double get discount;
  BuiltList<InvoiceItemEntity> get invoiceItems;

  double get total {
    var total = 0.0;

    invoiceItems.forEach((item) {
      var lineTotal = item.qty * item.cost;

      if (item.discount != 0) {
        if (isAmountDiscount) {
          lineTotal -= item.discount;
        } else {
          lineTotal -= lineTotal * item.discount / 100;
          //$lineTotal -= round($lineTotal * $discount / 100, 4);
        }
      }
      //$total += round($lineTotal, 2);

      total += lineTotal;
    });

    return total;
  }
}


abstract class ErrorMessage implements Built<ErrorMessage, ErrorMessageBuilder> {

  String get message;

  ErrorMessage._();
  factory ErrorMessage([updates(ErrorMessageBuilder b)]) = _$ErrorMessage;
  static Serializer<ErrorMessage> get serializer => _$errorMessageSerializer;
}


abstract class LoginResponse implements Built<LoginResponse, LoginResponseBuilder> {

  LoginResponseData get data;

  @nullable
  ErrorMessage get error;

  LoginResponse._();
  factory LoginResponse([updates(LoginResponseBuilder b)]) = _$LoginResponse;
  static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;
}

abstract class LoginResponseData implements Built<LoginResponseData, LoginResponseDataBuilder> {

  BuiltList<CompanyEntity> get accounts;
  String get version;
  StaticData get static;

  LoginResponseData._();
  factory LoginResponseData([updates(LoginResponseDataBuilder b)]) = _$LoginResponseData;
  static Serializer<LoginResponseData> get serializer => _$loginResponseDataSerializer;
}

abstract class StaticData implements Built<StaticData, StaticDataBuilder> {

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

  StaticData._();
  factory StaticData([updates(StaticDataBuilder b)]) = _$StaticData;
  static Serializer<StaticData> get serializer => _$staticDataSerializer;
}

abstract class CompanyEntity implements Built<CompanyEntity, CompanyEntityBuilder> {

  String get name;
  String get token;

  String get plan;

  @BuiltValueField(wireName: 'logo_url')
  String get logoUrl;

  @BuiltValueField(wireName: 'currency_id')
  int get currencyId;

  @BuiltValueField(wireName: 'timezone_id')
  int get timezoneId;

  @BuiltValueField(wireName: 'date_format_id')
  int get dateFormatId;

  @BuiltValueField(wireName: 'datetime_format_id')
  int get datetimeFormatId;

  @BuiltValueField(wireName: 'invoice_terms')
  String get defaultInvoiceTerms;

  @BuiltValueField(wireName: 'invoice_taxes')
  bool get enableInvoiceTaxes;

  @BuiltValueField(wireName: 'invoice_item_taxes')
  bool get enableInvoiceItemTaxes;

  @BuiltValueField(wireName: 'invoice_design_id')
  int get defaultInvoiceDesignId;

  @BuiltValueField(wireName: 'quote_design_id')
  int get defaultQuoteDesignId;

  @BuiltValueField(wireName: 'language_id')
  int get languageId;

  @BuiltValueField(wireName: 'invoice_footer')
  String get defaultInvoiceFooter;

  @BuiltValueField(wireName: 'show_item_taxes')
  bool get showInvoiceItemTaxes;

  @BuiltValueField(wireName: 'military_time')
  bool get enableMilitaryTime;

  @BuiltValueField(wireName: 'tax_name1')
  String get defaultTaxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  double get defaultTaxRate1;

  @BuiltValueField(wireName: 'tax_name2')
  String get defaultTaxName2;

  @BuiltValueField(wireName: 'tax_rate2')
  double get defaultTaxRate2;

  @BuiltValueField(wireName: 'quote_terms')
  String get defaultQuoteTerms;

  @BuiltValueField(wireName: 'show_currency_code')
  bool get showCurrencyCode;

  @BuiltValueField(wireName: 'enable_second_tax_rate')
  bool get enableSecondTaxRate;

  @BuiltValueField(wireName: 'start_of_week')
  int get startOfWeek;

  @BuiltValueField(wireName: 'financial_year_start')
  int get financialYearStart;

  @BuiltValueField(wireName: 'enabled_modules')
  int get enabledModules;

  @BuiltValueField(wireName: 'payment_terms')
  int get defaultPaymentTerms;

  @BuiltValueField(wireName: 'payment_type_id')
  int get defaultPaymentTypeId;

  @BuiltValueField(wireName: 'task_rate')
  double get defaultTaskRate;

  @BuiltValueField(wireName: 'inclusive_taxes')
  bool get enableInclusiveTaxes;

  @BuiltValueField(wireName: 'convert_products')
  bool get convertProductExchangeRate;

  @BuiltValueField(wireName: 'custom_invoice_taxes1')
  bool get enableCustomInvoiceTaxes1;

  @BuiltValueField(wireName: 'custom_invoice_taxes2')
  bool get enableCustomInvoiceTaxes2;

  //@BuiltValueField(wireName: 'custom_fields')
  //@BuiltValueField(wireName: 'invoice_labels')

  factory CompanyEntity() {
    return _$CompanyEntity._(
      name: '',
      token: '',
      plan: '',
      logoUrl: '',
      convertProductExchangeRate: false,
      currencyId: 1,
      dateFormatId: 1,
      datetimeFormatId: 1,
      defaultInvoiceDesignId: 1,
      defaultInvoiceFooter: '',
      defaultInvoiceTerms: '',
      defaultPaymentTerms: 0,
      defaultPaymentTypeId: 0,
      defaultQuoteDesignId: 1,
      defaultQuoteTerms: '',
      defaultTaskRate: 0.0,
      defaultTaxName1: '',
      defaultTaxRate1: 0.0,
      defaultTaxName2: '',
      defaultTaxRate2: 0.0,
      enableCustomInvoiceTaxes1: false,
      enableCustomInvoiceTaxes2: false,
      enabledModules: 0,
      enableInclusiveTaxes: false,
      enableInvoiceItemTaxes: false,
      enableInvoiceTaxes: true,
      enableMilitaryTime: false,
      enableSecondTaxRate: false,
      financialYearStart: 1,
      languageId: 1,
      showCurrencyCode: false,
      showInvoiceItemTaxes: false,
      startOfWeek: 1,
      timezoneId: 1,
    );
  }

  CompanyEntity._();
  static Serializer<CompanyEntity> get serializer => _$companyEntitySerializer;
}


abstract class DashboardResponse implements Built<DashboardResponse, DashboardResponseBuilder> {

  DashboardEntity get data;

  DashboardResponse._();
  factory DashboardResponse([updates(DashboardResponseBuilder b)]) = _$DashboardResponse;
  static Serializer<DashboardResponse> get serializer => _$dashboardResponseSerializer;
}


abstract class DashboardEntity implements Built<DashboardEntity, DashboardEntityBuilder> {

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

  DashboardEntity._();
  factory DashboardEntity([updates(DashboardEntityBuilder b)]) = _$DashboardEntity;
  static Serializer<DashboardEntity> get serializer => _$dashboardEntitySerializer;
}
