import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reports_state.g.dart';

abstract class ReportsUIState
    implements Built<ReportsUIState, ReportsUIStateBuilder> {
  factory ReportsUIState() {
    return _$ReportsUIState._(
      report: kReportClient,
      customStartDate: '',
      customEndDate: '',
      groupBy: '',
      filters: BuiltMap<String, String>(),
    );
  }

  ReportsUIState._();

  String get report;

  String get groupBy;

  String get customStartDate;

  String get customEndDate;

  BuiltMap<String, String> get filters;

  static Serializer<ReportsUIState> get serializer =>
      _$reportsUIStateSerializer;

}
