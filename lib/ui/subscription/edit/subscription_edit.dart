import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
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
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final subscription = widget.viewModel.subscription;
    //_subscriptionsController.text = subscription.subscriptions;
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
    _debouncer.run(() {
      final subscription = widget.viewModel.subscription.rebuild((b) => b
          // STARTER: set value - do not remove comment
          //..subscriptions = _subscriptionsController.text.trim()
          );
      if (subscription != widget.viewModel.subscription) {
        widget.viewModel.onChanged(subscription);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final subscription = viewModel.subscription;

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
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Subscriptions',
                    ),
                  ),
                  BoolDropdownButton(
                      label: localization.allowCancellation,
                      value: subscription.allowCancellation,
                      onChanged: (value) => viewModel.onChanged(subscription
                          .rebuild((b) => b..allowCancellation = value))),
                ],
              ),
            ],
          ),
          ScrollableListView(children: [
            Placeholder(),
          ]),
        ],
      ),
    );
  }
}
