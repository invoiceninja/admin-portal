import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/webhook_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'webhook_state.g.dart';

abstract class WebhookState
    implements Built<WebhookState, WebhookStateBuilder> {
  factory WebhookState() {
    return _$WebhookState._(
      lastUpdated: 0,
      map: BuiltMap<String, WebhookEntity>(),
      list: BuiltList<String>(),
    );
  }
  WebhookState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  int get lastUpdated;

  BuiltMap<String, WebhookEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  WebhookState loadWebhooks(BuiltList<WebhookEntity> clients) {
    final map = Map<String, WebhookEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<WebhookState> get serializer => _$webhookStateSerializer;
}

abstract class WebhookUIState extends Object
    with EntityUIState
    implements Built<WebhookUIState, WebhookUIStateBuilder> {
  factory WebhookUIState() {
    return _$WebhookUIState._(
      listUIState: ListUIState(WebhookFields.name),
      editing: WebhookEntity(),
      selectedId: '',
    );
  }
  WebhookUIState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  WebhookEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<WebhookUIState> get serializer =>
      _$webhookUIStateSerializer;
}
