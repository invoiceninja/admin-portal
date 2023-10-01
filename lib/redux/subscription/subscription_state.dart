// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'subscription_state.g.dart';

abstract class SubscriptionState
    implements Built<SubscriptionState, SubscriptionStateBuilder> {
  factory SubscriptionState() {
    return _$SubscriptionState._(
      map: BuiltMap<String, SubscriptionEntity>(),
      list: BuiltList<String>(),
    );
  }

  SubscriptionState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, SubscriptionEntity> get map;

  BuiltList<String> get list;

  SubscriptionEntity get(String subscriptionId) {
    if (map.containsKey(subscriptionId)) {
      return map[subscriptionId]!;
    } else {
      return SubscriptionEntity(id: subscriptionId);
    }
  }

  SubscriptionState loadSubscriptions(BuiltList<SubscriptionEntity> clients) {
    final map = Map<String, SubscriptionEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<SubscriptionState> get serializer =>
      _$subscriptionStateSerializer;
}

abstract class SubscriptionUIState extends Object
    with EntityUIState
    implements Built<SubscriptionUIState, SubscriptionUIStateBuilder> {
  factory SubscriptionUIState(PrefStateSortField? sortField) {
    return _$SubscriptionUIState._(
      listUIState: ListUIState(sortField?.field ?? SubscriptionFields.createdAt,
          sortAscending: sortField?.ascending),
      editing: SubscriptionEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  SubscriptionUIState._();

  @override
  @memoized
  int get hashCode;

  SubscriptionEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<SubscriptionUIState> get serializer =>
      _$subscriptionUIStateSerializer;
}
