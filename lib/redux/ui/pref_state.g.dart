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
  Iterable<Object?> serialize(Serializers serializers, PrefState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      'darkCustomColors',
      serializers.serialize(object.darkCustomColors,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'statementIncludes',
      serializers.serialize(object.statementIncludes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
      'showPdfPreviewSideBySide',
      serializers.serialize(object.showPdfPreviewSideBySide,
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
      'darkModeType',
      serializers.serialize(object.darkModeType,
          specifiedType: const FullType(String)),
      'enableDarkModeSystem',
      serializers.serialize(object.enableDarkModeSystem,
          specifiedType: const FullType(bool)),
      'isFilterVisible',
      serializers.serialize(object.isFilterVisible,
          specifiedType: const FullType(bool)),
      'persistData',
      serializers.serialize(object.persistData,
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
      'rowsPerPage',
      serializers.serialize(object.rowsPerPage,
          specifiedType: const FullType(int)),
      'enableTooltips',
      serializers.serialize(object.enableTooltips,
          specifiedType: const FullType(bool)),
      'colorTheme',
      serializers.serialize(object.colorTheme,
          specifiedType: const FullType(String)),
      'darkColorTheme',
      serializers.serialize(object.darkColorTheme,
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
      'hideOneYearReviewApp',
      serializers.serialize(object.hideOneYearReviewApp,
          specifiedType: const FullType(bool)),
      'hideTwoYearReviewApp',
      serializers.serialize(object.hideTwoYearReviewApp,
          specifiedType: const FullType(bool)),
      'hideTaskExtensionBanner',
      serializers.serialize(object.hideTaskExtensionBanner,
          specifiedType: const FullType(bool)),
      'editAfterSaving',
      serializers.serialize(object.editAfterSaving,
          specifiedType: const FullType(bool)),
      'enableNativeBrowser',
      serializers.serialize(object.enableNativeBrowser,
          specifiedType: const FullType(bool)),
      'textScaleFactor',
      serializers.serialize(object.textScaleFactor,
          specifiedType: const FullType(double)),
      'donwloadsFolder',
      serializers.serialize(object.donwloadsFolder,
          specifiedType: const FullType(String)),
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
  PrefState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrefStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'appLayout':
          result.appLayout = serializers.deserialize(value,
              specifiedType: const FullType(AppLayout))! as AppLayout;
          break;
        case 'moduleLayout':
          result.moduleLayout = serializers.deserialize(value,
              specifiedType: const FullType(ModuleLayout))! as ModuleLayout;
          break;
        case 'menuSidebarMode':
          result.menuSidebarMode = serializers.deserialize(value,
              specifiedType: const FullType(AppSidebarMode))! as AppSidebarMode;
          break;
        case 'historySidebarMode':
          result.historySidebarMode = serializers.deserialize(value,
              specifiedType: const FullType(AppSidebarMode))! as AppSidebarMode;
          break;
        case 'useSidebarEditor':
          result.useSidebarEditor.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(EntityType), const FullType(bool)]))!);
          break;
        case 'useSidebarViewer':
          result.useSidebarViewer.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(EntityType), const FullType(bool)]))!);
          break;
        case 'customColors':
          result.customColors.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'darkCustomColors':
          result.darkCustomColors.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'statementIncludes':
          result.statementIncludes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'isPreviewVisible':
          result.isPreviewVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isMenuVisible':
          result.isMenuVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'showKanban':
          result.showKanban = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'showPdfPreview':
          result.showPdfPreview = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'showPdfPreviewSideBySide':
          result.showPdfPreviewSideBySide = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'enableTouchEvents':
          result.enableTouchEvents = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'enableFlexibleSearch':
          result.enableFlexibleSearch = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isHistoryVisible':
          result.isHistoryVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'darkModeType':
          result.darkModeType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'enableDarkModeSystem':
          result.enableDarkModeSystem = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isFilterVisible':
          result.isFilterVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'persistData':
          result.persistData = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'longPressSelectionIsDefault':
          result.longPressSelectionIsDefault = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'requireAuthentication':
          result.requireAuthentication = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'tapSelectedToEdit':
          result.tapSelectedToEdit = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'rowsPerPage':
          result.rowsPerPage = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'enableTooltips':
          result.enableTooltips = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'colorTheme':
          result.colorTheme = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'darkColorTheme':
          result.darkColorTheme = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'hideDesktopWarning':
          result.hideDesktopWarning = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideGatewayWarning':
          result.hideGatewayWarning = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideReviewApp':
          result.hideReviewApp = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideOneYearReviewApp':
          result.hideOneYearReviewApp = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideTwoYearReviewApp':
          result.hideTwoYearReviewApp = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideTaskExtensionBanner':
          result.hideTaskExtensionBanner = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'editAfterSaving':
          result.editAfterSaving = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'enableNativeBrowser':
          result.enableNativeBrowser = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'textScaleFactor':
          result.textScaleFactor = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'donwloadsFolder':
          result.donwloadsFolder = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sortFields':
          result.sortFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(EntityType),
                const FullType(PrefStateSortField)
              ]))!);
          break;
        case 'companyPrefs':
          result.companyPrefs.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(CompanyPrefState)
              ]))!);
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
  Iterable<Object?> serialize(
      Serializers serializers, PrefStateSortField object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrefStateSortFieldBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'field':
          result.field = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'ascending':
          result.ascending = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
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
  Iterable<Object?> serialize(Serializers serializers, CompanyPrefState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'historyList',
      serializers.serialize(object.historyList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(HistoryRecord)])),
    ];

    return result;
  }

  @override
  CompanyPrefState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyPrefStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'historyList':
          result.historyList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(HistoryRecord)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(Serializers serializers, HistoryRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'entityType',
      serializers.serialize(object.entityType,
          specifiedType: const FullType(EntityType)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.page;
    if (value != null) {
      result
        ..add('page')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  HistoryRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HistoryRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'entityType':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType))! as EntityType;
          break;
        case 'page':
          result.page = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
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
  final BuiltMap<String, String> darkCustomColors;
  @override
  final BuiltList<String> statementIncludes;
  @override
  final bool isPreviewVisible;
  @override
  final bool isMenuVisible;
  @override
  final bool showKanban;
  @override
  final bool showPdfPreview;
  @override
  final bool showPdfPreviewSideBySide;
  @override
  final bool enableTouchEvents;
  @override
  final bool enableFlexibleSearch;
  @override
  final bool isHistoryVisible;
  @override
  final String darkModeType;
  @override
  final bool enableDarkModeSystem;
  @override
  final bool isFilterVisible;
  @override
  final bool persistData;
  @override
  final bool longPressSelectionIsDefault;
  @override
  final bool requireAuthentication;
  @override
  final bool tapSelectedToEdit;
  @override
  final int rowsPerPage;
  @override
  final bool enableTooltips;
  @override
  final String colorTheme;
  @override
  final String darkColorTheme;
  @override
  final bool hideDesktopWarning;
  @override
  final bool hideGatewayWarning;
  @override
  final bool hideReviewApp;
  @override
  final bool hideOneYearReviewApp;
  @override
  final bool hideTwoYearReviewApp;
  @override
  final bool hideTaskExtensionBanner;
  @override
  final bool editAfterSaving;
  @override
  final bool enableNativeBrowser;
  @override
  final double textScaleFactor;
  @override
  final String donwloadsFolder;
  @override
  final BuiltMap<EntityType, PrefStateSortField> sortFields;
  @override
  final BuiltMap<String, CompanyPrefState> companyPrefs;

  factory _$PrefState([void Function(PrefStateBuilder)? updates]) =>
      (new PrefStateBuilder()..update(updates))._build();

  _$PrefState._(
      {required this.appLayout,
      required this.moduleLayout,
      required this.menuSidebarMode,
      required this.historySidebarMode,
      required this.useSidebarEditor,
      required this.useSidebarViewer,
      required this.customColors,
      required this.darkCustomColors,
      required this.statementIncludes,
      required this.isPreviewVisible,
      required this.isMenuVisible,
      required this.showKanban,
      required this.showPdfPreview,
      required this.showPdfPreviewSideBySide,
      required this.enableTouchEvents,
      required this.enableFlexibleSearch,
      required this.isHistoryVisible,
      required this.darkModeType,
      required this.enableDarkModeSystem,
      required this.isFilterVisible,
      required this.persistData,
      required this.longPressSelectionIsDefault,
      required this.requireAuthentication,
      required this.tapSelectedToEdit,
      required this.rowsPerPage,
      required this.enableTooltips,
      required this.colorTheme,
      required this.darkColorTheme,
      required this.hideDesktopWarning,
      required this.hideGatewayWarning,
      required this.hideReviewApp,
      required this.hideOneYearReviewApp,
      required this.hideTwoYearReviewApp,
      required this.hideTaskExtensionBanner,
      required this.editAfterSaving,
      required this.enableNativeBrowser,
      required this.textScaleFactor,
      required this.donwloadsFolder,
      required this.sortFields,
      required this.companyPrefs})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(appLayout, r'PrefState', 'appLayout');
    BuiltValueNullFieldError.checkNotNull(
        moduleLayout, r'PrefState', 'moduleLayout');
    BuiltValueNullFieldError.checkNotNull(
        menuSidebarMode, r'PrefState', 'menuSidebarMode');
    BuiltValueNullFieldError.checkNotNull(
        historySidebarMode, r'PrefState', 'historySidebarMode');
    BuiltValueNullFieldError.checkNotNull(
        useSidebarEditor, r'PrefState', 'useSidebarEditor');
    BuiltValueNullFieldError.checkNotNull(
        useSidebarViewer, r'PrefState', 'useSidebarViewer');
    BuiltValueNullFieldError.checkNotNull(
        customColors, r'PrefState', 'customColors');
    BuiltValueNullFieldError.checkNotNull(
        darkCustomColors, r'PrefState', 'darkCustomColors');
    BuiltValueNullFieldError.checkNotNull(
        statementIncludes, r'PrefState', 'statementIncludes');
    BuiltValueNullFieldError.checkNotNull(
        isPreviewVisible, r'PrefState', 'isPreviewVisible');
    BuiltValueNullFieldError.checkNotNull(
        isMenuVisible, r'PrefState', 'isMenuVisible');
    BuiltValueNullFieldError.checkNotNull(
        showKanban, r'PrefState', 'showKanban');
    BuiltValueNullFieldError.checkNotNull(
        showPdfPreview, r'PrefState', 'showPdfPreview');
    BuiltValueNullFieldError.checkNotNull(
        showPdfPreviewSideBySide, r'PrefState', 'showPdfPreviewSideBySide');
    BuiltValueNullFieldError.checkNotNull(
        enableTouchEvents, r'PrefState', 'enableTouchEvents');
    BuiltValueNullFieldError.checkNotNull(
        enableFlexibleSearch, r'PrefState', 'enableFlexibleSearch');
    BuiltValueNullFieldError.checkNotNull(
        isHistoryVisible, r'PrefState', 'isHistoryVisible');
    BuiltValueNullFieldError.checkNotNull(
        darkModeType, r'PrefState', 'darkModeType');
    BuiltValueNullFieldError.checkNotNull(
        enableDarkModeSystem, r'PrefState', 'enableDarkModeSystem');
    BuiltValueNullFieldError.checkNotNull(
        isFilterVisible, r'PrefState', 'isFilterVisible');
    BuiltValueNullFieldError.checkNotNull(
        persistData, r'PrefState', 'persistData');
    BuiltValueNullFieldError.checkNotNull(longPressSelectionIsDefault,
        r'PrefState', 'longPressSelectionIsDefault');
    BuiltValueNullFieldError.checkNotNull(
        requireAuthentication, r'PrefState', 'requireAuthentication');
    BuiltValueNullFieldError.checkNotNull(
        tapSelectedToEdit, r'PrefState', 'tapSelectedToEdit');
    BuiltValueNullFieldError.checkNotNull(
        rowsPerPage, r'PrefState', 'rowsPerPage');
    BuiltValueNullFieldError.checkNotNull(
        enableTooltips, r'PrefState', 'enableTooltips');
    BuiltValueNullFieldError.checkNotNull(
        colorTheme, r'PrefState', 'colorTheme');
    BuiltValueNullFieldError.checkNotNull(
        darkColorTheme, r'PrefState', 'darkColorTheme');
    BuiltValueNullFieldError.checkNotNull(
        hideDesktopWarning, r'PrefState', 'hideDesktopWarning');
    BuiltValueNullFieldError.checkNotNull(
        hideGatewayWarning, r'PrefState', 'hideGatewayWarning');
    BuiltValueNullFieldError.checkNotNull(
        hideReviewApp, r'PrefState', 'hideReviewApp');
    BuiltValueNullFieldError.checkNotNull(
        hideOneYearReviewApp, r'PrefState', 'hideOneYearReviewApp');
    BuiltValueNullFieldError.checkNotNull(
        hideTwoYearReviewApp, r'PrefState', 'hideTwoYearReviewApp');
    BuiltValueNullFieldError.checkNotNull(
        hideTaskExtensionBanner, r'PrefState', 'hideTaskExtensionBanner');
    BuiltValueNullFieldError.checkNotNull(
        editAfterSaving, r'PrefState', 'editAfterSaving');
    BuiltValueNullFieldError.checkNotNull(
        enableNativeBrowser, r'PrefState', 'enableNativeBrowser');
    BuiltValueNullFieldError.checkNotNull(
        textScaleFactor, r'PrefState', 'textScaleFactor');
    BuiltValueNullFieldError.checkNotNull(
        donwloadsFolder, r'PrefState', 'donwloadsFolder');
    BuiltValueNullFieldError.checkNotNull(
        sortFields, r'PrefState', 'sortFields');
    BuiltValueNullFieldError.checkNotNull(
        companyPrefs, r'PrefState', 'companyPrefs');
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
        darkCustomColors == other.darkCustomColors &&
        statementIncludes == other.statementIncludes &&
        isPreviewVisible == other.isPreviewVisible &&
        isMenuVisible == other.isMenuVisible &&
        showKanban == other.showKanban &&
        showPdfPreview == other.showPdfPreview &&
        showPdfPreviewSideBySide == other.showPdfPreviewSideBySide &&
        enableTouchEvents == other.enableTouchEvents &&
        enableFlexibleSearch == other.enableFlexibleSearch &&
        isHistoryVisible == other.isHistoryVisible &&
        darkModeType == other.darkModeType &&
        enableDarkModeSystem == other.enableDarkModeSystem &&
        isFilterVisible == other.isFilterVisible &&
        persistData == other.persistData &&
        longPressSelectionIsDefault == other.longPressSelectionIsDefault &&
        requireAuthentication == other.requireAuthentication &&
        tapSelectedToEdit == other.tapSelectedToEdit &&
        rowsPerPage == other.rowsPerPage &&
        enableTooltips == other.enableTooltips &&
        colorTheme == other.colorTheme &&
        darkColorTheme == other.darkColorTheme &&
        hideDesktopWarning == other.hideDesktopWarning &&
        hideGatewayWarning == other.hideGatewayWarning &&
        hideReviewApp == other.hideReviewApp &&
        hideOneYearReviewApp == other.hideOneYearReviewApp &&
        hideTwoYearReviewApp == other.hideTwoYearReviewApp &&
        hideTaskExtensionBanner == other.hideTaskExtensionBanner &&
        editAfterSaving == other.editAfterSaving &&
        enableNativeBrowser == other.enableNativeBrowser &&
        textScaleFactor == other.textScaleFactor &&
        donwloadsFolder == other.donwloadsFolder &&
        sortFields == other.sortFields &&
        companyPrefs == other.companyPrefs;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, appLayout.hashCode);
    _$hash = $jc(_$hash, moduleLayout.hashCode);
    _$hash = $jc(_$hash, menuSidebarMode.hashCode);
    _$hash = $jc(_$hash, historySidebarMode.hashCode);
    _$hash = $jc(_$hash, useSidebarEditor.hashCode);
    _$hash = $jc(_$hash, useSidebarViewer.hashCode);
    _$hash = $jc(_$hash, customColors.hashCode);
    _$hash = $jc(_$hash, darkCustomColors.hashCode);
    _$hash = $jc(_$hash, statementIncludes.hashCode);
    _$hash = $jc(_$hash, isPreviewVisible.hashCode);
    _$hash = $jc(_$hash, isMenuVisible.hashCode);
    _$hash = $jc(_$hash, showKanban.hashCode);
    _$hash = $jc(_$hash, showPdfPreview.hashCode);
    _$hash = $jc(_$hash, showPdfPreviewSideBySide.hashCode);
    _$hash = $jc(_$hash, enableTouchEvents.hashCode);
    _$hash = $jc(_$hash, enableFlexibleSearch.hashCode);
    _$hash = $jc(_$hash, isHistoryVisible.hashCode);
    _$hash = $jc(_$hash, darkModeType.hashCode);
    _$hash = $jc(_$hash, enableDarkModeSystem.hashCode);
    _$hash = $jc(_$hash, isFilterVisible.hashCode);
    _$hash = $jc(_$hash, persistData.hashCode);
    _$hash = $jc(_$hash, longPressSelectionIsDefault.hashCode);
    _$hash = $jc(_$hash, requireAuthentication.hashCode);
    _$hash = $jc(_$hash, tapSelectedToEdit.hashCode);
    _$hash = $jc(_$hash, rowsPerPage.hashCode);
    _$hash = $jc(_$hash, enableTooltips.hashCode);
    _$hash = $jc(_$hash, colorTheme.hashCode);
    _$hash = $jc(_$hash, darkColorTheme.hashCode);
    _$hash = $jc(_$hash, hideDesktopWarning.hashCode);
    _$hash = $jc(_$hash, hideGatewayWarning.hashCode);
    _$hash = $jc(_$hash, hideReviewApp.hashCode);
    _$hash = $jc(_$hash, hideOneYearReviewApp.hashCode);
    _$hash = $jc(_$hash, hideTwoYearReviewApp.hashCode);
    _$hash = $jc(_$hash, hideTaskExtensionBanner.hashCode);
    _$hash = $jc(_$hash, editAfterSaving.hashCode);
    _$hash = $jc(_$hash, enableNativeBrowser.hashCode);
    _$hash = $jc(_$hash, textScaleFactor.hashCode);
    _$hash = $jc(_$hash, donwloadsFolder.hashCode);
    _$hash = $jc(_$hash, sortFields.hashCode);
    _$hash = $jc(_$hash, companyPrefs.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrefState')
          ..add('appLayout', appLayout)
          ..add('moduleLayout', moduleLayout)
          ..add('menuSidebarMode', menuSidebarMode)
          ..add('historySidebarMode', historySidebarMode)
          ..add('useSidebarEditor', useSidebarEditor)
          ..add('useSidebarViewer', useSidebarViewer)
          ..add('customColors', customColors)
          ..add('darkCustomColors', darkCustomColors)
          ..add('statementIncludes', statementIncludes)
          ..add('isPreviewVisible', isPreviewVisible)
          ..add('isMenuVisible', isMenuVisible)
          ..add('showKanban', showKanban)
          ..add('showPdfPreview', showPdfPreview)
          ..add('showPdfPreviewSideBySide', showPdfPreviewSideBySide)
          ..add('enableTouchEvents', enableTouchEvents)
          ..add('enableFlexibleSearch', enableFlexibleSearch)
          ..add('isHistoryVisible', isHistoryVisible)
          ..add('darkModeType', darkModeType)
          ..add('enableDarkModeSystem', enableDarkModeSystem)
          ..add('isFilterVisible', isFilterVisible)
          ..add('persistData', persistData)
          ..add('longPressSelectionIsDefault', longPressSelectionIsDefault)
          ..add('requireAuthentication', requireAuthentication)
          ..add('tapSelectedToEdit', tapSelectedToEdit)
          ..add('rowsPerPage', rowsPerPage)
          ..add('enableTooltips', enableTooltips)
          ..add('colorTheme', colorTheme)
          ..add('darkColorTheme', darkColorTheme)
          ..add('hideDesktopWarning', hideDesktopWarning)
          ..add('hideGatewayWarning', hideGatewayWarning)
          ..add('hideReviewApp', hideReviewApp)
          ..add('hideOneYearReviewApp', hideOneYearReviewApp)
          ..add('hideTwoYearReviewApp', hideTwoYearReviewApp)
          ..add('hideTaskExtensionBanner', hideTaskExtensionBanner)
          ..add('editAfterSaving', editAfterSaving)
          ..add('enableNativeBrowser', enableNativeBrowser)
          ..add('textScaleFactor', textScaleFactor)
          ..add('donwloadsFolder', donwloadsFolder)
          ..add('sortFields', sortFields)
          ..add('companyPrefs', companyPrefs))
        .toString();
  }
}

class PrefStateBuilder implements Builder<PrefState, PrefStateBuilder> {
  _$PrefState? _$v;

  AppLayout? _appLayout;
  AppLayout? get appLayout => _$this._appLayout;
  set appLayout(AppLayout? appLayout) => _$this._appLayout = appLayout;

  ModuleLayout? _moduleLayout;
  ModuleLayout? get moduleLayout => _$this._moduleLayout;
  set moduleLayout(ModuleLayout? moduleLayout) =>
      _$this._moduleLayout = moduleLayout;

  AppSidebarMode? _menuSidebarMode;
  AppSidebarMode? get menuSidebarMode => _$this._menuSidebarMode;
  set menuSidebarMode(AppSidebarMode? menuSidebarMode) =>
      _$this._menuSidebarMode = menuSidebarMode;

  AppSidebarMode? _historySidebarMode;
  AppSidebarMode? get historySidebarMode => _$this._historySidebarMode;
  set historySidebarMode(AppSidebarMode? historySidebarMode) =>
      _$this._historySidebarMode = historySidebarMode;

  MapBuilder<EntityType, bool>? _useSidebarEditor;
  MapBuilder<EntityType, bool> get useSidebarEditor =>
      _$this._useSidebarEditor ??= new MapBuilder<EntityType, bool>();
  set useSidebarEditor(MapBuilder<EntityType, bool>? useSidebarEditor) =>
      _$this._useSidebarEditor = useSidebarEditor;

  MapBuilder<EntityType, bool>? _useSidebarViewer;
  MapBuilder<EntityType, bool> get useSidebarViewer =>
      _$this._useSidebarViewer ??= new MapBuilder<EntityType, bool>();
  set useSidebarViewer(MapBuilder<EntityType, bool>? useSidebarViewer) =>
      _$this._useSidebarViewer = useSidebarViewer;

  MapBuilder<String, String>? _customColors;
  MapBuilder<String, String> get customColors =>
      _$this._customColors ??= new MapBuilder<String, String>();
  set customColors(MapBuilder<String, String>? customColors) =>
      _$this._customColors = customColors;

  MapBuilder<String, String>? _darkCustomColors;
  MapBuilder<String, String> get darkCustomColors =>
      _$this._darkCustomColors ??= new MapBuilder<String, String>();
  set darkCustomColors(MapBuilder<String, String>? darkCustomColors) =>
      _$this._darkCustomColors = darkCustomColors;

  ListBuilder<String>? _statementIncludes;
  ListBuilder<String> get statementIncludes =>
      _$this._statementIncludes ??= new ListBuilder<String>();
  set statementIncludes(ListBuilder<String>? statementIncludes) =>
      _$this._statementIncludes = statementIncludes;

  bool? _isPreviewVisible;
  bool? get isPreviewVisible => _$this._isPreviewVisible;
  set isPreviewVisible(bool? isPreviewVisible) =>
      _$this._isPreviewVisible = isPreviewVisible;

  bool? _isMenuVisible;
  bool? get isMenuVisible => _$this._isMenuVisible;
  set isMenuVisible(bool? isMenuVisible) =>
      _$this._isMenuVisible = isMenuVisible;

  bool? _showKanban;
  bool? get showKanban => _$this._showKanban;
  set showKanban(bool? showKanban) => _$this._showKanban = showKanban;

  bool? _showPdfPreview;
  bool? get showPdfPreview => _$this._showPdfPreview;
  set showPdfPreview(bool? showPdfPreview) =>
      _$this._showPdfPreview = showPdfPreview;

  bool? _showPdfPreviewSideBySide;
  bool? get showPdfPreviewSideBySide => _$this._showPdfPreviewSideBySide;
  set showPdfPreviewSideBySide(bool? showPdfPreviewSideBySide) =>
      _$this._showPdfPreviewSideBySide = showPdfPreviewSideBySide;

  bool? _enableTouchEvents;
  bool? get enableTouchEvents => _$this._enableTouchEvents;
  set enableTouchEvents(bool? enableTouchEvents) =>
      _$this._enableTouchEvents = enableTouchEvents;

  bool? _enableFlexibleSearch;
  bool? get enableFlexibleSearch => _$this._enableFlexibleSearch;
  set enableFlexibleSearch(bool? enableFlexibleSearch) =>
      _$this._enableFlexibleSearch = enableFlexibleSearch;

  bool? _isHistoryVisible;
  bool? get isHistoryVisible => _$this._isHistoryVisible;
  set isHistoryVisible(bool? isHistoryVisible) =>
      _$this._isHistoryVisible = isHistoryVisible;

  String? _darkModeType;
  String? get darkModeType => _$this._darkModeType;
  set darkModeType(String? darkModeType) => _$this._darkModeType = darkModeType;

  bool? _enableDarkModeSystem;
  bool? get enableDarkModeSystem => _$this._enableDarkModeSystem;
  set enableDarkModeSystem(bool? enableDarkModeSystem) =>
      _$this._enableDarkModeSystem = enableDarkModeSystem;

  bool? _isFilterVisible;
  bool? get isFilterVisible => _$this._isFilterVisible;
  set isFilterVisible(bool? isFilterVisible) =>
      _$this._isFilterVisible = isFilterVisible;

  bool? _persistData;
  bool? get persistData => _$this._persistData;
  set persistData(bool? persistData) => _$this._persistData = persistData;

  bool? _longPressSelectionIsDefault;
  bool? get longPressSelectionIsDefault => _$this._longPressSelectionIsDefault;
  set longPressSelectionIsDefault(bool? longPressSelectionIsDefault) =>
      _$this._longPressSelectionIsDefault = longPressSelectionIsDefault;

  bool? _requireAuthentication;
  bool? get requireAuthentication => _$this._requireAuthentication;
  set requireAuthentication(bool? requireAuthentication) =>
      _$this._requireAuthentication = requireAuthentication;

  bool? _tapSelectedToEdit;
  bool? get tapSelectedToEdit => _$this._tapSelectedToEdit;
  set tapSelectedToEdit(bool? tapSelectedToEdit) =>
      _$this._tapSelectedToEdit = tapSelectedToEdit;

  int? _rowsPerPage;
  int? get rowsPerPage => _$this._rowsPerPage;
  set rowsPerPage(int? rowsPerPage) => _$this._rowsPerPage = rowsPerPage;

  bool? _enableTooltips;
  bool? get enableTooltips => _$this._enableTooltips;
  set enableTooltips(bool? enableTooltips) =>
      _$this._enableTooltips = enableTooltips;

  String? _colorTheme;
  String? get colorTheme => _$this._colorTheme;
  set colorTheme(String? colorTheme) => _$this._colorTheme = colorTheme;

  String? _darkColorTheme;
  String? get darkColorTheme => _$this._darkColorTheme;
  set darkColorTheme(String? darkColorTheme) =>
      _$this._darkColorTheme = darkColorTheme;

  bool? _hideDesktopWarning;
  bool? get hideDesktopWarning => _$this._hideDesktopWarning;
  set hideDesktopWarning(bool? hideDesktopWarning) =>
      _$this._hideDesktopWarning = hideDesktopWarning;

  bool? _hideGatewayWarning;
  bool? get hideGatewayWarning => _$this._hideGatewayWarning;
  set hideGatewayWarning(bool? hideGatewayWarning) =>
      _$this._hideGatewayWarning = hideGatewayWarning;

  bool? _hideReviewApp;
  bool? get hideReviewApp => _$this._hideReviewApp;
  set hideReviewApp(bool? hideReviewApp) =>
      _$this._hideReviewApp = hideReviewApp;

  bool? _hideOneYearReviewApp;
  bool? get hideOneYearReviewApp => _$this._hideOneYearReviewApp;
  set hideOneYearReviewApp(bool? hideOneYearReviewApp) =>
      _$this._hideOneYearReviewApp = hideOneYearReviewApp;

  bool? _hideTwoYearReviewApp;
  bool? get hideTwoYearReviewApp => _$this._hideTwoYearReviewApp;
  set hideTwoYearReviewApp(bool? hideTwoYearReviewApp) =>
      _$this._hideTwoYearReviewApp = hideTwoYearReviewApp;

  bool? _hideTaskExtensionBanner;
  bool? get hideTaskExtensionBanner => _$this._hideTaskExtensionBanner;
  set hideTaskExtensionBanner(bool? hideTaskExtensionBanner) =>
      _$this._hideTaskExtensionBanner = hideTaskExtensionBanner;

  bool? _editAfterSaving;
  bool? get editAfterSaving => _$this._editAfterSaving;
  set editAfterSaving(bool? editAfterSaving) =>
      _$this._editAfterSaving = editAfterSaving;

  bool? _enableNativeBrowser;
  bool? get enableNativeBrowser => _$this._enableNativeBrowser;
  set enableNativeBrowser(bool? enableNativeBrowser) =>
      _$this._enableNativeBrowser = enableNativeBrowser;

  double? _textScaleFactor;
  double? get textScaleFactor => _$this._textScaleFactor;
  set textScaleFactor(double? textScaleFactor) =>
      _$this._textScaleFactor = textScaleFactor;

  String? _donwloadsFolder;
  String? get donwloadsFolder => _$this._donwloadsFolder;
  set donwloadsFolder(String? donwloadsFolder) =>
      _$this._donwloadsFolder = donwloadsFolder;

  MapBuilder<EntityType, PrefStateSortField>? _sortFields;
  MapBuilder<EntityType, PrefStateSortField> get sortFields =>
      _$this._sortFields ??= new MapBuilder<EntityType, PrefStateSortField>();
  set sortFields(MapBuilder<EntityType, PrefStateSortField>? sortFields) =>
      _$this._sortFields = sortFields;

  MapBuilder<String, CompanyPrefState>? _companyPrefs;
  MapBuilder<String, CompanyPrefState> get companyPrefs =>
      _$this._companyPrefs ??= new MapBuilder<String, CompanyPrefState>();
  set companyPrefs(MapBuilder<String, CompanyPrefState>? companyPrefs) =>
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
      _darkCustomColors = $v.darkCustomColors.toBuilder();
      _statementIncludes = $v.statementIncludes.toBuilder();
      _isPreviewVisible = $v.isPreviewVisible;
      _isMenuVisible = $v.isMenuVisible;
      _showKanban = $v.showKanban;
      _showPdfPreview = $v.showPdfPreview;
      _showPdfPreviewSideBySide = $v.showPdfPreviewSideBySide;
      _enableTouchEvents = $v.enableTouchEvents;
      _enableFlexibleSearch = $v.enableFlexibleSearch;
      _isHistoryVisible = $v.isHistoryVisible;
      _darkModeType = $v.darkModeType;
      _enableDarkModeSystem = $v.enableDarkModeSystem;
      _isFilterVisible = $v.isFilterVisible;
      _persistData = $v.persistData;
      _longPressSelectionIsDefault = $v.longPressSelectionIsDefault;
      _requireAuthentication = $v.requireAuthentication;
      _tapSelectedToEdit = $v.tapSelectedToEdit;
      _rowsPerPage = $v.rowsPerPage;
      _enableTooltips = $v.enableTooltips;
      _colorTheme = $v.colorTheme;
      _darkColorTheme = $v.darkColorTheme;
      _hideDesktopWarning = $v.hideDesktopWarning;
      _hideGatewayWarning = $v.hideGatewayWarning;
      _hideReviewApp = $v.hideReviewApp;
      _hideOneYearReviewApp = $v.hideOneYearReviewApp;
      _hideTwoYearReviewApp = $v.hideTwoYearReviewApp;
      _hideTaskExtensionBanner = $v.hideTaskExtensionBanner;
      _editAfterSaving = $v.editAfterSaving;
      _enableNativeBrowser = $v.enableNativeBrowser;
      _textScaleFactor = $v.textScaleFactor;
      _donwloadsFolder = $v.donwloadsFolder;
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
  void update(void Function(PrefStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrefState build() => _build();

  _$PrefState _build() {
    _$PrefState _$result;
    try {
      _$result = _$v ??
          new _$PrefState._(
              appLayout: BuiltValueNullFieldError.checkNotNull(
                  appLayout, r'PrefState', 'appLayout'),
              moduleLayout: BuiltValueNullFieldError.checkNotNull(
                  moduleLayout, r'PrefState', 'moduleLayout'),
              menuSidebarMode: BuiltValueNullFieldError.checkNotNull(
                  menuSidebarMode, r'PrefState', 'menuSidebarMode'),
              historySidebarMode: BuiltValueNullFieldError.checkNotNull(
                  historySidebarMode, r'PrefState', 'historySidebarMode'),
              useSidebarEditor: useSidebarEditor.build(),
              useSidebarViewer: useSidebarViewer.build(),
              customColors: customColors.build(),
              darkCustomColors: darkCustomColors.build(),
              statementIncludes: statementIncludes.build(),
              isPreviewVisible: BuiltValueNullFieldError.checkNotNull(
                  isPreviewVisible, r'PrefState', 'isPreviewVisible'),
              isMenuVisible: BuiltValueNullFieldError.checkNotNull(
                  isMenuVisible, r'PrefState', 'isMenuVisible'),
              showKanban: BuiltValueNullFieldError.checkNotNull(
                  showKanban, r'PrefState', 'showKanban'),
              showPdfPreview:
                  BuiltValueNullFieldError.checkNotNull(showPdfPreview, r'PrefState', 'showPdfPreview'),
              showPdfPreviewSideBySide: BuiltValueNullFieldError.checkNotNull(showPdfPreviewSideBySide, r'PrefState', 'showPdfPreviewSideBySide'),
              enableTouchEvents: BuiltValueNullFieldError.checkNotNull(enableTouchEvents, r'PrefState', 'enableTouchEvents'),
              enableFlexibleSearch: BuiltValueNullFieldError.checkNotNull(enableFlexibleSearch, r'PrefState', 'enableFlexibleSearch'),
              isHistoryVisible: BuiltValueNullFieldError.checkNotNull(isHistoryVisible, r'PrefState', 'isHistoryVisible'),
              darkModeType: BuiltValueNullFieldError.checkNotNull(darkModeType, r'PrefState', 'darkModeType'),
              enableDarkModeSystem: BuiltValueNullFieldError.checkNotNull(enableDarkModeSystem, r'PrefState', 'enableDarkModeSystem'),
              isFilterVisible: BuiltValueNullFieldError.checkNotNull(isFilterVisible, r'PrefState', 'isFilterVisible'),
              persistData: BuiltValueNullFieldError.checkNotNull(persistData, r'PrefState', 'persistData'),
              longPressSelectionIsDefault: BuiltValueNullFieldError.checkNotNull(longPressSelectionIsDefault, r'PrefState', 'longPressSelectionIsDefault'),
              requireAuthentication: BuiltValueNullFieldError.checkNotNull(requireAuthentication, r'PrefState', 'requireAuthentication'),
              tapSelectedToEdit: BuiltValueNullFieldError.checkNotNull(tapSelectedToEdit, r'PrefState', 'tapSelectedToEdit'),
              rowsPerPage: BuiltValueNullFieldError.checkNotNull(rowsPerPage, r'PrefState', 'rowsPerPage'),
              enableTooltips: BuiltValueNullFieldError.checkNotNull(enableTooltips, r'PrefState', 'enableTooltips'),
              colorTheme: BuiltValueNullFieldError.checkNotNull(colorTheme, r'PrefState', 'colorTheme'),
              darkColorTheme: BuiltValueNullFieldError.checkNotNull(darkColorTheme, r'PrefState', 'darkColorTheme'),
              hideDesktopWarning: BuiltValueNullFieldError.checkNotNull(hideDesktopWarning, r'PrefState', 'hideDesktopWarning'),
              hideGatewayWarning: BuiltValueNullFieldError.checkNotNull(hideGatewayWarning, r'PrefState', 'hideGatewayWarning'),
              hideReviewApp: BuiltValueNullFieldError.checkNotNull(hideReviewApp, r'PrefState', 'hideReviewApp'),
              hideOneYearReviewApp: BuiltValueNullFieldError.checkNotNull(hideOneYearReviewApp, r'PrefState', 'hideOneYearReviewApp'),
              hideTwoYearReviewApp: BuiltValueNullFieldError.checkNotNull(hideTwoYearReviewApp, r'PrefState', 'hideTwoYearReviewApp'),
              hideTaskExtensionBanner: BuiltValueNullFieldError.checkNotNull(hideTaskExtensionBanner, r'PrefState', 'hideTaskExtensionBanner'),
              editAfterSaving: BuiltValueNullFieldError.checkNotNull(editAfterSaving, r'PrefState', 'editAfterSaving'),
              enableNativeBrowser: BuiltValueNullFieldError.checkNotNull(enableNativeBrowser, r'PrefState', 'enableNativeBrowser'),
              textScaleFactor: BuiltValueNullFieldError.checkNotNull(textScaleFactor, r'PrefState', 'textScaleFactor'),
              donwloadsFolder: BuiltValueNullFieldError.checkNotNull(donwloadsFolder, r'PrefState', 'donwloadsFolder'),
              sortFields: sortFields.build(),
              companyPrefs: companyPrefs.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'useSidebarEditor';
        useSidebarEditor.build();
        _$failedField = 'useSidebarViewer';
        useSidebarViewer.build();
        _$failedField = 'customColors';
        customColors.build();
        _$failedField = 'darkCustomColors';
        darkCustomColors.build();
        _$failedField = 'statementIncludes';
        statementIncludes.build();

        _$failedField = 'sortFields';
        sortFields.build();
        _$failedField = 'companyPrefs';
        companyPrefs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PrefState', _$failedField, e.toString());
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
          [void Function(PrefStateSortFieldBuilder)? updates]) =>
      (new PrefStateSortFieldBuilder()..update(updates))._build();

  _$PrefStateSortField._({required this.field, required this.ascending})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        field, r'PrefStateSortField', 'field');
    BuiltValueNullFieldError.checkNotNull(
        ascending, r'PrefStateSortField', 'ascending');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jc(_$hash, ascending.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrefStateSortField')
          ..add('field', field)
          ..add('ascending', ascending))
        .toString();
  }
}

class PrefStateSortFieldBuilder
    implements Builder<PrefStateSortField, PrefStateSortFieldBuilder> {
  _$PrefStateSortField? _$v;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  bool? _ascending;
  bool? get ascending => _$this._ascending;
  set ascending(bool? ascending) => _$this._ascending = ascending;

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
  void update(void Function(PrefStateSortFieldBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrefStateSortField build() => _build();

  _$PrefStateSortField _build() {
    final _$result = _$v ??
        new _$PrefStateSortField._(
            field: BuiltValueNullFieldError.checkNotNull(
                field, r'PrefStateSortField', 'field'),
            ascending: BuiltValueNullFieldError.checkNotNull(
                ascending, r'PrefStateSortField', 'ascending'));
    replace(_$result);
    return _$result;
  }
}

class _$CompanyPrefState extends CompanyPrefState {
  @override
  final BuiltList<HistoryRecord> historyList;

  factory _$CompanyPrefState(
          [void Function(CompanyPrefStateBuilder)? updates]) =>
      (new CompanyPrefStateBuilder()..update(updates))._build();

  _$CompanyPrefState._({required this.historyList}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        historyList, r'CompanyPrefState', 'historyList');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, historyList.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompanyPrefState')
          ..add('historyList', historyList))
        .toString();
  }
}

class CompanyPrefStateBuilder
    implements Builder<CompanyPrefState, CompanyPrefStateBuilder> {
  _$CompanyPrefState? _$v;

  ListBuilder<HistoryRecord>? _historyList;
  ListBuilder<HistoryRecord> get historyList =>
      _$this._historyList ??= new ListBuilder<HistoryRecord>();
  set historyList(ListBuilder<HistoryRecord>? historyList) =>
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
  void update(void Function(CompanyPrefStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompanyPrefState build() => _build();

  _$CompanyPrefState _build() {
    _$CompanyPrefState _$result;
    try {
      _$result =
          _$v ?? new _$CompanyPrefState._(historyList: historyList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'historyList';
        historyList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CompanyPrefState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HistoryRecord extends HistoryRecord {
  @override
  final String? id;
  @override
  final EntityType entityType;
  @override
  final int? page;
  @override
  final int timestamp;

  factory _$HistoryRecord([void Function(HistoryRecordBuilder)? updates]) =>
      (new HistoryRecordBuilder()..update(updates))._build();

  _$HistoryRecord._(
      {this.id, required this.entityType, this.page, required this.timestamp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        entityType, r'HistoryRecord', 'entityType');
    BuiltValueNullFieldError.checkNotNull(
        timestamp, r'HistoryRecord', 'timestamp');
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
        page == other.page &&
        timestamp == other.timestamp;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HistoryRecord')
          ..add('id', id)
          ..add('entityType', entityType)
          ..add('page', page)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class HistoryRecordBuilder
    implements Builder<HistoryRecord, HistoryRecordBuilder> {
  _$HistoryRecord? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  EntityType? _entityType;
  EntityType? get entityType => _$this._entityType;
  set entityType(EntityType? entityType) => _$this._entityType = entityType;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _timestamp;
  int? get timestamp => _$this._timestamp;
  set timestamp(int? timestamp) => _$this._timestamp = timestamp;

  HistoryRecordBuilder();

  HistoryRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _entityType = $v.entityType;
      _page = $v.page;
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
  void update(void Function(HistoryRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistoryRecord build() => _build();

  _$HistoryRecord _build() {
    final _$result = _$v ??
        new _$HistoryRecord._(
            id: id,
            entityType: BuiltValueNullFieldError.checkNotNull(
                entityType, r'HistoryRecord', 'entityType'),
            page: page,
            timestamp: BuiltValueNullFieldError.checkNotNull(
                timestamp, r'HistoryRecord', 'timestamp'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
