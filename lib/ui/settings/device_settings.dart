// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/static/color_theme_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class DeviceSettings extends StatefulWidget {
  const DeviceSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DeviceSettingsVM viewModel;

  @override
  _DeviceSettingsState createState() => _DeviceSettingsState();
}

class _DeviceSettingsState extends State<DeviceSettings>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_deviceSettings');

  TabController _controller;
  FocusScopeNode _focusNode;

  @override
  void initState() {
    super.initState();
    final settingsUIState = widget.viewModel.state.settingsUIState;
    _focusNode = FocusScopeNode();
    _controller = TabController(
        vsync: this, length: 2, initialIndex: settingsUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller.index));
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final prefState = state.prefState;
    /*
    final countSessions = state.tokenState.list
        .map((tokenId) => state.tokenState.map[tokenId])
        .where(
            (token) => token.isSystem && token.createdUserId == state.user.id)
        .length;
    */

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: isMobile(context),
        title: Text(localization.deviceSettings),
        bottom: TabBar(
          key: ValueKey(state.settingsUIState.updatedAt),
          controller: _controller,
          isScrollable: false,
          tabs: [
            Tab(text: localization.options),
            Tab(text: localization.colors),
          ],
        ),
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: [
          ScrollableListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.layout,
                    value: prefState.appLayout == AppLayout.mobile,
                    onChanged: (value) {
                      viewModel.onLayoutChanged(context,
                          value ? AppLayout.mobile : AppLayout.desktop);
                    },
                    enabledLabel: localization.mobile,
                    disabledLabel: localization.desktop,
                  ),
                  if (state.prefState.isDesktop) ...[
                    BoolDropdownButton(
                      label: localization.menuSidebar,
                      value: prefState.menuSidebarMode == AppSidebarMode.float,
                      onChanged: (value) {
                        viewModel.onMenuModeChanged(
                          context,
                          value
                              ? AppSidebarMode.float
                              : AppSidebarMode.collapse,
                        );
                      },
                      enabledLabel: localization.float,
                      disabledLabel: localization.collapse,
                    ),
                    BoolDropdownButton(
                      label: localization.historySidebar,
                      value:
                          prefState.historySidebarMode == AppSidebarMode.float,
                      onChanged: (value) {
                        viewModel.onHistoryModeChanged(
                          context,
                          value ? AppSidebarMode.float : AppSidebarMode.visible,
                        );
                      },
                      enabledLabel: localization.float,
                      disabledLabel: localization.showOrHide,
                    ),
                  ],
                  if (isDesktop(context)) ...[
                    BoolDropdownButton(
                      label: localization.clickSelected,
                      value: prefState.tapSelectedToEdit,
                      onChanged: (value) {
                        viewModel.onTapSelectedChanged(context, value);
                      },
                      enabledLabel: localization.editRecord,
                      disabledLabel: localization.hidePreview,
                    ),
                    BoolDropdownButton(
                      label: localization.afterSaving,
                      value: prefState.editAfterSaving,
                      onChanged: (value) {
                        viewModel.onEditAfterSavingChanged(context, value);
                      },
                      enabledLabel: localization.editRecord,
                      disabledLabel: localization.viewRecord,
                    ),
                  ] else
                    BoolDropdownButton(
                      label: localization.listLongPress,
                      value: !prefState.longPressSelectionIsDefault,
                      onChanged: (value) {
                        viewModel.onLongPressSelectionIsDefault(
                            context, !value);
                      },
                      enabledLabel: localization.showActions,
                      disabledLabel: localization.startMultiselect,
                    ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppDropdownButton<double>(
                        labelText: localization.fontSize,
                        value: prefState.textScaleFactor,
                        onChanged: (dynamic value) {
                          viewModel.onTextScaleFactorChanged(context, value);
                          AppBuilder.of(context).rebuild();
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(localization.small),
                            value: PrefState.TEXT_SCALING_SMALL,
                          ),
                          DropdownMenuItem(
                            child: Text(localization.normal),
                            value: PrefState.TEXT_SCALING_NORMAL,
                          ),
                          DropdownMenuItem(
                            child: Text(localization.large),
                            value: PrefState.TEXT_SCALING_LARGE,
                          ),
                          DropdownMenuItem(
                            child: Text(localization.extraLarge),
                            value: PrefState.TEXT_SCALING_EXTRA_LARGE,
                          ),
                        ]),
                  ),
                  FutureBuilder(
                    future: viewModel.authenticationSupported,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return SwitchListTile(
                          title: Text(localization.biometricAuthentication),
                          value: prefState.requireAuthentication,
                          onChanged: (value) => viewModel
                              .onRequireAuthenticationChanged(context, value),
                          secondary: Icon(prefState.requireAuthentication
                              ? MdiIcons.lock
                              : MdiIcons.lockOpen),
                          activeColor: Theme.of(context).colorScheme.secondary,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  if (isDesktop(context)) ...[
                    SwitchListTile(
                      title: Text(localization.enableTouchEvents),
                      subtitle: Text(localization.enableTouchEventsHelp),
                      value: prefState.enableTouchEvents,
                      onChanged: (value) =>
                          viewModel.onEnableTouchEventsChanged(context, value),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      secondary: Icon(Icons.touch_app),
                    ),
                    SwitchListTile(
                      title: Text(localization.showPdfPreview),
                      subtitle: Text(localization.showPdfPreviewHelp),
                      value: prefState.showPdfPreview,
                      onChanged: (value) =>
                          viewModel.onShowPdfChanged(context, value),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      secondary: Icon(MdiIcons.filePdfBox),
                    ),
                    if (kIsWeb)
                      SwitchListTile(
                        title: Text(localization.alternatePdfViewer),
                        subtitle: Text(localization.alternatePdfViewerHelp),
                        value: prefState.enableJSPDF,
                        onChanged: (value) =>
                            viewModel.onEnableJSPDFChanged(context, value),
                        activeColor: Theme.of(context).colorScheme.secondary,
                        secondary: Icon(MdiIcons.filePdfBox),
                      ),
                  ],
                  /*
                  SwitchListTile(
                    title: Text(localization.persistUi),
                    subtitle: Text(localization.persistUiHelp),
                    value: prefState.persistUI,
                    onChanged: (value) =>
                        viewModel.onPersistUiChanged(context, value),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    secondary: Icon(Icons.save_alt),
                  ),
                  */
                  SwitchListTile(
                    title: Text(localization.persistData),
                    subtitle: Text(localization.persistDataHelp),
                    value: prefState.persistData,
                    onChanged: (value) =>
                        viewModel.onPersistDataChanged(context, value),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    secondary: Icon(Icons.save_alt),
                  ),
                ],
              ),
              FormCard(
                isLast: true,
                children: <Widget>[
                  Builder(builder: (BuildContext context) {
                    return ListTile(
                      leading: Icon(Icons.refresh),
                      title: Text(localization.refreshData),
                      subtitle: LiveText(() {
                        if (state.userCompanyState.lastUpdated == 0) {
                          return '';
                        }

                        return localization.lastUpdated +
                            ': ' +
                            timeago.format(
                                convertTimestampToDate(
                                    (state.userCompanyState.lastUpdated / 1000)
                                        .round()),
                                locale: localeSelector(state, twoLetter: true));
                      }),
                      onTap: () {
                        viewModel.onRefreshTap(context);
                      },
                    );
                  }),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(localization.endAllSessions),
                    /*
                    subtitle: Text(countSessions == 1
                        ? localization.countSession
                        : localization.countSession
                            .replaceFirst(':count', '$countSessions')),
                            */
                    onTap: () {
                      confirmCallback(
                          context: context,
                          callback: (_) {
                            viewModel.onLogoutTap(context);
                          });
                    },
                  ),
                ],
              )
            ],
          ),
          ScrollableListView(
            children: [
              FormCard(children: [
                SwitchListTile(
                  title: Text(localization.darkMode),
                  value: prefState.enableDarkMode,
                  onChanged: (value) =>
                      viewModel.onDarkModeChanged(context, value),
                  secondary: Icon(kIsWeb
                      ? Icons.lightbulb_outline
                      : MdiIcons.themeLightDark),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: 16),
                AppDropdownButton<String>(
                  labelText: localization.statusColorTheme,
                  value: state.prefState.colorTheme,
                  items: [
                    ...colorThemesMap.keys
                        .map((key) => DropdownMenuItem(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Text(toTitleCase(key)),
                                    width: 120,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorInfo,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorPrimary,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorSuccess,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorWarning,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorDanger,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                              value: key,
                            ))
                        .toList()
                  ],
                  onChanged: (dynamic value) =>
                      viewModel.onColorThemeChanged(context, value),
                ),
              ]),
              FormCard(
                isLast: true,
                children: [
                  AppDropdownButton<String>(
                      labelText: localization.loadColorTheme,
                      value: '',
                      onChanged: (dynamic value) {
                        if (value == 'clear_all') {
                          viewModel.onCustomColorsChanged(
                              context,
                              prefState.customColors
                                  .rebuild((b) => b..clear()));
                        } else if (value == 'contrast') {
                          final enableDarkMode = state.prefState.enableDarkMode;
                          viewModel.onCustomColorsChanged(
                            context,
                            prefState.customColors.rebuild(
                              (b) => b.addAll(
                                <String, String>{
                                  PrefState
                                          .THEME_SIDEBAR_ACTIVE_BACKGROUND_COLOR:
                                      '#444444',
                                  PrefState.THEME_SIDEBAR_ACTIVE_FONT_COLOR:
                                      '#FFFFFF',
                                  PrefState
                                          .THEME_SIDEBAR_INACTIVE_BACKGROUND_COLOR:
                                      '#2F2F2F',
                                  PrefState.THEME_SIDEBAR_INACTIVE_FONT_COLOR:
                                      '#FFFFFF',
                                  PrefState
                                          .THEME_INVOICE_HEADER_BACKGROUND_COLOR:
                                      '#777777',
                                  PrefState.THEME_INVOICE_HEADER_FONT_COLOR:
                                      '#FFFFFF',
                                  PrefState
                                          .THEME_TABLE_ALTERNATE_ROW_BACKGROUND_COLOR:
                                      enableDarkMode ? '#090909' : '#F9F9F9',
                                },
                              ),
                            ),
                          );
                        }
                      },
                      items: [
                        DropdownMenuItem(
                            child: Text(localization.clearAll),
                            value: 'clear_all'),
                        DropdownMenuItem(
                            child: Text(localization.contrast),
                            value: 'contrast'),
                      ]),
                  ...PrefState.THEME_COLORS
                      .map(
                        (selector) => FormColorPicker(
                          labelText: localization.lookup(selector),
                          initialValue: prefState.customColors[selector],
                          onSelected: (value) {
                            viewModel.onCustomColorsChanged(
                                context,
                                prefState.customColors
                                    .rebuild((b) => b[selector] = value ?? ''));
                          },
                        ),
                      )
                      .toList(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            final colors = PrefState.THEME_COLORS
                                .map((selector) =>
                                    prefState.customColors[selector] ?? '')
                                .toList();
                            Clipboard.setData(
                                ClipboardData(text: colors.join(',')));
                            showToast(localization.copiedToClipboard
                                .replaceFirst(':value', colors.join(',')));
                          },
                          child: Text(localization.exportColors.toUpperCase()),
                        ),
                      ),
                      SizedBox(width: kTableColumnGap),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            fieldCallback(
                              context: context,
                              field: localization.colors,
                              callback: (value) {
                                final colors = value.split(',');
                                var customColors = prefState.customColors;
                                for (var i = 0; i < colors.length; i++) {
                                  customColors = customColors.rebuild((b) =>
                                      b[PrefState.THEME_COLORS[i]] = colors[i]);
                                }
                                viewModel.onCustomColorsChanged(
                                    context, customColors);
                              },
                              title: localization.importColors,
                            );
                          },
                          child: Text(localization.importColors.toUpperCase()),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
