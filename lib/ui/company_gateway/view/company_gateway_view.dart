import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

class CompanyGatewayView extends StatefulWidget {

  const CompanyGatewayView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayViewVM viewModel;

  @override
  _CompanyGatewayViewState createState() => new _CompanyGatewayViewState();
}

class _CompanyGatewayViewState extends State<CompanyGatewayView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final companyGateway = viewModel.companyGateway;

    return Scaffold(
      appBar: AppBar(
        title: EntityStateTitle(entity: companyGateway),
      actions: [
        userCompany.canEditEntity(companyGateway)
            ? EditIconButton(
                isVisible: !companyGateway.isDeleted,
                onPressed: () => viewModel.onEditPressed(context),
              )
            : Container(),
        ActionMenuButton(
          entityActions: companyGateway.getActions(userCompany: userCompany),
          isSaving: viewModel.isSaving,
          entity: companyGateway,
          onSelected: viewModel.onEntityAction,
        )
      ],
      ),
      body: FormCard(
        children: [
          // STARTER: widgets - do not remove comment
        ]
      ),
    );
  }
}
