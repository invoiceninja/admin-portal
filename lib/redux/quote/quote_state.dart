import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'quote_state.g.dart';

abstract class QuoteState implements Built<QuoteState, QuoteStateBuilder> {
  factory QuoteState() {
    return _$QuoteState._(
      lastUpdated: 0,
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }

  QuoteState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, InvoiceEntity> get map;

  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<QuoteState> get serializer => _$quoteStateSerializer;
}

abstract class QuoteUIState extends Object
    with EntityUIState
    implements Built<QuoteUIState, QuoteUIStateBuilder> {
  factory QuoteUIState() {
    return _$QuoteUIState._(
      listUIState: ListUIState(QuoteFields.quoteNumber, sortAscending: false),
      editing: InvoiceEntity(),
      selectedId: '',
    );
  }

  QuoteUIState._();

  @nullable
  InvoiceEntity get editing;

  @nullable
  @BuiltValueField(serialize: false)
  int get editingItemIndex;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<QuoteUIState> get serializer => _$quoteUIStateSerializer;
}
