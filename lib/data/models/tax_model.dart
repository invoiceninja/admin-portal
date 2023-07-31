import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tax_model.g.dart';

abstract class TaxDataEntity
    implements Built<TaxDataEntity, TaxDataEntityBuilder> {
  factory TaxDataEntity() {
    return _$TaxDataEntity._(
      citySalesTax: 0,
      cityTaxCode: '',
      countySalesTax: 0,
      countyTaxCode: '',
      geoCity: '',
      geoCounty: '',
      geoPostalCode: '',
      geoState: '',
      stateSalesTax: 0,
      taxSales: 0,
      districtSalesTax: 0,
      /*
      cityUseTax: 0,
      countyUseTax: 0,
      district1SalesTax: 0,
      district1Code: '',
      district1UseTax: 0,
      district2Code: '',
      district2SalesTax: 0,
      district2UseTax: 0,
      district3Code: '',
      district3SalesTax: 0,
      district3UseTax: 0,
      district4Code: '',
      district4SalesTax: 0,
      district4UseTax: 0,
      district5Code: '',
      district5SalesTax: 0,
      district5UseTax: 0,
      districtUseTax: 0,
      originDestination: '',
      stateUseTax: 0,
      taxUse: 0,
      txbFreight: '',
      txbService: '',
      */
    );
  }

  TaxDataEntity._();

  String get geoPostalCode;
  String get geoCity;
  String get geoCounty;
  String get geoState;
  double get taxSales;
  double get stateSalesTax;
  double get citySalesTax;
  String get cityTaxCode;
  double get countySalesTax;
  String get countyTaxCode;
  double get districtSalesTax;
  //double get taxUse;
  //String get txbService;
  //String get txbFreight;
  //double get stateUseTax;
  //double get cityUseTax;
  //double get countyUseTax;
  //double get districtUseTax;
  //String get district1Code;
  //double get district1SalesTax;
  //double get district1UseTax;
  //String get district2Code;
  //double get district2SalesTax;
  //double get district2UseTax;
  //String get district3Code;
  //double get district3SalesTax;
  //double get district3UseTax;
  //String get district4Code;
  //double get district4SalesTax;
  //double get district4UseTax;
  //String get district5Code;
  //double get district5SalesTax;
  //double get district5UseTax;
  //String get originDestination;

  // ignore: unused_element
  static void _initializeBuilder(TaxDataEntityBuilder builder) => builder
    ..citySalesTax = 0
    ..cityTaxCode = ''
    ..countySalesTax = 0
    ..countyTaxCode = ''
    ..geoCity = ''
    ..geoCounty = ''
    ..geoPostalCode = ''
    ..geoState = ''
    ..stateSalesTax = 0
    ..taxSales = 0
    ..districtSalesTax = 0;
  /*    
    ..cityUseTax = 0
    ..countyUseTax = 0
    ..district1SalesTax = 0
    ..district1Code = ''
    ..district1UseTax = 0
    ..district2Code = ''
    ..district2SalesTax = 0
    ..district2UseTax = 0
    ..district3Code = ''
    ..district3SalesTax = 0
    ..district3UseTax = 0
    ..district4Code = ''
    ..district4SalesTax = 0
    ..district4UseTax = 0
    ..district5Code = ''
    ..district5SalesTax = 0
    ..district5UseTax = 0    
    ..districtUseTax = 0
    ..originDestination = ''
    ..stateUseTax = 0
    ..taxUse = 0
    ..txbFreight = ''
    ..txbService = '';
    */

  static Serializer<TaxDataEntity> get serializer => _$taxDataEntitySerializer;
}

abstract class TaxConfigEntity
    implements Built<TaxConfigEntity, TaxConfigEntityBuilder> {
  factory TaxConfigEntity() {
    return _$TaxConfigEntity._(
      version: '',
      sellerSubregion: '',
      regions: BuiltMap<String, TaxConfigRegionEntity>(),
    );
  }

  TaxConfigEntity._();

  @override
  @memoized
  int get hashCode;

  String get version;

  @BuiltValueField(wireName: 'seller_subregion')
  String get sellerSubregion;

  BuiltMap<String, TaxConfigRegionEntity> get regions;

  // ignore: unused_element
  static void _initializeBuilder(TaxConfigEntityBuilder builder) => builder
    ..version = ''
    ..sellerSubregion = ''
    ..regions.replace(BuiltMap<String, TaxConfigRegionEntity>());

  static Serializer<TaxConfigEntity> get serializer =>
      _$taxConfigEntitySerializer;
}

abstract class TaxConfigRegionEntity
    implements Built<TaxConfigRegionEntity, TaxConfigRegionEntityBuilder> {
  factory TaxConfigRegionEntity(bool reportErrors) {
    return _$TaxConfigRegionEntity._(
      hasSalesAboveThreshold: false,
      taxAll: false,
      taxThreshold: 0,
      subregions: BuiltMap<String, TaxConfigSubregionEntity>(),
    );
  }

  TaxConfigRegionEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'has_sales_above_threshold')
  bool get hasSalesAboveThreshold;

  @BuiltValueField(wireName: 'tax_all_subregions')
  bool get taxAll;

  @BuiltValueField(wireName: 'tax_threshold')
  double get taxThreshold;

  BuiltMap<String, TaxConfigSubregionEntity> get subregions;

  // ignore: unused_element
  static void _initializeBuilder(TaxConfigRegionEntityBuilder builder) =>
      builder
        ..hasSalesAboveThreshold = false
        ..taxAll = false
        ..taxThreshold = 0;

  static Serializer<TaxConfigRegionEntity> get serializer =>
      _$taxConfigRegionEntitySerializer;
}

abstract class TaxConfigSubregionEntity
    implements
        Built<TaxConfigSubregionEntity, TaxConfigSubregionEntityBuilder> {
  factory TaxConfigSubregionEntity(bool reportErrors) {
    return _$TaxConfigSubregionEntity._(
      applyTax: false,
      taxRate: 0,
      reducedTaxRate: 0,
      taxName: '',
    );
  }

  TaxConfigSubregionEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'apply_tax')
  bool get applyTax;

  @BuiltValueField(wireName: 'tax_rate')
  double get taxRate;

  @BuiltValueField(wireName: 'tax_name')
  String get taxName;

  @BuiltValueField(wireName: 'reduced_tax_rate')
  double get reducedTaxRate;

  // ignore: unused_element
  static void _initializeBuilder(TaxConfigSubregionEntityBuilder builder) =>
      builder
        ..applyTax = false
        ..taxName = ''
        ..reducedTaxRate = 0
        ..taxRate = 0;

  static Serializer<TaxConfigSubregionEntity> get serializer =>
      _$taxConfigSubregionEntitySerializer;
}
