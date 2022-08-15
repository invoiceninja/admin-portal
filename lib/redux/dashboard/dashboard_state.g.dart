// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DashboardUIState> _$dashboardUIStateSerializer =
    new _$DashboardUIStateSerializer();
Serializer<DashboardUISettings> _$dashboardUISettingsSerializer =
    new _$DashboardUISettingsSerializer();
Serializer<DashboardField> _$dashboardFieldSerializer =
    new _$DashboardFieldSerializer();

class _$DashboardUIStateSerializer
    implements StructuredSerializer<DashboardUIState> {
  @override
  final Iterable<Type> types = const [DashboardUIState, _$DashboardUIState];
  @override
  final String wireName = 'DashboardUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, DashboardUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(DashboardUISettings)),
      'selectedEntityType',
      serializers.serialize(object.selectedEntityType,
          specifiedType: const FullType(EntityType)),
      'selectedEntities',
      serializers.serialize(object.selectedEntities,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(EntityType),
            const FullType(BuiltList, const [const FullType(String)])
          ])),
      'showSidebar',
      serializers.serialize(object.showSidebar,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  DashboardUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DashboardUISettings))
              as DashboardUISettings);
          break;
        case 'selectedEntityType':
          result.selectedEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'selectedEntities':
          result.selectedEntities.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(EntityType),
                const FullType(BuiltList, const [const FullType(String)])
              ])));
          break;
        case 'showSidebar':
          result.showSidebar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardUISettingsSerializer
    implements StructuredSerializer<DashboardUISettings> {
  @override
  final Iterable<Type> types = const [
    DashboardUISettings,
    _$DashboardUISettings
  ];
  @override
  final String wireName = 'DashboardUISettings';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DashboardUISettings object,
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
          specifiedType: const FullType(String)),
      'includeTaxes',
      serializers.serialize(object.includeTaxes,
          specifiedType: const FullType(bool)),
      'groupBy',
      serializers.serialize(object.groupBy,
          specifiedType: const FullType(String)),
      'numberFieldsPerRowMobile',
      serializers.serialize(object.numberFieldsPerRowMobile,
          specifiedType: const FullType(int)),
      'numberFieldsPerRowDesktop',
      serializers.serialize(object.numberFieldsPerRowDesktop,
          specifiedType: const FullType(int)),
      'dashboardFields',
      serializers.serialize(object.dashboardFields,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DashboardField)])),
    ];

    return result;
  }

  @override
  DashboardUISettings deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardUISettingsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
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
              specifiedType: const FullType(String)) as String;
          break;
        case 'includeTaxes':
          result.includeTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'groupBy':
          result.groupBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'numberFieldsPerRowMobile':
          result.numberFieldsPerRowMobile = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'numberFieldsPerRowDesktop':
          result.numberFieldsPerRowDesktop = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dashboardFields':
          result.dashboardFields.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DashboardField)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardFieldSerializer
    implements StructuredSerializer<DashboardField> {
  @override
  final Iterable<Type> types = const [DashboardField, _$DashboardField];
  @override
  final String wireName = 'DashboardField';

  @override
  Iterable<Object> serialize(Serializers serializers, DashboardField object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'field',
      serializers.serialize(object.field,
          specifiedType: const FullType(String)),
      'period',
      serializers.serialize(object.period,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DashboardField deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardFieldBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'field':
          result.field = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'period':
          result.period = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardUIState extends DashboardUIState {
  @override
  final DashboardUISettings settings;
  @override
  final EntityType selectedEntityType;
  @override
  final BuiltMap<EntityType, BuiltList<String>> selectedEntities;
  @override
  final bool showSidebar;

  factory _$DashboardUIState(
          [void Function(DashboardUIStateBuilder) updates]) =>
      (new DashboardUIStateBuilder()..update(updates)).build();

  _$DashboardUIState._(
      {this.settings,
      this.selectedEntityType,
      this.selectedEntities,
      this.showSidebar})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        settings, 'DashboardUIState', 'settings');
    BuiltValueNullFieldError.checkNotNull(
        selectedEntityType, 'DashboardUIState', 'selectedEntityType');
    BuiltValueNullFieldError.checkNotNull(
        selectedEntities, 'DashboardUIState', 'selectedEntities');
    BuiltValueNullFieldError.checkNotNull(
        showSidebar, 'DashboardUIState', 'showSidebar');
  }

  @override
  DashboardUIState rebuild(void Function(DashboardUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardUIStateBuilder toBuilder() =>
      new DashboardUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardUIState &&
        settings == other.settings &&
        selectedEntityType == other.selectedEntityType &&
        selectedEntities == other.selectedEntities &&
        showSidebar == other.showSidebar;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc($jc(0, settings.hashCode), selectedEntityType.hashCode),
            selectedEntities.hashCode),
        showSidebar.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardUIState')
          ..add('settings', settings)
          ..add('selectedEntityType', selectedEntityType)
          ..add('selectedEntities', selectedEntities)
          ..add('showSidebar', showSidebar))
        .toString();
  }
}

class DashboardUIStateBuilder
    implements Builder<DashboardUIState, DashboardUIStateBuilder> {
  _$DashboardUIState _$v;

  DashboardUISettingsBuilder _settings;
  DashboardUISettingsBuilder get settings =>
      _$this._settings ??= new DashboardUISettingsBuilder();
  set settings(DashboardUISettingsBuilder settings) =>
      _$this._settings = settings;

  EntityType _selectedEntityType;
  EntityType get selectedEntityType => _$this._selectedEntityType;
  set selectedEntityType(EntityType selectedEntityType) =>
      _$this._selectedEntityType = selectedEntityType;

  MapBuilder<EntityType, BuiltList<String>> _selectedEntities;
  MapBuilder<EntityType, BuiltList<String>> get selectedEntities =>
      _$this._selectedEntities ??=
          new MapBuilder<EntityType, BuiltList<String>>();
  set selectedEntities(
          MapBuilder<EntityType, BuiltList<String>> selectedEntities) =>
      _$this._selectedEntities = selectedEntities;

  bool _showSidebar;
  bool get showSidebar => _$this._showSidebar;
  set showSidebar(bool showSidebar) => _$this._showSidebar = showSidebar;

  DashboardUIStateBuilder();

  DashboardUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _settings = $v.settings.toBuilder();
      _selectedEntityType = $v.selectedEntityType;
      _selectedEntities = $v.selectedEntities.toBuilder();
      _showSidebar = $v.showSidebar;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashboardUIState;
  }

  @override
  void update(void Function(DashboardUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardUIState build() {
    _$DashboardUIState _$result;
    try {
      _$result = _$v ??
          new _$DashboardUIState._(
              settings: settings.build(),
              selectedEntityType: BuiltValueNullFieldError.checkNotNull(
                  selectedEntityType, 'DashboardUIState', 'selectedEntityType'),
              selectedEntities: selectedEntities.build(),
              showSidebar: BuiltValueNullFieldError.checkNotNull(
                  showSidebar, 'DashboardUIState', 'showSidebar'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'settings';
        settings.build();

        _$failedField = 'selectedEntities';
        selectedEntities.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardUISettings extends DashboardUISettings {
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
  final String currencyId;
  @override
  final bool includeTaxes;
  @override
  final String groupBy;
  @override
  final int numberFieldsPerRowMobile;
  @override
  final int numberFieldsPerRowDesktop;
  @override
  final BuiltList<DashboardField> dashboardFields;

  factory _$DashboardUISettings(
          [void Function(DashboardUISettingsBuilder) updates]) =>
      (new DashboardUISettingsBuilder()..update(updates)).build();

  _$DashboardUISettings._(
      {this.dateRange,
      this.customStartDate,
      this.customEndDate,
      this.enableComparison,
      this.compareDateRange,
      this.compareCustomStartDate,
      this.compareCustomEndDate,
      this.offset,
      this.currencyId,
      this.includeTaxes,
      this.groupBy,
      this.numberFieldsPerRowMobile,
      this.numberFieldsPerRowDesktop,
      this.dashboardFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        dateRange, 'DashboardUISettings', 'dateRange');
    BuiltValueNullFieldError.checkNotNull(
        customStartDate, 'DashboardUISettings', 'customStartDate');
    BuiltValueNullFieldError.checkNotNull(
        customEndDate, 'DashboardUISettings', 'customEndDate');
    BuiltValueNullFieldError.checkNotNull(
        enableComparison, 'DashboardUISettings', 'enableComparison');
    BuiltValueNullFieldError.checkNotNull(
        compareDateRange, 'DashboardUISettings', 'compareDateRange');
    BuiltValueNullFieldError.checkNotNull(compareCustomStartDate,
        'DashboardUISettings', 'compareCustomStartDate');
    BuiltValueNullFieldError.checkNotNull(
        compareCustomEndDate, 'DashboardUISettings', 'compareCustomEndDate');
    BuiltValueNullFieldError.checkNotNull(
        offset, 'DashboardUISettings', 'offset');
    BuiltValueNullFieldError.checkNotNull(
        currencyId, 'DashboardUISettings', 'currencyId');
    BuiltValueNullFieldError.checkNotNull(
        includeTaxes, 'DashboardUISettings', 'includeTaxes');
    BuiltValueNullFieldError.checkNotNull(
        groupBy, 'DashboardUISettings', 'groupBy');
    BuiltValueNullFieldError.checkNotNull(numberFieldsPerRowMobile,
        'DashboardUISettings', 'numberFieldsPerRowMobile');
    BuiltValueNullFieldError.checkNotNull(numberFieldsPerRowDesktop,
        'DashboardUISettings', 'numberFieldsPerRowDesktop');
    BuiltValueNullFieldError.checkNotNull(
        dashboardFields, 'DashboardUISettings', 'dashboardFields');
  }

  @override
  DashboardUISettings rebuild(
          void Function(DashboardUISettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardUISettingsBuilder toBuilder() =>
      new DashboardUISettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardUISettings &&
        dateRange == other.dateRange &&
        customStartDate == other.customStartDate &&
        customEndDate == other.customEndDate &&
        enableComparison == other.enableComparison &&
        compareDateRange == other.compareDateRange &&
        compareCustomStartDate == other.compareCustomStartDate &&
        compareCustomEndDate == other.compareCustomEndDate &&
        offset == other.offset &&
        currencyId == other.currencyId &&
        includeTaxes == other.includeTaxes &&
        groupBy == other.groupBy &&
        numberFieldsPerRowMobile == other.numberFieldsPerRowMobile &&
        numberFieldsPerRowDesktop == other.numberFieldsPerRowDesktop &&
        dashboardFields == other.dashboardFields;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(0,
                                                            dateRange.hashCode),
                                                        customStartDate
                                                            .hashCode),
                                                    customEndDate.hashCode),
                                                enableComparison.hashCode),
                                            compareDateRange.hashCode),
                                        compareCustomStartDate.hashCode),
                                    compareCustomEndDate.hashCode),
                                offset.hashCode),
                            currencyId.hashCode),
                        includeTaxes.hashCode),
                    groupBy.hashCode),
                numberFieldsPerRowMobile.hashCode),
            numberFieldsPerRowDesktop.hashCode),
        dashboardFields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardUISettings')
          ..add('dateRange', dateRange)
          ..add('customStartDate', customStartDate)
          ..add('customEndDate', customEndDate)
          ..add('enableComparison', enableComparison)
          ..add('compareDateRange', compareDateRange)
          ..add('compareCustomStartDate', compareCustomStartDate)
          ..add('compareCustomEndDate', compareCustomEndDate)
          ..add('offset', offset)
          ..add('currencyId', currencyId)
          ..add('includeTaxes', includeTaxes)
          ..add('groupBy', groupBy)
          ..add('numberFieldsPerRowMobile', numberFieldsPerRowMobile)
          ..add('numberFieldsPerRowDesktop', numberFieldsPerRowDesktop)
          ..add('dashboardFields', dashboardFields))
        .toString();
  }
}

class DashboardUISettingsBuilder
    implements Builder<DashboardUISettings, DashboardUISettingsBuilder> {
  _$DashboardUISettings _$v;

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

  String _currencyId;
  String get currencyId => _$this._currencyId;
  set currencyId(String currencyId) => _$this._currencyId = currencyId;

  bool _includeTaxes;
  bool get includeTaxes => _$this._includeTaxes;
  set includeTaxes(bool includeTaxes) => _$this._includeTaxes = includeTaxes;

  String _groupBy;
  String get groupBy => _$this._groupBy;
  set groupBy(String groupBy) => _$this._groupBy = groupBy;

  int _numberFieldsPerRowMobile;
  int get numberFieldsPerRowMobile => _$this._numberFieldsPerRowMobile;
  set numberFieldsPerRowMobile(int numberFieldsPerRowMobile) =>
      _$this._numberFieldsPerRowMobile = numberFieldsPerRowMobile;

  int _numberFieldsPerRowDesktop;
  int get numberFieldsPerRowDesktop => _$this._numberFieldsPerRowDesktop;
  set numberFieldsPerRowDesktop(int numberFieldsPerRowDesktop) =>
      _$this._numberFieldsPerRowDesktop = numberFieldsPerRowDesktop;

  ListBuilder<DashboardField> _dashboardFields;
  ListBuilder<DashboardField> get dashboardFields =>
      _$this._dashboardFields ??= new ListBuilder<DashboardField>();
  set dashboardFields(ListBuilder<DashboardField> dashboardFields) =>
      _$this._dashboardFields = dashboardFields;

  DashboardUISettingsBuilder() {
    DashboardUISettings._initializeBuilder(this);
  }

  DashboardUISettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dateRange = $v.dateRange;
      _customStartDate = $v.customStartDate;
      _customEndDate = $v.customEndDate;
      _enableComparison = $v.enableComparison;
      _compareDateRange = $v.compareDateRange;
      _compareCustomStartDate = $v.compareCustomStartDate;
      _compareCustomEndDate = $v.compareCustomEndDate;
      _offset = $v.offset;
      _currencyId = $v.currencyId;
      _includeTaxes = $v.includeTaxes;
      _groupBy = $v.groupBy;
      _numberFieldsPerRowMobile = $v.numberFieldsPerRowMobile;
      _numberFieldsPerRowDesktop = $v.numberFieldsPerRowDesktop;
      _dashboardFields = $v.dashboardFields.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardUISettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashboardUISettings;
  }

  @override
  void update(void Function(DashboardUISettingsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardUISettings build() {
    _$DashboardUISettings _$result;
    try {
      _$result = _$v ??
          new _$DashboardUISettings._(
              dateRange: BuiltValueNullFieldError.checkNotNull(
                  dateRange, 'DashboardUISettings', 'dateRange'),
              customStartDate: BuiltValueNullFieldError.checkNotNull(
                  customStartDate, 'DashboardUISettings', 'customStartDate'),
              customEndDate: BuiltValueNullFieldError.checkNotNull(
                  customEndDate, 'DashboardUISettings', 'customEndDate'),
              enableComparison: BuiltValueNullFieldError.checkNotNull(
                  enableComparison, 'DashboardUISettings', 'enableComparison'),
              compareDateRange: BuiltValueNullFieldError.checkNotNull(
                  compareDateRange, 'DashboardUISettings', 'compareDateRange'),
              compareCustomStartDate: BuiltValueNullFieldError.checkNotNull(
                  compareCustomStartDate, 'DashboardUISettings', 'compareCustomStartDate'),
              compareCustomEndDate: BuiltValueNullFieldError.checkNotNull(
                  compareCustomEndDate, 'DashboardUISettings', 'compareCustomEndDate'),
              offset: BuiltValueNullFieldError.checkNotNull(offset, 'DashboardUISettings', 'offset'),
              currencyId: BuiltValueNullFieldError.checkNotNull(currencyId, 'DashboardUISettings', 'currencyId'),
              includeTaxes: BuiltValueNullFieldError.checkNotNull(includeTaxes, 'DashboardUISettings', 'includeTaxes'),
              groupBy: BuiltValueNullFieldError.checkNotNull(groupBy, 'DashboardUISettings', 'groupBy'),
              numberFieldsPerRowMobile: BuiltValueNullFieldError.checkNotNull(numberFieldsPerRowMobile, 'DashboardUISettings', 'numberFieldsPerRowMobile'),
              numberFieldsPerRowDesktop: BuiltValueNullFieldError.checkNotNull(numberFieldsPerRowDesktop, 'DashboardUISettings', 'numberFieldsPerRowDesktop'),
              dashboardFields: dashboardFields.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'dashboardFields';
        dashboardFields.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardUISettings', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardField extends DashboardField {
  @override
  final String field;
  @override
  final String period;

  factory _$DashboardField([void Function(DashboardFieldBuilder) updates]) =>
      (new DashboardFieldBuilder()..update(updates)).build();

  _$DashboardField._({this.field, this.period}) : super._() {
    BuiltValueNullFieldError.checkNotNull(field, 'DashboardField', 'field');
    BuiltValueNullFieldError.checkNotNull(period, 'DashboardField', 'period');
  }

  @override
  DashboardField rebuild(void Function(DashboardFieldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardFieldBuilder toBuilder() =>
      new DashboardFieldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardField &&
        field == other.field &&
        period == other.period;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, field.hashCode), period.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardField')
          ..add('field', field)
          ..add('period', period))
        .toString();
  }
}

class DashboardFieldBuilder
    implements Builder<DashboardField, DashboardFieldBuilder> {
  _$DashboardField _$v;

  String _field;
  String get field => _$this._field;
  set field(String field) => _$this._field = field;

  String _period;
  String get period => _$this._period;
  set period(String period) => _$this._period = period;

  DashboardFieldBuilder();

  DashboardFieldBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _field = $v.field;
      _period = $v.period;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardField other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashboardField;
  }

  @override
  void update(void Function(DashboardFieldBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardField build() {
    final _$result = _$v ??
        new _$DashboardField._(
            field: BuiltValueNullFieldError.checkNotNull(
                field, 'DashboardField', 'field'),
            period: BuiltValueNullFieldError.checkNotNull(
                period, 'DashboardField', 'period'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
