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
      'report',
      serializers.serialize(object.report,
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
        case 'report':
          result.report = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ReportsUIState extends ReportsUIState {
  @override
  final String report;

  factory _$ReportsUIState([void Function(ReportsUIStateBuilder) updates]) =>
      (new ReportsUIStateBuilder()..update(updates)).build();

  _$ReportsUIState._({this.report}) : super._() {
    if (report == null) {
      throw new BuiltValueNullFieldError('ReportsUIState', 'report');
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
    return other is ReportsUIState && report == other.report;
  }

  @override
  int get hashCode {
    return $jf($jc(0, report.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReportsUIState')
          ..add('report', report))
        .toString();
  }
}

class ReportsUIStateBuilder
    implements Builder<ReportsUIState, ReportsUIStateBuilder> {
  _$ReportsUIState _$v;

  String _report;
  String get report => _$this._report;
  set report(String report) => _$this._report = report;

  ReportsUIStateBuilder();

  ReportsUIStateBuilder get _$this {
    if (_$v != null) {
      _report = _$v.report;
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
    final _$result = _$v ?? new _$ReportsUIState._(report: report);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
