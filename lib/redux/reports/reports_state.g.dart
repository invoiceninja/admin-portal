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
  Iterable<Object> serialize(Serializers serializers, ReportsUIState object,
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
      'currencyId',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ReportsUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReportsUIStateBuilder();

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
        case 'currencyId':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ReportsUIState extends ReportsUIState {
  @override
  final DateRange dateRange;
  @override
  final String customStartDate;
  @override
  final String customEndDate;
  @override
  final String currencyId;

  factory _$ReportsUIState([void Function(ReportsUIStateBuilder) updates]) =>
      (new ReportsUIStateBuilder()..update(updates)).build();

  _$ReportsUIState._(
      {this.dateRange,
      this.customStartDate,
      this.customEndDate,
      this.currencyId})
      : super._() {
    if (dateRange == null) {
      throw new BuiltValueNullFieldError('ReportsUIState', 'dateRange');
    }
    if (customStartDate == null) {
      throw new BuiltValueNullFieldError('ReportsUIState', 'customStartDate');
    }
    if (customEndDate == null) {
      throw new BuiltValueNullFieldError('ReportsUIState', 'customEndDate');
    }
    if (currencyId == null) {
      throw new BuiltValueNullFieldError('ReportsUIState', 'currencyId');
    }
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
        dateRange == other.dateRange &&
        customStartDate == other.customStartDate &&
        customEndDate == other.customEndDate &&
        currencyId == other.currencyId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, dateRange.hashCode), customStartDate.hashCode),
            customEndDate.hashCode),
        currencyId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReportsUIState')
          ..add('dateRange', dateRange)
          ..add('customStartDate', customStartDate)
          ..add('customEndDate', customEndDate)
          ..add('currencyId', currencyId))
        .toString();
  }
}

class ReportsUIStateBuilder
    implements Builder<ReportsUIState, ReportsUIStateBuilder> {
  _$ReportsUIState _$v;

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

  String _currencyId;
  String get currencyId => _$this._currencyId;
  set currencyId(String currencyId) => _$this._currencyId = currencyId;

  ReportsUIStateBuilder();

  ReportsUIStateBuilder get _$this {
    if (_$v != null) {
      _dateRange = _$v.dateRange;
      _customStartDate = _$v.customStartDate;
      _customEndDate = _$v.customEndDate;
      _currencyId = _$v.currencyId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportsUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ReportsUIState;
  }

  @override
  void update(void Function(ReportsUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReportsUIState build() {
    final _$result = _$v ??
        new _$ReportsUIState._(
            dateRange: dateRange,
            customStartDate: customStartDate,
            customEndDate: customEndDate,
            currencyId: currencyId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
