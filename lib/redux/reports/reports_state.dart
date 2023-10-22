// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';

part 'reports_state.g.dart';

abstract class ReportsUIState
    implements Built<ReportsUIState, ReportsUIStateBuilder> {
  factory ReportsUIState() {
    return _$ReportsUIState._(
      report: kReportClient,
      customStartDate: '',
      customEndDate: '',
      group: '',
      selectedGroup: '',
      chart: '',
      subgroup: kReportGroupDay,
      filters: BuiltMap<String, String>(),
    );
  }

  ReportsUIState._();

  @override
  @memoized
  int get hashCode;

  String get report;

  String get group;

  String get selectedGroup;

  String get chart;

  String get subgroup;

  String get customStartDate;

  String get customEndDate;

  BuiltMap<String, String> get filters;

  bool get isGroupByFiltered =>
      filters.containsKey(group) && filters[group]!.isNotEmpty;

  static Serializer<ReportsUIState> get serializer =>
      _$reportsUIStateSerializer;
}
