import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

part 'invoice_state.g.dart';

abstract class InvoiceState implements Built<InvoiceState, InvoiceStateBuilder> {

  @nullable
  int get lastUpdated;

  BuiltMap<int, InvoiceEntity> get map;
  BuiltList<int> get list;

  factory InvoiceState() {
    return _$InvoiceState._(
      map: BuiltMap<int, InvoiceEntity>(),
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

  InvoiceState._();
  static Serializer<InvoiceState> get serializer => _$invoiceStateSerializer;
}

abstract class InvoiceUIState extends Object with EntityUIState implements Built<InvoiceUIState, InvoiceUIStateBuilder> {

  @nullable
  InvoiceEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew();

  factory InvoiceUIState() {
    return _$InvoiceUIState._(
      listUIState: ListUIState(InvoiceFields.invoiceNumber),
      editing: InvoiceEntity(),
      dropdownFilter: '',
      selectedId: 0,
    );
  }

  InvoiceUIState._();
  static Serializer<InvoiceUIState> get serializer => _$invoiceUIStateSerializer;
}