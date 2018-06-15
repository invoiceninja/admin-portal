import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/static/currency_model.dart';
import 'package:invoiceninja/data/models/static/size_model.dart';
import 'package:invoiceninja/data/models/static/industry_model.dart';
import 'package:invoiceninja/data/models/static/timezone_model.dart';
import 'package:invoiceninja/data/models/static/date_format_model.dart';
import 'package:invoiceninja/data/models/static/datetime_format_model.dart';

import 'package:invoiceninja/data/models/static/country_model.dart';
import 'package:invoiceninja/data/models/static/language_model.dart';
import 'package:invoiceninja/data/models/static/payment_type_model.dart';
import 'package:invoiceninja/data/models/static/invoice_design_model.dart';
import 'package:invoiceninja/data/models/static/invoice_status_model.dart';
import 'package:invoiceninja/data/models/static/frequency_model.dart';

import 'package:invoiceninja/data/models/static/bank_model.dart';
import 'package:invoiceninja/data/models/static/font_model.dart';
import 'package:invoiceninja/data/models/static/gateway_model.dart';
import 'package:invoiceninja/data/models/static/gateway_type_model.dart';

part 'static_data_model.g.dart';

abstract class StaticDataListResponse implements Built<StaticDataListResponse, StaticDataListResponseBuilder> {

  BuiltList<StaticDataEntity> get data;

  StaticDataListResponse._();
  factory StaticDataListResponse([updates(StaticDataListResponseBuilder b)]) = _$StaticDataListResponse;
  static Serializer<StaticDataListResponse> get serializer => _$staticDataListResponseSerializer;
}

abstract class StaticDataItemResponse implements Built<StaticDataItemResponse, StaticDataItemResponseBuilder> {

  StaticDataEntity get data;

  StaticDataItemResponse._();
  factory StaticDataItemResponse([updates(StaticDataItemResponseBuilder b)]) = _$StaticDataItemResponse;
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

  @nullable
  BuiltList<CurrencyEntity> get currencies;

  @nullable
  BuiltList<SizeEntity> get sizes;

  @nullable
  BuiltList<IndustryEntity> get industries;

  @nullable
  BuiltList<TimezoneEntity> get timezones;

  @nullable
  BuiltList<DateFormatEntity> get dateFormats;

  @nullable
  BuiltList<DatetimeFormatEntity> get datetimeFormats;

  @nullable
  BuiltList<LanguageEntity> get languages;

  @nullable
  BuiltList<PaymentTypeEntity> get paymentTypes;

  @nullable
  BuiltList<CountryEntity> get countries;

  @nullable
  BuiltList<InvoiceDesignEntity> get invoiceDesigns;

  @nullable
  BuiltList<InvoiceStatusEntity> get invoiceStatus;

  @nullable
  BuiltList<FrequencyEntity> get frequencies;

/*
  @nullable
  BuiltList<GatewayEntity> get gateways;

  @nullable
  BuiltList<GatewayTypeEntity> get gatewayTypes;

  @nullable
  BuiltList<FontEntity> get fonts;

  @nullable
  BuiltList<BankEntity> get banks;
  */

  StaticDataEntity._();
  factory StaticDataEntity([updates(StaticDataEntityBuilder b)]) = _$StaticDataEntity;
  static Serializer<StaticDataEntity> get serializer => _$staticDataEntitySerializer;
}

