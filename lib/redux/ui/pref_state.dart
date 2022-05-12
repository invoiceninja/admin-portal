// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/color_theme_model.dart';

part 'pref_state.g.dart';

abstract class PrefState implements Built<PrefState, PrefStateBuilder> {
  factory PrefState({ModuleLayout moduleLayout}) {
    return _$PrefState._(
      appLayout: AppLayout.desktop,
      moduleLayout: ModuleLayout.table,
      isPreviewVisible: false,
      useSidebarEditor: BuiltMap<EntityType, bool>(),
      menuSidebarMode: AppSidebarMode.collapse,
      historySidebarMode: AppSidebarMode.float,
      rowsPerPage: 10,
      isMenuVisible: true,
      isHistoryVisible: false,
      enableDarkMode: false,
      editAfterSaving: true,
      requireAuthentication: false,
      colorTheme: kColorThemeLight,
      enableTouchEvents: true,
      enableTooltips: true,
      enableJSPDF: false,
      isFilterVisible: false,
      textScaleFactor: 1,
      longPressSelectionIsDefault: true,
      tapSelectedToEdit: false,
      hideDesktopWarning: false,
      showKanban: false,
      showPdfPreview: true,
      persistData: false,
      persistUI: true,
      companyPrefs: BuiltMap<String, CompanyPrefState>(),
      sortFields: BuiltMap<EntityType, PrefStateSortField>(),
      customColors: BuiltMap<String, String>(CONTRAST_COLORS),
    );
  }

  PrefState._();

  static const TEXT_SCALING_SMALL = 0.8;
  static const TEXT_SCALING_NORMAL = 1.0;
  static const TEXT_SCALING_LARGE = 1.2;
  static const TEXT_SCALING_EXTRA_LARGE = 1.4;

  static const THEME_SIDEBAR_ACTIVE_BACKGROUND_COLOR =
      'sidebar_active_background_color';
  static const THEME_SIDEBAR_ACTIVE_FONT_COLOR = 'sidebar_active_font_color';
  static const THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR =
      'sidebar_inactive_background_color';
  static const THEME_SIDEBAR_INACTIVE_FONT_COLOR =
      'sidebar_inactive_font_color';
  static const THEME_INVOICE_HEADER_BACKGROUND_COLOR =
      'invoice_header_background_color';
  static const THEME_INVOICE_HEADER_FONT_COLOR = 'invoice_header_font_color';
  static const THEME_TABLE_ALTERNATE_ROW_BACKGROUND_COLOR =
      'table_alternate_row_background_color';

  static const THEME_COLORS = [
    PrefState.THEME_SIDEBAR_ACTIVE_BACKGROUND_COLOR,
    PrefState.THEME_SIDEBAR_ACTIVE_FONT_COLOR,
    PrefState.THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR,
    PrefState.THEME_SIDEBAR_INACTIVE_FONT_COLOR,
    PrefState.THEME_INVOICE_HEADER_BACKGROUND_COLOR,
    PrefState.THEME_INVOICE_HEADER_FONT_COLOR,
    PrefState.THEME_TABLE_ALTERNATE_ROW_BACKGROUND_COLOR,
  ];

  static const CONTRAST_COLORS = {
    PrefState.THEME_SIDEBAR_ACTIVE_BACKGROUND_COLOR: '#444444',
    PrefState.THEME_SIDEBAR_ACTIVE_FONT_COLOR: '#FFFFFF',
    PrefState.THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR: '#2F2F2F',
    PrefState.THEME_SIDEBAR_INACTIVE_FONT_COLOR: '#FFFFFF',
    PrefState.THEME_INVOICE_HEADER_BACKGROUND_COLOR: '#777777',
    PrefState.THEME_INVOICE_HEADER_FONT_COLOR: '#FFFFFF',
    PrefState.THEME_TABLE_ALTERNATE_ROW_BACKGROUND_COLOR: '#F9F9F9',
  };

  @override
  @memoized
  int get hashCode;

  AppLayout get appLayout;

  ModuleLayout get moduleLayout;

  AppSidebarMode get menuSidebarMode;

  AppSidebarMode get historySidebarMode;

  BuiltMap<EntityType, bool> get useSidebarEditor;

  BuiltMap<String, String> get customColors;

  bool get isPreviewVisible;

  bool get isMenuVisible;

  bool get showKanban;

  bool get showPdfPreview;

  bool get enableTouchEvents;

  bool get isHistoryVisible;

  bool get enableDarkMode;

  bool get isFilterVisible;

  bool get persistData;

  bool get persistUI;

  bool get longPressSelectionIsDefault;

  bool get requireAuthentication;

  bool get tapSelectedToEdit;

  bool get enableJSPDF;

  int get rowsPerPage;

  bool get enableTooltips;

  String get colorTheme;

  bool get hideDesktopWarning;

  bool get editAfterSaving;

  double get textScaleFactor;

  BuiltMap<EntityType, PrefStateSortField> get sortFields;

  ColorTheme get colorThemeModel => colorThemesMap.containsKey(colorTheme)
      ? colorThemesMap[colorTheme]
      : colorThemesMap[kColorThemeLight];

  BuiltMap<String, CompanyPrefState> get companyPrefs;

  bool get isDesktop => appLayout == AppLayout.desktop;

  bool isEditorFullScreen(EntityType entityType) {
    if (!isDesktop) {
      return false;
    }

    if ([EntityType.product, EntityType.payment, EntityType.project]
        .contains(entityType)) {
      return false;
    }

    return !(useSidebarEditor[entityType.baseType] ?? false);
  }

  bool get isNotDesktop => !isDesktop;

  bool get isMobile => appLayout == AppLayout.mobile;

  bool get isNotMobile => !isMobile;

  bool get isModuleList => moduleLayout == ModuleLayout.list;

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
    ..sortFields.replace(BuiltMap<EntityType, PrefStateSortField>())
    ..customColors.replace(builder.enableDarkMode == true
        ? BuiltMap<String, String>()
        : BuiltMap<String, String>(PrefState.CONTRAST_COLORS))
    ..showKanban = false
    ..isPreviewVisible = false
    ..isFilterVisible = false
    ..hideDesktopWarning = false
    ..tapSelectedToEdit = false
    ..persistData = false
    ..persistUI = true
    ..editAfterSaving = true
    ..showPdfPreview = true
    ..enableTouchEvents = true
    ..enableJSPDF = false
    ..enableTooltips = true
    ..textScaleFactor = 1
    ..colorTheme =
        builder.enableDarkMode == true ? kColorThemeLight : kColorThemeLight;

  static Serializer<PrefState> get serializer => _$prefStateSerializer;
}

abstract class PrefStateSortField
    implements Built<PrefStateSortField, PrefStateSortFieldBuilder> {
  factory PrefStateSortField(String field, bool ascending) {
    return _$PrefStateSortField._(
      field: field,
      ascending: ascending,
    );
  }

  PrefStateSortField._();

  @override
  @memoized
  int get hashCode;

  String get field;

  bool get ascending;

  static Serializer<PrefStateSortField> get serializer =>
      _$prefStateSortFieldSerializer;
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
