// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaxDataEntity> _$taxDataEntitySerializer =
    new _$TaxDataEntitySerializer();
Serializer<TaxConfigEntity> _$taxConfigEntitySerializer =
    new _$TaxConfigEntitySerializer();
Serializer<TaxConfigRegionEntity> _$taxConfigRegionEntitySerializer =
    new _$TaxConfigRegionEntitySerializer();
Serializer<TaxConfigSubregionEntity> _$taxConfigSubregionEntitySerializer =
    new _$TaxConfigSubregionEntitySerializer();

class _$TaxDataEntitySerializer implements StructuredSerializer<TaxDataEntity> {
  @override
  final Iterable<Type> types = const [TaxDataEntity, _$TaxDataEntity];
  @override
  final String wireName = 'TaxDataEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, TaxDataEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'geoPostalCode',
      serializers.serialize(object.geoPostalCode,
          specifiedType: const FullType(String)),
      'geoCity',
      serializers.serialize(object.geoCity,
          specifiedType: const FullType(String)),
      'geoCounty',
      serializers.serialize(object.geoCounty,
          specifiedType: const FullType(String)),
      'geoState',
      serializers.serialize(object.geoState,
          specifiedType: const FullType(String)),
      'taxSales',
      serializers.serialize(object.taxSales,
          specifiedType: const FullType(double)),
      'taxUse',
      serializers.serialize(object.taxUse,
          specifiedType: const FullType(double)),
      'txbService',
      serializers.serialize(object.txbService,
          specifiedType: const FullType(String)),
      'txbFreight',
      serializers.serialize(object.txbFreight,
          specifiedType: const FullType(String)),
      'stateSalesTax',
      serializers.serialize(object.stateSalesTax,
          specifiedType: const FullType(double)),
      'stateUseTax',
      serializers.serialize(object.stateUseTax,
          specifiedType: const FullType(double)),
      'citySalesTax',
      serializers.serialize(object.citySalesTax,
          specifiedType: const FullType(double)),
      'cityUseTax',
      serializers.serialize(object.cityUseTax,
          specifiedType: const FullType(double)),
      'cityTaxCode',
      serializers.serialize(object.cityTaxCode,
          specifiedType: const FullType(String)),
      'countySalesTax',
      serializers.serialize(object.countySalesTax,
          specifiedType: const FullType(double)),
      'countyUseTax',
      serializers.serialize(object.countyUseTax,
          specifiedType: const FullType(double)),
      'countyTaxCode',
      serializers.serialize(object.countyTaxCode,
          specifiedType: const FullType(String)),
      'districtSalesTax',
      serializers.serialize(object.districtSalesTax,
          specifiedType: const FullType(double)),
      'districtUseTax',
      serializers.serialize(object.districtUseTax,
          specifiedType: const FullType(double)),
      'district1Code',
      serializers.serialize(object.district1Code,
          specifiedType: const FullType(String)),
      'district1SalesTax',
      serializers.serialize(object.district1SalesTax,
          specifiedType: const FullType(double)),
      'district1UseTax',
      serializers.serialize(object.district1UseTax,
          specifiedType: const FullType(double)),
      'district2Code',
      serializers.serialize(object.district2Code,
          specifiedType: const FullType(String)),
      'district2SalesTax',
      serializers.serialize(object.district2SalesTax,
          specifiedType: const FullType(double)),
      'district2UseTax',
      serializers.serialize(object.district2UseTax,
          specifiedType: const FullType(double)),
      'district3Code',
      serializers.serialize(object.district3Code,
          specifiedType: const FullType(String)),
      'district3SalesTax',
      serializers.serialize(object.district3SalesTax,
          specifiedType: const FullType(double)),
      'district3UseTax',
      serializers.serialize(object.district3UseTax,
          specifiedType: const FullType(double)),
      'district4Code',
      serializers.serialize(object.district4Code,
          specifiedType: const FullType(String)),
      'district4SalesTax',
      serializers.serialize(object.district4SalesTax,
          specifiedType: const FullType(double)),
      'district4UseTax',
      serializers.serialize(object.district4UseTax,
          specifiedType: const FullType(double)),
      'district5Code',
      serializers.serialize(object.district5Code,
          specifiedType: const FullType(String)),
      'district5SalesTax',
      serializers.serialize(object.district5SalesTax,
          specifiedType: const FullType(double)),
      'district5UseTax',
      serializers.serialize(object.district5UseTax,
          specifiedType: const FullType(double)),
      'originDestination',
      serializers.serialize(object.originDestination,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TaxDataEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxDataEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'geoPostalCode':
          result.geoPostalCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'geoCity':
          result.geoCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'geoCounty':
          result.geoCounty = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'geoState':
          result.geoState = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'taxSales':
          result.taxSales = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'taxUse':
          result.taxUse = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'txbService':
          result.txbService = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'txbFreight':
          result.txbFreight = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'stateSalesTax':
          result.stateSalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'stateUseTax':
          result.stateUseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'citySalesTax':
          result.citySalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cityUseTax':
          result.cityUseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cityTaxCode':
          result.cityTaxCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'countySalesTax':
          result.countySalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'countyUseTax':
          result.countyUseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'countyTaxCode':
          result.countyTaxCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'districtSalesTax':
          result.districtSalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'districtUseTax':
          result.districtUseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district1Code':
          result.district1Code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'district1SalesTax':
          result.district1SalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district1UseTax':
          result.district1UseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district2Code':
          result.district2Code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'district2SalesTax':
          result.district2SalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district2UseTax':
          result.district2UseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district3Code':
          result.district3Code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'district3SalesTax':
          result.district3SalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district3UseTax':
          result.district3UseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district4Code':
          result.district4Code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'district4SalesTax':
          result.district4SalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district4UseTax':
          result.district4UseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district5Code':
          result.district5Code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'district5SalesTax':
          result.district5SalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'district5UseTax':
          result.district5UseTax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'originDestination':
          result.originDestination = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TaxConfigEntitySerializer
    implements StructuredSerializer<TaxConfigEntity> {
  @override
  final Iterable<Type> types = const [TaxConfigEntity, _$TaxConfigEntity];
  @override
  final String wireName = 'TaxConfigEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, TaxConfigEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'version',
      serializers.serialize(object.version,
          specifiedType: const FullType(String)),
      'seller_subregion',
      serializers.serialize(object.sellerSubregion,
          specifiedType: const FullType(String)),
      'regions',
      serializers.serialize(object.regions,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(TaxConfigRegionEntity)
          ])),
    ];

    return result;
  }

  @override
  TaxConfigEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxConfigEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'version':
          result.version = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'seller_subregion':
          result.sellerSubregion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'regions':
          result.regions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaxConfigRegionEntity)
              ])));
          break;
      }
    }

    return result.build();
  }
}

class _$TaxConfigRegionEntitySerializer
    implements StructuredSerializer<TaxConfigRegionEntity> {
  @override
  final Iterable<Type> types = const [
    TaxConfigRegionEntity,
    _$TaxConfigRegionEntity
  ];
  @override
  final String wireName = 'TaxConfigRegionEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TaxConfigRegionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'has_sales_above_threshold',
      serializers.serialize(object.hasSalesAboveThreshold,
          specifiedType: const FullType(bool)),
      'tax_all_subregions',
      serializers.serialize(object.taxAll, specifiedType: const FullType(bool)),
      'tax_threshold',
      serializers.serialize(object.taxThreshold,
          specifiedType: const FullType(double)),
      'subregions',
      serializers.serialize(object.subregions,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(TaxConfigSubregionEntity)
          ])),
    ];

    return result;
  }

  @override
  TaxConfigRegionEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxConfigRegionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'has_sales_above_threshold':
          result.hasSalesAboveThreshold = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'tax_all_subregions':
          result.taxAll = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'tax_threshold':
          result.taxThreshold = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'subregions':
          result.subregions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaxConfigSubregionEntity)
              ])));
          break;
      }
    }

    return result.build();
  }
}

class _$TaxConfigSubregionEntitySerializer
    implements StructuredSerializer<TaxConfigSubregionEntity> {
  @override
  final Iterable<Type> types = const [
    TaxConfigSubregionEntity,
    _$TaxConfigSubregionEntity
  ];
  @override
  final String wireName = 'TaxConfigSubregionEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TaxConfigSubregionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'apply_tax',
      serializers.serialize(object.applyTax,
          specifiedType: const FullType(bool)),
      'tax_rate',
      serializers.serialize(object.taxRate,
          specifiedType: const FullType(double)),
      'tax_name',
      serializers.serialize(object.taxName,
          specifiedType: const FullType(String)),
      'reduced_tax_rate',
      serializers.serialize(object.reducedTaxRate,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TaxConfigSubregionEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxConfigSubregionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'apply_tax':
          result.applyTax = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'tax_rate':
          result.taxRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name':
          result.taxName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reduced_tax_rate':
          result.reducedTaxRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$TaxDataEntity extends TaxDataEntity {
  @override
  final String geoPostalCode;
  @override
  final String geoCity;
  @override
  final String geoCounty;
  @override
  final String geoState;
  @override
  final double taxSales;
  @override
  final double taxUse;
  @override
  final String txbService;
  @override
  final String txbFreight;
  @override
  final double stateSalesTax;
  @override
  final double stateUseTax;
  @override
  final double citySalesTax;
  @override
  final double cityUseTax;
  @override
  final String cityTaxCode;
  @override
  final double countySalesTax;
  @override
  final double countyUseTax;
  @override
  final String countyTaxCode;
  @override
  final double districtSalesTax;
  @override
  final double districtUseTax;
  @override
  final String district1Code;
  @override
  final double district1SalesTax;
  @override
  final double district1UseTax;
  @override
  final String district2Code;
  @override
  final double district2SalesTax;
  @override
  final double district2UseTax;
  @override
  final String district3Code;
  @override
  final double district3SalesTax;
  @override
  final double district3UseTax;
  @override
  final String district4Code;
  @override
  final double district4SalesTax;
  @override
  final double district4UseTax;
  @override
  final String district5Code;
  @override
  final double district5SalesTax;
  @override
  final double district5UseTax;
  @override
  final String originDestination;

  factory _$TaxDataEntity([void Function(TaxDataEntityBuilder) updates]) =>
      (new TaxDataEntityBuilder()..update(updates))._build();

  _$TaxDataEntity._(
      {this.geoPostalCode,
      this.geoCity,
      this.geoCounty,
      this.geoState,
      this.taxSales,
      this.taxUse,
      this.txbService,
      this.txbFreight,
      this.stateSalesTax,
      this.stateUseTax,
      this.citySalesTax,
      this.cityUseTax,
      this.cityTaxCode,
      this.countySalesTax,
      this.countyUseTax,
      this.countyTaxCode,
      this.districtSalesTax,
      this.districtUseTax,
      this.district1Code,
      this.district1SalesTax,
      this.district1UseTax,
      this.district2Code,
      this.district2SalesTax,
      this.district2UseTax,
      this.district3Code,
      this.district3SalesTax,
      this.district3UseTax,
      this.district4Code,
      this.district4SalesTax,
      this.district4UseTax,
      this.district5Code,
      this.district5SalesTax,
      this.district5UseTax,
      this.originDestination})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        geoPostalCode, r'TaxDataEntity', 'geoPostalCode');
    BuiltValueNullFieldError.checkNotNull(geoCity, r'TaxDataEntity', 'geoCity');
    BuiltValueNullFieldError.checkNotNull(
        geoCounty, r'TaxDataEntity', 'geoCounty');
    BuiltValueNullFieldError.checkNotNull(
        geoState, r'TaxDataEntity', 'geoState');
    BuiltValueNullFieldError.checkNotNull(
        taxSales, r'TaxDataEntity', 'taxSales');
    BuiltValueNullFieldError.checkNotNull(taxUse, r'TaxDataEntity', 'taxUse');
    BuiltValueNullFieldError.checkNotNull(
        txbService, r'TaxDataEntity', 'txbService');
    BuiltValueNullFieldError.checkNotNull(
        txbFreight, r'TaxDataEntity', 'txbFreight');
    BuiltValueNullFieldError.checkNotNull(
        stateSalesTax, r'TaxDataEntity', 'stateSalesTax');
    BuiltValueNullFieldError.checkNotNull(
        stateUseTax, r'TaxDataEntity', 'stateUseTax');
    BuiltValueNullFieldError.checkNotNull(
        citySalesTax, r'TaxDataEntity', 'citySalesTax');
    BuiltValueNullFieldError.checkNotNull(
        cityUseTax, r'TaxDataEntity', 'cityUseTax');
    BuiltValueNullFieldError.checkNotNull(
        cityTaxCode, r'TaxDataEntity', 'cityTaxCode');
    BuiltValueNullFieldError.checkNotNull(
        countySalesTax, r'TaxDataEntity', 'countySalesTax');
    BuiltValueNullFieldError.checkNotNull(
        countyUseTax, r'TaxDataEntity', 'countyUseTax');
    BuiltValueNullFieldError.checkNotNull(
        countyTaxCode, r'TaxDataEntity', 'countyTaxCode');
    BuiltValueNullFieldError.checkNotNull(
        districtSalesTax, r'TaxDataEntity', 'districtSalesTax');
    BuiltValueNullFieldError.checkNotNull(
        districtUseTax, r'TaxDataEntity', 'districtUseTax');
    BuiltValueNullFieldError.checkNotNull(
        district1Code, r'TaxDataEntity', 'district1Code');
    BuiltValueNullFieldError.checkNotNull(
        district1SalesTax, r'TaxDataEntity', 'district1SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district1UseTax, r'TaxDataEntity', 'district1UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district2Code, r'TaxDataEntity', 'district2Code');
    BuiltValueNullFieldError.checkNotNull(
        district2SalesTax, r'TaxDataEntity', 'district2SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district2UseTax, r'TaxDataEntity', 'district2UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district3Code, r'TaxDataEntity', 'district3Code');
    BuiltValueNullFieldError.checkNotNull(
        district3SalesTax, r'TaxDataEntity', 'district3SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district3UseTax, r'TaxDataEntity', 'district3UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district4Code, r'TaxDataEntity', 'district4Code');
    BuiltValueNullFieldError.checkNotNull(
        district4SalesTax, r'TaxDataEntity', 'district4SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district4UseTax, r'TaxDataEntity', 'district4UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district5Code, r'TaxDataEntity', 'district5Code');
    BuiltValueNullFieldError.checkNotNull(
        district5SalesTax, r'TaxDataEntity', 'district5SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district5UseTax, r'TaxDataEntity', 'district5UseTax');
    BuiltValueNullFieldError.checkNotNull(
        originDestination, r'TaxDataEntity', 'originDestination');
  }

  @override
  TaxDataEntity rebuild(void Function(TaxDataEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxDataEntityBuilder toBuilder() => new TaxDataEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxDataEntity &&
        geoPostalCode == other.geoPostalCode &&
        geoCity == other.geoCity &&
        geoCounty == other.geoCounty &&
        geoState == other.geoState &&
        taxSales == other.taxSales &&
        taxUse == other.taxUse &&
        txbService == other.txbService &&
        txbFreight == other.txbFreight &&
        stateSalesTax == other.stateSalesTax &&
        stateUseTax == other.stateUseTax &&
        citySalesTax == other.citySalesTax &&
        cityUseTax == other.cityUseTax &&
        cityTaxCode == other.cityTaxCode &&
        countySalesTax == other.countySalesTax &&
        countyUseTax == other.countyUseTax &&
        countyTaxCode == other.countyTaxCode &&
        districtSalesTax == other.districtSalesTax &&
        districtUseTax == other.districtUseTax &&
        district1Code == other.district1Code &&
        district1SalesTax == other.district1SalesTax &&
        district1UseTax == other.district1UseTax &&
        district2Code == other.district2Code &&
        district2SalesTax == other.district2SalesTax &&
        district2UseTax == other.district2UseTax &&
        district3Code == other.district3Code &&
        district3SalesTax == other.district3SalesTax &&
        district3UseTax == other.district3UseTax &&
        district4Code == other.district4Code &&
        district4SalesTax == other.district4SalesTax &&
        district4UseTax == other.district4UseTax &&
        district5Code == other.district5Code &&
        district5SalesTax == other.district5SalesTax &&
        district5UseTax == other.district5UseTax &&
        originDestination == other.originDestination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, geoPostalCode.hashCode);
    _$hash = $jc(_$hash, geoCity.hashCode);
    _$hash = $jc(_$hash, geoCounty.hashCode);
    _$hash = $jc(_$hash, geoState.hashCode);
    _$hash = $jc(_$hash, taxSales.hashCode);
    _$hash = $jc(_$hash, taxUse.hashCode);
    _$hash = $jc(_$hash, txbService.hashCode);
    _$hash = $jc(_$hash, txbFreight.hashCode);
    _$hash = $jc(_$hash, stateSalesTax.hashCode);
    _$hash = $jc(_$hash, stateUseTax.hashCode);
    _$hash = $jc(_$hash, citySalesTax.hashCode);
    _$hash = $jc(_$hash, cityUseTax.hashCode);
    _$hash = $jc(_$hash, cityTaxCode.hashCode);
    _$hash = $jc(_$hash, countySalesTax.hashCode);
    _$hash = $jc(_$hash, countyUseTax.hashCode);
    _$hash = $jc(_$hash, countyTaxCode.hashCode);
    _$hash = $jc(_$hash, districtSalesTax.hashCode);
    _$hash = $jc(_$hash, districtUseTax.hashCode);
    _$hash = $jc(_$hash, district1Code.hashCode);
    _$hash = $jc(_$hash, district1SalesTax.hashCode);
    _$hash = $jc(_$hash, district1UseTax.hashCode);
    _$hash = $jc(_$hash, district2Code.hashCode);
    _$hash = $jc(_$hash, district2SalesTax.hashCode);
    _$hash = $jc(_$hash, district2UseTax.hashCode);
    _$hash = $jc(_$hash, district3Code.hashCode);
    _$hash = $jc(_$hash, district3SalesTax.hashCode);
    _$hash = $jc(_$hash, district3UseTax.hashCode);
    _$hash = $jc(_$hash, district4Code.hashCode);
    _$hash = $jc(_$hash, district4SalesTax.hashCode);
    _$hash = $jc(_$hash, district4UseTax.hashCode);
    _$hash = $jc(_$hash, district5Code.hashCode);
    _$hash = $jc(_$hash, district5SalesTax.hashCode);
    _$hash = $jc(_$hash, district5UseTax.hashCode);
    _$hash = $jc(_$hash, originDestination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxDataEntity')
          ..add('geoPostalCode', geoPostalCode)
          ..add('geoCity', geoCity)
          ..add('geoCounty', geoCounty)
          ..add('geoState', geoState)
          ..add('taxSales', taxSales)
          ..add('taxUse', taxUse)
          ..add('txbService', txbService)
          ..add('txbFreight', txbFreight)
          ..add('stateSalesTax', stateSalesTax)
          ..add('stateUseTax', stateUseTax)
          ..add('citySalesTax', citySalesTax)
          ..add('cityUseTax', cityUseTax)
          ..add('cityTaxCode', cityTaxCode)
          ..add('countySalesTax', countySalesTax)
          ..add('countyUseTax', countyUseTax)
          ..add('countyTaxCode', countyTaxCode)
          ..add('districtSalesTax', districtSalesTax)
          ..add('districtUseTax', districtUseTax)
          ..add('district1Code', district1Code)
          ..add('district1SalesTax', district1SalesTax)
          ..add('district1UseTax', district1UseTax)
          ..add('district2Code', district2Code)
          ..add('district2SalesTax', district2SalesTax)
          ..add('district2UseTax', district2UseTax)
          ..add('district3Code', district3Code)
          ..add('district3SalesTax', district3SalesTax)
          ..add('district3UseTax', district3UseTax)
          ..add('district4Code', district4Code)
          ..add('district4SalesTax', district4SalesTax)
          ..add('district4UseTax', district4UseTax)
          ..add('district5Code', district5Code)
          ..add('district5SalesTax', district5SalesTax)
          ..add('district5UseTax', district5UseTax)
          ..add('originDestination', originDestination))
        .toString();
  }
}

class TaxDataEntityBuilder
    implements Builder<TaxDataEntity, TaxDataEntityBuilder> {
  _$TaxDataEntity _$v;

  String _geoPostalCode;
  String get geoPostalCode => _$this._geoPostalCode;
  set geoPostalCode(String geoPostalCode) =>
      _$this._geoPostalCode = geoPostalCode;

  String _geoCity;
  String get geoCity => _$this._geoCity;
  set geoCity(String geoCity) => _$this._geoCity = geoCity;

  String _geoCounty;
  String get geoCounty => _$this._geoCounty;
  set geoCounty(String geoCounty) => _$this._geoCounty = geoCounty;

  String _geoState;
  String get geoState => _$this._geoState;
  set geoState(String geoState) => _$this._geoState = geoState;

  double _taxSales;
  double get taxSales => _$this._taxSales;
  set taxSales(double taxSales) => _$this._taxSales = taxSales;

  double _taxUse;
  double get taxUse => _$this._taxUse;
  set taxUse(double taxUse) => _$this._taxUse = taxUse;

  String _txbService;
  String get txbService => _$this._txbService;
  set txbService(String txbService) => _$this._txbService = txbService;

  String _txbFreight;
  String get txbFreight => _$this._txbFreight;
  set txbFreight(String txbFreight) => _$this._txbFreight = txbFreight;

  double _stateSalesTax;
  double get stateSalesTax => _$this._stateSalesTax;
  set stateSalesTax(double stateSalesTax) =>
      _$this._stateSalesTax = stateSalesTax;

  double _stateUseTax;
  double get stateUseTax => _$this._stateUseTax;
  set stateUseTax(double stateUseTax) => _$this._stateUseTax = stateUseTax;

  double _citySalesTax;
  double get citySalesTax => _$this._citySalesTax;
  set citySalesTax(double citySalesTax) => _$this._citySalesTax = citySalesTax;

  double _cityUseTax;
  double get cityUseTax => _$this._cityUseTax;
  set cityUseTax(double cityUseTax) => _$this._cityUseTax = cityUseTax;

  String _cityTaxCode;
  String get cityTaxCode => _$this._cityTaxCode;
  set cityTaxCode(String cityTaxCode) => _$this._cityTaxCode = cityTaxCode;

  double _countySalesTax;
  double get countySalesTax => _$this._countySalesTax;
  set countySalesTax(double countySalesTax) =>
      _$this._countySalesTax = countySalesTax;

  double _countyUseTax;
  double get countyUseTax => _$this._countyUseTax;
  set countyUseTax(double countyUseTax) => _$this._countyUseTax = countyUseTax;

  String _countyTaxCode;
  String get countyTaxCode => _$this._countyTaxCode;
  set countyTaxCode(String countyTaxCode) =>
      _$this._countyTaxCode = countyTaxCode;

  double _districtSalesTax;
  double get districtSalesTax => _$this._districtSalesTax;
  set districtSalesTax(double districtSalesTax) =>
      _$this._districtSalesTax = districtSalesTax;

  double _districtUseTax;
  double get districtUseTax => _$this._districtUseTax;
  set districtUseTax(double districtUseTax) =>
      _$this._districtUseTax = districtUseTax;

  String _district1Code;
  String get district1Code => _$this._district1Code;
  set district1Code(String district1Code) =>
      _$this._district1Code = district1Code;

  double _district1SalesTax;
  double get district1SalesTax => _$this._district1SalesTax;
  set district1SalesTax(double district1SalesTax) =>
      _$this._district1SalesTax = district1SalesTax;

  double _district1UseTax;
  double get district1UseTax => _$this._district1UseTax;
  set district1UseTax(double district1UseTax) =>
      _$this._district1UseTax = district1UseTax;

  String _district2Code;
  String get district2Code => _$this._district2Code;
  set district2Code(String district2Code) =>
      _$this._district2Code = district2Code;

  double _district2SalesTax;
  double get district2SalesTax => _$this._district2SalesTax;
  set district2SalesTax(double district2SalesTax) =>
      _$this._district2SalesTax = district2SalesTax;

  double _district2UseTax;
  double get district2UseTax => _$this._district2UseTax;
  set district2UseTax(double district2UseTax) =>
      _$this._district2UseTax = district2UseTax;

  String _district3Code;
  String get district3Code => _$this._district3Code;
  set district3Code(String district3Code) =>
      _$this._district3Code = district3Code;

  double _district3SalesTax;
  double get district3SalesTax => _$this._district3SalesTax;
  set district3SalesTax(double district3SalesTax) =>
      _$this._district3SalesTax = district3SalesTax;

  double _district3UseTax;
  double get district3UseTax => _$this._district3UseTax;
  set district3UseTax(double district3UseTax) =>
      _$this._district3UseTax = district3UseTax;

  String _district4Code;
  String get district4Code => _$this._district4Code;
  set district4Code(String district4Code) =>
      _$this._district4Code = district4Code;

  double _district4SalesTax;
  double get district4SalesTax => _$this._district4SalesTax;
  set district4SalesTax(double district4SalesTax) =>
      _$this._district4SalesTax = district4SalesTax;

  double _district4UseTax;
  double get district4UseTax => _$this._district4UseTax;
  set district4UseTax(double district4UseTax) =>
      _$this._district4UseTax = district4UseTax;

  String _district5Code;
  String get district5Code => _$this._district5Code;
  set district5Code(String district5Code) =>
      _$this._district5Code = district5Code;

  double _district5SalesTax;
  double get district5SalesTax => _$this._district5SalesTax;
  set district5SalesTax(double district5SalesTax) =>
      _$this._district5SalesTax = district5SalesTax;

  double _district5UseTax;
  double get district5UseTax => _$this._district5UseTax;
  set district5UseTax(double district5UseTax) =>
      _$this._district5UseTax = district5UseTax;

  String _originDestination;
  String get originDestination => _$this._originDestination;
  set originDestination(String originDestination) =>
      _$this._originDestination = originDestination;

  TaxDataEntityBuilder();

  TaxDataEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _geoPostalCode = $v.geoPostalCode;
      _geoCity = $v.geoCity;
      _geoCounty = $v.geoCounty;
      _geoState = $v.geoState;
      _taxSales = $v.taxSales;
      _taxUse = $v.taxUse;
      _txbService = $v.txbService;
      _txbFreight = $v.txbFreight;
      _stateSalesTax = $v.stateSalesTax;
      _stateUseTax = $v.stateUseTax;
      _citySalesTax = $v.citySalesTax;
      _cityUseTax = $v.cityUseTax;
      _cityTaxCode = $v.cityTaxCode;
      _countySalesTax = $v.countySalesTax;
      _countyUseTax = $v.countyUseTax;
      _countyTaxCode = $v.countyTaxCode;
      _districtSalesTax = $v.districtSalesTax;
      _districtUseTax = $v.districtUseTax;
      _district1Code = $v.district1Code;
      _district1SalesTax = $v.district1SalesTax;
      _district1UseTax = $v.district1UseTax;
      _district2Code = $v.district2Code;
      _district2SalesTax = $v.district2SalesTax;
      _district2UseTax = $v.district2UseTax;
      _district3Code = $v.district3Code;
      _district3SalesTax = $v.district3SalesTax;
      _district3UseTax = $v.district3UseTax;
      _district4Code = $v.district4Code;
      _district4SalesTax = $v.district4SalesTax;
      _district4UseTax = $v.district4UseTax;
      _district5Code = $v.district5Code;
      _district5SalesTax = $v.district5SalesTax;
      _district5UseTax = $v.district5UseTax;
      _originDestination = $v.originDestination;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxDataEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaxDataEntity;
  }

  @override
  void update(void Function(TaxDataEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxDataEntity build() => _build();

  _$TaxDataEntity _build() {
    final _$result = _$v ??
        new _$TaxDataEntity._(
            geoPostalCode: BuiltValueNullFieldError.checkNotNull(
                geoPostalCode, r'TaxDataEntity', 'geoPostalCode'),
            geoCity: BuiltValueNullFieldError.checkNotNull(
                geoCity, r'TaxDataEntity', 'geoCity'),
            geoCounty: BuiltValueNullFieldError.checkNotNull(
                geoCounty, r'TaxDataEntity', 'geoCounty'),
            geoState: BuiltValueNullFieldError.checkNotNull(
                geoState, r'TaxDataEntity', 'geoState'),
            taxSales: BuiltValueNullFieldError.checkNotNull(
                taxSales, r'TaxDataEntity', 'taxSales'),
            taxUse: BuiltValueNullFieldError.checkNotNull(
                taxUse, r'TaxDataEntity', 'taxUse'),
            txbService: BuiltValueNullFieldError.checkNotNull(
                txbService, r'TaxDataEntity', 'txbService'),
            txbFreight: BuiltValueNullFieldError.checkNotNull(
                txbFreight, r'TaxDataEntity', 'txbFreight'),
            stateSalesTax: BuiltValueNullFieldError.checkNotNull(stateSalesTax, r'TaxDataEntity', 'stateSalesTax'),
            stateUseTax: BuiltValueNullFieldError.checkNotNull(stateUseTax, r'TaxDataEntity', 'stateUseTax'),
            citySalesTax: BuiltValueNullFieldError.checkNotNull(citySalesTax, r'TaxDataEntity', 'citySalesTax'),
            cityUseTax: BuiltValueNullFieldError.checkNotNull(cityUseTax, r'TaxDataEntity', 'cityUseTax'),
            cityTaxCode: BuiltValueNullFieldError.checkNotNull(cityTaxCode, r'TaxDataEntity', 'cityTaxCode'),
            countySalesTax: BuiltValueNullFieldError.checkNotNull(countySalesTax, r'TaxDataEntity', 'countySalesTax'),
            countyUseTax: BuiltValueNullFieldError.checkNotNull(countyUseTax, r'TaxDataEntity', 'countyUseTax'),
            countyTaxCode: BuiltValueNullFieldError.checkNotNull(countyTaxCode, r'TaxDataEntity', 'countyTaxCode'),
            districtSalesTax: BuiltValueNullFieldError.checkNotNull(districtSalesTax, r'TaxDataEntity', 'districtSalesTax'),
            districtUseTax: BuiltValueNullFieldError.checkNotNull(districtUseTax, r'TaxDataEntity', 'districtUseTax'),
            district1Code: BuiltValueNullFieldError.checkNotNull(district1Code, r'TaxDataEntity', 'district1Code'),
            district1SalesTax: BuiltValueNullFieldError.checkNotNull(district1SalesTax, r'TaxDataEntity', 'district1SalesTax'),
            district1UseTax: BuiltValueNullFieldError.checkNotNull(district1UseTax, r'TaxDataEntity', 'district1UseTax'),
            district2Code: BuiltValueNullFieldError.checkNotNull(district2Code, r'TaxDataEntity', 'district2Code'),
            district2SalesTax: BuiltValueNullFieldError.checkNotNull(district2SalesTax, r'TaxDataEntity', 'district2SalesTax'),
            district2UseTax: BuiltValueNullFieldError.checkNotNull(district2UseTax, r'TaxDataEntity', 'district2UseTax'),
            district3Code: BuiltValueNullFieldError.checkNotNull(district3Code, r'TaxDataEntity', 'district3Code'),
            district3SalesTax: BuiltValueNullFieldError.checkNotNull(district3SalesTax, r'TaxDataEntity', 'district3SalesTax'),
            district3UseTax: BuiltValueNullFieldError.checkNotNull(district3UseTax, r'TaxDataEntity', 'district3UseTax'),
            district4Code: BuiltValueNullFieldError.checkNotNull(district4Code, r'TaxDataEntity', 'district4Code'),
            district4SalesTax: BuiltValueNullFieldError.checkNotNull(district4SalesTax, r'TaxDataEntity', 'district4SalesTax'),
            district4UseTax: BuiltValueNullFieldError.checkNotNull(district4UseTax, r'TaxDataEntity', 'district4UseTax'),
            district5Code: BuiltValueNullFieldError.checkNotNull(district5Code, r'TaxDataEntity', 'district5Code'),
            district5SalesTax: BuiltValueNullFieldError.checkNotNull(district5SalesTax, r'TaxDataEntity', 'district5SalesTax'),
            district5UseTax: BuiltValueNullFieldError.checkNotNull(district5UseTax, r'TaxDataEntity', 'district5UseTax'),
            originDestination: BuiltValueNullFieldError.checkNotNull(originDestination, r'TaxDataEntity', 'originDestination'));
    replace(_$result);
    return _$result;
  }
}

class _$TaxConfigEntity extends TaxConfigEntity {
  @override
  final String version;
  @override
  final String sellerSubregion;
  @override
  final BuiltMap<String, TaxConfigRegionEntity> regions;

  factory _$TaxConfigEntity([void Function(TaxConfigEntityBuilder) updates]) =>
      (new TaxConfigEntityBuilder()..update(updates))._build();

  _$TaxConfigEntity._({this.version, this.sellerSubregion, this.regions})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        version, r'TaxConfigEntity', 'version');
    BuiltValueNullFieldError.checkNotNull(
        sellerSubregion, r'TaxConfigEntity', 'sellerSubregion');
    BuiltValueNullFieldError.checkNotNull(
        regions, r'TaxConfigEntity', 'regions');
  }

  @override
  TaxConfigEntity rebuild(void Function(TaxConfigEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxConfigEntityBuilder toBuilder() =>
      new TaxConfigEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxConfigEntity &&
        version == other.version &&
        sellerSubregion == other.sellerSubregion &&
        regions == other.regions;
  }

  int __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode;
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, sellerSubregion.hashCode);
    _$hash = $jc(_$hash, regions.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxConfigEntity')
          ..add('version', version)
          ..add('sellerSubregion', sellerSubregion)
          ..add('regions', regions))
        .toString();
  }
}

class TaxConfigEntityBuilder
    implements Builder<TaxConfigEntity, TaxConfigEntityBuilder> {
  _$TaxConfigEntity _$v;

  String _version;
  String get version => _$this._version;
  set version(String version) => _$this._version = version;

  String _sellerSubregion;
  String get sellerSubregion => _$this._sellerSubregion;
  set sellerSubregion(String sellerSubregion) =>
      _$this._sellerSubregion = sellerSubregion;

  MapBuilder<String, TaxConfigRegionEntity> _regions;
  MapBuilder<String, TaxConfigRegionEntity> get regions =>
      _$this._regions ??= new MapBuilder<String, TaxConfigRegionEntity>();
  set regions(MapBuilder<String, TaxConfigRegionEntity> regions) =>
      _$this._regions = regions;

  TaxConfigEntityBuilder() {
    TaxConfigEntity._initializeBuilder(this);
  }

  TaxConfigEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _sellerSubregion = $v.sellerSubregion;
      _regions = $v.regions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxConfigEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaxConfigEntity;
  }

  @override
  void update(void Function(TaxConfigEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxConfigEntity build() => _build();

  _$TaxConfigEntity _build() {
    _$TaxConfigEntity _$result;
    try {
      _$result = _$v ??
          new _$TaxConfigEntity._(
              version: BuiltValueNullFieldError.checkNotNull(
                  version, r'TaxConfigEntity', 'version'),
              sellerSubregion: BuiltValueNullFieldError.checkNotNull(
                  sellerSubregion, r'TaxConfigEntity', 'sellerSubregion'),
              regions: regions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'regions';
        regions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaxConfigEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxConfigRegionEntity extends TaxConfigRegionEntity {
  @override
  final bool hasSalesAboveThreshold;
  @override
  final bool taxAll;
  @override
  final double taxThreshold;
  @override
  final BuiltMap<String, TaxConfigSubregionEntity> subregions;

  factory _$TaxConfigRegionEntity(
          [void Function(TaxConfigRegionEntityBuilder) updates]) =>
      (new TaxConfigRegionEntityBuilder()..update(updates))._build();

  _$TaxConfigRegionEntity._(
      {this.hasSalesAboveThreshold,
      this.taxAll,
      this.taxThreshold,
      this.subregions})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(hasSalesAboveThreshold,
        r'TaxConfigRegionEntity', 'hasSalesAboveThreshold');
    BuiltValueNullFieldError.checkNotNull(
        taxAll, r'TaxConfigRegionEntity', 'taxAll');
    BuiltValueNullFieldError.checkNotNull(
        taxThreshold, r'TaxConfigRegionEntity', 'taxThreshold');
    BuiltValueNullFieldError.checkNotNull(
        subregions, r'TaxConfigRegionEntity', 'subregions');
  }

  @override
  TaxConfigRegionEntity rebuild(
          void Function(TaxConfigRegionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxConfigRegionEntityBuilder toBuilder() =>
      new TaxConfigRegionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxConfigRegionEntity &&
        hasSalesAboveThreshold == other.hasSalesAboveThreshold &&
        taxAll == other.taxAll &&
        taxThreshold == other.taxThreshold &&
        subregions == other.subregions;
  }

  int __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode;
    var _$hash = 0;
    _$hash = $jc(_$hash, hasSalesAboveThreshold.hashCode);
    _$hash = $jc(_$hash, taxAll.hashCode);
    _$hash = $jc(_$hash, taxThreshold.hashCode);
    _$hash = $jc(_$hash, subregions.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxConfigRegionEntity')
          ..add('hasSalesAboveThreshold', hasSalesAboveThreshold)
          ..add('taxAll', taxAll)
          ..add('taxThreshold', taxThreshold)
          ..add('subregions', subregions))
        .toString();
  }
}

class TaxConfigRegionEntityBuilder
    implements Builder<TaxConfigRegionEntity, TaxConfigRegionEntityBuilder> {
  _$TaxConfigRegionEntity _$v;

  bool _hasSalesAboveThreshold;
  bool get hasSalesAboveThreshold => _$this._hasSalesAboveThreshold;
  set hasSalesAboveThreshold(bool hasSalesAboveThreshold) =>
      _$this._hasSalesAboveThreshold = hasSalesAboveThreshold;

  bool _taxAll;
  bool get taxAll => _$this._taxAll;
  set taxAll(bool taxAll) => _$this._taxAll = taxAll;

  double _taxThreshold;
  double get taxThreshold => _$this._taxThreshold;
  set taxThreshold(double taxThreshold) => _$this._taxThreshold = taxThreshold;

  MapBuilder<String, TaxConfigSubregionEntity> _subregions;
  MapBuilder<String, TaxConfigSubregionEntity> get subregions =>
      _$this._subregions ??= new MapBuilder<String, TaxConfigSubregionEntity>();
  set subregions(MapBuilder<String, TaxConfigSubregionEntity> subregions) =>
      _$this._subregions = subregions;

  TaxConfigRegionEntityBuilder() {
    TaxConfigRegionEntity._initializeBuilder(this);
  }

  TaxConfigRegionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hasSalesAboveThreshold = $v.hasSalesAboveThreshold;
      _taxAll = $v.taxAll;
      _taxThreshold = $v.taxThreshold;
      _subregions = $v.subregions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxConfigRegionEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaxConfigRegionEntity;
  }

  @override
  void update(void Function(TaxConfigRegionEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxConfigRegionEntity build() => _build();

  _$TaxConfigRegionEntity _build() {
    _$TaxConfigRegionEntity _$result;
    try {
      _$result = _$v ??
          new _$TaxConfigRegionEntity._(
              hasSalesAboveThreshold: BuiltValueNullFieldError.checkNotNull(
                  hasSalesAboveThreshold,
                  r'TaxConfigRegionEntity',
                  'hasSalesAboveThreshold'),
              taxAll: BuiltValueNullFieldError.checkNotNull(
                  taxAll, r'TaxConfigRegionEntity', 'taxAll'),
              taxThreshold: BuiltValueNullFieldError.checkNotNull(
                  taxThreshold, r'TaxConfigRegionEntity', 'taxThreshold'),
              subregions: subregions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subregions';
        subregions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TaxConfigRegionEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxConfigSubregionEntity extends TaxConfigSubregionEntity {
  @override
  final bool applyTax;
  @override
  final double taxRate;
  @override
  final String taxName;
  @override
  final double reducedTaxRate;

  factory _$TaxConfigSubregionEntity(
          [void Function(TaxConfigSubregionEntityBuilder) updates]) =>
      (new TaxConfigSubregionEntityBuilder()..update(updates))._build();

  _$TaxConfigSubregionEntity._(
      {this.applyTax, this.taxRate, this.taxName, this.reducedTaxRate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        applyTax, r'TaxConfigSubregionEntity', 'applyTax');
    BuiltValueNullFieldError.checkNotNull(
        taxRate, r'TaxConfigSubregionEntity', 'taxRate');
    BuiltValueNullFieldError.checkNotNull(
        taxName, r'TaxConfigSubregionEntity', 'taxName');
    BuiltValueNullFieldError.checkNotNull(
        reducedTaxRate, r'TaxConfigSubregionEntity', 'reducedTaxRate');
  }

  @override
  TaxConfigSubregionEntity rebuild(
          void Function(TaxConfigSubregionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxConfigSubregionEntityBuilder toBuilder() =>
      new TaxConfigSubregionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxConfigSubregionEntity &&
        applyTax == other.applyTax &&
        taxRate == other.taxRate &&
        taxName == other.taxName &&
        reducedTaxRate == other.reducedTaxRate;
  }

  int __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode;
    var _$hash = 0;
    _$hash = $jc(_$hash, applyTax.hashCode);
    _$hash = $jc(_$hash, taxRate.hashCode);
    _$hash = $jc(_$hash, taxName.hashCode);
    _$hash = $jc(_$hash, reducedTaxRate.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxConfigSubregionEntity')
          ..add('applyTax', applyTax)
          ..add('taxRate', taxRate)
          ..add('taxName', taxName)
          ..add('reducedTaxRate', reducedTaxRate))
        .toString();
  }
}

class TaxConfigSubregionEntityBuilder
    implements
        Builder<TaxConfigSubregionEntity, TaxConfigSubregionEntityBuilder> {
  _$TaxConfigSubregionEntity _$v;

  bool _applyTax;
  bool get applyTax => _$this._applyTax;
  set applyTax(bool applyTax) => _$this._applyTax = applyTax;

  double _taxRate;
  double get taxRate => _$this._taxRate;
  set taxRate(double taxRate) => _$this._taxRate = taxRate;

  String _taxName;
  String get taxName => _$this._taxName;
  set taxName(String taxName) => _$this._taxName = taxName;

  double _reducedTaxRate;
  double get reducedTaxRate => _$this._reducedTaxRate;
  set reducedTaxRate(double reducedTaxRate) =>
      _$this._reducedTaxRate = reducedTaxRate;

  TaxConfigSubregionEntityBuilder() {
    TaxConfigSubregionEntity._initializeBuilder(this);
  }

  TaxConfigSubregionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _applyTax = $v.applyTax;
      _taxRate = $v.taxRate;
      _taxName = $v.taxName;
      _reducedTaxRate = $v.reducedTaxRate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxConfigSubregionEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaxConfigSubregionEntity;
  }

  @override
  void update(void Function(TaxConfigSubregionEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxConfigSubregionEntity build() => _build();

  _$TaxConfigSubregionEntity _build() {
    final _$result = _$v ??
        new _$TaxConfigSubregionEntity._(
            applyTax: BuiltValueNullFieldError.checkNotNull(
                applyTax, r'TaxConfigSubregionEntity', 'applyTax'),
            taxRate: BuiltValueNullFieldError.checkNotNull(
                taxRate, r'TaxConfigSubregionEntity', 'taxRate'),
            taxName: BuiltValueNullFieldError.checkNotNull(
                taxName, r'TaxConfigSubregionEntity', 'taxName'),
            reducedTaxRate: BuiltValueNullFieldError.checkNotNull(
                reducedTaxRate, r'TaxConfigSubregionEntity', 'reducedTaxRate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
