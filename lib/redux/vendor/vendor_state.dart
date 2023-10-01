// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'vendor_state.g.dart';

abstract class VendorState implements Built<VendorState, VendorStateBuilder> {
  factory VendorState() {
    return _$VendorState._(
      map: BuiltMap<String, VendorEntity>(),
      list: BuiltList<String>(),
    );
  }

  VendorState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, VendorEntity> get map;

  VendorEntity get(String vendorId) {
    if (map.containsKey(vendorId)) {
      return map[vendorId]!;
    } else {
      return VendorEntity(id: vendorId);
    }
  }

  BuiltList<String> get list;

  VendorState loadVendors(BuiltList<VendorEntity> clients) {
    final map = Map<String, VendorEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<VendorState> get serializer => _$vendorStateSerializer;
}

abstract class VendorUIState extends Object
    with EntityUIState
    implements Built<VendorUIState, VendorUIStateBuilder> {
  factory VendorUIState(PrefStateSortField? sortField) {
    return _$VendorUIState._(
      listUIState: ListUIState(sortField?.field ?? VendorFields.name,
          sortAscending: sortField?.ascending),
      editing: VendorEntity(),
      editingContact: VendorContactEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  VendorUIState._();

  @override
  @memoized
  int get hashCode;

  VendorEntity? get editing;

  VendorContactEntity? get editingContact;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<VendorUIState> get serializer => _$vendorUIStateSerializer;
}
