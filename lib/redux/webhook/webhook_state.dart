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

part 'webhook_state.g.dart';

abstract class WebhookState
    implements Built<WebhookState, WebhookStateBuilder> {
  factory WebhookState() {
    return _$WebhookState._(
      map: BuiltMap<String, WebhookEntity>(),
      list: BuiltList<String>(),
    );
  }

  WebhookState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, WebhookEntity> get map;

  BuiltList<String> get list;

  WebhookState loadWebhooks(BuiltList<WebhookEntity> clients) {
    final map = Map<String, WebhookEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<WebhookState> get serializer => _$webhookStateSerializer;
}

abstract class WebhookUIState extends Object
    with EntityUIState
    implements Built<WebhookUIState, WebhookUIStateBuilder> {
  factory WebhookUIState(PrefStateSortField? sortField) {
    return _$WebhookUIState._(
      listUIState: ListUIState(sortField?.field ?? WebhookFields.targetUrl,
          sortAscending: sortField?.ascending),
      editing: WebhookEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  WebhookUIState._();

  @override
  @memoized
  int get hashCode;

  WebhookEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<WebhookUIState> get serializer =>
      _$webhookUIStateSerializer;
}
