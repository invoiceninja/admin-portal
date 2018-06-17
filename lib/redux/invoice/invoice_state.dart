import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'invoice_state.g.dart';

abstract class InvoiceState implements Built<InvoiceState, InvoiceStateBuilder> {

  @nullable
  int get lastUpdated;

  BuiltMap<int, InvoiceEntity> get map;
  BuiltList<int> get list;

  @nullable
  InvoiceEntity get editing;

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