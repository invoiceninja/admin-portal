import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'invoice_state.g.dart';

abstract class InvoiceState implements Built<InvoiceState, InvoiceStateBuilder> {

  bool get isLoading;
  int get lastUpdated;

  BuiltMap<int, InvoiceEntity> get map;
  BuiltList<int> get list;

  @nullable
  InvoiceEntity get editing;

  @nullable
  String get editingFor;

  factory InvoiceState() {
    return _$InvoiceState._(
      isLoading: false,
      lastUpdated: 0,
      map: BuiltMap<int, InvoiceEntity>(),
      list: BuiltList<int>(),
    );
  }

  bool isStale() {
    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool isLoaded() {
    return lastUpdated != null;
  }

  InvoiceState._();
  //factory InvoiceState([updates(InvoiceStateBuilder b)]) = _$InvoiceState;
  static Serializer<InvoiceState> get serializer => _$invoiceStateSerializer;
}