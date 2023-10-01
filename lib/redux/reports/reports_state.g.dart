// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReportsUIState> _$reportsUIStateSerializer =
    new _$ReportsUIStateSerializer();

class _$ReportsUIStateSerializer
    implements StructuredSerializer<ReportsUIState> {
  @override
  final Iterable<Type> types = const [ReportsUIState, _$ReportsUIState];
  @override
  final String wireName = 'ReportsUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReportsUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'report',
      serializers.serialize(object.report,
          specifiedType: const FullType(String)),
      'group',
      serializers.serialize(object.group,
          specifiedType: const FullType(String)),
      'selectedGroup',
      serializers.serialize(object.selectedGroup,
          specifiedType: const FullType(String)),
      'chart',
      serializers.serialize(object.chart,
          specifiedType: const FullType(String)),
      'subgroup',
      serializers.serialize(object.subgroup,
          specifiedType: const FullType(String)),
      'customStartDate',
      serializers.serialize(object.customStartDate,
          specifiedType: const FullType(String)),
      'customEndDate',
      serializers.serialize(object.customEndDate,
          specifiedType: const FullType(String)),
      'filters',
      serializers.serialize(object.filters,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
    ];

    return result;
  }

  @override
  ReportsUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReportsUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'report':
          result.report = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'group':
          result.group = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'selectedGroup':
          result.selectedGroup = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'chart':
          result.chart = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'subgroup':
          result.subgroup = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'customStartDate':
          result.customStartDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'customEndDate':
          result.customEndDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'filters':
          result.filters.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$ReportsUIState extends ReportsUIState {
  @override
  final String report;
  @override
  final String group;
  @override
  final String selectedGroup;
  @override
  final String chart;
  @override
  final String subgroup;
  @override
  final String customStartDate;
  @override
  final String customEndDate;
  @override
  final BuiltMap<String, String> filters;

  factory _$ReportsUIState([void Function(ReportsUIStateBuilder)? updates]) =>
      (new ReportsUIStateBuilder()..update(updates))._build();

  _$ReportsUIState._(
      {required this.report,
      required this.group,
      required this.selectedGroup,
      required this.chart,
      required this.subgroup,
      required this.customStartDate,
      required this.customEndDate,
      required this.filters})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(report, r'ReportsUIState', 'report');
    BuiltValueNullFieldError.checkNotNull(group, r'ReportsUIState', 'group');
    BuiltValueNullFieldError.checkNotNull(
        selectedGroup, r'ReportsUIState', 'selectedGroup');
    BuiltValueNullFieldError.checkNotNull(chart, r'ReportsUIState', 'chart');
    BuiltValueNullFieldError.checkNotNull(
        subgroup, r'ReportsUIState', 'subgroup');
    BuiltValueNullFieldError.checkNotNull(
        customStartDate, r'ReportsUIState', 'customStartDate');
    BuiltValueNullFieldError.checkNotNull(
        customEndDate, r'ReportsUIState', 'customEndDate');
    BuiltValueNullFieldError.checkNotNull(
        filters, r'ReportsUIState', 'filters');
  }

  @override
  ReportsUIState rebuild(void Function(ReportsUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportsUIStateBuilder toBuilder() =>
      new ReportsUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportsUIState &&
        report == other.report &&
        group == other.group &&
        selectedGroup == other.selectedGroup &&
        chart == other.chart &&
        subgroup == other.subgroup &&
        customStartDate == other.customStartDate &&
        customEndDate == other.customEndDate &&
        filters == other.filters;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, report.hashCode);
    _$hash = $jc(_$hash, group.hashCode);
    _$hash = $jc(_$hash, selectedGroup.hashCode);
    _$hash = $jc(_$hash, chart.hashCode);
    _$hash = $jc(_$hash, subgroup.hashCode);
    _$hash = $jc(_$hash, customStartDate.hashCode);
    _$hash = $jc(_$hash, customEndDate.hashCode);
    _$hash = $jc(_$hash, filters.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReportsUIState')
          ..add('report', report)
          ..add('group', group)
          ..add('selectedGroup', selectedGroup)
          ..add('chart', chart)
          ..add('subgroup', subgroup)
          ..add('customStartDate', customStartDate)
          ..add('customEndDate', customEndDate)
          ..add('filters', filters))
        .toString();
  }
}

class ReportsUIStateBuilder
    implements Builder<ReportsUIState, ReportsUIStateBuilder> {
  _$ReportsUIState? _$v;

  String? _report;
  String? get report => _$this._report;
  set report(String? report) => _$this._report = report;

  String? _group;
  String? get group => _$this._group;
  set group(String? group) => _$this._group = group;

  String? _selectedGroup;
  String? get selectedGroup => _$this._selectedGroup;
  set selectedGroup(String? selectedGroup) =>
      _$this._selectedGroup = selectedGroup;

  String? _chart;
  String? get chart => _$this._chart;
  set chart(String? chart) => _$this._chart = chart;

  String? _subgroup;
  String? get subgroup => _$this._subgroup;
  set subgroup(String? subgroup) => _$this._subgroup = subgroup;

  String? _customStartDate;
  String? get customStartDate => _$this._customStartDate;
  set customStartDate(String? customStartDate) =>
      _$this._customStartDate = customStartDate;

  String? _customEndDate;
  String? get customEndDate => _$this._customEndDate;
  set customEndDate(String? customEndDate) =>
      _$this._customEndDate = customEndDate;

  MapBuilder<String, String>? _filters;
  MapBuilder<String, String> get filters =>
      _$this._filters ??= new MapBuilder<String, String>();
  set filters(MapBuilder<String, String>? filters) => _$this._filters = filters;

  ReportsUIStateBuilder();

  ReportsUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _report = $v.report;
      _group = $v.group;
      _selectedGroup = $v.selectedGroup;
      _chart = $v.chart;
      _subgroup = $v.subgroup;
      _customStartDate = $v.customStartDate;
      _customEndDate = $v.customEndDate;
      _filters = $v.filters.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportsUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReportsUIState;
  }

  @override
  void update(void Function(ReportsUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportsUIState build() => _build();

  _$ReportsUIState _build() {
    _$ReportsUIState _$result;
    try {
      _$result = _$v ??
          new _$ReportsUIState._(
              report: BuiltValueNullFieldError.checkNotNull(
                  report, r'ReportsUIState', 'report'),
              group: BuiltValueNullFieldError.checkNotNull(
                  group, r'ReportsUIState', 'group'),
              selectedGroup: BuiltValueNullFieldError.checkNotNull(
                  selectedGroup, r'ReportsUIState', 'selectedGroup'),
              chart: BuiltValueNullFieldError.checkNotNull(
                  chart, r'ReportsUIState', 'chart'),
              subgroup: BuiltValueNullFieldError.checkNotNull(
                  subgroup, r'ReportsUIState', 'subgroup'),
              customStartDate: BuiltValueNullFieldError.checkNotNull(
                  customStartDate, r'ReportsUIState', 'customStartDate'),
              customEndDate: BuiltValueNullFieldError.checkNotNull(
                  customEndDate, r'ReportsUIState', 'customEndDate'),
              filters: filters.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'filters';
        filters.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReportsUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
