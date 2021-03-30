import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
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
  final _trialDurationController = TextEditingController();
  final _refundPeriodController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this, length: 2, initialIndex: settingsUIState.tabIndex);
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
      _trialDurationController,
      _refundPeriodController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final subscription = widget.viewModel.subscription;
    _promoCodeController.text = subscription.promoCode;
    _promoDiscountController.text = formatNumber(
        subscription.promoDiscount, context,
        formatNumberType: FormatNumberType.inputMoney);
    _maxSeatsLimitController.text = formatNumber(
        subscription.maxSeatsLimit.toDouble(), context,
        formatNumberType: FormatNumberType.inputAmount);
    _trialDurationController.text = formatNumber(
        subscription.trialDuration.toDouble(), context,
        formatNumberType: FormatNumberType.inputAmount);
    _refundPeriodController.text = formatNumber(
        subscription.refundPeriod.toDouble(), context,
        formatNumberType: FormatNumberType.inputAmount);

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
      ..trialDuration = parseInt(_trialDurationController.text)
      ..refundPeriod = parseInt(_refundPeriodController.text));
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
        isScrollable: false,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.settings,
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
                  //
                ],
              ),
            ],
          ),
          ScrollableListView(children: [
            FormCard(
              children: [
                AppDropdownButton<String>(
                    labelText: localization.frequency,
                    value: subscription.frequencyId,
                    onChanged: (dynamic value) {
                      viewModel.onChanged(
                          subscription.rebuild((b) => b..frequencyId = value));
                    },
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
                  onTypeChanged: (value) => viewModel.onChanged(
                      subscription.rebuild((b) => b..isAmountDiscount = value)),
                ),
              ],
            ),
            FormCard(
              children: [
                BoolDropdownButton(
                    label: localization.allowCancellation,
                    value: subscription.allowCancellation,
                    onChanged: (value) => viewModel.onChanged(subscription
                        .rebuild((b) => b..allowCancellation = value))),
                if (subscription.allowCancellation ||
                    origSubscription.allowCancellation)
                  DecoratedFormField(
                    label: localization.refundPeriod,
                    controller: _refundPeriodController,
                  ),
                BoolDropdownButton(
                    label: localization.trialEnabled,
                    value: subscription.trialEnabled,
                    onChanged: (value) => viewModel.onChanged(
                        subscription.rebuild((b) => b.trialEnabled = value))),
                if (subscription.trialEnabled || origSubscription.trialEnabled)
                  DecoratedFormField(
                    label: localization.trialDuration,
                    controller: _trialDurationController,
                  ),
                BoolDropdownButton(
                    label: localization.perSeatEnabled,
                    value: subscription.perSeatEnabled,
                    onChanged: (value) => viewModel.onChanged(
                        subscription.rebuild((b) => b.perSeatEnabled = value))),
                if (subscription.perSeatEnabled ||
                    origSubscription.perSeatEnabled)
                  DecoratedFormField(
                    label: localization.maxSeatsLimit,
                    controller: _maxSeatsLimitController,
                    keyboardType: TextInputType.number,
                  ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
