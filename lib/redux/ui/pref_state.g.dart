// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AppLayout _$mobile = const AppLayout._('mobile');
const AppLayout _$desktop = const AppLayout._('desktop');

AppLayout _$valueOf(String name) {
  switch (name) {
    case 'mobile':
      return _$mobile;
    case 'desktop':
      return _$desktop;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppLayout> _$values = new BuiltSet<AppLayout>(const <AppLayout>[
  _$mobile,
  _$desktop,
]);

const ModuleLayout _$list = const ModuleLayout._('list');
const ModuleLayout _$table = const ModuleLayout._('table');

ModuleLayout _$moduleLayoutValueOf(String name) {
  switch (name) {
    case 'list':
      return _$list;
    case 'table':
      return _$table;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ModuleLayout> _$moduleLayoutValues =
    new BuiltSet<ModuleLayout>(const <ModuleLayout>[
  _$list,
  _$table,
]);

const AppSidebar _$menu = const AppSidebar._('menu');
const AppSidebar _$history = const AppSidebar._('history');

AppSidebar _$valueOfSidebar(String name) {
  switch (name) {
    case 'menu':
      return _$menu;
    case 'history':
      return _$history;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppSidebar> _$valuesSidebar =
    new BuiltSet<AppSidebar>(const <AppSidebar>[
  _$menu,
  _$history,
]);

const AppSidebarMode _$float = const AppSidebarMode._('float');
const AppSidebarMode _$visible = const AppSidebarMode._('visible');
const AppSidebarMode _$collapse = const AppSidebarMode._('collapse');

AppSidebarMode _$valueOfSidebarMode(String name) {
  switch (name) {
    case 'float':
      return _$float;
    case 'visible':
      return _$visible;
    case 'collapse':
      return _$collapse;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppSidebarMode> _$valuesSidebarMode =
    new BuiltSet<AppSidebarMode>(const <AppSidebarMode>[
  _$float,
  _$visible,
  _$collapse,
]);

Serializer<PrefState> _$prefStateSerializer = new _$PrefStateSerializer();
Serializer<CompanyPrefState> _$companyPrefStateSerializer =
    new _$CompanyPrefStateSerializer();
Serializer<AppLayout> _$appLayoutSerializer = new _$AppLayoutSerializer();
Serializer<ModuleLayout> _$moduleLayoutSerializer =
    new _$ModuleLayoutSerializer();
Serializer<AppSidebar> _$appSidebarSerializer = new _$AppSidebarSerializer();
Serializer<AppSidebarMode> _$appSidebarModeSerializer =
    new _$AppSidebarModeSerializer();
Serializer<HistoryRecord> _$historyRecordSerializer =
    new _$HistoryRecordSerializer();

class _$PrefStateSerializer implements StructuredSerializer<PrefState> {
  @override
  final Iterable<Type> types = const [PrefState, _$PrefState];
  @override
  final String wireName = 'PrefState';

  @override
  Iterable<Object> serialize(Serializers serializers, PrefState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'appLayout',
      serializers.serialize(object.appLayout,
          specifiedType: const FullType(AppLayout)),
      'moduleLayout',
      serializers.serialize(object.moduleLayout,
          specifiedType: const FullType(ModuleLayout)),
      'menuSidebarMode',
      serializers.serialize(object.menuSidebarMode,
          specifiedType: const FullType(AppSidebarMode)),
      'historySidebarMode',
      serializers.serialize(object.historySidebarMode,
          specifiedType: const FullType(AppSidebarMode)),
      'useSidebarEditor',
      serializers.serialize(object.useSidebarEditor,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(EntityType), const FullType(bool)])),
      'isPreviewVisible',
      serializers.serialize(object.isPreviewVisible,
          specifiedType: const FullType(bool)),
      'isMenuVisible',
      serializers.serialize(object.isMenuVisible,
          specifiedType: const FullType(bool)),
      'isHistoryVisible',
      serializers.serialize(object.isHistoryVisible,
          specifiedType: const FullType(bool)),
      'enableDarkMode',
      serializers.serialize(object.enableDarkMode,
          specifiedType: const FullType(bool)),
      'showFilterSidebar',
      serializers.serialize(object.showFilterSidebar,
          specifiedType: const FullType(bool)),
      'longPressSelectionIsDefault',
      serializers.serialize(object.longPressSelectionIsDefault,
          specifiedType: const FullType(bool)),
      'requireAuthentication',
      serializers.serialize(object.requireAuthentication,
          specifiedType: const FullType(bool)),
      'rowsPerPage',
      serializers.serialize(object.rowsPerPage,
          specifiedType: const FullType(int)),
      'colorTheme',
      serializers.serialize(object.colorTheme,
          specifiedType: const FullType(String)),
      'companyPrefs',
      serializers.serialize(object.companyPrefs,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(CompanyPrefState)
          ])),
    ];

    return result;
  }

  @override
  PrefState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrefStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'appLayout':
          result.appLayout = serializers.deserialize(value,
              specifiedType: const FullType(AppLayout)) as AppLayout;
          break;
        case 'moduleLayout':
          result.moduleLayout = serializers.deserialize(value,
              specifiedType: const FullType(ModuleLayout)) as ModuleLayout;
          break;
        case 'menuSidebarMode':
          result.menuSidebarMode = serializers.deserialize(value,
              specifiedType: const FullType(AppSidebarMode)) as AppSidebarMode;
          break;
        case 'historySidebarMode':
          result.historySidebarMode = serializers.deserialize(value,
              specifiedType: const FullType(AppSidebarMode)) as AppSidebarMode;
          break;
        case 'useSidebarEditor':
          result.useSidebarEditor.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(EntityType), const FullType(bool)])));
          break;
        case 'isPreviewVisible':
          result.isPreviewVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isMenuVisible':
          result.isMenuVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isHistoryVisible':
          result.isHistoryVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enableDarkMode':
          result.enableDarkMode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'showFilterSidebar':
          result.showFilterSidebar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'longPressSelectionIsDefault':
          result.longPressSelectionIsDefault = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'requireAuthentication':
          result.requireAuthentication = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'rowsPerPage':
          result.rowsPerPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'colorTheme':
          result.colorTheme = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'companyPrefs':
          result.companyPrefs.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(CompanyPrefState)
              ])));
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyPrefStateSerializer
    implements StructuredSerializer<CompanyPrefState> {
  @override
  final Iterable<Type> types = const [CompanyPrefState, _$CompanyPrefState];
  @override
  final String wireName = 'CompanyPrefState';

  @override
  Iterable<Object> serialize(Serializers serializers, CompanyPrefState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'historyList',
      serializers.serialize(object.historyList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(HistoryRecord)])),
    ];

    return result;
  }

  @override
  CompanyPrefState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyPrefStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'historyList':
          result.historyList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(HistoryRecord)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$AppLayoutSerializer implements PrimitiveSerializer<AppLayout> {
  @override
  final Iterable<Type> types = const <Type>[AppLayout];
  @override
  final String wireName = 'AppLayout';

  @override
  Object serialize(Serializers serializers, AppLayout object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppLayout deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppLayout.valueOf(serialized as String);
}

class _$ModuleLayoutSerializer implements PrimitiveSerializer<ModuleLayout> {
  @override
  final Iterable<Type> types = const <Type>[ModuleLayout];
  @override
  final String wireName = 'ModuleLayout';

  @override
  Object serialize(Serializers serializers, ModuleLayout object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ModuleLayout deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ModuleLayout.valueOf(serialized as String);
}

class _$AppSidebarSerializer implements PrimitiveSerializer<AppSidebar> {
  @override
  final Iterable<Type> types = const <Type>[AppSidebar];
  @override
  final String wireName = 'AppSidebar';

  @override
  Object serialize(Serializers serializers, AppSidebar object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppSidebar deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppSidebar.valueOf(serialized as String);
}

class _$AppSidebarModeSerializer
    implements PrimitiveSerializer<AppSidebarMode> {
  @override
  final Iterable<Type> types = const <Type>[AppSidebarMode];
  @override
  final String wireName = 'AppSidebarMode';

  @override
  Object serialize(Serializers serializers, AppSidebarMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppSidebarMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppSidebarMode.valueOf(serialized as String);
}

class _$HistoryRecordSerializer implements StructuredSerializer<HistoryRecord> {
  @override
  final Iterable<Type> types = const [HistoryRecord, _$HistoryRecord];
  @override
  final String wireName = 'HistoryRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, HistoryRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'entityType',
      serializers.serialize(object.entityType,
          specifiedType: const FullType(EntityType)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(int)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  HistoryRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HistoryRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'entityType':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$PrefState extends PrefState {
  @override
  final AppLayout appLayout;
  @override
  final ModuleLayout moduleLayout;
  @override
  final AppSidebarMode menuSidebarMode;
  @override
  final AppSidebarMode historySidebarMode;
  @override
  final BuiltMap<EntityType, bool> useSidebarEditor;
  @override
  final bool isPreviewVisible;
  @override
  final bool isMenuVisible;
  @override
  final bool isHistoryVisible;
  @override
  final bool enableDarkMode;
  @override
  final bool showFilterSidebar;
  @override
  final bool longPressSelectionIsDefault;
  @override
  final bool requireAuthentication;
  @override
  final int rowsPerPage;
  @override
  final String colorTheme;
  @override
  final BuiltMap<String, CompanyPrefState> companyPrefs;

  factory _$PrefState([void Function(PrefStateBuilder) updates]) =>
      (new PrefStateBuilder()..update(updates)).build();

  _$PrefState._(
      {this.appLayout,
      this.moduleLayout,
      this.menuSidebarMode,
      this.historySidebarMode,
      this.useSidebarEditor,
      this.isPreviewVisible,
      this.isMenuVisible,
      this.isHistoryVisible,
      this.enableDarkMode,
      this.showFilterSidebar,
      this.longPressSelectionIsDefault,
      this.requireAuthentication,
      this.rowsPerPage,
      this.colorTheme,
      this.companyPrefs})
      : super._() {
    if (appLayout == null) {
      throw new BuiltValueNullFieldError('PrefState', 'appLayout');
    }
    if (moduleLayout == null) {
      throw new BuiltValueNullFieldError('PrefState', 'moduleLayout');
    }
    if (menuSidebarMode == null) {
      throw new BuiltValueNullFieldError('PrefState', 'menuSidebarMode');
    }
    if (historySidebarMode == null) {
      throw new BuiltValueNullFieldError('PrefState', 'historySidebarMode');
    }
    if (useSidebarEditor == null) {
      throw new BuiltValueNullFieldError('PrefState', 'useSidebarEditor');
    }
    if (isPreviewVisible == null) {
      throw new BuiltValueNullFieldError('PrefState', 'isPreviewVisible');
    }
    if (isMenuVisible == null) {
      throw new BuiltValueNullFieldError('PrefState', 'isMenuVisible');
    }
    if (isHistoryVisible == null) {
      throw new BuiltValueNullFieldError('PrefState', 'isHistoryVisible');
    }
    if (enableDarkMode == null) {
      throw new BuiltValueNullFieldError('PrefState', 'enableDarkMode');
    }
    if (showFilterSidebar == null) {
      throw new BuiltValueNullFieldError('PrefState', 'showFilterSidebar');
    }
    if (longPressSelectionIsDefault == null) {
      throw new BuiltValueNullFieldError(
          'PrefState', 'longPressSelectionIsDefault');
    }
    if (requireAuthentication == null) {
      throw new BuiltValueNullFieldError('PrefState', 'requireAuthentication');
    }
    if (rowsPerPage == null) {
      throw new BuiltValueNullFieldError('PrefState', 'rowsPerPage');
    }
    if (colorTheme == null) {
      throw new BuiltValueNullFieldError('PrefState', 'colorTheme');
    }
    if (companyPrefs == null) {
      throw new BuiltValueNullFieldError('PrefState', 'companyPrefs');
    }
  }

  @override
  PrefState rebuild(void Function(PrefStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrefStateBuilder toBuilder() => new PrefStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrefState &&
        appLayout == other.appLayout &&
        moduleLayout == other.moduleLayout &&
        menuSidebarMode == other.menuSidebarMode &&
        historySidebarMode == other.historySidebarMode &&
        useSidebarEditor == other.useSidebarEditor &&
        isPreviewVisible == other.isPreviewVisible &&
        isMenuVisible == other.isMenuVisible &&
        isHistoryVisible == other.isHistoryVisible &&
        enableDarkMode == other.enableDarkMode &&
        showFilterSidebar == other.showFilterSidebar &&
        longPressSelectionIsDefault == other.longPressSelectionIsDefault &&
        requireAuthentication == other.requireAuthentication &&
        rowsPerPage == other.rowsPerPage &&
        colorTheme == other.colorTheme &&
        companyPrefs == other.companyPrefs;
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
                                                        $jc(
                                                            $jc(
                                                                0,
                                                                appLayout
                                                                    .hashCode),
                                                            moduleLayout
                                                                .hashCode),
                                                        menuSidebarMode
                                                            .hashCode),
                                                    historySidebarMode
                                                        .hashCode),
                                                useSidebarEditor.hashCode),
                                            isPreviewVisible.hashCode),
                                        isMenuVisible.hashCode),
                                    isHistoryVisible.hashCode),
                                enableDarkMode.hashCode),
                            showFilterSidebar.hashCode),
                        longPressSelectionIsDefault.hashCode),
                    requireAuthentication.hashCode),
                rowsPerPage.hashCode),
            colorTheme.hashCode),
        companyPrefs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PrefState')
          ..add('appLayout', appLayout)
          ..add('moduleLayout', moduleLayout)
          ..add('menuSidebarMode', menuSidebarMode)
          ..add('historySidebarMode', historySidebarMode)
          ..add('useSidebarEditor', useSidebarEditor)
          ..add('isPreviewVisible', isPreviewVisible)
          ..add('isMenuVisible', isMenuVisible)
          ..add('isHistoryVisible', isHistoryVisible)
          ..add('enableDarkMode', enableDarkMode)
          ..add('showFilterSidebar', showFilterSidebar)
          ..add('longPressSelectionIsDefault', longPressSelectionIsDefault)
          ..add('requireAuthentication', requireAuthentication)
          ..add('rowsPerPage', rowsPerPage)
          ..add('colorTheme', colorTheme)
          ..add('companyPrefs', companyPrefs))
        .toString();
  }
}

class PrefStateBuilder implements Builder<PrefState, PrefStateBuilder> {
  _$PrefState _$v;

  AppLayout _appLayout;
  AppLayout get appLayout => _$this._appLayout;
  set appLayout(AppLayout appLayout) => _$this._appLayout = appLayout;

  ModuleLayout _moduleLayout;
  ModuleLayout get moduleLayout => _$this._moduleLayout;
  set moduleLayout(ModuleLayout moduleLayout) =>
      _$this._moduleLayout = moduleLayout;

  AppSidebarMode _menuSidebarMode;
  AppSidebarMode get menuSidebarMode => _$this._menuSidebarMode;
  set menuSidebarMode(AppSidebarMode menuSidebarMode) =>
      _$this._menuSidebarMode = menuSidebarMode;

  AppSidebarMode _historySidebarMode;
  AppSidebarMode get historySidebarMode => _$this._historySidebarMode;
  set historySidebarMode(AppSidebarMode historySidebarMode) =>
      _$this._historySidebarMode = historySidebarMode;

  MapBuilder<EntityType, bool> _useSidebarEditor;
  MapBuilder<EntityType, bool> get useSidebarEditor =>
      _$this._useSidebarEditor ??= new MapBuilder<EntityType, bool>();
  set useSidebarEditor(MapBuilder<EntityType, bool> useSidebarEditor) =>
      _$this._useSidebarEditor = useSidebarEditor;

  bool _isPreviewVisible;
  bool get isPreviewVisible => _$this._isPreviewVisible;
  set isPreviewVisible(bool isPreviewVisible) =>
      _$this._isPreviewVisible = isPreviewVisible;

  bool _isMenuVisible;
  bool get isMenuVisible => _$this._isMenuVisible;
  set isMenuVisible(bool isMenuVisible) =>
      _$this._isMenuVisible = isMenuVisible;

  bool _isHistoryVisible;
  bool get isHistoryVisible => _$this._isHistoryVisible;
  set isHistoryVisible(bool isHistoryVisible) =>
      _$this._isHistoryVisible = isHistoryVisible;

  bool _enableDarkMode;
  bool get enableDarkMode => _$this._enableDarkMode;
  set enableDarkMode(bool enableDarkMode) =>
      _$this._enableDarkMode = enableDarkMode;

  bool _showFilterSidebar;
  bool get showFilterSidebar => _$this._showFilterSidebar;
  set showFilterSidebar(bool showFilterSidebar) =>
      _$this._showFilterSidebar = showFilterSidebar;

  bool _longPressSelectionIsDefault;
  bool get longPressSelectionIsDefault => _$this._longPressSelectionIsDefault;
  set longPressSelectionIsDefault(bool longPressSelectionIsDefault) =>
      _$this._longPressSelectionIsDefault = longPressSelectionIsDefault;

  bool _requireAuthentication;
  bool get requireAuthentication => _$this._requireAuthentication;
  set requireAuthentication(bool requireAuthentication) =>
      _$this._requireAuthentication = requireAuthentication;

  int _rowsPerPage;
  int get rowsPerPage => _$this._rowsPerPage;
  set rowsPerPage(int rowsPerPage) => _$this._rowsPerPage = rowsPerPage;

  String _colorTheme;
  String get colorTheme => _$this._colorTheme;
  set colorTheme(String colorTheme) => _$this._colorTheme = colorTheme;

  MapBuilder<String, CompanyPrefState> _companyPrefs;
  MapBuilder<String, CompanyPrefState> get companyPrefs =>
      _$this._companyPrefs ??= new MapBuilder<String, CompanyPrefState>();
  set companyPrefs(MapBuilder<String, CompanyPrefState> companyPrefs) =>
      _$this._companyPrefs = companyPrefs;

  PrefStateBuilder() {
    PrefState._initializeBuilder(this);
  }

  PrefStateBuilder get _$this {
    if (_$v != null) {
      _appLayout = _$v.appLayout;
      _moduleLayout = _$v.moduleLayout;
      _menuSidebarMode = _$v.menuSidebarMode;
      _historySidebarMode = _$v.historySidebarMode;
      _useSidebarEditor = _$v.useSidebarEditor?.toBuilder();
      _isPreviewVisible = _$v.isPreviewVisible;
      _isMenuVisible = _$v.isMenuVisible;
      _isHistoryVisible = _$v.isHistoryVisible;
      _enableDarkMode = _$v.enableDarkMode;
      _showFilterSidebar = _$v.showFilterSidebar;
      _longPressSelectionIsDefault = _$v.longPressSelectionIsDefault;
      _requireAuthentication = _$v.requireAuthentication;
      _rowsPerPage = _$v.rowsPerPage;
      _colorTheme = _$v.colorTheme;
      _companyPrefs = _$v.companyPrefs?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrefState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PrefState;
  }

  @override
  void update(void Function(PrefStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PrefState build() {
    _$PrefState _$result;
    try {
      _$result = _$v ??
          new _$PrefState._(
              appLayout: appLayout,
              moduleLayout: moduleLayout,
              menuSidebarMode: menuSidebarMode,
              historySidebarMode: historySidebarMode,
              useSidebarEditor: useSidebarEditor.build(),
              isPreviewVisible: isPreviewVisible,
              isMenuVisible: isMenuVisible,
              isHistoryVisible: isHistoryVisible,
              enableDarkMode: enableDarkMode,
              showFilterSidebar: showFilterSidebar,
              longPressSelectionIsDefault: longPressSelectionIsDefault,
              requireAuthentication: requireAuthentication,
              rowsPerPage: rowsPerPage,
              colorTheme: colorTheme,
              companyPrefs: companyPrefs.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'useSidebarEditor';
        useSidebarEditor.build();

        _$failedField = 'companyPrefs';
        companyPrefs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PrefState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyPrefState extends CompanyPrefState {
  @override
  final BuiltList<HistoryRecord> historyList;

  factory _$CompanyPrefState(
          [void Function(CompanyPrefStateBuilder) updates]) =>
      (new CompanyPrefStateBuilder()..update(updates)).build();

  _$CompanyPrefState._({this.historyList}) : super._() {
    if (historyList == null) {
      throw new BuiltValueNullFieldError('CompanyPrefState', 'historyList');
    }
  }

  @override
  CompanyPrefState rebuild(void Function(CompanyPrefStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyPrefStateBuilder toBuilder() =>
      new CompanyPrefStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyPrefState && historyList == other.historyList;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, historyList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyPrefState')
          ..add('historyList', historyList))
        .toString();
  }
}

class CompanyPrefStateBuilder
    implements Builder<CompanyPrefState, CompanyPrefStateBuilder> {
  _$CompanyPrefState _$v;

  ListBuilder<HistoryRecord> _historyList;
  ListBuilder<HistoryRecord> get historyList =>
      _$this._historyList ??= new ListBuilder<HistoryRecord>();
  set historyList(ListBuilder<HistoryRecord> historyList) =>
      _$this._historyList = historyList;

  CompanyPrefStateBuilder();

  CompanyPrefStateBuilder get _$this {
    if (_$v != null) {
      _historyList = _$v.historyList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyPrefState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CompanyPrefState;
  }

  @override
  void update(void Function(CompanyPrefStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyPrefState build() {
    _$CompanyPrefState _$result;
    try {
      _$result =
          _$v ?? new _$CompanyPrefState._(historyList: historyList.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'historyList';
        historyList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyPrefState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HistoryRecord extends HistoryRecord {
  @override
  final String id;
  @override
  final EntityType entityType;
  @override
  final int timestamp;

  factory _$HistoryRecord([void Function(HistoryRecordBuilder) updates]) =>
      (new HistoryRecordBuilder()..update(updates)).build();

  _$HistoryRecord._({this.id, this.entityType, this.timestamp}) : super._() {
    if (entityType == null) {
      throw new BuiltValueNullFieldError('HistoryRecord', 'entityType');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('HistoryRecord', 'timestamp');
    }
  }

  @override
  HistoryRecord rebuild(void Function(HistoryRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HistoryRecordBuilder toBuilder() => new HistoryRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistoryRecord &&
        id == other.id &&
        entityType == other.entityType &&
        timestamp == other.timestamp;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf(
        $jc($jc($jc(0, id.hashCode), entityType.hashCode), timestamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HistoryRecord')
          ..add('id', id)
          ..add('entityType', entityType)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class HistoryRecordBuilder
    implements Builder<HistoryRecord, HistoryRecordBuilder> {
  _$HistoryRecord _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  EntityType _entityType;
  EntityType get entityType => _$this._entityType;
  set entityType(EntityType entityType) => _$this._entityType = entityType;

  int _timestamp;
  int get timestamp => _$this._timestamp;
  set timestamp(int timestamp) => _$this._timestamp = timestamp;

  HistoryRecordBuilder();

  HistoryRecordBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _entityType = _$v.entityType;
      _timestamp = _$v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HistoryRecord other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HistoryRecord;
  }

  @override
  void update(void Function(HistoryRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HistoryRecord build() {
    final _$result = _$v ??
        new _$HistoryRecord._(
            id: id, entityType: entityType, timestamp: timestamp);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
