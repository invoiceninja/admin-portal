import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayEdit extends StatefulWidget {
  const CompanyGatewayEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayEditVM viewModel;

  @override
  _CompanyGatewayEditState createState() => _CompanyGatewayEditState();
}

class _CompanyGatewayEditState extends State<CompanyGatewayEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusScopeNode _node = FocusScopeNode();
  TabController _controller;
  bool autoValidate = false;

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final companyGateway = widget.viewModel.companyGateway;
    // STARTER: read value - do not remove comment

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final companyGateway = widget.viewModel.companyGateway.rebuild((b) => b
        // STARTER: set value - do not remove comment
        );
    if (companyGateway != widget.viewModel.companyGateway) {
      widget.viewModel.onChanged(companyGateway);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final companyGateway = viewModel.companyGateway;

    return SettingsScaffold(
      title: viewModel.companyGateway.isNew
          ? localization.newCompanyGateway
          : localization.editCompanyGateway,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.credentials,
          ),
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.limits,
          ),
          Tab(
            text: localization.fees,
          ),
        ],
      ),
      body: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: TabBarView(
            key: ValueKey(state.settingsUIState.updatedAt),
            controller: _controller,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      EntityDropdown(
                        key:
                            ValueKey('__gateway_${companyGateway.gatewayId}__'),
                        entityType: EntityType.gateway,
                        entityMap: state.staticState.gatewayMap,
                        entityList:
                            memoizedGatewayList(state.staticState.gatewayMap),
                        labelText: localization.provider,
                        initialValue: state.staticState
                            .gatewayMap[companyGateway.gatewayId]?.name,
                        onSelected: (SelectableEntity gateway) =>
                            viewModel.onChanged(
                          companyGateway
                              .rebuild((b) => b..gatewayId = gateway.id),
                        ),
                        //onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                    ],
                  ),
                ],
              ),
              ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      SwitchListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text(localization.billingAddress),
                        subtitle: Text(localization.requireBillingAddressHelp),
                        value: companyGateway.showBillingAddress,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..showBillingAddress = value)),
                      ),
                      SwitchListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text(localization.shippingAddress),
                        subtitle: Text(localization.requireShippingAddressHelp),
                        value: companyGateway.showShippingAddress,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..showShippingAddress = value)),
                      ),
                      SwitchListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text(localization.updateAddress),
                        subtitle: Text(localization.updateAddressHelp),
                        value: companyGateway.updateDetails,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..updateDetails = value)),
                      ),
                    ],
                  ),
                  FormCard(
                    children: <Widget>[
                      SwitchListTile(
                       activeColor: Theme.of(context).accentColor,
                       //title: Text(),
                       value: false,
                       //onChanged: (value) => viewModel.onChanged(companyGateway.rebuild((b) => b..)),
                      )
                    ],
                  )
                ],
              ),
              ListView(
                children: <Widget>[],
              ),
              ListView(
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
