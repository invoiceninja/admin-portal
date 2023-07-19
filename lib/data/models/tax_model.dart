import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tax_model.g.dart';

abstract class TaxConfigEntity
    implements Built<TaxConfigEntity, TaxConfigEntityBuilder> {
  factory TaxConfigEntity() {
    return _$TaxConfigEntity._();
  }

  TaxConfigEntity._();

  String get geoPostalCode;
  String get geoCity;
  String get geoCounty;
  String get geoState;
  double get taxSales;
  double get taxUse;
  String get txbService;
  String get txbFreight;
  double get stateSalesTax;
  double get stateUseTax;
  double get citySalesTax;
  double get cityUseTax;
  String get cityTaxCode;
  double get countySalesTax;
  double get countyUseTax;
  String get countyTaxCode;
  double get districtSalesTax;
  double get districtUseTax;
  String get district1Code;
  double get district1SalesTax;
  double get district1UseTax;
  String get district2Code;
  double get district2SalesTax;
  double get district2UseTax;
  String get district3Code;
  double get district3SalesTax;
  double get district3UseTax;
  String get district4Code;
  double get district4SalesTax;
  double get district4UseTax;
  String get district5Code;
  double get district5SalesTax;
  double get district5UseTax;
  String get originDestination;

  static Serializer<TaxConfigEntity> get serializer =>
      _$taxConfigEntitySerializer;
}
