import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/data/models/static/size_model.dart';
import 'package:invoiceninja_flutter/data/models/static/industry_model.dart';
import 'package:invoiceninja_flutter/data/models/static/timezone_model.dart';
import 'package:invoiceninja_flutter/data/models/static/date_format_model.dart';
import 'package:invoiceninja_flutter/data/models/static/datetime_format_model.dart';

import 'package:invoiceninja_flutter/data/models/static/country_model.dart';
import 'package:invoiceninja_flutter/data/models/static/language_model.dart';
import 'package:invoiceninja_flutter/data/models/static/payment_type_model.dart';
import 'package:invoiceninja_flutter/data/models/static/invoice_design_model.dart';
import 'package:invoiceninja_flutter/data/models/static/invoice_status_model.dart';
import 'package:invoiceninja_flutter/data/models/static/frequency_model.dart';

part 'static_data_model.g.dart';

abstract class StaticDataListResponse implements Built<StaticDataListResponse, StaticDataListResponseBuilder> {

  factory StaticDataListResponse([void updates(StaticDataListResponseBuilder b)]) = _$StaticDataListResponse;
  StaticDataListResponse._();

  BuiltList<StaticDataEntity> get data;

  static Serializer<StaticDataListResponse> get serializer => _$staticDataListResponseSerializer;
}

abstract class StaticDataItemResponse implements Built<StaticDataItemResponse, StaticDataItemResponseBuilder> {

  factory StaticDataItemResponse([void updates(StaticDataItemResponseBuilder b)]) = _$StaticDataItemResponse;
  StaticDataItemResponse._();

  StaticDataEntity get data;

  static Serializer<StaticDataItemResponse> get serializer => _$staticDataItemResponseSerializer;
}

class StaticDataFields {
  static const String currencies = 'currencies';
  static const String sizes = 'sizes';
  static const String industries = 'industries';
  static const String timezones = 'timezones';
  static const String dateFormats = 'dateFormats';
  static const String datetimeFormats = 'datetimeFormats';
  static const String languages = 'languages';
  static const String paymentTypes = 'paymentTypes';
  static const String countries = 'countries';
  static const String invoiceDesigns = 'invoiceDesigns';
  static const String invoiceStatus = 'invoiceStatus';
  static const String frequencies = 'frequencies';
  static const String gateways = 'gateways';
  static const String gatewayTypes = 'gatewayTypes';
  static const String fonts = 'fonts';
  static const String banks = 'banks';
}

abstract class StaticDataEntity implements Built<StaticDataEntity, StaticDataEntityBuilder> {

  factory StaticDataEntity() {
    return _$StaticDataEntity._(
      currencies: BuiltList<CurrencyEntity>(),
      sizes: BuiltList<SizeEntity>(),
      industries: BuiltList<IndustryEntity>(),
      timezones: BuiltList<TimezoneEntity>(),
      dateFormats: BuiltList<DateFormatEntity>(),
      datetimeFormats: BuiltList<DatetimeFormatEntity>(),
      languages: BuiltList<LanguageEntity>(),
      paymentTypes: BuiltList<PaymentTypeEntity>(),
      countries: BuiltList<CountryEntity>(),
      invoiceDesigns: BuiltList<InvoiceDesignEntity>(),
      invoiceStatus: BuiltList<InvoiceStatusEntity>(),
      frequencies: BuiltList<FrequencyEntity>(),
    );
  }
  StaticDataEntity._();

  BuiltList<CurrencyEntity> get currencies;

  BuiltList<SizeEntity> get sizes;

  BuiltList<IndustryEntity> get industries;

  BuiltList<TimezoneEntity> get timezones;

  BuiltList<DateFormatEntity> get dateFormats;

  BuiltList<DatetimeFormatEntity> get datetimeFormats;

  BuiltList<LanguageEntity> get languages;

  BuiltList<PaymentTypeEntity> get paymentTypes;

  BuiltList<CountryEntity> get countries;

  BuiltList<InvoiceDesignEntity> get invoiceDesigns;

  BuiltList<InvoiceStatusEntity> get invoiceStatus;

  BuiltList<FrequencyEntity> get frequencies;

  static Serializer<StaticDataEntity> get serializer => _$staticDataEntitySerializer;
}

