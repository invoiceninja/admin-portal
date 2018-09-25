import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'invoice_state.g.dart';

abstract class InvoiceState
    implements Built<InvoiceState, InvoiceStateBuilder> {
  factory InvoiceState() {
    return _$InvoiceState._(
      lastUpdated: 0,
      map: BuiltMap<int, InvoiceEntity>(),
      list: BuiltList<int>(),
    );
  }

  InvoiceState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, InvoiceEntity> get map;

  BuiltList<int> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<InvoiceState> get serializer => _$invoiceStateSerializer;
}

abstract class InvoiceUIState extends Object
    with EntityUIState
    implements Built<InvoiceUIState, InvoiceUIStateBuilder> {
  factory InvoiceUIState() {
    return _$InvoiceUIState._(
      listUIState:
          ListUIState(InvoiceFields.invoiceNumber, sortAscending: false),
      editing: InvoiceEntity(),
      editingItem: InvoiceItemEntity(),
      selectedId: 0,
    );
  }

  InvoiceUIState._();

  @nullable
  InvoiceEntity get editing;

  @nullable
  InvoiceItemEntity get editingItem;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<InvoiceUIState> get serializer =>
      _$invoiceUIStateSerializer;
}
