// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaxConfigEntity> _$taxConfigEntitySerializer =
    new _$TaxConfigEntitySerializer();

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

class _$TaxConfigEntity extends TaxConfigEntity {
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

  factory _$TaxConfigEntity([void Function(TaxConfigEntityBuilder) updates]) =>
      (new TaxConfigEntityBuilder()..update(updates))._build();

  _$TaxConfigEntity._(
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
        geoPostalCode, r'TaxConfigEntity', 'geoPostalCode');
    BuiltValueNullFieldError.checkNotNull(
        geoCity, r'TaxConfigEntity', 'geoCity');
    BuiltValueNullFieldError.checkNotNull(
        geoCounty, r'TaxConfigEntity', 'geoCounty');
    BuiltValueNullFieldError.checkNotNull(
        geoState, r'TaxConfigEntity', 'geoState');
    BuiltValueNullFieldError.checkNotNull(
        taxSales, r'TaxConfigEntity', 'taxSales');
    BuiltValueNullFieldError.checkNotNull(taxUse, r'TaxConfigEntity', 'taxUse');
    BuiltValueNullFieldError.checkNotNull(
        txbService, r'TaxConfigEntity', 'txbService');
    BuiltValueNullFieldError.checkNotNull(
        txbFreight, r'TaxConfigEntity', 'txbFreight');
    BuiltValueNullFieldError.checkNotNull(
        stateSalesTax, r'TaxConfigEntity', 'stateSalesTax');
    BuiltValueNullFieldError.checkNotNull(
        stateUseTax, r'TaxConfigEntity', 'stateUseTax');
    BuiltValueNullFieldError.checkNotNull(
        citySalesTax, r'TaxConfigEntity', 'citySalesTax');
    BuiltValueNullFieldError.checkNotNull(
        cityUseTax, r'TaxConfigEntity', 'cityUseTax');
    BuiltValueNullFieldError.checkNotNull(
        cityTaxCode, r'TaxConfigEntity', 'cityTaxCode');
    BuiltValueNullFieldError.checkNotNull(
        countySalesTax, r'TaxConfigEntity', 'countySalesTax');
    BuiltValueNullFieldError.checkNotNull(
        countyUseTax, r'TaxConfigEntity', 'countyUseTax');
    BuiltValueNullFieldError.checkNotNull(
        countyTaxCode, r'TaxConfigEntity', 'countyTaxCode');
    BuiltValueNullFieldError.checkNotNull(
        districtSalesTax, r'TaxConfigEntity', 'districtSalesTax');
    BuiltValueNullFieldError.checkNotNull(
        districtUseTax, r'TaxConfigEntity', 'districtUseTax');
    BuiltValueNullFieldError.checkNotNull(
        district1Code, r'TaxConfigEntity', 'district1Code');
    BuiltValueNullFieldError.checkNotNull(
        district1SalesTax, r'TaxConfigEntity', 'district1SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district1UseTax, r'TaxConfigEntity', 'district1UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district2Code, r'TaxConfigEntity', 'district2Code');
    BuiltValueNullFieldError.checkNotNull(
        district2SalesTax, r'TaxConfigEntity', 'district2SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district2UseTax, r'TaxConfigEntity', 'district2UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district3Code, r'TaxConfigEntity', 'district3Code');
    BuiltValueNullFieldError.checkNotNull(
        district3SalesTax, r'TaxConfigEntity', 'district3SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district3UseTax, r'TaxConfigEntity', 'district3UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district4Code, r'TaxConfigEntity', 'district4Code');
    BuiltValueNullFieldError.checkNotNull(
        district4SalesTax, r'TaxConfigEntity', 'district4SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district4UseTax, r'TaxConfigEntity', 'district4UseTax');
    BuiltValueNullFieldError.checkNotNull(
        district5Code, r'TaxConfigEntity', 'district5Code');
    BuiltValueNullFieldError.checkNotNull(
        district5SalesTax, r'TaxConfigEntity', 'district5SalesTax');
    BuiltValueNullFieldError.checkNotNull(
        district5UseTax, r'TaxConfigEntity', 'district5UseTax');
    BuiltValueNullFieldError.checkNotNull(
        originDestination, r'TaxConfigEntity', 'originDestination');
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
    return (newBuiltValueToStringHelper(r'TaxConfigEntity')
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

class TaxConfigEntityBuilder
    implements Builder<TaxConfigEntity, TaxConfigEntityBuilder> {
  _$TaxConfigEntity _$v;

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

  TaxConfigEntityBuilder();

  TaxConfigEntityBuilder get _$this {
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
    final _$result = _$v ??
        new _$TaxConfigEntity._(
            geoPostalCode: BuiltValueNullFieldError.checkNotNull(
                geoPostalCode, r'TaxConfigEntity', 'geoPostalCode'),
            geoCity: BuiltValueNullFieldError.checkNotNull(
                geoCity, r'TaxConfigEntity', 'geoCity'),
            geoCounty: BuiltValueNullFieldError.checkNotNull(
                geoCounty, r'TaxConfigEntity', 'geoCounty'),
            geoState: BuiltValueNullFieldError.checkNotNull(
                geoState, r'TaxConfigEntity', 'geoState'),
            taxSales: BuiltValueNullFieldError.checkNotNull(
                taxSales, r'TaxConfigEntity', 'taxSales'),
            taxUse: BuiltValueNullFieldError.checkNotNull(
                taxUse, r'TaxConfigEntity', 'taxUse'),
            txbService: BuiltValueNullFieldError.checkNotNull(
                txbService, r'TaxConfigEntity', 'txbService'),
            txbFreight: BuiltValueNullFieldError.checkNotNull(
                txbFreight, r'TaxConfigEntity', 'txbFreight'),
            stateSalesTax: BuiltValueNullFieldError.checkNotNull(stateSalesTax, r'TaxConfigEntity', 'stateSalesTax'),
            stateUseTax: BuiltValueNullFieldError.checkNotNull(stateUseTax, r'TaxConfigEntity', 'stateUseTax'),
            citySalesTax: BuiltValueNullFieldError.checkNotNull(citySalesTax, r'TaxConfigEntity', 'citySalesTax'),
            cityUseTax: BuiltValueNullFieldError.checkNotNull(cityUseTax, r'TaxConfigEntity', 'cityUseTax'),
            cityTaxCode: BuiltValueNullFieldError.checkNotNull(cityTaxCode, r'TaxConfigEntity', 'cityTaxCode'),
            countySalesTax: BuiltValueNullFieldError.checkNotNull(countySalesTax, r'TaxConfigEntity', 'countySalesTax'),
            countyUseTax: BuiltValueNullFieldError.checkNotNull(countyUseTax, r'TaxConfigEntity', 'countyUseTax'),
            countyTaxCode: BuiltValueNullFieldError.checkNotNull(countyTaxCode, r'TaxConfigEntity', 'countyTaxCode'),
            districtSalesTax: BuiltValueNullFieldError.checkNotNull(districtSalesTax, r'TaxConfigEntity', 'districtSalesTax'),
            districtUseTax: BuiltValueNullFieldError.checkNotNull(districtUseTax, r'TaxConfigEntity', 'districtUseTax'),
            district1Code: BuiltValueNullFieldError.checkNotNull(district1Code, r'TaxConfigEntity', 'district1Code'),
            district1SalesTax: BuiltValueNullFieldError.checkNotNull(district1SalesTax, r'TaxConfigEntity', 'district1SalesTax'),
            district1UseTax: BuiltValueNullFieldError.checkNotNull(district1UseTax, r'TaxConfigEntity', 'district1UseTax'),
            district2Code: BuiltValueNullFieldError.checkNotNull(district2Code, r'TaxConfigEntity', 'district2Code'),
            district2SalesTax: BuiltValueNullFieldError.checkNotNull(district2SalesTax, r'TaxConfigEntity', 'district2SalesTax'),
            district2UseTax: BuiltValueNullFieldError.checkNotNull(district2UseTax, r'TaxConfigEntity', 'district2UseTax'),
            district3Code: BuiltValueNullFieldError.checkNotNull(district3Code, r'TaxConfigEntity', 'district3Code'),
            district3SalesTax: BuiltValueNullFieldError.checkNotNull(district3SalesTax, r'TaxConfigEntity', 'district3SalesTax'),
            district3UseTax: BuiltValueNullFieldError.checkNotNull(district3UseTax, r'TaxConfigEntity', 'district3UseTax'),
            district4Code: BuiltValueNullFieldError.checkNotNull(district4Code, r'TaxConfigEntity', 'district4Code'),
            district4SalesTax: BuiltValueNullFieldError.checkNotNull(district4SalesTax, r'TaxConfigEntity', 'district4SalesTax'),
            district4UseTax: BuiltValueNullFieldError.checkNotNull(district4UseTax, r'TaxConfigEntity', 'district4UseTax'),
            district5Code: BuiltValueNullFieldError.checkNotNull(district5Code, r'TaxConfigEntity', 'district5Code'),
            district5SalesTax: BuiltValueNullFieldError.checkNotNull(district5SalesTax, r'TaxConfigEntity', 'district5SalesTax'),
            district5UseTax: BuiltValueNullFieldError.checkNotNull(district5UseTax, r'TaxConfigEntity', 'district5UseTax'),
            originDestination: BuiltValueNullFieldError.checkNotNull(originDestination, r'TaxConfigEntity', 'originDestination'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
