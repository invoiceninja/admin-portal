// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/autobill_dropdown_menu_item.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/discount_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SubscriptionEdit extends StatefulWidget {
  const SubscriptionEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final SubscriptionEditVM viewModel;

  @override
  _SubscriptionEditState createState() => _SubscriptionEditState();
}

class _SubscriptionEditState extends State<SubscriptionEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_subscriptionEdit');
  final _debouncer = Debouncer();
  FocusScopeNode? _focusNode;
  TabController? _controller;

  final _nameController = TextEditingController();
  final _promoCodeController = TextEditingController();
  final _promoDiscountController = TextEditingController();
  final _maxSeatsLimitController = TextEditingController();
  final _returnUrlController = TextEditingController();
  final _postPurchaseHeaderKeyController = TextEditingController();
  final _postPurchaseHeaderValueController = TextEditingController();
  final _postPurchaseUrlController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this, length: 3, initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _promoCodeController,
      _promoDiscountController,
      _maxSeatsLimitController,
      _returnUrlController,
      _postPurchaseUrlController,
      _postPurchaseHeaderKeyController,
      _postPurchaseHeaderValueController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final subscription = widget.viewModel.subscription;
    final webhookConfiguration = subscription.webhookConfiguration;
    _nameController.text = subscription.name;
    _promoCodeController.text = subscription.promoCode;
    _promoDiscountController.text = formatNumber(
        subscription.promoDiscount, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _maxSeatsLimitController.text = formatNumber(
        subscription.maxSeatsLimit.toDouble(), context,
        formatNumberType: FormatNumberType.inputAmount)!;
    _returnUrlController.text = webhookConfiguration.returnUrl;
    _postPurchaseUrlController.text = webhookConfiguration.postPurchaseUrl;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _onChanged() {
    final subscription = widget.viewModel.subscription.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..promoCode = _promoCodeController.text.trim()
      ..promoDiscount = parseDouble(_promoDiscountController.text)
      ..maxSeatsLimit = parseInt(_maxSeatsLimitController.text)
      ..webhookConfiguration.returnUrl = _returnUrlController.text.trim()
      ..webhookConfiguration.postPurchaseUrl =
          _postPurchaseUrlController.text.trim());
    if (subscription != widget.viewModel.subscription) {
      _debouncer.run(() {
        widget.viewModel.onChanged(subscription);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context)!;
    final subscription = viewModel.subscription;
    final webhookConfiguration = subscription.webhookConfiguration;

    final durations = [
      DropdownMenuItem<int>(
        child: Text(localization.countDay),
        value: 60 * 60 * 24,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '2')),
        value: 60 * 60 * 24 * 2,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '3')),
        value: 60 * 60 * 24 * 3,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '7')),
        value: 60 * 60 * 24 * 7,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '14')),
        value: 60 * 60 * 24 * 14,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '30')),
        value: 60 * 60 * 24 * 30,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '60')),
        value: 60 * 60 * 24 * 60,
      ),
    ];

    final key = _postPurchaseHeaderKeyController.text.trim();
    final value = _postPurchaseHeaderValueController.text.trim();

    return EditScaffold(
      entity: subscription,
      title: subscription.isNew
          ? localization.newPaymentLink
          : localization.editPaymentLink,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: _onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: isMobile(context),
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.webhook,
          ),
        ],
      ),
      body: AppTabForm(
        formKey: _formKey,
        focusNode: _focusNode,
        tabController: _controller,
        children: [
          ScrollableListView(
            children: <Widget>[
              FormCard(
                children: [
                  DecoratedFormField(
                    controller: _nameController,
                    label: localization.name,
                    onSavePressed: _onSavePressed,
                    keyboardType: TextInputType.text,
                  ),
                  DynamicSelector(
                    entityType: EntityType.group,
                    entityIds: memoizedGroupList(state.groupState.map),
                    entityId: subscription.groupId,
                    onChanged: (groupId) => viewModel.onChanged(
                        subscription.rebuild((b) => b..groupId = groupId)),
                  ),
                  UserPicker(
                    userId: subscription.assignedUserId,
                    onChanged: (userId) => viewModel.onChanged(subscription
                        .rebuild((b) => b..assignedUserId = userId)),
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  EntityDropdown(
                    entityType: EntityType.product,
                    entityList: dropdownProductsSelector(state.productState.map,
                        state.productState.list, state.userState.map),
                    entityMap: state.productState.map,
                    labelText: localization.oneTimeProducts,
                    onSelected: (value) {
                      if (value != null) {
                        final parts = subscription.productIds.split(',');
                        viewModel.onChanged(subscription.rebuild((b) => b
                          ..productIds = <String>[...parts, value.id]
                              .where((part) => part.isNotEmpty)
                              .join(',')));

                        WidgetsBinding.instance
                            .addPostFrameCallback((duration) {
                          FocusScope.of(context).unfocus();
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ...subscription.productIds
                      .split(',')
                      .where((element) => element.isNotEmpty)
                      .map((productId) => ListTile(
                            title: Text(
                                state.productState.get(productId).productKey),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                final parts =
                                    subscription.productIds.split(',');
                                parts.remove(productId);
                                viewModel.onChanged(subscription.rebuild(
                                    (b) => b..productIds = parts.join(',')));
                              },
                            ),
                          ))
                      .toList(),
                  SizedBox(
                    height: 16,
                  ),
                  EntityDropdown(
                    entityType: EntityType.product,
                    entityList: dropdownProductsSelector(state.productState.map,
                        state.productState.list, state.userState.map),
                    entityMap: state.productState.map,
                    labelText: localization.recurringProducts,
                    onSelected: (value) {
                      final parts = subscription.recurringProductIds.split(',');
                      viewModel.onChanged(subscription.rebuild((b) => b
                        ..recurringProductIds = <String>[...parts, value!.id]
                            .where((part) => part.isNotEmpty)
                            .join(',')));

                      WidgetsBinding.instance.addPostFrameCallback((duration) {
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ...subscription.recurringProductIds
                      .split(',')
                      .where((element) => element.isNotEmpty)
                      .map((productId) => ListTile(
                            title: Text(
                                state.productState.get(productId).productKey),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                final parts =
                                    subscription.recurringProductIds.split(',');
                                parts.remove(productId);
                                viewModel.onChanged(subscription.rebuild((b) =>
                                    b..recurringProductIds = parts.join(',')));
                              },
                            ),
                          ))
                      .toList(),
                ],
              ),
              FormCard(
                isLast: true,
                children: <Widget>[
                  EntityDropdown(
                    entityType: EntityType.product,
                    entityList: dropdownProductsSelector(state.productState.map,
                        state.productState.list, state.userState.map),
                    entityMap: state.productState.map,
                    labelText: localization.optionalOneTimeProducts,
                    onSelected: (value) {
                      if (value != null) {
                        final parts =
                            subscription.optionalProductIds.split(',');
                        viewModel.onChanged(subscription.rebuild((b) => b
                          ..optionalProductIds = <String>[...parts, value.id]
                              .where((part) => part.isNotEmpty)
                              .join(',')));

                        WidgetsBinding.instance
                            .addPostFrameCallback((duration) {
                          FocusScope.of(context).unfocus();
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ...subscription.optionalProductIds
                      .split(',')
                      .where((element) => element.isNotEmpty)
                      .map((productId) => ListTile(
                            title: Text(
                                state.productState.get(productId).productKey),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                final parts =
                                    subscription.optionalProductIds.split(',');
                                parts.remove(productId);
                                viewModel.onChanged(subscription.rebuild((b) =>
                                    b..optionalProductIds = parts.join(',')));
                              },
                            ),
                          ))
                      .toList(),
                  SizedBox(
                    height: 16,
                  ),
                  EntityDropdown(
                    entityType: EntityType.product,
                    entityList: dropdownProductsSelector(state.productState.map,
                        state.productState.list, state.userState.map),
                    entityMap: state.productState.map,
                    labelText: localization.optionalRecurringProducts,
                    onSelected: (value) {
                      if (value != null) {
                        final parts =
                            subscription.optionalRecurringProductIds.split(',');
                        viewModel.onChanged(subscription.rebuild((b) => b
                          ..optionalRecurringProductIds = <String>[
                            ...parts,
                            value.id
                          ].where((part) => part.isNotEmpty).join(',')));

                        WidgetsBinding.instance
                            .addPostFrameCallback((duration) {
                          FocusScope.of(context).unfocus();
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ...subscription.optionalRecurringProductIds
                      .split(',')
                      .where((element) => element.isNotEmpty)
                      .map((productId) => ListTile(
                            title: Text(
                                state.productState.get(productId).productKey),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                final parts = subscription
                                    .optionalRecurringProductIds
                                    .split(',');
                                parts.remove(productId);
                                viewModel.onChanged(subscription.rebuild((b) =>
                                    b
                                      ..optionalRecurringProductIds =
                                          parts.join(',')));
                              },
                            ),
                          ))
                      .toList(),
                ],
              ),
            ],
          ),
          ScrollableListView(
            children: [
              FormCard(
                children: [
                  AppDropdownButton<String>(
                      labelText: localization.frequency,
                      value: subscription.frequencyId,
                      onChanged: (dynamic value) {
                        viewModel.onChanged(subscription
                            .rebuild((b) => b..frequencyId = value));
                      },
                      showBlank: true,
                      items: kFrequencies.entries
                          .map((entry) => DropdownMenuItem(
                                value: entry.key,
                                child: Text(localization.lookup(entry.value)),
                              ))
                          .toList()),
                  AppDropdownButton<String>(
                    labelText: localization.autoBill,
                    value: subscription.autoBill,
                    onChanged: (dynamic value) => viewModel.onChanged(
                        subscription.rebuild((b) => b..autoBill = value)),
                    showBlank: true,
                    selectedItemBuilder: (context) => [
                      '',
                      SettingsEntity.AUTO_BILL_ALWAYS,
                      SettingsEntity.AUTO_BILL_OPT_OUT,
                      SettingsEntity.AUTO_BILL_OPT_IN,
                      SettingsEntity.AUTO_BILL_OFF,
                    ].map((type) => Text(localization.lookup(type))).toList(),
                    items: [
                      SettingsEntity.AUTO_BILL_ALWAYS,
                      SettingsEntity.AUTO_BILL_OPT_OUT,
                      SettingsEntity.AUTO_BILL_OPT_IN,
                      SettingsEntity.AUTO_BILL_OFF,
                    ]
                        .map((value) => DropdownMenuItem(
                              child: AutobillDropdownMenuItem(type: value),
                              value: value,
                            ))
                        .toList(),
                  ),
                  DecoratedFormField(
                    label: localization.promoCode,
                    controller: _promoCodeController,
                    onSavePressed: _onSavePressed,
                    keyboardType: TextInputType.text,
                  ),
                  DiscountField(
                    label: localization.promoDiscount,
                    controller: _promoDiscountController,
                    value: subscription.promoDiscount,
                    isAmountDiscount: subscription.isAmountDiscount,
                    onTypeChanged: (value) => viewModel.onChanged(subscription
                        .rebuild((b) => b..isAmountDiscount = value)),
                  ),
                ],
              ),
              FormCard(
                children: [
                  BoolDropdownButton(
                      label: localization.registrationRequired,
                      helpLabel: localization.registrationRequiredHelp,
                      value: subscription.registrationRequired,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b..registrationRequired = value))),
                  BoolDropdownButton(
                      label: localization.useInventoryManagement,
                      helpLabel: localization.useInventoryManagementHelp,
                      value: subscription.useInventoryManagement,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b..useInventoryManagement = value))),
                ],
              ),
              FormCard(
                isLast: true,
                children: [
                  DecoratedFormField(
                    label: localization.returnUrl,
                    controller: _returnUrlController,
                    keyboardType: TextInputType.url,
                    onSavePressed: _onSavePressed,
                  ),
                  SizedBox(height: 16),
                  BoolDropdownButton(
                      label: localization.allowQueryOverrides,
                      value: subscription.allowQueryOverrides,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b..allowQueryOverrides = value))),
                  BoolDropdownButton(
                      label: localization.allowPlanChanges,
                      value: subscription.allowPlanChanges,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b..allowPlanChanges = value))),
                  BoolDropdownButton(
                      label: localization.allowCancellation,
                      value: subscription.allowCancellation,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b..allowCancellation = value))),
                  if (subscription.allowCancellation)
                    AppDropdownButton<int>(
                      showBlank: true,
                      blankValue: 0,
                      labelText: localization.refundPeriod,
                      value: subscription.refundPeriod,
                      onChanged: (dynamic value) => viewModel.onChanged(
                          subscription.rebuild((b) => b..refundPeriod = value)),
                      items: durations,
                    ),
                  BoolDropdownButton(
                      label: localization.trialEnabled,
                      value: subscription.trialEnabled,
                      onChanged: (value) => viewModel.onChanged(
                          subscription.rebuild((b) => b.trialEnabled = value))),
                  if (subscription.trialEnabled)
                    AppDropdownButton<int>(
                      showBlank: true,
                      blankValue: 0,
                      labelText: localization.trialDuration,
                      value: subscription.trialDuration,
                      onChanged: (dynamic value) => viewModel.onChanged(
                          subscription
                              .rebuild((b) => b..trialDuration = value)),
                      items: durations,
                    ),
                  BoolDropdownButton(
                      label: localization.perSeatEnabled,
                      value: subscription.perSeatEnabled,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b.perSeatEnabled = value))),
                  if (subscription.perSeatEnabled)
                    DecoratedFormField(
                      label: localization.maxSeatsLimit,
                      controller: _maxSeatsLimitController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onSavePressed: _onSavePressed,
                    ),
                ],
              )
            ],
          ),
          ScrollableListView(children: [
            FormCard(
              isLast: true,
              children: [
                DecoratedFormField(
                  label: localization.webhookUrl,
                  controller: _postPurchaseUrlController,
                  keyboardType: TextInputType.url,
                  onSavePressed: _onSavePressed,
                ),
                AppDropdownButton<String>(
                  showBlank: true,
                  labelText: localization.restMethod,
                  value: webhookConfiguration.postPurchaseRestMethod,
                  onChanged: (dynamic value) => viewModel.onChanged(
                      subscription.rebuild((b) => b
                        ..webhookConfiguration.postPurchaseRestMethod = value)),
                  items: [
                    DropdownMenuItem(
                      child: Text('POST'),
                      value: 'post',
                    ),
                    DropdownMenuItem(
                      child: Text('PUT'),
                      value: 'put',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DecoratedFormField(
                        label: localization.headerKey,
                        controller: _postPurchaseHeaderKeyController,
                        onSavePressed: _onSavePressed,
                        onChanged: (value) => setState(() {}),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: kTableColumnGap,
                    ),
                    Expanded(
                      child: DecoratedFormField(
                        label: localization.headerValue,
                        controller: _postPurchaseHeaderValueController,
                        onSavePressed: _onSavePressed,
                        onChanged: (value) => setState(() {}),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: kTableColumnGap,
                    ),
                    IconButton(
                        tooltip: localization.addHeader,
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: (key.isEmpty || value.isEmpty)
                            ? null
                            : () {
                                _postPurchaseHeaderKeyController.text = '';
                                _postPurchaseHeaderValueController.text = '';

                                if (webhookConfiguration.postPurchaseHeaders
                                    .containsKey(key)) {
                                  return;
                                }

                                viewModel.onChanged(subscription.rebuild((b) =>
                                    b
                                      ..webhookConfiguration
                                          .postPurchaseHeaders[key] = value));
                              })
                  ],
                ),
                SizedBox(height: 8),
                if (webhookConfiguration.postPurchaseHeaders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Center(
                      child: HelpText(localization.noHeaders),
                    ),
                  )
                else
                  ...webhookConfiguration.postPurchaseHeaders.keys.map(
                    (key) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(key),
                          ),
                          SizedBox(width: kTableColumnGap),
                          Expanded(
                            child: Text(
                                webhookConfiguration.postPurchaseHeaders[key]!),
                          )
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        tooltip: localization.removeHeader,
                        onPressed: () {
                          viewModel.onChanged(subscription.rebuild((b) => b
                            ..webhookConfiguration
                                .postPurchaseHeaders
                                .remove(key)));
                        },
                      ),
                    ),
                  )
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
