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
  Iterable<Object?> serialize(Serializers serializers, TaxDataEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      'stateSalesTax',
      serializers.serialize(object.stateSalesTax,
          specifiedType: const FullType(double)),
      'citySalesTax',
      serializers.serialize(object.citySalesTax,
          specifiedType: const FullType(double)),
      'cityTaxCode',
      serializers.serialize(object.cityTaxCode,
          specifiedType: const FullType(String)),
      'countySalesTax',
      serializers.serialize(object.countySalesTax,
          specifiedType: const FullType(double)),
      'countyTaxCode',
      serializers.serialize(object.countyTaxCode,
          specifiedType: const FullType(String)),
      'districtSalesTax',
      serializers.serialize(object.districtSalesTax,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TaxDataEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxDataEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'geoPostalCode':
          result.geoPostalCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'geoCity':
          result.geoCity = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'geoCounty':
          result.geoCounty = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'geoState':
          result.geoState = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'taxSales':
          result.taxSales = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'stateSalesTax':
          result.stateSalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'citySalesTax':
          result.citySalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'cityTaxCode':
          result.cityTaxCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'countySalesTax':
          result.countySalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'countyTaxCode':
          result.countyTaxCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'districtSalesTax':
          result.districtSalesTax = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
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
  Iterable<Object?> serialize(Serializers serializers, TaxConfigEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxConfigEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'version':
          result.version = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'seller_subregion':
          result.sellerSubregion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'regions':
          result.regions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaxConfigRegionEntity)
              ]))!);
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
  Iterable<Object?> serialize(
      Serializers serializers, TaxConfigRegionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxConfigRegionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'has_sales_above_threshold':
          result.hasSalesAboveThreshold = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'tax_all_subregions':
          result.taxAll = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'tax_threshold':
          result.taxThreshold = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'subregions':
          result.subregions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TaxConfigSubregionEntity)
              ]))!);
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
  Iterable<Object?> serialize(
      Serializers serializers, TaxConfigSubregionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxConfigSubregionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'apply_tax':
          result.applyTax = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'tax_rate':
          result.taxRate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name':
          result.taxName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reduced_tax_rate':
          result.reducedTaxRate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
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
  final double stateSalesTax;
  @override
  final double citySalesTax;
  @override
  final String cityTaxCode;
  @override
  final double countySalesTax;
  @override
  final String countyTaxCode;
  @override
  final double districtSalesTax;

  factory _$TaxDataEntity([void Function(TaxDataEntityBuilder)? updates]) =>
      (new TaxDataEntityBuilder()..update(updates))._build();

  _$TaxDataEntity._(
      {required this.geoPostalCode,
      required this.geoCity,
      required this.geoCounty,
      required this.geoState,
      required this.taxSales,
      required this.stateSalesTax,
      required this.citySalesTax,
      required this.cityTaxCode,
      required this.countySalesTax,
      required this.countyTaxCode,
      required this.districtSalesTax})
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
    BuiltValueNullFieldError.checkNotNull(
        stateSalesTax, r'TaxDataEntity', 'stateSalesTax');
    BuiltValueNullFieldError.checkNotNull(
        citySalesTax, r'TaxDataEntity', 'citySalesTax');
    BuiltValueNullFieldError.checkNotNull(
        cityTaxCode, r'TaxDataEntity', 'cityTaxCode');
    BuiltValueNullFieldError.checkNotNull(
        countySalesTax, r'TaxDataEntity', 'countySalesTax');
    BuiltValueNullFieldError.checkNotNull(
        countyTaxCode, r'TaxDataEntity', 'countyTaxCode');
    BuiltValueNullFieldError.checkNotNull(
        districtSalesTax, r'TaxDataEntity', 'districtSalesTax');
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
        stateSalesTax == other.stateSalesTax &&
        citySalesTax == other.citySalesTax &&
        cityTaxCode == other.cityTaxCode &&
        countySalesTax == other.countySalesTax &&
        countyTaxCode == other.countyTaxCode &&
        districtSalesTax == other.districtSalesTax;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, geoPostalCode.hashCode);
    _$hash = $jc(_$hash, geoCity.hashCode);
    _$hash = $jc(_$hash, geoCounty.hashCode);
    _$hash = $jc(_$hash, geoState.hashCode);
    _$hash = $jc(_$hash, taxSales.hashCode);
    _$hash = $jc(_$hash, stateSalesTax.hashCode);
    _$hash = $jc(_$hash, citySalesTax.hashCode);
    _$hash = $jc(_$hash, cityTaxCode.hashCode);
    _$hash = $jc(_$hash, countySalesTax.hashCode);
    _$hash = $jc(_$hash, countyTaxCode.hashCode);
    _$hash = $jc(_$hash, districtSalesTax.hashCode);
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
          ..add('stateSalesTax', stateSalesTax)
          ..add('citySalesTax', citySalesTax)
          ..add('cityTaxCode', cityTaxCode)
          ..add('countySalesTax', countySalesTax)
          ..add('countyTaxCode', countyTaxCode)
          ..add('districtSalesTax', districtSalesTax))
        .toString();
  }
}

class TaxDataEntityBuilder
    implements Builder<TaxDataEntity, TaxDataEntityBuilder> {
  _$TaxDataEntity? _$v;

  String? _geoPostalCode;
  String? get geoPostalCode => _$this._geoPostalCode;
  set geoPostalCode(String? geoPostalCode) =>
      _$this._geoPostalCode = geoPostalCode;

  String? _geoCity;
  String? get geoCity => _$this._geoCity;
  set geoCity(String? geoCity) => _$this._geoCity = geoCity;

  String? _geoCounty;
  String? get geoCounty => _$this._geoCounty;
  set geoCounty(String? geoCounty) => _$this._geoCounty = geoCounty;

  String? _geoState;
  String? get geoState => _$this._geoState;
  set geoState(String? geoState) => _$this._geoState = geoState;

  double? _taxSales;
  double? get taxSales => _$this._taxSales;
  set taxSales(double? taxSales) => _$this._taxSales = taxSales;

  double? _stateSalesTax;
  double? get stateSalesTax => _$this._stateSalesTax;
  set stateSalesTax(double? stateSalesTax) =>
      _$this._stateSalesTax = stateSalesTax;

  double? _citySalesTax;
  double? get citySalesTax => _$this._citySalesTax;
  set citySalesTax(double? citySalesTax) => _$this._citySalesTax = citySalesTax;

  String? _cityTaxCode;
  String? get cityTaxCode => _$this._cityTaxCode;
  set cityTaxCode(String? cityTaxCode) => _$this._cityTaxCode = cityTaxCode;

  double? _countySalesTax;
  double? get countySalesTax => _$this._countySalesTax;
  set countySalesTax(double? countySalesTax) =>
      _$this._countySalesTax = countySalesTax;

  String? _countyTaxCode;
  String? get countyTaxCode => _$this._countyTaxCode;
  set countyTaxCode(String? countyTaxCode) =>
      _$this._countyTaxCode = countyTaxCode;

  double? _districtSalesTax;
  double? get districtSalesTax => _$this._districtSalesTax;
  set districtSalesTax(double? districtSalesTax) =>
      _$this._districtSalesTax = districtSalesTax;

  TaxDataEntityBuilder() {
    TaxDataEntity._initializeBuilder(this);
  }

  TaxDataEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _geoPostalCode = $v.geoPostalCode;
      _geoCity = $v.geoCity;
      _geoCounty = $v.geoCounty;
      _geoState = $v.geoState;
      _taxSales = $v.taxSales;
      _stateSalesTax = $v.stateSalesTax;
      _citySalesTax = $v.citySalesTax;
      _cityTaxCode = $v.cityTaxCode;
      _countySalesTax = $v.countySalesTax;
      _countyTaxCode = $v.countyTaxCode;
      _districtSalesTax = $v.districtSalesTax;
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
  void update(void Function(TaxDataEntityBuilder)? updates) {
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
            stateSalesTax: BuiltValueNullFieldError.checkNotNull(
                stateSalesTax, r'TaxDataEntity', 'stateSalesTax'),
            citySalesTax: BuiltValueNullFieldError.checkNotNull(
                citySalesTax, r'TaxDataEntity', 'citySalesTax'),
            cityTaxCode: BuiltValueNullFieldError.checkNotNull(
                cityTaxCode, r'TaxDataEntity', 'cityTaxCode'),
            countySalesTax:
                BuiltValueNullFieldError.checkNotNull(countySalesTax, r'TaxDataEntity', 'countySalesTax'),
            countyTaxCode: BuiltValueNullFieldError.checkNotNull(countyTaxCode, r'TaxDataEntity', 'countyTaxCode'),
            districtSalesTax: BuiltValueNullFieldError.checkNotNull(districtSalesTax, r'TaxDataEntity', 'districtSalesTax'));
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

  factory _$TaxConfigEntity([void Function(TaxConfigEntityBuilder)? updates]) =>
      (new TaxConfigEntityBuilder()..update(updates))._build();

  _$TaxConfigEntity._(
      {required this.version,
      required this.sellerSubregion,
      required this.regions})
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
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
  _$TaxConfigEntity? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  String? _sellerSubregion;
  String? get sellerSubregion => _$this._sellerSubregion;
  set sellerSubregion(String? sellerSubregion) =>
      _$this._sellerSubregion = sellerSubregion;

  MapBuilder<String, TaxConfigRegionEntity>? _regions;
  MapBuilder<String, TaxConfigRegionEntity> get regions =>
      _$this._regions ??= new MapBuilder<String, TaxConfigRegionEntity>();
  set regions(MapBuilder<String, TaxConfigRegionEntity>? regions) =>
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
  void update(void Function(TaxConfigEntityBuilder)? updates) {
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
      late String _$failedField;
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
          [void Function(TaxConfigRegionEntityBuilder)? updates]) =>
      (new TaxConfigRegionEntityBuilder()..update(updates))._build();

  _$TaxConfigRegionEntity._(
      {required this.hasSalesAboveThreshold,
      required this.taxAll,
      required this.taxThreshold,
      required this.subregions})
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
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
  _$TaxConfigRegionEntity? _$v;

  bool? _hasSalesAboveThreshold;
  bool? get hasSalesAboveThreshold => _$this._hasSalesAboveThreshold;
  set hasSalesAboveThreshold(bool? hasSalesAboveThreshold) =>
      _$this._hasSalesAboveThreshold = hasSalesAboveThreshold;

  bool? _taxAll;
  bool? get taxAll => _$this._taxAll;
  set taxAll(bool? taxAll) => _$this._taxAll = taxAll;

  double? _taxThreshold;
  double? get taxThreshold => _$this._taxThreshold;
  set taxThreshold(double? taxThreshold) => _$this._taxThreshold = taxThreshold;

  MapBuilder<String, TaxConfigSubregionEntity>? _subregions;
  MapBuilder<String, TaxConfigSubregionEntity> get subregions =>
      _$this._subregions ??= new MapBuilder<String, TaxConfigSubregionEntity>();
  set subregions(MapBuilder<String, TaxConfigSubregionEntity>? subregions) =>
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
  void update(void Function(TaxConfigRegionEntityBuilder)? updates) {
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
      late String _$failedField;
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
          [void Function(TaxConfigSubregionEntityBuilder)? updates]) =>
      (new TaxConfigSubregionEntityBuilder()..update(updates))._build();

  _$TaxConfigSubregionEntity._(
      {required this.applyTax,
      required this.taxRate,
      required this.taxName,
      required this.reducedTaxRate})
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
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
  _$TaxConfigSubregionEntity? _$v;

  bool? _applyTax;
  bool? get applyTax => _$this._applyTax;
  set applyTax(bool? applyTax) => _$this._applyTax = applyTax;

  double? _taxRate;
  double? get taxRate => _$this._taxRate;
  set taxRate(double? taxRate) => _$this._taxRate = taxRate;

  String? _taxName;
  String? get taxName => _$this._taxName;
  set taxName(String? taxName) => _$this._taxName = taxName;

  double? _reducedTaxRate;
  double? get reducedTaxRate => _$this._reducedTaxRate;
  set reducedTaxRate(double? reducedTaxRate) =>
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
  void update(void Function(TaxConfigSubregionEntityBuilder)? updates) {
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
