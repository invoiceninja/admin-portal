import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
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

class _CompanyGatewayEditState extends State<CompanyGatewayEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

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

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
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
      onCancelPressed: viewModel.onCancelPressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              EntityDropdown(
                key: ValueKey('__gateway_${companyGateway.gatewayId}__'),
                entityType: EntityType.gateway,
                entityMap: state.staticState.gatewayMap,
                entityList: memoizedGatewayList(state.staticState.gatewayMap),
                labelText: localization.provider,
                initialValue: state
                    .staticState.gatewayMap[companyGateway.gatewayId]?.name,
                onSelected: (SelectableEntity gateway) => viewModel.onChanged(
                  companyGateway.rebuild((b) => b..gatewayId = gateway.id),
                ),
                //onFieldSubmitted: (String value) => _node.nextFocus(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
