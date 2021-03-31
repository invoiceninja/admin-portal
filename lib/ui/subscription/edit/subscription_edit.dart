import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
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
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SubscriptionEdit extends StatefulWidget {
  const SubscriptionEdit({
    Key key,
    @required this.viewModel,
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
  FocusScopeNode _focusNode;
  TabController _controller;

  final _nameController = TextEditingController();
  final _promoCodeController = TextEditingController();
  final _promoDiscountController = TextEditingController();
  final _maxSeatsLimitController = TextEditingController();
  final _returnUrlController = TextEditingController();
  final _postPurchaseBodyController = TextEditingController();
  final _postPurchaseHeadersController = TextEditingController();
  final _postPurchaseRestMethodController = TextEditingController();
  final _postPurchaseUrlController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this, length: 3, initialIndex: settingsUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller.index));
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _promoCodeController,
      _promoDiscountController,
      _maxSeatsLimitController,
      _returnUrlController,
      _postPurchaseBodyController,
      _postPurchaseHeadersController,
      _postPurchaseRestMethodController,
      _postPurchaseUrlController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final subscription = widget.viewModel.subscription;
    final webhookConfiguration = subscription.webhookConfiguration;
    _promoCodeController.text = subscription.promoCode;
    _promoDiscountController.text = formatNumber(
        subscription.promoDiscount, context,
        formatNumberType: FormatNumberType.inputMoney);
    _maxSeatsLimitController.text = formatNumber(
        subscription.maxSeatsLimit.toDouble(), context,
        formatNumberType: FormatNumberType.inputAmount);
    _returnUrlController.text = webhookConfiguration.returnUrl;
    _postPurchaseBodyController.text = webhookConfiguration.postPurchaseBody;
    _postPurchaseHeadersController.text =
        webhookConfiguration.postPurchaseHeaders.join(',');
    _postPurchaseRestMethodController.text =
        webhookConfiguration.postPurchaseRestMethod;
    _postPurchaseUrlController.text = webhookConfiguration.postPurchaseUrl;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _onChanged() {
    final subscription = widget.viewModel.subscription.rebuild((b) => b
      ..promoCode = _promoCodeController.text.trim()
      ..promoDiscount = parseDouble(_promoDiscountController.text)
      ..maxSeatsLimit = parseInt(_maxSeatsLimitController.text)
      ..webhookConfiguration.returnUrl = _returnUrlController.text.trim()
      ..webhookConfiguration.postPurchaseBody =
          _postPurchaseBodyController.text.trim()
      ..webhookConfiguration
          .postPurchaseHeaders
          .replace(_postPurchaseHeadersController.text.trim().split(','))
      ..webhookConfiguration.postPurchaseRestMethod =
          _postPurchaseRestMethodController.text.trim()
      ..webhookConfiguration.postPurchaseUrl =
          _postPurchaseUrlController.text.trim());
    if (subscription != widget.viewModel.subscription) {
      _debouncer.run(() {
        widget.viewModel.onChanged(subscription);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final subscription = viewModel.subscription;
    final origSubscription = state.subscriptionState.get(subscription.id);

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

    return EditScaffold(
      title: subscription.isNew
          ? localization.newSubscription
          : localization.editSubscription,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
          setState(() {
            _autoValidate = !isValid;
          });
            */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
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
                  TextFormField(
                    controller: _nameController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: localization.name,
                    ),
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
                    key: ValueKey('__products_${subscription.productIds}__'),
                    entityType: EntityType.product,
                    entityList: dropdownProductsSelector(state.productState.map,
                        state.productState.list, state.userState.map),
                    entityMap: state.productState.map,
                    labelText: localization.products,
                    onSelected: (value) => viewModel.onChanged(
                        subscription.rebuild((b) => b
                          ..productIds =
                              subscription.productIds + ',${value.id}')),
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
                    key: ValueKey(
                        '__recuring_products_${subscription.recurringProductIds}__'),
                    entityType: EntityType.product,
                    entityList: dropdownProductsSelector(state.productState.map,
                        state.productState.list, state.userState.map),
                    entityMap: state.productState.map,
                    labelText: localization.recurringProducts,
                    onSelected: (value) => viewModel.onChanged(
                        subscription.rebuild((b) => b
                          ..recurringProductIds =
                              subscription.recurringProductIds +
                                  ',${value.id}')),
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
                    items: [
                      SettingsEntity.AUTO_BILL_ALWAYS,
                      SettingsEntity.AUTO_BILL_OPT_OUT,
                      SettingsEntity.AUTO_BILL_OPT_IN,
                      SettingsEntity.AUTO_BILL_OFF,
                    ]
                        .map((value) => DropdownMenuItem(
                              child: Text(localization.lookup(value)),
                              value: value,
                            ))
                        .toList(),
                  ),
                ],
              ),
              FormCard(
                children: [
                  DecoratedFormField(
                    label: localization.promoCode,
                    controller: _promoCodeController,
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
                  if (subscription.allowCancellation ||
                      origSubscription.allowCancellation)
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
                  if (subscription.trialEnabled ||
                      origSubscription.trialEnabled)
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
                  if (subscription.perSeatEnabled ||
                      origSubscription.perSeatEnabled)
                    DecoratedFormField(
                      label: localization.maxSeatsLimit,
                      controller: _maxSeatsLimitController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                ],
              )
            ],
          ),
          ScrollableListView(children: [
            FormCard(
              children: [
                DecoratedFormField(
                  label: localization.returnUrl,
                  controller: _returnUrlController,
                  keyboardType: TextInputType.url,
                ),
                DecoratedFormField(
                  label: localization.postPurchaseUrl,
                  controller: _postPurchaseUrlController,
                  keyboardType: TextInputType.url,
                ),
                DecoratedFormField(
                  label: localization.postPurchaseRestMethod,
                  controller: _postPurchaseRestMethodController,
                ),
                DecoratedFormField(
                  label: localization.postPurchaseHeaders,
                  controller: _postPurchaseHeadersController,
                ),
                DecoratedFormField(
                  label: localization.postPurchaseBody,
                  controller: _postPurchaseBodyController,
                  maxLines: 6,
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
