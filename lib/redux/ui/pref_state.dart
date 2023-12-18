// Flutter imports:

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
  factory PrefState() {
    return _$PrefState._(
      appLayout: AppLayout.desktop,
      moduleLayout: ModuleLayout.table,
      isPreviewVisible: false,
      useSidebarEditor: BuiltMap<EntityType, bool>(),
      useSidebarViewer: BuiltMap<EntityType, bool>(),
      menuSidebarMode: AppSidebarMode.collapse,
      historySidebarMode: AppSidebarMode.float,
      rowsPerPage: 10,
      isMenuVisible: true,
      isHistoryVisible: false,
      darkModeType: kBrightnessSytem,
      enableDarkModeSystem: false,
      enableFlexibleSearch: false,
      editAfterSaving: true,
      requireAuthentication: false,
      colorTheme: kColorThemeLight,
      darkColorTheme: kColorThemeDark,
      enableTouchEvents: false,
      enableTooltips: true,
      isFilterVisible: false,
      textScaleFactor: 1,
      longPressSelectionIsDefault: true,
      tapSelectedToEdit: false,
      hideDesktopWarning: false,
      hideGatewayWarning: false,
      hideReviewApp: false,
      hideOneYearReviewApp: false,
      hideTwoYearReviewApp: false,
      hideTaskExtensionBanner: false,
      showKanban: false,
      showPdfPreview: true,
      showPdfPreviewSideBySide: false,
      persistData: false,
      enableNativeBrowser: false,
      donwloadsFolder: '',
      statementIncludes: BuiltList(<String>[kStatementIncludePayments]),
      companyPrefs: BuiltMap<String, CompanyPrefState>(),
      sortFields: BuiltMap<EntityType, PrefStateSortField>(),
      customColors: BuiltMap<String, String>(CONTRAST_COLORS),
      darkCustomColors: BuiltMap<String, String>(),
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
    PrefState.THEME_SIDEBAR_ACTIVE_BACKGROUND_COLOR: '#2F2E2E',
    PrefState.THEME_SIDEBAR_ACTIVE_FONT_COLOR: '#FFFFFF',
    PrefState.THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR: '#454544',
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

  BuiltMap<EntityType, bool> get useSidebarViewer;

  BuiltMap<String, String> get customColors;

  BuiltMap<String, String> get darkCustomColors;

  BuiltList<String> get statementIncludes;

  bool get isPreviewVisible;

  bool get isMenuVisible;

  bool get showKanban;

  bool get showPdfPreview;

  bool get showPdfPreviewSideBySide;

  bool get enableTouchEvents;

  bool get enableFlexibleSearch;

  bool get isHistoryVisible;

  String get darkModeType;

  bool get enableDarkModeSystem;

  bool get isFilterVisible;

  bool get persistData;

  bool get longPressSelectionIsDefault;

  bool get requireAuthentication;

  bool get tapSelectedToEdit;

  int get rowsPerPage;

  bool get enableTooltips;

  String get colorTheme;

  String get darkColorTheme;

  bool get hideDesktopWarning;

  bool get hideGatewayWarning;

  bool get hideReviewApp;

  bool get hideOneYearReviewApp;

  bool get hideTwoYearReviewApp;

  bool get hideTaskExtensionBanner;

  bool get editAfterSaving;

  bool get enableNativeBrowser;

  double get textScaleFactor;

  String get donwloadsFolder;

  BuiltMap<EntityType, PrefStateSortField> get sortFields;

  bool get enableDarkMode => darkModeType == kBrightnessSytem
      ? enableDarkModeSystem
      : darkModeType == kBrightnessDark;

  ColorTheme? get colorThemeModel {
    final theme = enableDarkMode ? darkColorTheme : colorTheme;

    if (colorThemesMap.containsKey(theme)) {
      return colorThemesMap[theme];
    } else if (enableDarkMode) {
      return colorThemesMap[kColorThemeDark];
    } else {
      return colorThemesMap[kColorThemeLight];
    }
  }

  BuiltMap<String, String> get activeCustomColors =>
      enableDarkMode ? darkCustomColors : customColors;

  BuiltMap<String, CompanyPrefState> get companyPrefs;

  bool get isDesktop => appLayout == AppLayout.desktop;

  bool isEditorFullScreen(EntityType? entityType) {
    if (!isDesktop) {
      return false;
    }

    if ([EntityType.product, EntityType.payment, EntityType.project]
        .contains(entityType)) {
      return false;
    }

    return !(useSidebarEditor[entityType!.baseType] ?? false);
  }

  bool isViewerFullScreen(EntityType? entityType) {
    if (!isDesktop || entityType == null) {
      return false;
    }

    if (!entityType.hasFullWidthViewer) {
      return false;
    }

    return !(useSidebarViewer[entityType.baseType] ?? false);
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
    ..statementIncludes
        .replace(BuiltList<String>(<String>[kStatementIncludePayments]))
    ..useSidebarEditor.replace(BuiltMap<EntityType, bool>())
    ..useSidebarViewer.replace(BuiltMap<EntityType, bool>())
    ..sortFields.replace(BuiltMap<EntityType, PrefStateSortField>())
    ..customColors.replace(BuiltMap<String, String>(PrefState.CONTRAST_COLORS))
    ..darkCustomColors.replace(BuiltMap<String, String>())
    ..showKanban = false
    ..isPreviewVisible = false
    ..isFilterVisible = false
    ..hideDesktopWarning = false
    ..hideGatewayWarning = false
    ..hideReviewApp = false
    ..hideOneYearReviewApp = false
    ..hideTwoYearReviewApp = false
    ..tapSelectedToEdit = false
    ..persistData = false
    ..editAfterSaving = true
    ..showPdfPreview = true
    ..showPdfPreviewSideBySide = false
    ..enableTouchEvents = false
    ..enableFlexibleSearch = false
    ..enableTooltips = true
    ..enableNativeBrowser = false
    ..textScaleFactor = 1
    ..darkModeType = kBrightnessSytem
    ..colorTheme = kColorThemeLight
    ..darkColorTheme = kColorThemeDark
    ..enableDarkModeSystem = false
    ..donwloadsFolder = ''
    ..hideTaskExtensionBanner = false;

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
    String? accentColor,
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
    required EntityType entityType,
    String? id,
    int? page,
  }) {
    return _$HistoryRecord._(
      id: id,
      entityType: entityType,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      page: page ?? 0,
    );
  }

  HistoryRecord._();

  @override
  @memoized
  int get hashCode;

  String? get id;

  EntityType get entityType;

  int? get page;

  int get timestamp;

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);

  bool matchesRecord(HistoryRecord record) =>
      isEqualTo(entityId: record.id, entityType: record.entityType);

  bool isEqualTo({EntityType? entityType, String? entityId}) =>
      entityType == this.entityType && (entityId ?? '') == (id ?? '');

  static Serializer<HistoryRecord> get serializer => _$historyRecordSerializer;
}
