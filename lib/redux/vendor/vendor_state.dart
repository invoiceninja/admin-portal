import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'vendor_state.g.dart';

abstract class VendorState implements Built<VendorState, VendorStateBuilder> {
  factory VendorState() {
    return _$VendorState._(
      lastUpdated: 0,
      map: BuiltMap<int, VendorEntity>(),
      list: BuiltList<int>(),
    );
  }
  VendorState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, VendorEntity> get map;
  BuiltList<int> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<VendorState> get serializer => _$vendorStateSerializer;
}

abstract class VendorUIState extends Object
    with EntityUIState
    implements Built<VendorUIState, VendorUIStateBuilder> {
  factory VendorUIState() {
    return _$VendorUIState._(
      listUIState: ListUIState(VendorFields.name),
      editing: VendorEntity(),
      editingContact: VendorContactEntity(),
      selectedId: 0,
    );
  }
  VendorUIState._();

  @nullable
  VendorEntity get editing;

  @nullable
  VendorContactEntity get editingContact;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<VendorUIState> get serializer => _$vendorUIStateSerializer;
}
