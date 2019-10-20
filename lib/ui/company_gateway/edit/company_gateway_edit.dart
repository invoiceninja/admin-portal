import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

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
                      GatewayConfigSettings(
                        companyGateway: companyGateway,
                        viewModel: viewModel,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 16),
                        child: Text(
                          localization.acceptedCardLogos,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                      CardListTile(
                        viewModel: viewModel,
                        cardType: kCardTypeVisa,
                        paymentType: kPaymentTypeVisa,
                      ),
                      CardListTile(
                        viewModel: viewModel,
                        cardType: kCardTypeMasterCard,
                        paymentType: kPaymentTypeMasterCard,
                      ),
                      CardListTile(
                        viewModel: viewModel,
                        cardType: kCardTypeAmEx,
                        paymentType: kPaymentTypeAmEx,
                      ),
                      CardListTile(
                        viewModel: viewModel,
                        cardType: kCardTypeDiscover,
                        paymentType: kPaymentTypeDiscover,
                      ),
                      CardListTile(
                        viewModel: viewModel,
                        cardType: kCardTypeDiners,
                        paymentType: kPaymentTypeDiners,
                      ),
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

class CardListTile extends StatelessWidget {
  const CardListTile({this.viewModel, this.paymentType, this.cardType});

  final CompanyGatewayEditVM viewModel;
  final String paymentType;
  final int cardType;

  @override
  Widget build(BuildContext context) {
    final staticState = viewModel.state.staticState;
    final companyGateway = viewModel.companyGateway;

    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).accentColor,
      title: Text(staticState.paymentTypeMap[paymentType]?.name ?? ''),
      value: companyGateway.supportsCard(cardType),
      onChanged: (value) => viewModel.onChanged(value
          ? companyGateway.addCard(cardType)
          : companyGateway.removeCard(cardType)),
    );
  }
}

class GatewayConfigSettings extends StatelessWidget {
  const GatewayConfigSettings({this.companyGateway, this.viewModel});

  final CompanyGatewayEntity companyGateway;
  final CompanyGatewayEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final gateway = state.staticState.gatewayMap[companyGateway.gatewayId];

    if (gateway == null) {
      return SizedBox();
    }

    return Column(
      children: gateway.parsedFields.keys
          .map((field) => GatewayConfigField(
                field: field,
                value: companyGateway.parsedConfig[field],
                defaultValue: gateway.parsedFields[field],
                onChanged: (dynamic value) {
                  viewModel
                      .onChanged(companyGateway.updateConfig(field, value));
                },
              ))
          .toList(),
    );
  }
}

class GatewayConfigField extends StatefulWidget {
  const GatewayConfigField({
    Key key,
    @required this.field,
    @required this.value,
    @required this.defaultValue,
    @required this.onChanged,
  }) : super(key: key);

  final String field;
  final dynamic value;
  final dynamic defaultValue;
  final Function(dynamic) onChanged;

  @override
  _GatewayConfigFieldState createState() => _GatewayConfigFieldState();
}

class _GatewayConfigFieldState extends State<GatewayConfigField> {
  bool autoValidate = false;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _textController.removeListener(_onChanged);

    _textController.text = (widget.value ?? widget.defaultValue).toString();

    _textController.addListener(_onChanged);

    super.didChangeDependencies();
  }

  void _onChanged() {
    widget.onChanged(_textController.text.trim());
  }

  bool _obscureText(String field) {
    bool obscure = false;
    ['password', 'secret', 'key'].forEach((word) {
      if (field.toLowerCase().contains(word)) {
        obscure = true;
      }
    });
    return obscure;
  }

  @override
  Widget build(BuildContext context) {
    if ('${widget.defaultValue}'.startsWith('[') &&
        '${widget.defaultValue}'.endsWith(']')) {
      final options = [
        '',
        ...'${widget.defaultValue}'
            .replaceFirst('[', '')
            .replaceFirst(']', '')
            .split(',')
      ];
      final dynamic value =
          widget.value == widget.defaultValue ? '' : widget.value;

      return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          //isExpanded: true,
          value: value,
          onChanged: (value) => null,
          items: options
              .map((value) => DropdownMenuItem<String>(
                    child: Text(value.trim()),
                    value: value.trim(),
                  ))
              .toList(),
        ),
      );
    } else if (widget.field.toLowerCase().contains('color')) {
      return FormColorPicker(
        initialValue: widget.value,
        labelText: toTitleCase(widget.field),
        onSelected: (value) => widget.onChanged(value),
      );
    } else if (widget.value.runtimeType == bool) {
      return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Theme.of(context).accentColor,
        title: Text(toTitleCase(widget.field)),
        value: widget.value,
        onChanged: (value) => widget.onChanged(value),
      );
    } else {
      return TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          labelText: toTitleCase(widget.field),
        ),
        onChanged: (value) => _onChanged(),
        obscureText: _obscureText(widget.field),
      );
    }
  }
}
