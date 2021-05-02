import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/color_theme_model.dart';

part 'pref_state.g.dart';

abstract class PrefState implements Built<PrefState, PrefStateBuilder> {
  factory PrefState({ModuleLayout moduleLayout}) {
    return _$PrefState._(
      appLayout: AppLayout.desktop,
      moduleLayout: ModuleLayout.table,
      isPreviewEnabled: true,
      isPreviewVisible: true,
      useSidebarEditor: BuiltMap<EntityType, bool>(),
      menuSidebarMode: AppSidebarMode.collapse,
      historySidebarMode: AppSidebarMode.float,
      rowsPerPage: 10,
      isMenuVisible: true,
      isHistoryVisible: false,
      enableDarkMode: false,
      requireAuthentication: false,
      colorTheme: kColorThemeLight,
      showFilterSidebar: false,
      longPressSelectionIsDefault: true,
      showKanban: false,
      companyPrefs: BuiltMap<String, CompanyPrefState>(),
    );
  }

  PrefState._();

  @override
  @memoized
  int get hashCode;

  AppLayout get appLayout;

  ModuleLayout get moduleLayout;

  AppSidebarMode get menuSidebarMode;

  AppSidebarMode get historySidebarMode;

  BuiltMap<EntityType, bool> get useSidebarEditor;

  bool get isPreviewVisible;

  bool get isPreviewEnabled;

  bool get isMenuVisible;

  bool get showKanban;

  bool get isHistoryVisible;

  bool get enableDarkMode;

  bool get showFilterSidebar;

  bool get longPressSelectionIsDefault;

  bool get requireAuthentication;

  int get rowsPerPage;

  String get colorTheme;

  ColorTheme get colorThemeModel => colorThemesMap.containsKey(colorTheme)
      ? colorThemesMap[colorTheme]
      : colorThemesMap[kColorThemeLight];

  BuiltMap<String, CompanyPrefState> get companyPrefs;

  bool get isDesktop => appLayout == AppLayout.desktop;

  bool isEditorFullScreen(EntityType entityType) =>
      isDesktop && !(useSidebarEditor[entityType] ?? false);

  bool get isNotDesktop => !isDesktop;

  bool get isMobile => appLayout == AppLayout.mobile;

  bool get isNotMobile => !isMobile;

  bool get isModuleList {
    if (isDesktop && !isPreviewEnabled) {
      return false;
    }

    return moduleLayout == ModuleLayout.list;
  }

  bool get isModuleTable => !isModuleList;

  bool get isMenuFloated =>
      appLayout == AppLayout.mobile || menuSidebarMode == AppSidebarMode.float;

  bool get isHistoryFloated =>
      appLayout == AppLayout.mobile ||
      historySidebarMode == AppSidebarMode.float;

  bool get showMenu =>
      (isMenuVisible && menuSidebarMode == AppSidebarMode.visible) ||
      menuSidebarMode == AppSidebarMode.collapse;

  bool get showHistory =>
      isHistoryVisible && historySidebarMode == AppSidebarMode.visible;

  bool get isMenuCollapsed =>
      isNotMobile &&
      menuSidebarMode == AppSidebarMode.collapse &&
      !isMenuVisible;

  // ignore: unused_element
  static void _initializeBuilder(PrefStateBuilder builder) => builder
    ..useSidebarEditor.replace(BuiltMap<EntityType, bool>())
    ..showKanban = false
    ..isPreviewEnabled = true
    ..colorTheme = kColorThemeLight;

  static Serializer<PrefState> get serializer => _$prefStateSerializer;
}

abstract class CompanyPrefState
    implements Built<CompanyPrefState, CompanyPrefStateBuilder> {
  factory CompanyPrefState({
    String accentColor,
  }) {
    return _$CompanyPrefState._(
      historyList: BuiltList<HistoryRecord>(),
    );
  }

  CompanyPrefState._();

  @override
  @memoized
  int get hashCode;

  BuiltList<HistoryRecord> get historyList;

  static Serializer<CompanyPrefState> get serializer =>
      _$companyPrefStateSerializer;
}

class AppLayout extends EnumClass {
  const AppLayout._(String name) : super(name);

  static Serializer<AppLayout> get serializer => _$appLayoutSerializer;

  static const AppLayout mobile = _$mobile;
  static const AppLayout desktop = _$desktop;

  static BuiltSet<AppLayout> get values => _$values;

  static AppLayout valueOf(String name) => _$valueOf(name);
}

class ModuleLayout extends EnumClass {
  const ModuleLayout._(String name) : super(name);

  static Serializer<ModuleLayout> get serializer => _$moduleLayoutSerializer;

  static const ModuleLayout list = _$list;
  static const ModuleLayout table = _$table;

  static BuiltSet<ModuleLayout> get values => _$moduleLayoutValues;

  static ModuleLayout valueOf(String name) => _$moduleLayoutValueOf(name);
}

class AppSidebar extends EnumClass {
  const AppSidebar._(String name) : super(name);

  static Serializer<AppSidebar> get serializer => _$appSidebarSerializer;
  static const AppSidebar menu = _$menu;
  static const AppSidebar history = _$history;

  static BuiltSet<AppSidebar> get values => _$valuesSidebar;

  static AppSidebar valueOf(String name) => _$valueOfSidebar(name);
}

class AppSidebarMode extends EnumClass {
  const AppSidebarMode._(String name) : super(name);

  static Serializer<AppSidebarMode> get serializer =>
      _$appSidebarModeSerializer;

  static const AppSidebarMode float = _$float;
  static const AppSidebarMode visible = _$visible;
  static const AppSidebarMode collapse = _$collapse;

  static BuiltSet<AppSidebarMode> get values => _$valuesSidebarMode;

  static AppSidebarMode valueOf(String name) => _$valueOfSidebarMode(name);
}

abstract class HistoryRecord
    implements Built<HistoryRecord, HistoryRecordBuilder> {
  factory HistoryRecord({
    @required EntityType entityType,
    String id,
  }) {
    return _$HistoryRecord._(
      id: id,
      entityType: entityType,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  HistoryRecord._();

  @override
  @memoized
  int get hashCode;

  @nullable
  String get id;

  EntityType get entityType;

  int get timestamp;

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);

  bool matchesRecord(HistoryRecord record) =>
      isEqualTo(entityId: record.id, entityType: record.entityType);

  bool isEqualTo({EntityType entityType, String entityId}) =>
      entityType == this.entityType && entityId == id;

  static Serializer<HistoryRecord> get serializer => _$historyRecordSerializer;
}
