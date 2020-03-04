import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'company_gateway_state.g.dart';

abstract class CompanyGatewayState
    implements Built<CompanyGatewayState, CompanyGatewayStateBuilder> {
  factory CompanyGatewayState() {
    return _$CompanyGatewayState._(
      lastUpdated: 0,
      map: BuiltMap<String, CompanyGatewayEntity>(),
      list: BuiltList<String>(),
    );
  }
  CompanyGatewayState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, CompanyGatewayEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<CompanyGatewayState> get serializer =>
      _$companyGatewayStateSerializer;
}

abstract class CompanyGatewayUIState extends Object
    with EntityUIState
    implements Built<CompanyGatewayUIState, CompanyGatewayUIStateBuilder> {
  factory CompanyGatewayUIState() {
    return _$CompanyGatewayUIState._(
      listUIState: ListUIState(CompanyGatewayFields.name),
      editing: CompanyGatewayEntity(),
      selectedId: '',
    );
  }
  CompanyGatewayUIState._();

  @nullable
  CompanyGatewayEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<CompanyGatewayUIState> get serializer =>
      _$companyGatewayUIStateSerializer;
}
