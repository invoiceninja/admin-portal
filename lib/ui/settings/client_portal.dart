import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientPortal extends StatefulWidget {
  const ClientPortal({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientPortalVM viewModel;

  @override
  _ClientPortalState createState() => _ClientPortalState();
}

class _ClientPortalState extends State<ClientPortal>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController _controller;

  bool autoValidate = false;

  final _subdomainController = TextEditingController();
  final _domainController = TextEditingController();
  final _iFrameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _subdomainController,
      _domainController,
      _iFrameController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.clientPortal,
      onSavePressed: null,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.limitsAndFees,
          ),
        ],
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: localization.linkType,
                    ),
                    //isEmpty: false,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          //value: companyGateway.gatewayTypeId,
                          isExpanded: true,
                          isDense: true,
                          //onChanged: (value) => viewModel.onChanged(companyGateway.rebuild((b) => b..gatewayTypeId = value)),
                          items: []),
                    ),
                  ),
                  DecoratedFormField(
                    label: localization.subdomain,
                    controller: _subdomainController,
                  ),
                  DecoratedFormField(
                    label: localization.domain,
                    controller: _domainController,
                    keyboardType: TextInputType.url,
                  ),
                  DecoratedFormField(
                    label: 'iFrame',
                    controller: _iFrameController,
                    keyboardType: TextInputType.url,
                  ),
                ],
              )
            ],
          ),
          ListView(),
          ListView(),
        ],
      ),
    );
  }
}
