// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'quote_state.g.dart';

abstract class QuoteState implements Built<QuoteState, QuoteStateBuilder> {
  factory QuoteState() {
    return _$QuoteState._(
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }

  QuoteState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, InvoiceEntity> get map;

  BuiltList<String> get list;

  InvoiceEntity get(String quoteId) {
    if (map.containsKey(quoteId)) {
      return map[quoteId]!;
    } else {
      return InvoiceEntity(id: quoteId, entityType: EntityType.quote);
    }
  }

  QuoteState loadQuotes(BuiltList<InvoiceEntity> quotes) {
    final map = Map<String, InvoiceEntity>.fromIterable(
      quotes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<QuoteState> get serializer => _$quoteStateSerializer;
}

abstract class QuoteUIState extends Object
    with EntityUIState
    implements Built<QuoteUIState, QuoteUIStateBuilder> {
  factory QuoteUIState(PrefStateSortField? sortField) {
    return _$QuoteUIState._(
      listUIState: ListUIState(sortField?.field ?? QuoteFields.number,
          sortAscending: sortField?.ascending ?? false),
      editing: InvoiceEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  QuoteUIState._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity? get editing;

  @BuiltValueField(serialize: false)
  int? get editingItemIndex;

  @BuiltValueField(serialize: false)
  String? get historyActivityId;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<QuoteUIState> get serializer => _$quoteUIStateSerializer;
}
