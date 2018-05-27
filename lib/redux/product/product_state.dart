import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'product_state.g.dart';

abstract class ProductState implements Built<ProductState, ProductStateBuilder> {

  bool get isLoading;
  int get lastUpdated;

  BuiltMap<int, ProductEntity> get map;
  BuiltList<int> get list;

  factory ProductState() {
    return _$ProductState._(
      isLoading: false,
      lastUpdated: 0,
      map: BuiltMap<int, ProductEntity>(),
      list: BuiltList<int>(),
    );
  }


  ProductState._();
  //factory ProductState([updates(ProductStateBuilder b)]) = _$ProductState;
  static Serializer<ProductState> get serializer => _$productStateSerializer;
}