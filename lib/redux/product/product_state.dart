import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

part 'product_state.g.dart';

abstract class ProductState implements Built<ProductState, ProductStateBuilder> {

  @nullable
  int get lastUpdated;

  BuiltMap<int, ProductEntity> get map;
  BuiltList<int> get list;

  factory ProductState() {
    return _$ProductState._(
      map: BuiltMap<int, ProductEntity>(),
      list: BuiltList<int>(),
    );
  }

  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null;
  }

  ProductState._();
  static Serializer<ProductState> get serializer => _$productStateSerializer;
}

abstract class ProductUIState extends Object with EntityUIState implements Built<ProductUIState, ProductUIStateBuilder> {

  @nullable
  ProductEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew();

  factory ProductUIState() {
    return _$ProductUIState._(
      listUIState: ListUIState(ProductFields.productKey),
      editing: ProductEntity(),
      dropdownFilter: '',
      selectedId: 0,
    );
  }

  ProductUIState._();
  static Serializer<ProductUIState> get serializer => _$productUIStateSerializer;
}