// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/workflow_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class WorkflowSettings extends StatefulWidget {
  const WorkflowSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final WorkflowSettingsVM viewModel;

  @override
  _WorkflowSettingsState createState() => _WorkflowSettingsState();
}

class _WorkflowSettingsState extends State<WorkflowSettings>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_workflowSettings');

  FocusScopeNode? _focusNode;
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this, length: 2, initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
    final company = viewModel.company;

    return EditScaffold(
      title: localization.workflowSettings,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.invoices,
          ),
          Tab(
            text: localization.quotes,
          ),
        ],
      ),
      body: AppTabForm(
          tabController: _controller,
          formKey: _formKey,
          focusNode: _focusNode,
          children: <Widget>[
            ScrollableListView(
              primary: true,
              children: <Widget>[
                FormCard(children: <Widget>[
                  BoolDropdownButton(
                    label: localization.autoEmailInvoice,
                    helpLabel: localization.autoEmailInvoiceHelp,
                    value: settings.autoEmailInvoice,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..autoEmailInvoice = value)),
                    iconData: Icons.email,
                  ),
                  if (!state.settingsUIState.isFiltered)
                    BoolDropdownButton(
                      label: localization.stopOnUnpaid,
                      helpLabel: localization.stopOnUnpaidHelp,
                      value: company.stopOnUnpaidRecurring,
                      onChanged: (value) => viewModel.onCompanyChanged(company
                          .rebuild((b) => b..stopOnUnpaidRecurring = value)),
                      iconData: Icons.stop_circle,
                    ),
                ]),
                FormCard(children: <Widget>[
                  BoolDropdownButton(
                    label: localization.autoArchivePaidInvoices,
                    helpLabel: localization.autoArchivePaidInvoices,
                    value: settings.autoArchiveInvoice,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..autoArchiveInvoice = value)),
                    iconData: Icons.archive,
                  ),
                  BoolDropdownButton(
                    label: localization.autoArchiveCancelledInvoices,
                    helpLabel: localization.autoArchiveCancelledInvoicesHelp,
                    value: settings.autoArchiveInvoiceCancelled,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild(
                            (b) => b..autoArchiveInvoiceCancelled = value)),
                    iconData: Icons.archive,
                  ),
                ]),
                FormCard(
                  isLast: true,
                  children: <Widget>[
                    AppDropdownButton<String>(
                      value: settings.lockInvoices,
                      onChanged: (dynamic value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..lockInvoices = value)),
                      labelText: localization.lockInvoices,
                      items: [
                        SettingsEntity.LOCK_INVOICES_OFF,
                        SettingsEntity.LOCK_INVOICES_SENT,
                        SettingsEntity.LOCK_INVOICES_PAID,
                      ]
                          .map((option) => DropdownMenuItem(
                                child: Text(localization.lookup(option)),
                                value: option,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
            ScrollableListView(
              primary: true,
              children: <Widget>[
                FormCard(
                  isLast: true,
                  children: <Widget>[
                    BoolDropdownButton(
                      label: localization.autoConvertQuote,
                      helpLabel: localization.autoConvertQuoteHelp,
                      value: settings.autoConvertQuote,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..autoConvertQuote = value)),
                      iconData: getEntityIcon(EntityType.quote),
                    ),
                    BoolDropdownButton(
                      label: localization.autoArchiveQuote,
                      helpLabel: localization.autoArchiveQuoteHelp,
                      value: settings.autoArchiveQuote,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..autoArchiveQuote = value)),
                      iconData: Icons.archive,
                    ),
                  ],
                ),
              ],
            ),
          ]),
    );
  }
}
