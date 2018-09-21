// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<DashboardState> _$dashboardStateSerializer =
    new _$DashboardStateSerializer();
Serializer<DashboardUIState> _$dashboardUIStateSerializer =
    new _$DashboardUIStateSerializer();

class _$DashboardStateSerializer
    implements StructuredSerializer<DashboardState> {
  @override
  final Iterable<Type> types = const [DashboardState, _$DashboardState];
  @override
  final String wireName = 'DashboardState';

  @override
  Iterable serialize(Serializers serializers, DashboardState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.lastUpdated != null) {
      result
        ..add('lastUpdated')
        ..add(serializers.serialize(object.lastUpdated,
            specifiedType: const FullType(int)));
    }
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType: const FullType(DashboardEntity)));
    }

    return result;
  }

  @override
  DashboardState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DashboardEntity))
              as DashboardEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardUIStateSerializer
    implements StructuredSerializer<DashboardUIState> {
  @override
  final Iterable<Type> types = const [DashboardUIState, _$DashboardUIState];
  @override
  final String wireName = 'DashboardUIState';

  @override
  Iterable serialize(Serializers serializers, DashboardUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'dateRange',
      serializers.serialize(object.dateRange,
          specifiedType: const FullType(DateRange)),
      'customStartDate',
      serializers.serialize(object.customStartDate,
          specifiedType: const FullType(String)),
      'customEndDate',
      serializers.serialize(object.customEndDate,
          specifiedType: const FullType(String)),
      'enableComparison',
      serializers.serialize(object.enableComparison,
          specifiedType: const FullType(bool)),
      'compareDateRange',
      serializers.serialize(object.compareDateRange,
          specifiedType: const FullType(DateRangeComparison)),
      'compareCustomStartDate',
      serializers.serialize(object.compareCustomStartDate,
          specifiedType: const FullType(String)),
      'compareCustomEndDate',
      serializers.serialize(object.compareCustomEndDate,
          specifiedType: const FullType(String)),
      'offset',
      serializers.serialize(object.offset, specifiedType: const FullType(int)),
      'currencyId',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  DashboardUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'dateRange':
          result.dateRange = serializers.deserialize(value,
              specifiedType: const FullType(DateRange)) as DateRange;
          break;
        case 'customStartDate':
          result.customStartDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customEndDate':
          result.customEndDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'enableComparison':
          result.enableComparison = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'compareDateRange':
          result.compareDateRange = serializers.deserialize(value,
                  specifiedType: const FullType(DateRangeComparison))
              as DateRangeComparison;
          break;
        case 'compareCustomStartDate':
          result.compareCustomStartDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'compareCustomEndDate':
          result.compareCustomEndDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'currencyId':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardState extends DashboardState {
  @override
  final int lastUpdated;
  @override
  final DashboardEntity data;

  factory _$DashboardState([void updates(DashboardStateBuilder b)]) =>
      (new DashboardStateBuilder()..update(updates)).build();

  _$DashboardState._({this.lastUpdated, this.data}) : super._();

  @override
  DashboardState rebuild(void updates(DashboardStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardStateBuilder toBuilder() =>
      new DashboardStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardState &&
        lastUpdated == other.lastUpdated &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, lastUpdated.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardState')
          ..add('lastUpdated', lastUpdated)
          ..add('data', data))
        .toString();
  }
}

class DashboardStateBuilder
    implements Builder<DashboardState, DashboardStateBuilder> {
  _$DashboardState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  DashboardEntityBuilder _data;
  DashboardEntityBuilder get data =>
      _$this._data ??= new DashboardEntityBuilder();
  set data(DashboardEntityBuilder data) => _$this._data = data;

  DashboardStateBuilder();

  DashboardStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DashboardState;
  }

  @override
  void update(void updates(DashboardStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardState build() {
    _$DashboardState _$result;
    try {
      _$result = _$v ??
          new _$DashboardState._(
              lastUpdated: lastUpdated, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardUIState extends DashboardUIState {
  @override
  final DateRange dateRange;
  @override
  final String customStartDate;
  @override
  final String customEndDate;
  @override
  final bool enableComparison;
  @override
  final DateRangeComparison compareDateRange;
  @override
  final String compareCustomStartDate;
  @override
  final String compareCustomEndDate;
  @override
  final int offset;
  @override
  final int currencyId;

  factory _$DashboardUIState([void updates(DashboardUIStateBuilder b)]) =>
      (new DashboardUIStateBuilder()..update(updates)).build();

  _$DashboardUIState._(
      {this.dateRange,
      this.customStartDate,
      this.customEndDate,
      this.enableComparison,
      this.compareDateRange,
      this.compareCustomStartDate,
      this.compareCustomEndDate,
      this.offset,
      this.currencyId})
      : super._() {
    if (dateRange == null) {
      throw new BuiltValueNullFieldError('DashboardUIState', 'dateRange');
    }
    if (customStartDate == null) {
      throw new BuiltValueNullFieldError('DashboardUIState', 'customStartDate');
    }
    if (customEndDate == null) {
      throw new BuiltValueNullFieldError('DashboardUIState', 'customEndDate');
    }
    if (enableComparison == null) {
      throw new BuiltValueNullFieldError(
          'DashboardUIState', 'enableComparison');
    }
    if (compareDateRange == null) {
      throw new BuiltValueNullFieldError(
          'DashboardUIState', 'compareDateRange');
    }
    if (compareCustomStartDate == null) {
      throw new BuiltValueNullFieldError(
          'DashboardUIState', 'compareCustomStartDate');
    }
    if (compareCustomEndDate == null) {
      throw new BuiltValueNullFieldError(
          'DashboardUIState', 'compareCustomEndDate');
    }
    if (offset == null) {
      throw new BuiltValueNullFieldError('DashboardUIState', 'offset');
    }
    if (currencyId == null) {
      throw new BuiltValueNullFieldError('DashboardUIState', 'currencyId');
    }
  }

  @override
  DashboardUIState rebuild(void updates(DashboardUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardUIStateBuilder toBuilder() =>
      new DashboardUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardUIState &&
        dateRange == other.dateRange &&
        customStartDate == other.customStartDate &&
        customEndDate == other.customEndDate &&
        enableComparison == other.enableComparison &&
        compareDateRange == other.compareDateRange &&
        compareCustomStartDate == other.compareCustomStartDate &&
        compareCustomEndDate == other.compareCustomEndDate &&
        offset == other.offset &&
        currencyId == other.currencyId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, dateRange.hashCode),
                                    customStartDate.hashCode),
                                customEndDate.hashCode),
                            enableComparison.hashCode),
                        compareDateRange.hashCode),
                    compareCustomStartDate.hashCode),
                compareCustomEndDate.hashCode),
            offset.hashCode),
        currencyId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardUIState')
          ..add('dateRange', dateRange)
          ..add('customStartDate', customStartDate)
          ..add('customEndDate', customEndDate)
          ..add('enableComparison', enableComparison)
          ..add('compareDateRange', compareDateRange)
          ..add('compareCustomStartDate', compareCustomStartDate)
          ..add('compareCustomEndDate', compareCustomEndDate)
          ..add('offset', offset)
          ..add('currencyId', currencyId))
        .toString();
  }
}

class DashboardUIStateBuilder
    implements Builder<DashboardUIState, DashboardUIStateBuilder> {
  _$DashboardUIState _$v;

  DateRange _dateRange;
  DateRange get dateRange => _$this._dateRange;
  set dateRange(DateRange dateRange) => _$this._dateRange = dateRange;

  String _customStartDate;
  String get customStartDate => _$this._customStartDate;
  set customStartDate(String customStartDate) =>
      _$this._customStartDate = customStartDate;

  String _customEndDate;
  String get customEndDate => _$this._customEndDate;
  set customEndDate(String customEndDate) =>
      _$this._customEndDate = customEndDate;

  bool _enableComparison;
  bool get enableComparison => _$this._enableComparison;
  set enableComparison(bool enableComparison) =>
      _$this._enableComparison = enableComparison;

  DateRangeComparison _compareDateRange;
  DateRangeComparison get compareDateRange => _$this._compareDateRange;
  set compareDateRange(DateRangeComparison compareDateRange) =>
      _$this._compareDateRange = compareDateRange;

  String _compareCustomStartDate;
  String get compareCustomStartDate => _$this._compareCustomStartDate;
  set compareCustomStartDate(String compareCustomStartDate) =>
      _$this._compareCustomStartDate = compareCustomStartDate;

  String _compareCustomEndDate;
  String get compareCustomEndDate => _$this._compareCustomEndDate;
  set compareCustomEndDate(String compareCustomEndDate) =>
      _$this._compareCustomEndDate = compareCustomEndDate;

  int _offset;
  int get offset => _$this._offset;
  set offset(int offset) => _$this._offset = offset;

  int _currencyId;
  int get currencyId => _$this._currencyId;
  set currencyId(int currencyId) => _$this._currencyId = currencyId;

  DashboardUIStateBuilder();

  DashboardUIStateBuilder get _$this {
    if (_$v != null) {
      _dateRange = _$v.dateRange;
      _customStartDate = _$v.customStartDate;
      _customEndDate = _$v.customEndDate;
      _enableComparison = _$v.enableComparison;
      _compareDateRange = _$v.compareDateRange;
      _compareCustomStartDate = _$v.compareCustomStartDate;
      _compareCustomEndDate = _$v.compareCustomEndDate;
      _offset = _$v.offset;
      _currencyId = _$v.currencyId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DashboardUIState;
  }

  @override
  void update(void updates(DashboardUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardUIState build() {
    final _$result = _$v ??
        new _$DashboardUIState._(
            dateRange: dateRange,
            customStartDate: customStartDate,
            customEndDate: customEndDate,
            enableComparison: enableComparison,
            compareDateRange: compareDateRange,
            compareCustomStartDate: compareCustomStartDate,
            compareCustomEndDate: compareCustomEndDate,
            offset: offset,
            currencyId: currencyId);
    replace(_$result);
    return _$result;
  }
}
