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
Serializer<PrefStateSortField> _$prefStateSortFieldSerializer =
    new _$PrefStateSortFieldSerializer();
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
      'useSidebarViewer',
      serializers.serialize(object.useSidebarViewer,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(EntityType), const FullType(bool)])),
      'customColors',
      serializers.serialize(object.customColors,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'isPreviewVisible',
      serializers.serialize(object.isPreviewVisible,
          specifiedType: const FullType(bool)),
      'isMenuVisible',
      serializers.serialize(object.isMenuVisible,
          specifiedType: const FullType(bool)),
      'showKanban',
      serializers.serialize(object.showKanban,
          specifiedType: const FullType(bool)),
      'showPdfPreview',
      serializers.serialize(object.showPdfPreview,
          specifiedType: const FullType(bool)),
      'enableTouchEvents',
      serializers.serialize(object.enableTouchEvents,
          specifiedType: const FullType(bool)),
      'enableFlexibleSearch',
      serializers.serialize(object.enableFlexibleSearch,
          specifiedType: const FullType(bool)),
      'isHistoryVisible',
      serializers.serialize(object.isHistoryVisible,
          specifiedType: const FullType(bool)),
      'enableDarkMode',
      serializers.serialize(object.enableDarkMode,
          specifiedType: const FullType(bool)),
      'isFilterVisible',
      serializers.serialize(object.isFilterVisible,
          specifiedType: const FullType(bool)),
      'persistData',
      serializers.serialize(object.persistData,
          specifiedType: const FullType(bool)),
      'persistUI',
      serializers.serialize(object.persistUI,
          specifiedType: const FullType(bool)),
      'longPressSelectionIsDefault',
      serializers.serialize(object.longPressSelectionIsDefault,
          specifiedType: const FullType(bool)),
      'requireAuthentication',
      serializers.serialize(object.requireAuthentication,
          specifiedType: const FullType(bool)),
      'tapSelectedToEdit',
      serializers.serialize(object.tapSelectedToEdit,
          specifiedType: const FullType(bool)),
      'enableJSPDF',
      serializers.serialize(object.enableJSPDF,
          specifiedType: const FullType(bool)),
      'rowsPerPage',
      serializers.serialize(object.rowsPerPage,
          specifiedType: const FullType(int)),
      'enableTooltips',
      serializers.serialize(object.enableTooltips,
          specifiedType: const FullType(bool)),
      'colorTheme',
      serializers.serialize(object.colorTheme,
          specifiedType: const FullType(String)),
      'hideDesktopWarning',
      serializers.serialize(object.hideDesktopWarning,
          specifiedType: const FullType(bool)),
      'hideGatewayWarning',
      serializers.serialize(object.hideGatewayWarning,
          specifiedType: const FullType(bool)),
      'hideReviewApp',
      serializers.serialize(object.hideReviewApp,
          specifiedType: const FullType(bool)),
      'editAfterSaving',
      serializers.serialize(object.editAfterSaving,
          specifiedType: const FullType(bool)),
      'textScaleFactor',
      serializers.serialize(object.textScaleFactor,
          specifiedType: const FullType(double)),
      'sortFields',
      serializers.serialize(object.sortFields,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(EntityType),
            const FullType(PrefStateSortField)
          ])),
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
      final Object value = iterator.current;
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
        case 'useSidebarViewer':
          result.useSidebarViewer.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(EntityType), const FullType(bool)])));
          break;
        case 'customColors':
          result.customColors.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'isPreviewVisible':
          result.isPreviewVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isMenuVisible':
          result.isMenuVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'showKanban':
          result.showKanban = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'showPdfPreview':
          result.showPdfPreview = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enableTouchEvents':
          result.enableTouchEvents = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enableFlexibleSearch':
          result.enableFlexibleSearch = serializers.deserialize(value,
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
        case 'isFilterVisible':
          result.isFilterVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'persistData':
          result.persistData = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'persistUI':
          result.persistUI = serializers.deserialize(value,
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
        case 'tapSelectedToEdit':
          result.tapSelectedToEdit = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enableJSPDF':
          result.enableJSPDF = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'rowsPerPage':
          result.rowsPerPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'enableTooltips':
          result.enableTooltips = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'colorTheme':
          result.colorTheme = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hideDesktopWarning':
          result.hideDesktopWarning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'hideGatewayWarning':
          result.hideGatewayWarning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'hideReviewApp':
          result.hideReviewApp = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'editAfterSaving':
          result.editAfterSaving = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'textScaleFactor':
          result.textScaleFactor = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'sortFields':
          result.sortFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(EntityType),
                const FullType(PrefStateSortField)
              ])));
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

class _$PrefStateSortFieldSerializer
    implements StructuredSerializer<PrefStateSortField> {
  @override
  final Iterable<Type> types = const [PrefStateSortField, _$PrefStateSortField];
  @override
  final String wireName = 'PrefStateSortField';

  @override
  Iterable<Object> serialize(Serializers serializers, PrefStateSortField object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'field',
      serializers.serialize(object.field,
          specifiedType: const FullType(String)),
      'ascending',
      serializers.serialize(object.ascending,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  PrefStateSortField deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrefStateSortFieldBuilder();

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
        case 'ascending':
          result.ascending = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
      final Object value = iterator.current;
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
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
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
      final Object value = iterator.current;
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
  final BuiltMap<EntityType, bool> useSidebarViewer;
  @override
  final BuiltMap<String, String> customColors;
  @override
  final bool isPreviewVisible;
  @override
  final bool isMenuVisible;
  @override
  final bool showKanban;
  @override
  final bool showPdfPreview;
  @override
  final bool enableTouchEvents;
  @override
  final bool enableFlexibleSearch;
  @override
  final bool isHistoryVisible;
  @override
  final bool enableDarkMode;
  @override
  final bool isFilterVisible;
  @override
  final bool persistData;
  @override
  final bool persistUI;
  @override
  final bool longPressSelectionIsDefault;
  @override
  final bool requireAuthentication;
  @override
  final bool tapSelectedToEdit;
  @override
  final bool enableJSPDF;
  @override
  final int rowsPerPage;
  @override
  final bool enableTooltips;
  @override
  final String colorTheme;
  @override
  final bool hideDesktopWarning;
  @override
  final bool hideGatewayWarning;
  @override
  final bool hideReviewApp;
  @override
  final bool editAfterSaving;
  @override
  final double textScaleFactor;
  @override
  final BuiltMap<EntityType, PrefStateSortField> sortFields;
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
      this.useSidebarViewer,
      this.customColors,
      this.isPreviewVisible,
      this.isMenuVisible,
      this.showKanban,
      this.showPdfPreview,
      this.enableTouchEvents,
      this.enableFlexibleSearch,
      this.isHistoryVisible,
      this.enableDarkMode,
      this.isFilterVisible,
      this.persistData,
      this.persistUI,
      this.longPressSelectionIsDefault,
      this.requireAuthentication,
      this.tapSelectedToEdit,
      this.enableJSPDF,
      this.rowsPerPage,
      this.enableTooltips,
      this.colorTheme,
      this.hideDesktopWarning,
      this.hideGatewayWarning,
      this.hideReviewApp,
      this.editAfterSaving,
      this.textScaleFactor,
      this.sortFields,
      this.companyPrefs})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(appLayout, 'PrefState', 'appLayout');
    BuiltValueNullFieldError.checkNotNull(
        moduleLayout, 'PrefState', 'moduleLayout');
    BuiltValueNullFieldError.checkNotNull(
        menuSidebarMode, 'PrefState', 'menuSidebarMode');
    BuiltValueNullFieldError.checkNotNull(
        historySidebarMode, 'PrefState', 'historySidebarMode');
    BuiltValueNullFieldError.checkNotNull(
        useSidebarEditor, 'PrefState', 'useSidebarEditor');
    BuiltValueNullFieldError.checkNotNull(
        useSidebarViewer, 'PrefState', 'useSidebarViewer');
    BuiltValueNullFieldError.checkNotNull(
        customColors, 'PrefState', 'customColors');
    BuiltValueNullFieldError.checkNotNull(
        isPreviewVisible, 'PrefState', 'isPreviewVisible');
    BuiltValueNullFieldError.checkNotNull(
        isMenuVisible, 'PrefState', 'isMenuVisible');
    BuiltValueNullFieldError.checkNotNull(
        showKanban, 'PrefState', 'showKanban');
    BuiltValueNullFieldError.checkNotNull(
        showPdfPreview, 'PrefState', 'showPdfPreview');
    BuiltValueNullFieldError.checkNotNull(
        enableTouchEvents, 'PrefState', 'enableTouchEvents');
    BuiltValueNullFieldError.checkNotNull(
        enableFlexibleSearch, 'PrefState', 'enableFlexibleSearch');
    BuiltValueNullFieldError.checkNotNull(
        isHistoryVisible, 'PrefState', 'isHistoryVisible');
    BuiltValueNullFieldError.checkNotNull(
        enableDarkMode, 'PrefState', 'enableDarkMode');
    BuiltValueNullFieldError.checkNotNull(
        isFilterVisible, 'PrefState', 'isFilterVisible');
    BuiltValueNullFieldError.checkNotNull(
        persistData, 'PrefState', 'persistData');
    BuiltValueNullFieldError.checkNotNull(persistUI, 'PrefState', 'persistUI');
    BuiltValueNullFieldError.checkNotNull(longPressSelectionIsDefault,
        'PrefState', 'longPressSelectionIsDefault');
    BuiltValueNullFieldError.checkNotNull(
        requireAuthentication, 'PrefState', 'requireAuthentication');
    BuiltValueNullFieldError.checkNotNull(
        tapSelectedToEdit, 'PrefState', 'tapSelectedToEdit');
    BuiltValueNullFieldError.checkNotNull(
        enableJSPDF, 'PrefState', 'enableJSPDF');
    BuiltValueNullFieldError.checkNotNull(
        rowsPerPage, 'PrefState', 'rowsPerPage');
    BuiltValueNullFieldError.checkNotNull(
        enableTooltips, 'PrefState', 'enableTooltips');
    BuiltValueNullFieldError.checkNotNull(
        colorTheme, 'PrefState', 'colorTheme');
    BuiltValueNullFieldError.checkNotNull(
        hideDesktopWarning, 'PrefState', 'hideDesktopWarning');
    BuiltValueNullFieldError.checkNotNull(
        hideGatewayWarning, 'PrefState', 'hideGatewayWarning');
    BuiltValueNullFieldError.checkNotNull(
        hideReviewApp, 'PrefState', 'hideReviewApp');
    BuiltValueNullFieldError.checkNotNull(
        editAfterSaving, 'PrefState', 'editAfterSaving');
    BuiltValueNullFieldError.checkNotNull(
        textScaleFactor, 'PrefState', 'textScaleFactor');
    BuiltValueNullFieldError.checkNotNull(
        sortFields, 'PrefState', 'sortFields');
    BuiltValueNullFieldError.checkNotNull(
        companyPrefs, 'PrefState', 'companyPrefs');
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
        useSidebarViewer == other.useSidebarViewer &&
        customColors == other.customColors &&
        isPreviewVisible == other.isPreviewVisible &&
        isMenuVisible == other.isMenuVisible &&
        showKanban == other.showKanban &&
        showPdfPreview == other.showPdfPreview &&
        enableTouchEvents == other.enableTouchEvents &&
        enableFlexibleSearch == other.enableFlexibleSearch &&
        isHistoryVisible == other.isHistoryVisible &&
        enableDarkMode == other.enableDarkMode &&
        isFilterVisible == other.isFilterVisible &&
        persistData == other.persistData &&
        persistUI == other.persistUI &&
        longPressSelectionIsDefault == other.longPressSelectionIsDefault &&
        requireAuthentication == other.requireAuthentication &&
        tapSelectedToEdit == other.tapSelectedToEdit &&
        enableJSPDF == other.enableJSPDF &&
        rowsPerPage == other.rowsPerPage &&
        enableTooltips == other.enableTooltips &&
        colorTheme == other.colorTheme &&
        hideDesktopWarning == other.hideDesktopWarning &&
        hideGatewayWarning == other.hideGatewayWarning &&
        hideReviewApp == other.hideReviewApp &&
        editAfterSaving == other.editAfterSaving &&
        textScaleFactor == other.textScaleFactor &&
        sortFields == other.sortFields &&
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
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, appLayout.hashCode), moduleLayout.hashCode), menuSidebarMode.hashCode), historySidebarMode.hashCode), useSidebarEditor.hashCode), useSidebarViewer.hashCode), customColors.hashCode), isPreviewVisible.hashCode), isMenuVisible.hashCode), showKanban.hashCode), showPdfPreview.hashCode), enableTouchEvents.hashCode), enableFlexibleSearch.hashCode),
                                                                                isHistoryVisible.hashCode),
                                                                            enableDarkMode.hashCode),
                                                                        isFilterVisible.hashCode),
                                                                    persistData.hashCode),
                                                                persistUI.hashCode),
                                                            longPressSelectionIsDefault.hashCode),
                                                        requireAuthentication.hashCode),
                                                    tapSelectedToEdit.hashCode),
                                                enableJSPDF.hashCode),
                                            rowsPerPage.hashCode),
                                        enableTooltips.hashCode),
                                    colorTheme.hashCode),
                                hideDesktopWarning.hashCode),
                            hideGatewayWarning.hashCode),
                        hideReviewApp.hashCode),
                    editAfterSaving.hashCode),
                textScaleFactor.hashCode),
            sortFields.hashCode),
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
          ..add('useSidebarViewer', useSidebarViewer)
          ..add('customColors', customColors)
          ..add('isPreviewVisible', isPreviewVisible)
          ..add('isMenuVisible', isMenuVisible)
          ..add('showKanban', showKanban)
          ..add('showPdfPreview', showPdfPreview)
          ..add('enableTouchEvents', enableTouchEvents)
          ..add('enableFlexibleSearch', enableFlexibleSearch)
          ..add('isHistoryVisible', isHistoryVisible)
          ..add('enableDarkMode', enableDarkMode)
          ..add('isFilterVisible', isFilterVisible)
          ..add('persistData', persistData)
          ..add('persistUI', persistUI)
          ..add('longPressSelectionIsDefault', longPressSelectionIsDefault)
          ..add('requireAuthentication', requireAuthentication)
          ..add('tapSelectedToEdit', tapSelectedToEdit)
          ..add('enableJSPDF', enableJSPDF)
          ..add('rowsPerPage', rowsPerPage)
          ..add('enableTooltips', enableTooltips)
          ..add('colorTheme', colorTheme)
          ..add('hideDesktopWarning', hideDesktopWarning)
          ..add('hideGatewayWarning', hideGatewayWarning)
          ..add('hideReviewApp', hideReviewApp)
          ..add('editAfterSaving', editAfterSaving)
          ..add('textScaleFactor', textScaleFactor)
          ..add('sortFields', sortFields)
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

  MapBuilder<EntityType, bool> _useSidebarViewer;
  MapBuilder<EntityType, bool> get useSidebarViewer =>
      _$this._useSidebarViewer ??= new MapBuilder<EntityType, bool>();
  set useSidebarViewer(MapBuilder<EntityType, bool> useSidebarViewer) =>
      _$this._useSidebarViewer = useSidebarViewer;

  MapBuilder<String, String> _customColors;
  MapBuilder<String, String> get customColors =>
      _$this._customColors ??= new MapBuilder<String, String>();
  set customColors(MapBuilder<String, String> customColors) =>
      _$this._customColors = customColors;

  bool _isPreviewVisible;
  bool get isPreviewVisible => _$this._isPreviewVisible;
  set isPreviewVisible(bool isPreviewVisible) =>
      _$this._isPreviewVisible = isPreviewVisible;

  bool _isMenuVisible;
  bool get isMenuVisible => _$this._isMenuVisible;
  set isMenuVisible(bool isMenuVisible) =>
      _$this._isMenuVisible = isMenuVisible;

  bool _showKanban;
  bool get showKanban => _$this._showKanban;
  set showKanban(bool showKanban) => _$this._showKanban = showKanban;

  bool _showPdfPreview;
  bool get showPdfPreview => _$this._showPdfPreview;
  set showPdfPreview(bool showPdfPreview) =>
      _$this._showPdfPreview = showPdfPreview;

  bool _enableTouchEvents;
  bool get enableTouchEvents => _$this._enableTouchEvents;
  set enableTouchEvents(bool enableTouchEvents) =>
      _$this._enableTouchEvents = enableTouchEvents;

  bool _enableFlexibleSearch;
  bool get enableFlexibleSearch => _$this._enableFlexibleSearch;
  set enableFlexibleSearch(bool enableFlexibleSearch) =>
      _$this._enableFlexibleSearch = enableFlexibleSearch;

  bool _isHistoryVisible;
  bool get isHistoryVisible => _$this._isHistoryVisible;
  set isHistoryVisible(bool isHistoryVisible) =>
      _$this._isHistoryVisible = isHistoryVisible;

  bool _enableDarkMode;
  bool get enableDarkMode => _$this._enableDarkMode;
  set enableDarkMode(bool enableDarkMode) =>
      _$this._enableDarkMode = enableDarkMode;

  bool _isFilterVisible;
  bool get isFilterVisible => _$this._isFilterVisible;
  set isFilterVisible(bool isFilterVisible) =>
      _$this._isFilterVisible = isFilterVisible;

  bool _persistData;
  bool get persistData => _$this._persistData;
  set persistData(bool persistData) => _$this._persistData = persistData;

  bool _persistUI;
  bool get persistUI => _$this._persistUI;
  set persistUI(bool persistUI) => _$this._persistUI = persistUI;

  bool _longPressSelectionIsDefault;
  bool get longPressSelectionIsDefault => _$this._longPressSelectionIsDefault;
  set longPressSelectionIsDefault(bool longPressSelectionIsDefault) =>
      _$this._longPressSelectionIsDefault = longPressSelectionIsDefault;

  bool _requireAuthentication;
  bool get requireAuthentication => _$this._requireAuthentication;
  set requireAuthentication(bool requireAuthentication) =>
      _$this._requireAuthentication = requireAuthentication;

  bool _tapSelectedToEdit;
  bool get tapSelectedToEdit => _$this._tapSelectedToEdit;
  set tapSelectedToEdit(bool tapSelectedToEdit) =>
      _$this._tapSelectedToEdit = tapSelectedToEdit;

  bool _enableJSPDF;
  bool get enableJSPDF => _$this._enableJSPDF;
  set enableJSPDF(bool enableJSPDF) => _$this._enableJSPDF = enableJSPDF;

  int _rowsPerPage;
  int get rowsPerPage => _$this._rowsPerPage;
  set rowsPerPage(int rowsPerPage) => _$this._rowsPerPage = rowsPerPage;

  bool _enableTooltips;
  bool get enableTooltips => _$this._enableTooltips;
  set enableTooltips(bool enableTooltips) =>
      _$this._enableTooltips = enableTooltips;

  String _colorTheme;
  String get colorTheme => _$this._colorTheme;
  set colorTheme(String colorTheme) => _$this._colorTheme = colorTheme;

  bool _hideDesktopWarning;
  bool get hideDesktopWarning => _$this._hideDesktopWarning;
  set hideDesktopWarning(bool hideDesktopWarning) =>
      _$this._hideDesktopWarning = hideDesktopWarning;

  bool _hideGatewayWarning;
  bool get hideGatewayWarning => _$this._hideGatewayWarning;
  set hideGatewayWarning(bool hideGatewayWarning) =>
      _$this._hideGatewayWarning = hideGatewayWarning;

  bool _hideReviewApp;
  bool get hideReviewApp => _$this._hideReviewApp;
  set hideReviewApp(bool hideReviewApp) =>
      _$this._hideReviewApp = hideReviewApp;

  bool _editAfterSaving;
  bool get editAfterSaving => _$this._editAfterSaving;
  set editAfterSaving(bool editAfterSaving) =>
      _$this._editAfterSaving = editAfterSaving;

  double _textScaleFactor;
  double get textScaleFactor => _$this._textScaleFactor;
  set textScaleFactor(double textScaleFactor) =>
      _$this._textScaleFactor = textScaleFactor;

  MapBuilder<EntityType, PrefStateSortField> _sortFields;
  MapBuilder<EntityType, PrefStateSortField> get sortFields =>
      _$this._sortFields ??= new MapBuilder<EntityType, PrefStateSortField>();
  set sortFields(MapBuilder<EntityType, PrefStateSortField> sortFields) =>
      _$this._sortFields = sortFields;

  MapBuilder<String, CompanyPrefState> _companyPrefs;
  MapBuilder<String, CompanyPrefState> get companyPrefs =>
      _$this._companyPrefs ??= new MapBuilder<String, CompanyPrefState>();
  set companyPrefs(MapBuilder<String, CompanyPrefState> companyPrefs) =>
      _$this._companyPrefs = companyPrefs;

  PrefStateBuilder() {
    PrefState._initializeBuilder(this);
  }

  PrefStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _appLayout = $v.appLayout;
      _moduleLayout = $v.moduleLayout;
      _menuSidebarMode = $v.menuSidebarMode;
      _historySidebarMode = $v.historySidebarMode;
      _useSidebarEditor = $v.useSidebarEditor.toBuilder();
      _useSidebarViewer = $v.useSidebarViewer.toBuilder();
      _customColors = $v.customColors.toBuilder();
      _isPreviewVisible = $v.isPreviewVisible;
      _isMenuVisible = $v.isMenuVisible;
      _showKanban = $v.showKanban;
      _showPdfPreview = $v.showPdfPreview;
      _enableTouchEvents = $v.enableTouchEvents;
      _enableFlexibleSearch = $v.enableFlexibleSearch;
      _isHistoryVisible = $v.isHistoryVisible;
      _enableDarkMode = $v.enableDarkMode;
      _isFilterVisible = $v.isFilterVisible;
      _persistData = $v.persistData;
      _persistUI = $v.persistUI;
      _longPressSelectionIsDefault = $v.longPressSelectionIsDefault;
      _requireAuthentication = $v.requireAuthentication;
      _tapSelectedToEdit = $v.tapSelectedToEdit;
      _enableJSPDF = $v.enableJSPDF;
      _rowsPerPage = $v.rowsPerPage;
      _enableTooltips = $v.enableTooltips;
      _colorTheme = $v.colorTheme;
      _hideDesktopWarning = $v.hideDesktopWarning;
      _hideGatewayWarning = $v.hideGatewayWarning;
      _hideReviewApp = $v.hideReviewApp;
      _editAfterSaving = $v.editAfterSaving;
      _textScaleFactor = $v.textScaleFactor;
      _sortFields = $v.sortFields.toBuilder();
      _companyPrefs = $v.companyPrefs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrefState other) {
    ArgumentError.checkNotNull(other, 'other');
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
              appLayout: BuiltValueNullFieldError.checkNotNull(
                  appLayout, 'PrefState', 'appLayout'),
              moduleLayout: BuiltValueNullFieldError.checkNotNull(
                  moduleLayout, 'PrefState', 'moduleLayout'),
              menuSidebarMode: BuiltValueNullFieldError.checkNotNull(
                  menuSidebarMode, 'PrefState', 'menuSidebarMode'),
              historySidebarMode: BuiltValueNullFieldError.checkNotNull(
                  historySidebarMode, 'PrefState', 'historySidebarMode'),
              useSidebarEditor: useSidebarEditor.build(),
              useSidebarViewer: useSidebarViewer.build(),
              customColors: customColors.build(),
              isPreviewVisible: BuiltValueNullFieldError.checkNotNull(
                  isPreviewVisible, 'PrefState', 'isPreviewVisible'),
              isMenuVisible: BuiltValueNullFieldError.checkNotNull(
                  isMenuVisible, 'PrefState', 'isMenuVisible'),
              showKanban: BuiltValueNullFieldError.checkNotNull(
                  showKanban, 'PrefState', 'showKanban'),
              showPdfPreview:
                  BuiltValueNullFieldError.checkNotNull(showPdfPreview, 'PrefState', 'showPdfPreview'),
              enableTouchEvents: BuiltValueNullFieldError.checkNotNull(enableTouchEvents, 'PrefState', 'enableTouchEvents'),
              enableFlexibleSearch: BuiltValueNullFieldError.checkNotNull(enableFlexibleSearch, 'PrefState', 'enableFlexibleSearch'),
              isHistoryVisible: BuiltValueNullFieldError.checkNotNull(isHistoryVisible, 'PrefState', 'isHistoryVisible'),
              enableDarkMode: BuiltValueNullFieldError.checkNotNull(enableDarkMode, 'PrefState', 'enableDarkMode'),
              isFilterVisible: BuiltValueNullFieldError.checkNotNull(isFilterVisible, 'PrefState', 'isFilterVisible'),
              persistData: BuiltValueNullFieldError.checkNotNull(persistData, 'PrefState', 'persistData'),
              persistUI: BuiltValueNullFieldError.checkNotNull(persistUI, 'PrefState', 'persistUI'),
              longPressSelectionIsDefault: BuiltValueNullFieldError.checkNotNull(longPressSelectionIsDefault, 'PrefState', 'longPressSelectionIsDefault'),
              requireAuthentication: BuiltValueNullFieldError.checkNotNull(requireAuthentication, 'PrefState', 'requireAuthentication'),
              tapSelectedToEdit: BuiltValueNullFieldError.checkNotNull(tapSelectedToEdit, 'PrefState', 'tapSelectedToEdit'),
              enableJSPDF: BuiltValueNullFieldError.checkNotNull(enableJSPDF, 'PrefState', 'enableJSPDF'),
              rowsPerPage: BuiltValueNullFieldError.checkNotNull(rowsPerPage, 'PrefState', 'rowsPerPage'),
              enableTooltips: BuiltValueNullFieldError.checkNotNull(enableTooltips, 'PrefState', 'enableTooltips'),
              colorTheme: BuiltValueNullFieldError.checkNotNull(colorTheme, 'PrefState', 'colorTheme'),
              hideDesktopWarning: BuiltValueNullFieldError.checkNotNull(hideDesktopWarning, 'PrefState', 'hideDesktopWarning'),
              hideGatewayWarning: BuiltValueNullFieldError.checkNotNull(hideGatewayWarning, 'PrefState', 'hideGatewayWarning'),
              hideReviewApp: BuiltValueNullFieldError.checkNotNull(hideReviewApp, 'PrefState', 'hideReviewApp'),
              editAfterSaving: BuiltValueNullFieldError.checkNotNull(editAfterSaving, 'PrefState', 'editAfterSaving'),
              textScaleFactor: BuiltValueNullFieldError.checkNotNull(textScaleFactor, 'PrefState', 'textScaleFactor'),
              sortFields: sortFields.build(),
              companyPrefs: companyPrefs.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'useSidebarEditor';
        useSidebarEditor.build();
        _$failedField = 'useSidebarViewer';
        useSidebarViewer.build();
        _$failedField = 'customColors';
        customColors.build();

        _$failedField = 'sortFields';
        sortFields.build();
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

class _$PrefStateSortField extends PrefStateSortField {
  @override
  final String field;
  @override
  final bool ascending;

  factory _$PrefStateSortField(
          [void Function(PrefStateSortFieldBuilder) updates]) =>
      (new PrefStateSortFieldBuilder()..update(updates)).build();

  _$PrefStateSortField._({this.field, this.ascending}) : super._() {
    BuiltValueNullFieldError.checkNotNull(field, 'PrefStateSortField', 'field');
    BuiltValueNullFieldError.checkNotNull(
        ascending, 'PrefStateSortField', 'ascending');
  }

  @override
  PrefStateSortField rebuild(
          void Function(PrefStateSortFieldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrefStateSortFieldBuilder toBuilder() =>
      new PrefStateSortFieldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrefStateSortField &&
        field == other.field &&
        ascending == other.ascending;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, field.hashCode), ascending.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PrefStateSortField')
          ..add('field', field)
          ..add('ascending', ascending))
        .toString();
  }
}

class PrefStateSortFieldBuilder
    implements Builder<PrefStateSortField, PrefStateSortFieldBuilder> {
  _$PrefStateSortField _$v;

  String _field;
  String get field => _$this._field;
  set field(String field) => _$this._field = field;

  bool _ascending;
  bool get ascending => _$this._ascending;
  set ascending(bool ascending) => _$this._ascending = ascending;

  PrefStateSortFieldBuilder();

  PrefStateSortFieldBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _field = $v.field;
      _ascending = $v.ascending;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrefStateSortField other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PrefStateSortField;
  }

  @override
  void update(void Function(PrefStateSortFieldBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PrefStateSortField build() {
    final _$result = _$v ??
        new _$PrefStateSortField._(
            field: BuiltValueNullFieldError.checkNotNull(
                field, 'PrefStateSortField', 'field'),
            ascending: BuiltValueNullFieldError.checkNotNull(
                ascending, 'PrefStateSortField', 'ascending'));
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
    BuiltValueNullFieldError.checkNotNull(
        historyList, 'CompanyPrefState', 'historyList');
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
    final $v = _$v;
    if ($v != null) {
      _historyList = $v.historyList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyPrefState other) {
    ArgumentError.checkNotNull(other, 'other');
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
    BuiltValueNullFieldError.checkNotNull(
        entityType, 'HistoryRecord', 'entityType');
    BuiltValueNullFieldError.checkNotNull(
        timestamp, 'HistoryRecord', 'timestamp');
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
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _entityType = $v.entityType;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HistoryRecord other) {
    ArgumentError.checkNotNull(other, 'other');
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
            id: id,
            entityType: BuiltValueNullFieldError.checkNotNull(
                entityType, 'HistoryRecord', 'entityType'),
            timestamp: BuiltValueNullFieldError.checkNotNull(
                timestamp, 'HistoryRecord', 'timestamp'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
